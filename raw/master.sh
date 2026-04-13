########################################################
# master.sh - Master Script
########################################################

echo "Extracting..."
python extract.py 

echo "Generating DDL..."
python ddl.py 

echo "Ingesting..."
python ingest.py