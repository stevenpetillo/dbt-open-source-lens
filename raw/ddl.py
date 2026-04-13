########################################################
# ddl.py - Generate DDL for SQL Table from Raw JSON
########################################################

import json
import re

JSON_FILE=''

def flatten_json_sample(json_list):
    """Return a dict of key -> sample value from first object in list."""
    flat = {}
    first_row = json_list[0]
    if not isinstance(first_row, dict):
        raise ValueError("Expected first element of list to be dict")
    for key, value in first_row.items():
        flat[key] = value
    return flat


def generate_ddl_from_json(json_file, table_name, schema):
    """Generate a CREATE TABLE statement from a JSON file."""
    with open(json_file) as f:
        data = json.load(f)

    if not isinstance(data, list) or len(data) == 0:
        raise ValueError("JSON should be a non-empty list of objects")

    sample = flatten_json_sample(data)
    columns = []

    for key, value in sample.items():
        sql_type = 'TEXT'
        safe_key = key.lower().replace(" ", "_")

        if safe_key in {"user","placeholder"}:
            safe_key = f'"{safe_key}"'

        columns.append(f"{safe_key} {sql_type}")

    columns.append("ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP")

    ddl = f"CREATE TABLE IF NOT EXISTS {schema}.{table_name} (\n    " + ",\n    ".join(columns) + "\n);"
    return ddl


if __name__ == "__main__":
    ddl_statement = generate_ddl_from_json("extract.json", "issues", "github")

    # Save to file
    with open("ddl.sql", "w") as f:
        f.write(ddl_statement)
