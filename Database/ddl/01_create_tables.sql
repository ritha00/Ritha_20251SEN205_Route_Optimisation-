-- =========================================================
-- Name: MUNEZERO Isimbi Ritha
-- Student ID: 20251SEN205
-- Group: B
-- Project: Public Transportation Management and Route Optimization System
-- Script: 01_create_tables.sql
-- =========================================================

-- 1. AGENCIES (Parent)
CREATE TABLE agencies (
    agency_id NUMBER(10) CONSTRAINT pk_agencies PRIMARY KEY,
    agency_name VARCHAR2(100) CONSTRAINT nn_agencies_name NOT NULL,
    agency_timezone VARCHAR2(50)
);

-- 2. AREAS (Parent)
CREATE TABLE areas (
    area_id NUMBER(10) CONSTRAINT pk_areas PRIMARY KEY,
    area_name VARCHAR2(100) CONSTRAINT nn_areas_name NOT NULL,
    district VARCHAR2(100) CONSTRAINT nn_areas_district NOT NULL
);

-- 3. PASSENGERS (Parent)
CREATE TABLE passengers (
    passenger_id NUMBER(10) CONSTRAINT pk_passengers PRIMARY KEY,
    passenger_code VARCHAR2(20) CONSTRAINT uq_passengers_code UNIQUE,
    registration_date DATE DEFAULT SYSDATE CONSTRAINT nn_passengers_date NOT NULL
);

-- 4. BUSES (Parent)
CREATE TABLE buses (
    bus_id NUMBER(10) CONSTRAINT pk_buses PRIMARY KEY,
    bus_code VARCHAR2(20) CONSTRAINT uq_buses_code UNIQUE,
    capacity NUMBER(5) CONSTRAINT ck_buses_capacity CHECK (capacity > 0),
    operator_name VARCHAR2(100),
    bus_status VARCHAR2(20) DEFAULT 'ACTIVE' CONSTRAINT ck_buses_status CHECK (bus_status IN ('ACTIVE', 'INACTIVE', 'MAINTENANCE'))
);

-- 5. BUS_STOPS (Parent)
CREATE TABLE bus_stops (
    stop_id NUMBER(10) CONSTRAINT pk_bus_stops PRIMARY KEY,
    stop_name VARCHAR2(100) CONSTRAINT nn_stops_name NOT NULL,
    area_id NUMBER(10) CONSTRAINT fk_stops_area REFERENCES areas(area_id) ON DELETE SET NULL,
    latitude NUMBER(10,6),
    longitude NUMBER(10,6)
);

-- 6. ROUTES (Parent, references AGENCIES)
CREATE TABLE routes (
    route_id NUMBER(10) CONSTRAINT pk_routes PRIMARY KEY,
    agency_id NUMBER(10) CONSTRAINT fk_routes_agency REFERENCES agencies(agency_id) ON DELETE CASCADE,
    route_short_name VARCHAR2(20),
    route_long_name VARCHAR2(200),
    route_type NUMBER(2) DEFAULT 3 CONSTRAINT ck_routes_type CHECK (route_type IN (0,1,2,3,4,5,6,7,11,12)),
    route_desc VARCHAR2(500)
);

-- 7. ROUTE_STOPS (Child of ROUTES and BUS_STOPS)
CREATE TABLE route_stops (
    route_stop_id NUMBER(10) CONSTRAINT pk_route_stops PRIMARY KEY,
    route_id NUMBER(10) CONSTRAINT fk_route_stops_route REFERENCES routes(route_id) ON DELETE CASCADE,
    stop_id NUMBER(10) CONSTRAINT fk_route_stops_stop REFERENCES bus_stops(stop_id) ON DELETE CASCADE,
    sequence NUMBER(5) CONSTRAINT nn_route_stops_seq NOT NULL
);

-- 8. BUS_SCHEDULES (Child of ROUTES)
CREATE TABLE bus_schedules (
    schedule_id NUMBER(10) CONSTRAINT pk_bus_schedules PRIMARY KEY,
    trip_id NUMBER(10),
    route_id NUMBER(10) CONSTRAINT fk_schedules_route REFERENCES routes(route_id) ON DELETE CASCADE,
    start_time VARCHAR2(10),
    end_time VARCHAR2(10),
    headway_secs NUMBER(10) CONSTRAINT ck_schedules_headway CHECK (headway_secs > 0)
);

-- 9. FARES (Child of AGENCIES)
CREATE TABLE fares (
    fare_id NUMBER(10) CONSTRAINT pk_fares PRIMARY KEY,
    price NUMBER(10,2) CONSTRAINT ck_fares_price CHECK (price >= 0),
    currency_type VARCHAR2(10) DEFAULT 'RWF',
    payment_method NUMBER(2) DEFAULT 0 CONSTRAINT ck_fares_payment CHECK (payment_method IN (0,1)),
    transfers NUMBER(2) DEFAULT 0,
    agency_id NUMBER(10) CONSTRAINT fk_fares_agency REFERENCES agencies(agency_id) ON DELETE CASCADE
);

-- 10. SURVEY_RESPONSES (Child of AREAS and PASSENGERS)
CREATE TABLE survey_responses (
    response_id NUMBER(10) CONSTRAINT pk_survey_responses PRIMARY KEY,
    passenger_id NUMBER(10) CONSTRAINT fk_survey_passenger REFERENCES passengers(passenger_id) ON DELETE SET NULL,
    origin_area_id NUMBER(10) CONSTRAINT fk_survey_origin REFERENCES areas(area_id) ON DELETE SET NULL,
    destination_area_id NUMBER(10) CONSTRAINT fk_survey_dest REFERENCES areas(area_id) ON DELETE SET NULL,
    travel_period VARCHAR2(50),
    usual_wait_time NUMBER(5),
    usual_journey_time NUMBER(5),
    buses_used NUMBER(2),
    delay_frequency VARCHAR2(50),
    main_delay_cause VARCHAR2(100),
    route_convenience VARCHAR2(50),
    recommendation_interest VARCHAR2(50)
);

-- 11. DELAY_REPORTS (Child of ROUTES and BUS_STOPS)
CREATE TABLE delay_reports (
    delay_id NUMBER(10) CONSTRAINT pk_delay_reports PRIMARY KEY,
    route_id NUMBER(10) CONSTRAINT fk_delay_route REFERENCES routes(route_id) ON DELETE CASCADE,
    stop_id NUMBER(10) CONSTRAINT fk_delay_stop REFERENCES bus_stops(stop_id) ON DELETE SET NULL,
    delay_duration NUMBER(5) CONSTRAINT ck_delay_duration CHECK (delay_duration > 0),
    delay_cause VARCHAR2(200),
    report_date DATE DEFAULT SYSDATE
);

-- 12. ROUTE_RECOMMENDATIONS (Child of AREAS and ROUTES)
CREATE TABLE route_recommendations (
    recommendation_id NUMBER(10) CONSTRAINT pk_route_recs PRIMARY KEY,
    origin_area_id NUMBER(10) CONSTRAINT fk_recs_origin REFERENCES areas(area_id) ON DELETE CASCADE,
    destination_area_id NUMBER(10) CONSTRAINT fk_recs_dest REFERENCES areas(area_id) ON DELETE CASCADE,
    route_id NUMBER(10) CONSTRAINT fk_recs_route REFERENCES routes(route_id) ON DELETE CASCADE,
    estimated_duration NUMBER(5),
    transfer_count NUMBER(2) DEFAULT 0,
    recommendation_date DATE DEFAULT SYSDATE
);
