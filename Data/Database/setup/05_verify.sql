-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- PDB Name: B_20251SEN205_ritha_route_optimisation_db
-- Script: 05_verify.sql
-- =========================================================

-- 1. Confirm the PDB exists and is open
SELECT name, open_mode FROM v$pdbs WHERE name = 'B_20251SEN205_RITHA_ROUTE_OPTIMISATION_DB';

-- 2. Admin user's default and temporary tablespaces
SELECT username, default_tablespace, temporary_tablespace FROM dba_users WHERE username = 'RITHA';

-- 3. Tablespaces with size and autoextend
SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb, autoextensible, maxbytes/1024/1024 AS max_size_mb 
FROM dba_data_files 
WHERE tablespace_name IN ('ROUTE_DATA', 'ROUTE_IDX')
UNION ALL
SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb, autoextensible, maxbytes/1024/1024 AS max_size_mb 
FROM dba_temp_files 
WHERE tablespace_name = 'ROUTE_TEMP';

-- 4. Archive log mode
SELECT log_mode FROM v$database;
