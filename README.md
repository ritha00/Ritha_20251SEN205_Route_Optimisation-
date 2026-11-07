#  PUBLIC TRANSPORTATION MANAGEMENT AND ROUTE OPTIMIZATION SYSTEM

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

## 3. DATA SOURCE AND COLLECTION PLAN

**Dataset Name:** Kigali Public Transport Passenger Survey

### 3.1 Primary Data Source

Data will be collected directly from public transportation passengers in Kigali, Rwanda, through an anonymous questionnaire using Google Forms or paper-based surveys.

### 3.2 Dataset Size

Target of at least **300 valid passenger responses**.

### 3.3 Dataset Characteristics

The dataset will contain passenger travel information, including:

- Origin area
- Destination area
- Travel period
- Usual waiting time
- Usual journey duration
- Number of buses used
- Delay frequency
- Main delay cause
- Route convenience
- Interest in route recommendations

### 3.4 Data Usage

The collected survey data will be cleaned, validated and imported into the Oracle database to populate the `SURVEY_RESPONSES` table.

It will support passenger travel analysis, transportation demand identification, waiting-time analysis and route recommendation development.

### 3.5 Additional Data Sources

- **Digital Transport for Africa:** Kigali GTFS dataset for bus routes, stops and schedules, subject to licence and permission verification.
- **National Institute of Statistics of Rwanda (NISR):** Reports for public transportation accessibility information.
- **University of Rwanda:** Research on bus waiting times and scheduled bus operations in Kigali.
- **Rwanda Utilities Regulatory Authority (RURA):** Regulations for public transportation management requirements.

### 3.6 Data Privacy

No names, telephone numbers, national identification numbers or exact home addresses will be collected from survey participants.

Data collection will be subject to institutional approval and voluntary participant consent.

---

## 4. PLANNED DATABASE SCHEMA (3NF TARGET)

The proposed Oracle database will contain the following main tables:

| Table Name | Description |
|---|---|
| `AREAS` | Stores area names and districts. |
| `PASSENGERS` | Stores optional anonymous passenger references. |
| `BUSES` | Stores bus identification, capacity, operator and status. |
| `BUS_STOPS` | Stores bus stop information and geographical coordinates. |
| `ROUTES` | Stores route information, origin, destination and estimated duration. |
| `ROUTE_STOPS` | Connects routes with bus stops and their sequence. |
| `BUS_SCHEDULES` | Stores bus departure and arrival schedules. |
| `SURVEY_RESPONSES` | Stores anonymous passenger survey responses. |
| `DELAY_REPORTS` | Stores reported transportation delays. |
| `ROUTE_RECOMMENDATIONS` | Stores recommended journeys and transfer information. |

### 4.1 Table Attributes

- **AREAS:** (area_id, area_name, district)
- **PASSENGERS:** (passenger_id, passenger_code, registration_date)
- **BUSES:** (bus_id, bus_code, capacity, operator_name, bus_status)
- **BUS_STOPS:** (stop_id, stop_name, area_id, latitude, longitude)
- **ROUTES:** (route_id, route_name, origin_area_id, destination_area_id, estimated_duration, route_status)
- **ROUTE_STOPS:** (route_stop_id, route_id, stop_id, stop_sequence)
- **BUS_SCHEDULES:** (schedule_id, bus_id, route_id, departure_time, arrival_time, operating_day)
- **SURVEY_RESPONSES:** (response_id, origin_area_id, destination_area_id, travel_period, usual_wait_time, usual_journey_time, buses_used, delay_frequency, main_delay_cause, route_convenience, recommendation_interest)
- **DELAY_REPORTS:** (delay_id, route_id, stop_id, delay_duration, delay_cause, report_date)
- **ROUTE_RECOMMENDATIONS:** (recommendation_id, origin_area_id, destination_area_id, route_id, estimated_duration, transfer_count, recommendation_date)

---

## 5. PLANNED PL/SQL FEATURES

### 5.1 Packages

**PKG_TRANSPORT_MANAGEMENT**

Encapsulates bus, route, bus stop and schedule management operations.

**PKG_PASSENGER_ANALYTICS**

Handles passenger survey analysis, waiting-time calculations and transportation demand reports.

**PKG_ROUTE_OPTIMIZATION**

Implements route comparison and recommendation operations using available transportation information.

### 5.2 Stored Procedures

| Procedure | Function |
|---|---|
| `PRC_ADD_BUS` | Registers new buses in the database. |
| `PRC_ADD_ROUTE` | Registers and manages transportation routes. |
| `PRC_ADD_BUS_STOP` | Adds new bus stops. |
| `PRC_ADD_SURVEY_RESPONSE` | Inserts passenger survey responses. |
| `PRC_RECORD_DELAY` | Records reported transportation delays. |
| `PRC_GENERATE_TRANSPORT_REPORT` | Generates transportation management reports. |

### 5.3 Functions

| Function | Purpose |
|---|---|
| `FNC_CALCULATE_AVERAGE_WAITING_TIME` | Calculates average passenger waiting time. |
| `FNC_CALCULATE_AVERAGE_JOURNEY_TIME` | Calculates average journey duration. |
| `FNC_COUNT_ROUTE_TRANSFERS` | Determines the number of transfers required for a journey. |
| `FNC_GET_ROUTE_DEMAND` | Calculates passenger demand for a particular route or journey. |
| `FNC_GET_POPULAR_DESTINATION` | Identifies the most frequently reported destination. |

### 5.4 Triggers

- `TRG_SURVEY_DATE`: Automatically records the date when a survey response is inserted.
- `TRG_DELAY_DATE`: Automatically records delay report dates.
- `TRG_ROUTE_STATUS`: Validates route status changes.
- `TRG_BUS_ID`: Generates or validates bus identifiers if identity columns are not used.

### 5.5 Cursors

Explicit cursors will be used to process multiple passenger records, analyze route demand and generate transportation reports.

### 5.6 Exception Handling

PL/SQL exception handling will manage invalid records, duplicate entries, missing information and database operation errors.

### 5.7 Views

Database views will provide summarized information about passenger demand, bus routes, waiting times and reported delays.

---

## 6. PLANNED INNOVATION: TRANSPORTATION MANAGEMENT AND ROUTE RECOMMENDATION

**Innovation Type:** Passenger-Based Transportation Analysis and Route Recommendation System.

**Technology Stack:** Oracle Database, PL/SQL, SQL and a selected application interface for passenger and administrator interaction.

### 6.1 Innovation Description

The proposed innovation is a centralized transportation management system designed around the public transportation needs of Kigali, Rwanda.

It will combine passenger survey information, route management, bus stop information, available schedules and transportation delay analysis to support convenient journey planning and better transport management.

### 6.2 Key Features

**1. Route Recommendations**

Compare available routes and recommend convenient journeys based on estimated journey duration and bus transfers.

**2. Passenger Travel Analysis**

Analyze passenger origins, destinations and travel periods.

**3. Waiting-Time Analysis**

Calculate and analyze average passenger waiting times.

**4. Delay Monitoring**

Identify common reported causes and patterns of transportation delays.

**5. Transportation Demand Analysis**

Identify frequently reported routes and popular destinations.

**6. Management Reports**

Generate useful reports to support transport planning and decision-making.

### 6.3 Future Enhancements

The system will initially use collected passenger survey data and verified transport information.

Real-time traffic monitoring and live vehicle tracking may be considered future enhancements if reliable data sources and integrations become available.

---

## 7. GITHUB REPOSITORY STRUCTURE

The project files will be organized into separate folders to ensure proper documentation, database development, data management and innovation implementation.

```text
MUNEZERO_Isimbi_Ritha_20251SEN205_publicTransportSystem/
│
├── README.md
│
├── docs/
│   │
│   ├── research/
│   │   └── research_log.md
│   │
│   ├── proposal/
│   │   └── proposal.pdf
│   │
│   ├── presentation/
│   │
│   └── architecture/
│       └── er_diagram.png
│
├── data/
│   │
│   ├── raw/
│   │   └── kigali_transport_survey.csv
│   │
│   ├── processed/
│   │   └── cleaned_transport_survey.csv
│   │
│   └── scripts/
│       └── data_import.sql
│
├── sql/
│   │
│   ├── ddl/
│   │   ├── create_tables.sql
│   │   └── constraints.sql
│   │
│   ├── dml/
│   │   └── insert_data.sql
│   │
│   ├── plsql/
│   │   ├── packages.sql
│   │   ├── procedures.sql
│   │   ├── functions.sql
│   │   └── cursors.sql
│   │
│   ├── triggers/
│   │   └── triggers.sql
│   │
│   └── reports/
│       └── transport_reports.sql
│
└── innovation/
    │
    ├── interface_design/
    │
    ├── route_recommendations/
    │
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

**Developed by:** MUNEZERO Isimbi Ritha

**Student ID:** 20251SEN205

**Institution:** Adventist University of Central Africa (AUCA)

**Course:** INSY 8311 – Database Development with PL/SQL

**Academic Year:** 2026–2027
