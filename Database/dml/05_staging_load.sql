-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Script: 05_staging_load.sql
-- =========================================================

-- 1. Staging table for Agencies
DROP TABLE staging_agency;
CREATE TABLE staging_agency (
    agency_id VARCHAR2(50),
    agency_name VARCHAR2(100),
    agency_url VARCHAR2(200),
    agency_timezone VARCHAR2(50)
);

-- 2. Staging table for Routes
DROP TABLE staging_routes;
CREATE TABLE staging_routes (
    route_id VARCHAR2(50),
    agency_id VARCHAR2(50),
    route_short_name VARCHAR2(50),
    route_long_name VARCHAR2(200),
    route_type VARCHAR2(10),
    route_desc VARCHAR2(500)
);
