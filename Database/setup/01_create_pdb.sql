-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- PDB Name: B_20251SEN205_ritha_route_optimisation_db
-- Script: 01_create_pdb.sql
-- =========================================================

-- Create the pluggable database
CREATE PLUGGABLE DATABASE B_20251SEN205_ritha_route_optimisation_db
  ADMIN USER ritha_admin IDENTIFIED BY ritha
  FILE_NAME_CONVERT = ('/pdbseed/', '/B_20251SEN205_ritha_route_optimisation_db/');

-- Open the PDB
ALTER PLUGGABLE DATABASE B_20251SEN205_ritha_route_optimisation_db OPEN;

-- Save state so it opens automatically after restart
ALTER PLUGGABLE DATABASE B_20251SEN205_ritha_route_optimisation_db SAVE STATE;

-- Verify the PDB is open
SELECT name, open_mode FROM v$pdbs WHERE name = 'B_20251SEN205_RITHA_ROUTE_OPTIMISATION_DB';
