# Phase II — Logical ERD (Crow's Foot)

```mermaid
erDiagram
    AGENCIES ||--o{ ROUTES : "operates"
    ROUTES ||--o{ ROUTE_STOPS : "has"
    BUS_STOPS ||--o{ ROUTE_STOPS : "is part of"
    AREAS ||--o{ BUS_STOPS : "contains"
    
    ROUTES ||--o{ BUS_SCHEDULES : "has"
    ROUTES ||--o{ FARES : "priced by"
    ROUTES ||--o{ DELAY_REPORTS : "experiences"
    BUS_STOPS ||--o{ DELAY_REPORTS : "occurs at"
    
    AREAS ||--o{ SURVEY_RESPONSES : "origin"
    AREAS ||--o{ SURVEY_RESPONSES : "destination"
    
    AREAS ||--o{ ROUTE_RECOMMENDATIONS : "origin"
    AREAS ||--o{ ROUTE_RECOMMENDATIONS : "destination"
    ROUTES ||--o{ ROUTE_RECOMMENDATIONS : "recommended route"
    
    PASSENGERS ||--o{ SURVEY_RESPONSES : "submits (optional)"

    AGENCIES {
        number agency_id PK
        varchar agency_name
        varchar agency_timezone
    }

    AREAS {
        number area_id PK
        varchar area_name
        varchar district
    }

    PASSENGERS {
        number passenger_id PK
        varchar passenger_code
        date registration_date
    }

    BUSES {
        number bus_id PK
        varchar bus_code
        number capacity
        varchar operator_name
        varchar bus_status
    }

    BUS_STOPS {
        number stop_id PK
        varchar stop_name
        number area_id FK
        number latitude
        number longitude
    }

    ROUTES {
        number route_id PK
        number agency_id FK
        varchar route_short_name
        varchar route_long_name
        number route_type
        varchar route_desc
    }

    ROUTE_STOPS {
        number route_stop_id PK
        number route_id FK
        number stop_id FK
        number sequence
    }

    BUS_SCHEDULES {
        number schedule_id PK
        number trip_id
        number route_id FK
        date start_time
        date end_time
        number headway_secs
    }

    FARES {
        number fare_id PK
        number price
        varchar currency_type
        number payment_method
        number transfers
        number agency_id FK
    }

    SURVEY_RESPONSES {
        number response_id PK
        number origin_area_id FK
        number destination_area_id FK
        varchar travel_period
        number usual_wait_time
        number usual_journey_time
        number buses_used
        varchar delay_frequency
        varchar main_delay_cause
        varchar route_convenience
        varchar recommendation_interest
    }

    DELAY_REPORTS {
        number delay_id PK
        number route_id FK
        number stop_id FK
        number delay_duration
        varchar delay_cause
        date report_date
    }

    ROUTE_RECOMMENDATIONS {
        number recommendation_id PK
        number origin_area_id FK
        number destination_area_id FK
        number route_id FK
        number estimated_duration
        number transfer_count
        date recommendation_date
    }
