# Phase IV — Detailed Data Dictionary

## 1. AGENCIES
*Why this table exists:* To store the transport companies (KBS, RFTC, Royal Express) operating in Kigali. Created to remove transitive dependencies from the routes table (3NF).

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| agency_id | NUMBER(10) | No | PK (pk_agencies) | Surrogate key. Unique identifier for the agency. |
| agency_name | VARCHAR2(100) | No | NOT NULL (nn_agencies_name) | Name of the company. Required for reporting. |
| agency_timezone | VARCHAR2(50) | Yes | — | Timezone is optional because all agencies are local. |

## 2. AREAS
*Why this table exists:* To store Kigali neighborhoods and districts. Created to remove transitive dependencies (a stop belongs to an area, not the other way around).

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| area_id | NUMBER(10) | No | PK (pk_areas) | Surrogate key. |
| area_name | VARCHAR2(100) | No | NOT NULL (nn_areas_name) | Name of the area (e.g., Remera). |
| district | VARCHAR2(100) | No | NOT NULL (nn_areas_district) | Kigali district (e.g., Gasabo). |

## 3. PASSENGERS
*Why this table exists:* To store anonymous passenger references.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| passenger_id | NUMBER(10) | No | PK (pk_passengers) | Surrogate key. |
| passenger_code | VARCHAR2(20) | Yes | UNIQUE (uq_passengers_code) | Anonymous code to protect identity. |
| registration_date | DATE | No | DEFAULT SYSDATE (nn_passengers_date) | Automatically records when they joined. |

## 4. BUSES
*Why this table exists:* To store physical bus details.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| bus_id | NUMBER(10) | No | PK (pk_buses) | Surrogate key. |
| bus_code | VARCHAR2(20) | Yes | UNIQUE (uq_buses_code) | The license plate or bus number. |
| capacity | NUMBER(5) | Yes | CHECK > 0 (ck_buses_capacity) | Prevents entering negative or zero capacity. |
| operator_name | VARCHAR2(100) | Yes | — | Name of the driver/operator. |
| bus_status | VARCHAR2(20) | Yes | CHECK (ck_buses_status) | Ensures only 'ACTIVE', 'INACTIVE', 'MAINTENANCE' are used. |

## 5. BUS_STOPS
*Why this table exists:* To store the physical locations of bus stops.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| stop_id | NUMBER(10) | No | PK (pk_bus_stops) | Surrogate key. |
| stop_name | VARCHAR2(100) | No | NOT NULL (nn_stops_name) | Name of the stop. |
| area_id | NUMBER(10) | Yes | FK (fk_stops_area) | Links stop to its area. |
| latitude | NUMBER(10,6) | Yes | — | GPS coordinate. |
| longitude | NUMBER(10,6) | Yes | — | GPS coordinate. |

## 6. ROUTES
*Why this table exists:* It stores the actual bus routes. Created to remove partial dependencies from GTFS data.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| route_id | NUMBER(10) | No | PK (pk_routes) | Surrogate key. |
| agency_id | NUMBER(10) | Yes | FK (fk_routes_agency) | Links route to the operating agency. |
| route_short_name | VARCHAR2(20) | Yes | — | E.g., "101". |
| route_long_name | VARCHAR2(200) | Yes | — | Full descriptive name. |
| route_type | NUMBER(2) | Yes | CHECK (ck_routes_type) | 3 = bus. Check ensures only valid GTFS types. |
| route_desc | VARCHAR2(500) | Yes | — | Path description. |

## 7. ROUTE_STOPS
*Why this table exists:* Junction table resolving the many-to-many relationship between Routes and Stops.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| route_stop_id | NUMBER(10) | No | PK (pk_route_stops) | Surrogate key. |
| route_id | NUMBER(10) | Yes | FK (fk_route_stops_route) | Links to route. |
| stop_id | NUMBER(10) | Yes | FK (fk_route_stops_stop) | Links to stop. |
| sequence | NUMBER(5) | No | NOT NULL (nn_route_stops_seq) | The order the stop appears on the route. |

## 8. BUS_SCHEDULES
*Why this table exists:* It stores the frequency and times of the trips.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| schedule_id | NUMBER(10) | No | PK (pk_bus_schedules) | Surrogate key. |
| trip_id | NUMBER(10) | Yes | — | GTFS trip identifier. |
| route_id | NUMBER(10) | Yes | FK (fk_schedules_route) | Links to route. |
| start_time | VARCHAR2(10) | Yes | — | When the frequency starts. |
| end_time | VARCHAR2(10) | Yes | — | When the frequency ends. |
| headway_secs | NUMBER(10) | Yes | CHECK > 0 (ck_schedules_headway) | Seconds between buses. Cannot be negative. |

## 9. FARES
*Why this table exists:* Stores price information for routes.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| fare_id | NUMBER(10) | No | PK (pk_fares) | Surrogate key. |
| price | NUMBER(10,2) | Yes | CHECK >= 0 (ck_fares_price) | Prevents negative prices. |
| currency_type | VARCHAR2(10) | Yes | DEFAULT 'RWF' | Defaults to Rwandan Francs. |
| payment_method | NUMBER(2) | Yes | CHECK (ck_fares_payment) | 0 = onboard, 1 = before. |
| transfers | NUMBER(2) | Yes | DEFAULT 0 | Number of transfers allowed. |
| agency_id | NUMBER(10) | Yes | FK (fk_fares_agency) | Links to agency. |

## 10. SURVEY_RESPONSES
*Why this table exists:* Stores the data collected from the passenger survey.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| response_id | NUMBER(10) | No | PK (pk_survey_responses) | Surrogate key. |
| passenger_id | NUMBER(10) | Yes | FK (fk_survey_passenger) | Anonymous link to passenger. |
| origin_area_id | NUMBER(10) | Yes | FK (fk_survey_origin) | Starting area. |
| destination_area_id | NUMBER(10) | Yes | FK (fk_survey_dest) | Destination area. |
| travel_period | VARCHAR2(50) | Yes | — | Peak or off-peak. |
| usual_wait_time | NUMBER(5) | Yes | — | Average wait time. |
| usual_journey_time | NUMBER(5) | Yes | — | Average journey time. |
| buses_used | NUMBER(2) | Yes | — | Number of buses. |
| delay_frequency | VARCHAR2(50) | Yes | — | How often delays happen. |
| main_delay_cause | VARCHAR2(100) | Yes | — | Main cause of delay. |
| route_convenience | VARCHAR2(50) | Yes | — | How convenient the route is. |
| recommendation_interest | VARCHAR2(50) | Yes | — | Would they use the app? |

## 11. DELAY_REPORTS
*Why this table exists:* Stores reported delays to monitor system performance.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| delay_id | NUMBER(10) | No | PK (pk_delay_reports) | Surrogate key. |
| route_id | NUMBER(10) | Yes | FK (fk_delay_route) | Which route was affected. |
| stop_id | NUMBER(10) | Yes | FK (fk_delay_stop) | Where it happened. |
| delay_duration | NUMBER(5) | Yes | CHECK > 0 (ck_delay_duration) | Cannot be negative. |
| delay_cause | VARCHAR2(200) | Yes | — | What caused it. |
| report_date | DATE | Yes | DEFAULT SYSDATE | Automatically records today's date. |

## 12. ROUTE_RECOMMENDATIONS
*Why this table exists:* Stores the output of the route optimization algorithm.

| Column | Data type | Null? | Constraint | Why / description |
| :--- | :--- | :--- | :--- | :--- |
| recommendation_id | NUMBER(10) | No | PK (pk_route_recs) | Surrogate key. |
| origin_area_id | NUMBER(10) | Yes | FK (fk_recs_origin) | Starting area. |
| destination_area_id | NUMBER(10) | Yes | FK (fk_recs_dest) | Destination area. |
| route_id | NUMBER(10) | Yes | FK (fk_recs_route) | The recommended route. |
| estimated_duration | NUMBER(5) | Yes | — | Time it will take. |
| transfer_count | NUMBER(2) | Yes | DEFAULT 0 | Number of transfers. |
| recommendation_date | DATE | Yes | DEFAULT SYSDATE | When it was generated. |

## Foreign Key Decision Table (Task 4)

| Foreign key name | Child table | Parent table | Rule chosen | Why this rule |
| :--- | :--- | :--- | :--- | :--- |
| fk_routes_agency | ROUTES | AGENCIES | ON DELETE CASCADE | If an agency goes out of business, its routes should be removed. |
| fk_stops_area | BUS_STOPS | AREAS | ON DELETE SET NULL | If an area is deleted, the stop remains but without an area assigned. |
| fk_route_stops_route | ROUTE_STOPS | ROUTES | ON DELETE CASCADE | A stop sequence cannot exist without the route. |
| fk_route_stops_stop | ROUTE_STOPS | BUS_STOPS | ON DELETE CASCADE | If a stop is removed, it cannot remain on a route. |
| fk_schedules_route | BUS_SCHEDULES | ROUTES | ON DELETE CASCADE | Schedules depend entirely on routes. |
| fk_fares_agency | FARES | AGENCIES | ON DELETE CASCADE | Fare structures belong to the agency. |
| fk_survey_passenger | SURVEY_RESPONSES | PASSENGERS | ON DELETE SET NULL | Survey data should remain anonymous if a passenger is deleted. |
| fk_survey_origin | SURVEY_RESPONSES | AREAS | ON DELETE SET NULL | Keep the survey response even if the area is deleted. |
| fk_survey_dest | SURVEY_RESPONSES | AREAS | ON DELETE SET NULL | Keep the survey response even if the area is deleted. |
| fk_delay_route | DELAY_REPORTS | ROUTES | ON DELETE CASCADE | Delay reports belong to a route. |
| fk_delay_stop | DELAY_REPORTS | BUS_STOPS | NO ACTION | We chose NO ACTION here to prevent accidentally deleting a stop that has delay history. |
| fk_recs_origin | ROUTE_RECOMMENDATIONS | AREAS | ON DELETE CASCADE | Recommendation is tied to the origin area. |
| fk_recs_dest | ROUTE_RECOMMENDATIONS | AREAS | ON DELETE CASCADE | Recommendation is tied to the destination area. |
| fk_recs_route | ROUTE_RECOMMENDATIONS | ROUTES | ON DELETE CASCADE | Recommendations are tied to the route. |
