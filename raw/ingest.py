########################################################
# ingest.py - Load raw GitHub JSON into Postgres
########################################################

import os
import json
import psycopg

# Config: update these for your Postgres instance
DB_CONFIG = {
    "dbname": os.getenv("DB"),
    "user": os.getenv("USR"),
    "password": os.getenv("PW"),
    "host": os.getenv("HOST"),
    "port": int(os.getenv("PORT"))
}

json_file = "extract.json"
table_name = "github.issues"
ddl_file = "ddl.sql"

def get_cols(ddl_file):
    column_list = []
    with open(ddl_file) as f:
        for line in f:
            line_clean = line.strip().upper()
            column = line.split()[0]
            if line_clean.startswith(("CREATE TABLE", ")", ";", "INGESTED_AT")):
                continue
            else: 
                column_list.append(column)

    return ", ".join(column_list) 
           

def get_vals(ddl_file):
    value_list = []
    with open(ddl_file) as f:
        for line in f:
            line_clean = line.strip().upper()
            column = line.split()[0]
            value = f"%({column})s"

            if line_clean.startswith(("CREATE TABLE", ")", ";", "INGESTED_AT")):
                continue
            else:
                value_list.append(value)

    return ", ".join(value_list)


def get_dict(ddl_file, issue):
    d = {}
    with open(ddl_file) as f:
        for line in f:
            line_clean = line.strip().upper()
            sql_key = line.split()[0]          # i.e. '"user"' or 'title'

            if line_clean.startswith(("CREATE TABLE", ")", ";", "INGESTED_AT")):
                continue
            
            json_key = sql_key.strip('"').lower()
            val = issue.get(json_key)

            if isinstance(val, (dict, list)):
                val = json.dumps(val)

            d[sql_key] = val                   # matches SQL placeholder

    return d


def load_json(file_path):
    """Load the JSON file containing issues."""
    with open(file_path) as f:
        return json.load(f)


def insert_issues(conn, issues):
    """Insert issues into Postgres table."""
    print(f"    Inserting Into {table_name}...")
    with conn.cursor() as cur:
        for issue in issues:
            if not isinstance(issue, dict):
                continue  # or log it

            cur.execute(
                f"""
                INSERT INTO {table_name} ({get_cols(ddl_file)})
                VALUES ({get_vals(ddl_file)})
                """,
                get_dict(ddl_file, issue)
            )
        conn.commit()
        print(f"    Inserted rows into {table_name}")

def truncate_table(conn):
    """Truncate target table before loading."""
    print(f"    Truncating {table_name}...")
    with conn.cursor() as cur:
        cur.execute(f"TRUNCATE TABLE {table_name}")
    conn.commit()

def drop_table(conn):
    """Drop target table if it exists."""
    print(f"    Dropping {table_name} if exists...")
    with conn.cursor() as cur:
        cur.execute(f"DROP TABLE IF EXISTS {table_name} CASCADE")
    conn.commit()

def create_table(conn):
    """Create target table if it does not exist."""
    print(f"    Creating {table_name} if not exists...")
    with open(ddl_file, "r") as f:
        sql = f.read()
    with conn.cursor() as cur:
        cur.execute(sql)
    conn.commit()

def main():
    issues = load_json(json_file)

    with psycopg.connect(**DB_CONFIG) as conn:
        # Optional Drop table if exists
        drop_table(conn)

        # Optional Create table if not exists based off ddl generated from raw json
        create_table(conn)

        truncate_table(conn)

        insert_issues(conn, issues)

if __name__ == "__main__":
    main()