-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- PDB Name: B_20251SEN205_ritha_route_optimisation_db
-- Script: 02_create_user.sql
-- =========================================================

ALTER SESSION SET CONTAINER = B_20251SEN205_ritha_route_optimisation_db;

-- Note: If the user 'Ritha' already exists, drop it first: DROP USER Ritha CASCADE;
CREATE USER Ritha IDENTIFIED BY ritha;

GRANT DBA TO Ritha;

SHOW USER;
