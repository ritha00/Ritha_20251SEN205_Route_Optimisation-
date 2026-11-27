-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- Script: 06_clean.sql
-- =========================================================

-- Trim spaces from staging tables (Task 8)
UPDATE staging_agency SET agency_name = TRIM(agency_name);
UPDATE staging_routes SET route_short_name = TRIM(route_short_name);

COMMIT;
