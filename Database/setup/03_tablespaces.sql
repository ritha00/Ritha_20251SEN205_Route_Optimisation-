-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- PDB Name: B_20251SEN205_ritha_route_optimisation_db
-- Script: 03_tablespaces.sql
-- =========================================================

CREATE TABLESPACE route_data DATAFILE 'route_data01.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1G;

CREATE TABLESPACE route_idx DATAFILE 'route_idx01.dbf' SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

CREATE TEMPORARY TABLESPACE route_temp TEMPFILE 'route_temp01.dbf' SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

ALTER USER Ritha DEFAULT TABLESPACE route_data;

ALTER USER Ritha TEMPORARY TABLESPACE route_temp;

ALTER USER Ritha QUOTA UNLIMITED ON route_data;

ALTER USER Ritha QUOTA UNLIMITED ON route_idx;
