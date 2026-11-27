-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- Script: 10_validation.sql
-- =========================================================

-- 1. Compare row counts between staging and real tables (Task 10)
SELECT 'Staging Agencies' AS table_name, COUNT(*) AS row_count FROM staging_agency
UNION ALL
SELECT 'Real Agencies', COUNT(*) FROM agencies
UNION ALL
SELECT 'Staging Routes', COUNT(*) FROM staging_routes
UNION ALL
SELECT 'Real Routes', COUNT(*) FROM routes;

-- 2. Check for orphans (Routes without an Agency)
SELECT COUNT(*) AS orphan_routes 
FROM routes r 
LEFT JOIN agencies a ON r.agency_id = a.agency_id 
WHERE a.agency_id IS NULL;

-- 3. Test summary view (GROUP BY)
SELECT * FROM vw_agency_route_summary;
