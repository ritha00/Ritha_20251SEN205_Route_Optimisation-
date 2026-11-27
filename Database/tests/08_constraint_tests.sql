-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- Script: 08_constraint_tests.sql
-- =========================================================

-- TEST 1: Primary Key Violation (Should fail)
INSERT INTO agencies (agency_id, agency_name) VALUES (1, 'KBS');
INSERT INTO agencies (agency_id, agency_name) VALUES (1, 'RFTC'); 
-- Expected ORA-00001: unique constraint (RITHA.PK_AGENCIES) violated

-- TEST 2: Check Constraint Violation (Should fail)
INSERT INTO buses (bus_id, bus_code, capacity) VALUES (101, 'BUS-001', -5);
-- Expected ORA-02290: check constraint (RITHA.CK_BUSES_CAPACITY) violated

-- TEST 3: Foreign Key Violation (Should fail)
INSERT INTO routes (route_id, agency_id) VALUES (999, 50);
-- Expected ORA-02291: integrity constraint (RITHA.FK_ROUTES_AGENCY) violated - parent key not found

-- TEST 4: NOT NULL Violation (Should fail)
INSERT INTO areas (area_id, district) VALUES (1, 'Gasabo');
-- Expected ORA-01400: cannot insert NULL into ("RITHA"."AREAS"."AREA_NAME")
