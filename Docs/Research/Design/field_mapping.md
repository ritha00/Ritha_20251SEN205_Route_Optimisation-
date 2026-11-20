# Phase II — Raw Field to Target Column Mapping

This table maps every field from the raw GTFS files to the target 3NF tables. It also notes any type conversions required (this becomes the cleaning checklist for Phase IV).

## 1. From `agency.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `agency_id` | `AGENCIES` | `agency_id` | Text to NUMBER | Keep |
| `agency_name` | `AGENCIES` | `agency_name` | None | Keep |
| `agency_url` | `AGENCIES` | (dropped) | None | Drop (all blank) |
| `agency_timezone` | `AGENCIES` | `agency_timezone` | None | Keep (will be null) |

## 2. From `routes.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `route_id` | `ROUTES` | `route_id` | Text to NUMBER | Keep |
| `agency_id` | `ROUTES` | `agency_id` | Text to NUMBER | Keep (FK) |
| `route_short_name` | `ROUTES` | `route_short_name` | None | Keep |
| `route_long_name` | `ROUTES` | `route_long_name` | None | Keep |
| `route_type` | `ROUTES` | `route_type` | Text to NUMBER | Keep |
| `route_desc` | `ROUTES` | `route_desc` | None | Keep |

## 3. From `shapes.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `shape_id` | `ROUTE_STOPS` | `shape_id` (or `route_stop_id` context) | Text to NUMBER | Keep |
| `shape_pt_sequence` | `ROUTE_STOPS` | `sequence` | Text to NUMBER | Keep |
| `shape_pt_lat` | `ROUTE_STOPS` | `latitude` | Text to NUMBER | Keep |
| `shape_pt_lon` | `ROUTE_STOPS` | `longitude` | Text to NUMBER | Keep |

*Note: To link `shapes.txt` to a route, you must join with `trips.txt` (which is not included in the extracted files). For Phase IV, we will assume the `shape_id` implicitly maps to the `route_id` or we will create a temporary mapping table.*

## 4. From `frequencies.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `trip_id` | `BUS_SCHEDULES` | `trip_id` | Text to NUMBER | Keep |
| `start_time` | `BUS_SCHEDULES` | `start_time` | Text to DATE/TIMESTAMP | Convert |
| `end_time` | `BUS_SCHEDULES` | `end_time` | Text to DATE/TIMESTAMP | Convert |
| `headway_secs` | `BUS_SCHEDULES` | `headway_secs` | Text to NUMBER | Keep |
| *(Implicit)* | `BUS_SCHEDULES` | `route_id` | Text to NUMBER | Derive from `trip_id` |

## 5. From `fare_attributes.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `fare_id` | `FARES` | `fare_id` | Text to NUMBER | Keep |
| `price` | `FARES` | `price` | Text to NUMBER | Keep |
| `currency_type` | `FARES` | `currency_type` | None | Keep |
| `payment_method` | `FARES` | `payment_method` | Text to NUMBER | Keep |
| `transfers` | `FARES` | `transfers` | Text to NUMBER | Keep |
| `agency_id` | `FARES` | `agency_id` | Text to NUMBER | Keep (FK) |

## 6. From `fare_rules.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `fare_id` | `FARES` | `fare_id` | Text to NUMBER | Keep (FK) |
| `route_id` | `ROUTES` | `route_id` | Text to NUMBER | Keep (FK) |

*Note: `fare_rules.txt` is a junction table linking `FARES` and `ROUTES`.*

## 7. From `calendar.txt`

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| `service_id` | `BUS_SCHEDULES` | (derived) | Text to NUMBER | Drop (handled by schedule logic) |
| `start_date` | `BUS_SCHEDULES` | (derived) | Text to DATE | Convert |
| `end_date` | `BUS_SCHEDULES` | (derived) | Text to DATE | Convert |
| `monday` ... `sunday` | `BUS_SCHEDULES` | (derived) | Text to NUMBER | Convert to day flags |

## 8. From `SURVEY_RESPONSES` (your Google Form data)

| Raw Field | Target Table | Target Column | Type Conversion | Action |
| :--- | :--- | :--- | :--- | :--- |
| Origin area | `SURVEY_RESPONSES` | `origin_area_id` | Text to NUMBER | Map to `AREAS` table |
| Destination area | `SURVEY_RESPONSES` | `destination_area_id` | Text to NUMBER | Map to `AREAS` table |
| Travel period | `SURVEY_RESPONSES` | `travel_period` | None | Keep |
| Usual waiting time | `SURVEY_RESPONSES` | `usual_wait_time` | Text to NUMBER | Keep |
| Usual journey duration | `SURVEY_RESPONSES` | `usual_journey_time` | Text to NUMBER | Keep |
| Number of buses used | `SURVEY_RESPONSES` | `buses_used` | Text to NUMBER | Keep |
| Delay frequency | `SURVEY_RESPONSES` | `delay_frequency` | None | Keep |
| Main delay cause | `SURVEY_RESPONSES` | `main_delay_cause` | None | Keep |
| Route convenience | `SURVEY_RESPONSES` | `route_convenience` | None | Keep |
| Interest in recommendations | `SURVEY_RESPONSES` | `recommendation_interest` | None | Keep |
