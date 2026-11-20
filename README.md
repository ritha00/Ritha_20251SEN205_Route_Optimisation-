# PUBLIC TRANSPORTATION MANAGEMENT AND ROUTE OPTIMIZATION SYSTEM

### Kigali, Rwanda

---

## PROJECT INFORMATION

**Student Name:** MUNEZERO Isimbi Ritha

**Student ID:** 20251SEN205

**Course:** INSY 8311 – Database Development with PL/SQL

**Instructor:** Eric Maniraguha

**Institution:** Adventist University of Central Africa (AUCA)

**Academic Year:** 2026–2027 (Semester I)

**Repository Name:** `Ritha_20251SEN205_Route_Optimisation`

---

## 1. PROBLEM STATEMENT

Public transportation plays an important role in the daily lives of people in Kigali, Rwanda. However, passengers frequently experience challenges such as long bus waiting times, traffic-related delays, inconvenient routes, multiple bus transfers and difficulties identifying the most suitable journeys to their destinations.

Additionally, limited access to organized transportation information makes it difficult for passengers to plan their journeys effectively and for transport managers to understand passenger demand, waiting times and common transportation problems.

This project aims to develop a **Public Transportation Management and Route Optimization System** using Oracle Database and PL/SQL. The system will centralize public transportation information, including bus routes, bus stops, schedules, passenger travel patterns and reported delays.

Through database management, data analysis and route recommendation mechanisms, the system will help passengers identify convenient journeys based on available transport information while providing useful reports to support better transportation planning and management in Kigali, Rwanda.

---

## 2. PROJECT OBJECTIVES

### 2.1 Main Objective

To design and develop a Public Transportation Management and Route Optimization System that improves journey planning and supports efficient public transportation management in Kigali, Rwanda.

### 2.2 Specific Objectives

1. **Database Architecture:** Design and implement a structured relational database using Third Normal Form (3NF) to manage passenger information, buses, routes, bus stops, schedules and transportation records.
2. **Passenger Data Analysis:** Collect and analyze passenger travel patterns, waiting times, journey durations and reported transportation delays.
3. **Route Management:** Develop database operations for registering, updating and managing bus routes, stops and schedules.
4. **Route Optimization:** Implement route recommendation mechanisms that compare available journeys using estimated travel duration, waiting time and the number of bus transfers.
5. **Transportation Reporting:** Generate reports that identify passenger demand, popular destinations, average waiting times and common causes of delays.
6. **PL/SQL Automation:** Implement stored procedures, functions, triggers, cursors and packages to automate transportation database operations.

---

## 3. BUSINESS PROCESS MODELING (PHASE I)

The system's operational flow is modeled using a BPMN swimlane diagram, detailing the interaction between the Passenger, the Transport Management System, the Transport Operator, and the Monitoring module.

### 3.1 Process Description

The process begins when a passenger submits a travel request by providing a pickup location, destination, and preferred departure time. The system gathers transportation data, including bus GPS locations, traffic conditions, and passenger demand. It then estimates bus arrival and journey times before optimizing available routes. Once a suitable route is identified, the Transport Operator checks vehicle availability, assigns a bus and driver, and dispatches the bus. During the journey, the Monitoring function tracks the bus and identifies delays or disruptions. If a disruption occurs, the system recalculates the route and updates the passenger. Finally, the system evaluates journey performance to improve future transportation services.

### 3.2 Actors and Responsibilities

- **Passenger:** Submits travel requests and receives journey estimates, notifications, and updates.
- **Transportation Management System:** Processes requests, gathers data, estimates travel times, and optimizes routes.
- **Transport Operator:** Checks vehicle availability, assigns buses and drivers, and dispatches vehicles.
- **Monitoring:** Tracks bus locations, detects delays, records journey performance, and reports disruptions.

### 3.3 Key Decisions in the Process

- **Is a suitable route available?** If yes, the system selects it; if not, it evaluates alternative routes.
- **Is a vehicle available?** If yes, a bus and driver are assigned; if not, the passenger is informed and given alternatives.
- **Is there a major delay or disruption?** If yes, the system recalculates the route and updates the passenger; if not, the journey continues as planned.

### 3.4 Business Process Files

The detailed business process diagram and its written explanation are stored in the repository under `docs/business_process/`.

- `business_process_diagram.png`
- `business_process_explanation.pdf`

---

## 4. DATA SOURCE AND COLLECTION PLAN

To build a robust database, this project utilizes **real-world GTFS (General Transit Feed Specification) data** for Kigali, supplemented by primary data collection.

### 4.1 Primary Data Source: Kigali GTFS Dataset

- **Source:** Mobility Database (Kigali Bus Services, dry conditions data collection)
- **Feed ID:** `mdb-1961`
- **Mobility Database Link:** `https://mobilitydatabase.org/feeds/gtfs/mdb-1961`
- **Original Producer URL (GitLab):** `https://gitlab.com/digitaltransport/data/africa/kigali/-/raw/main/GTFS%20Datasets/Kigali_GTFS.zip?ref_type=heads&inline=false`
- **Service Date Range:** February 25, 2019 – February 25, 2021 (dry conditions dataset)
- **Format:** GTFS (`.txt` files zipped as `Kigali_GTFS.zip`)
- **Contents:** This dataset contains real transit data for Kigali, including agencies (`agency.txt`), routes (`routes.txt`), shapes/geolocations (`shapes.txt`), schedules/frequencies (`frequencies.txt`), and fares (`fare_attributes.txt`, `fare_rules.txt`). Agencies included are Kigali Bus Services (KBS), Royal Express, and Rwanda Federation of Transport Cooperatives (RFTC).
- **Data Volume:** Thousands of records (e.g., thousands of GPS coordinate points in `shapes.txt`, multiple route definitions, and frequency data).
- **License:** Public use, suitable for educational purposes. The original data is produced by the Digital Transport for Africa initiative.
- **Data Privacy:** The dataset contains no personal identifying information (PII) and is strictly related to transit infrastructure and schedules.

### 4.2 Supplementary Data Source: Kigali Public Transport Passenger Survey

- **Source:** Anonymous questionnaire for passengers in Kigali.
- **Target Size:** At least 300 valid responses.
- **Purpose:** To populate the `SURVEY_RESPONSES` table and analyze passenger waiting times, demand, and delay frequency.

### 4.3 Additional Data Sources (Contextual)

- **National Institute of Statistics of Rwanda (NISR):** Reports for public transportation accessibility information.
- **Rwanda Utilities Regulatory Authority (RURA):** Regulations for public transportation management requirements.

---

## 5. PLANNED DATABASE SCHEMA (3NF TARGET)

The proposed Oracle database will contain the following main tables (derived from the raw GTFS and survey data):

| Table Name | Description |
| :--- | :--- |
| `AREAS` | Stores area names and districts (derived from route origins/destinations). |
| `AGENCIES` | Stores transport operators (e.g., KBS, RFTC, Royal Express). |
| `PASSENGERS` | Stores optional anonymous passenger references. |
| `BUSES` | Stores bus identification, capacity, operator and status. |
| `BUS_STOPS` | Stores bus stop information and geographical coordinates. |
| `ROUTES` | Stores route information, origin, destination and estimated duration. |
| `ROUTE_STOPS` | Connects routes with bus stops and their sequence (derived from `shapes.txt`). |
| `BUS_SCHEDULES` | Stores bus departure and arrival schedules (derived from `frequencies.txt`). |
| `FARES` | Stores fare prices, currency, and payment methods (derived from `fare_attributes.txt`). |
| `SURVEY_RESPONSES` | Stores anonymous passenger survey responses. |
| `DELAY_REPORTS` | Stores reported transportation delays. |
| `ROUTE_RECOMMENDATIONS` | Stores recommended journeys and transfer information. |

### 5.1 Table Attributes

- **AGENCIES:** (agency_id, agency_name, agency_url, agency_timezone)
- **ROUTES:** (route_id, agency_id, route_short_name, route_long_name, route_type, route_desc)
- **BUS_STOPS:** (stop_id, stop_name, area_id, latitude, longitude)
- **BUS_SCHEDULES:** (trip_id, route_id, start_time, end_time, headway_secs)
- **FARES:** (fare_id, price, currency_type, payment_method, transfers, agency_id)
- **ROUTE_STOPS:** (route_stop_id, route_id, shape_id, latitude, longitude, sequence)
- **SURVEY_RESPONSES:** (response_id, origin_area_id, destination_area_id, travel_period, usual_wait_time, usual_journey_time, buses_used, delay_frequency, main_delay_cause, route_convenience, recommendation_interest)
- **DELAY_REPORTS:** (delay_id, route_id, stop_id, delay_duration, delay_cause, report_date)
- **ROUTE_RECOMMENDATIONS:** (recommendation_id, origin_area_id, destination_area_id, route_id, estimated_duration, transfer_count, recommendation_date)

---

## 6. PLANNED PL/SQL FEATURES

### 6.1 Packages

- **PKG_TRANSPORT_MANAGEMENT:** Encapsulates bus, route, bus stop and schedule management operations.
- **PKG_PASSENGER_ANALYTICS:** Handles passenger survey analysis, waiting-time calculations and transportation demand reports.
- **PKG_ROUTE_OPTIMIZATION:** Implements route comparison and recommendation operations using available transportation information.

### 6.2 Stored Procedures

| Procedure | Function |
| :--- | :--- |
| `PRC_ADD_BUS` | Registers new buses in the database. |
| `PRC_ADD_ROUTE` | Registers and manages transportation routes. |
| `PRC_ADD_BUS_STOP` | Adds new bus stops. |
| `PRC_ADD_SURVEY_RESPONSE` | Inserts passenger survey responses. |
| `PRC_RECORD_DELAY` | Records reported transportation delays. |
| `PRC_GENERATE_TRANSPORT_REPORT` | Generates transportation management reports. |

### 6.3 Functions

| Function | Purpose |
| :--- | :--- |
| `FNC_CALCULATE_AVERAGE_WAITING_TIME` | Calculates average passenger waiting time. |
| `FNC_CALCULATE_AVERAGE_JOURNEY_TIME` | Calculates average journey duration. |
| `FNC_COUNT_ROUTE_TRANSFERS` | Determines the number of transfers required for a journey. |
| `FNC_GET_ROUTE_DEMAND` | Calculates passenger demand for a particular route or journey. |
| `FNC_GET_POPULAR_DESTINATION` | Identifies the most frequently reported destination. |

### 6.4 Triggers, Cursors & Views

- **Triggers:** `TRG_SURVEY_DATE` (auto-date), `TRG_DELAY_DATE` (auto-date), `TRG_ROUTE_STATUS` (validates status changes).
- **Cursors:** Explicit cursors for processing multiple passenger records and generating reports.
- **Views:** Database views summarizing passenger demand, bus routes, and delays.
- **Exception Handling:** PL/SQL exception handling will manage invalid records, duplicate entries, and missing information.

---

## 7. PLANNED INNOVATION: TRANSPORTATION MANAGEMENT AND ROUTE RECOMMENDATION

**Innovation Type:** Passenger-Based Transportation Analysis and Route Recommendation System.

**Technology Stack:** Oracle Database, PL/SQL, SQL, and a selected application interface (e.g., Oracle APEX or Python/Streamlit).

### 7.1 Innovation Description

The proposed innovation is a centralized transportation management system designed around the public transportation needs of Kigali. It will combine GTFS route data, passenger survey information, available schedules, and transportation delay analysis to support convenient journey planning and better transport management.

### 7.2 Key Features

1. **Route Recommendations:** Compare available routes and recommend convenient journeys based on estimated journey duration and bus transfers.
2. **Passenger Travel Analysis:** Analyze passenger origins, destinations, and travel periods.
3. **Waiting-Time Analysis:** Calculate and analyze average passenger waiting times.
4. **Delay Monitoring:** Identify common reported causes and patterns of transportation delays.
5. **Transportation Demand Analysis:** Identify frequently reported routes and popular destinations.
6. **Management Reports:** Generate useful reports to support transport planning and decision-making.

### 7.3 Future Enhancements

Real-time traffic monitoring and live vehicle tracking may be considered future enhancements if reliable data sources and integrations become available.

---

## 8. GITHUB REPOSITORY STRUCTURE

```text
Ritha_20251SEN205_Route_Optimisation/
│
├── README.md
│
├── docs/
│   ├── research/
│   │   └── research_log.md
│   ├── proposal/
│   │   └── proposal.pdf
│   ├── presentation/
│   ├── architecture/
│   │   └── er_diagram.png
│   ├── design/
│   │   └── normalization.md
│   └── business_process/
│       ├── business_process_diagram.png
│       └── business_process_explanation.pdf
│
├── data/
│   ├── raw/
│   │   ├── kigali_gtfs.zip
│   │   └── kigali_transport_survey.csv
│   ├── processed/
│   │   └── cleaned_transport_survey.csv
│   └── scripts/
│       └── data_import.sql
│
├── sql/
│   ├── ddl/
│   │   ├── create_tables.sql
│   │   └── constraints.sql
│   ├── dml/
│   │   └── insert_data.sql
│   ├── plsql/
│   │   ├── packages.sql
│   │   ├── procedures.sql
│   │   ├── functions.sql
│   │   └── cursors.sql
│   ├── triggers/
│   │   └── triggers.sql
│   └── reports/
│       └── transport_reports.sql
│
└── innovation/
    ├── interface_design/
    ├── route_recommendations/
    └── screenshots/
```

---

## 8. REFERENCES (APA STYLE)

1. Mutambuka, A. (2022). *Queue and waiting time in public transport management: Case study: Rwanda Federation Transport Cooperative (RFTC).* Master's dissertation, University of Rwanda.

2. Mizero, J. (2025). *Assessment of scheduled bus operations and its feasibility in the city of Kigali: Case study line 203.* Master's dissertation, University of Rwanda.

3. National Institute of Statistics of Rwanda. (2025). *EICV7 thematic report: Utilities and amenities 2023/24.*

4. Digital Transport for Africa. (2024). *GTFS: Kigali* [Dataset]. TUMI Datahub.

5. ECOFLEET SOLUTIONS. (n.d.). *Bisi* [Mobile application]. Google Play.

6. Rwanda Utilities Regulatory Authority. (2021). *Regulation No. 010/R/TLTPT/TRANS/RURA/2021 governing public transport bus services.*

---

## 9. PROJECT GOAL

The ultimate goal of this project is to develop a reliable, organized and data-driven public transportation management system that helps passengers make better travel decisions while supporting efficient transportation planning and management in Kigali, Rwanda.

---

