-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- PDB Name: B_20251SEN205_ritha_route_optimisation_db
-- Script: 04_archive_log.sql
-- =========================================================

ARCHIVE LOG LIST;

/*
Explanation of CDB vs PDB scope:
Archive logging is a Container Database (CDB) level setting, not a Pluggable Database (PDB) setting.
All PDBs share the same redo log files of the root container. Therefore, enabling or disabling archive 
logging affects the entire CDB and requires SYSDBA access to the root container and a full database restart.
It cannot be configured for a single PDB independently.
*/
