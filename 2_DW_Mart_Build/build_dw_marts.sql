-- step 1: DW - Create star schema tables
.read 01_create_tables_DW.sql

-- step 2: DW - Load data from csv into tables
.read 02_load_schema_dw.sql