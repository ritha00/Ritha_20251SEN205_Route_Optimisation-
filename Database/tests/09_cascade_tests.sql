-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Script: 09_cascade_tests.sql
-- =========================================================

-- 1. Insert test data
INSERT INTO agencies (agency_id, agency_name) VALUES (999, 'Test Agency');
INSERT INTO routes (route_id, agency_id, route_short_name) VALUES (999, 999, 'R1');

-- 2. Test ON DELETE CASCADE
-- We delete the agency. The route should automatically be deleted.
DELETE FROM agencies WHERE agency_id = 999;

-- Check if the route is gone
SELECT COUNT(*) FROM routes WHERE agency_id = 999; 
-- Expected result: 0 (because of ON DELETE CASCADE)

-- 3. Test NO ACTION
-- Insert a stop and a delay report for that stop
INSERT INTO areas (area_id, area_name, district) VALUES (999, 'Test Area', 'Test District');
INSERT INTO bus_stops (stop_id, stop_name, area_id) VALUES (999, 'Test Stop', 999);
INSERT INTO routes (route_id, agency_id, route_short_name) VALUES (998, 1, 'R2'); -- Need a route for the delay report
INSERT INTO delay_reports (delay_id, route_id, stop_id, delay_duration) VALUES (999, 998, 999, 15);

-- Now try to delete the stop that has a delay report
DELETE FROM bus_stops WHERE stop_id = 999;
-- Expected result: ORA-02292: integrity constraint (RITHA.FK_DELAY_STOP) violated - child record found

-- Clean up test data (except the one that failed)
DELETE FROM delay_reports WHERE delay_id = 999;
DELETE FROM bus_stops WHERE stop_id = 999;
DELETE FROM routes WHERE route_id = 998;
DELETE FROM areas WHERE area_id = 999;
COMMIT;
