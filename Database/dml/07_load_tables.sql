-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- Script: 07_load_tables.sql
-- =========================================================

-- Move Agencies (Parent first) (Task 9)
INSERT INTO agencies (agency_id, agency_name, agency_timezone) 
SELECT TO_NUMBER(agency_id), agency_name, agency_timezone 
FROM staging_agency 
WHERE agency_id IS NOT NULL;

-- Move Routes (Child second) (Task 9)
INSERT INTO routes (route_id, agency_id, route_short_name, route_long_name, route_type, route_desc) 
SELECT TO_NUMBER(route_id), TO_NUMBER(agency_id), route_short_name, route_long_name, TO_NUMBER(route_type), route_desc 
FROM staging_routes 
WHERE route_id IS NOT NULL AND agency_id IS NOT NULL;

COMMIT;
