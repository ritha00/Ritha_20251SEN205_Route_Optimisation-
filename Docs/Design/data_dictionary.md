# Phase II — Data Dictionary (Logical Design)

## 1. AGENCIES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| agency_id | Unique identifier for the transport agency | PK | Yes | Yes |
| agency_name | Name of the agency (e.g., KBS, RFTC) | | Yes | No |
| agency_timezone | Timezone of the agency | | No | No |

## 2. AREAS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| area_id | Unique identifier for the area | PK | Yes | Yes |
| area_name | Name of the area | | Yes | No |
| district | District where the area is located | | Yes | No |

## 3. PASSENGERS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| passenger_id | Unique identifier for the passenger | PK | Yes | Yes |
| passenger_code | Anonymous code for the passenger | | Yes | Yes |
| registration_date | Date the passenger registered | | Yes | No |

## 4. BUSES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| bus_id | Unique identifier for the bus | PK | Yes | Yes |
| bus_code | Code printed on the bus | | Yes | Yes |
| capacity | Number of seats | | Yes | No |
| operator_name | Operator of the bus | | Yes | No |
| bus_status | Current status (active, inactive) | | Yes | No |

## 5. BUS_STOPS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| stop_id | Unique identifier for the bus stop | PK | Yes | Yes |
| stop_name | Name of the bus stop | | Yes | No |
| area_id | Area where the stop is located | FK | Yes | No |
| latitude | GPS latitude | | Yes | No |
| longitude | GPS longitude | | Yes | No |

## 6. ROUTES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| route_id | Unique identifier for the bus route | PK | Yes | Yes |
| agency_id | The agency operating the route | FK | Yes | No |
| route_short_name | Short name (e.g., 101) | | Yes | No |
| route_long_name | Full descriptive name | | Yes | No |
| route_type | Type of transport (3 = bus) | | Yes | No |
| route_desc | Description of the route path | | No | No |

## 7. ROUTE_STOPS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| route_stop_id | Unique identifier for the route-stop link | PK | Yes | Yes |
| route_id | The route this stop belongs to | FK | Yes | No |
| stop_id | The stop on the route | FK | Yes | No |
| sequence | Order of the stop on the route | | Yes | No |

## 8. BUS_SCHEDULES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| schedule_id | Unique identifier for the schedule | PK | Yes | Yes |
| trip_id | Unique trip identifier from GTFS | | Yes | No |
| route_id | The route this trip belongs to | FK | Yes | No |
| start_time | Start time of the frequency window | | Yes | No |
| end_time | End time of the frequency window | | Yes | No |
| headway_secs | Time between buses in seconds | | Yes | No |

## 9. FARES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| fare_id | Unique identifier for the fare | PK | Yes | Yes |
| price | Fare price in RWF | | Yes | No |
| currency_type | Currency (RWF) | | Yes | No |
| payment_method | 0 = on board, 1 = before boarding | | Yes | No |
| transfers | Number of transfers allowed | | Yes | No |
| agency_id | The agency that owns this fare | FK | Yes | No |

## 10. SURVEY_RESPONSES
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| response_id | Unique identifier for the survey response | PK | Yes | Yes |
| origin_area_id | Area where the journey started | FK | Yes | No |
| destination_area_id | Area where the journey ended | FK | Yes | No |
| travel_period | Time of day (peak/off-peak) | | Yes | No |
| usual_wait_time | Average waiting time in minutes | | Yes | No |
| usual_journey_time | Average journey time in minutes | | Yes | No |
| buses_used | Number of buses used | | Yes | No |
| delay_frequency | How often delays occur | | Yes | No |
| main_delay_cause | Main cause of delays | | No | No |
| route_convenience | Rating of route convenience | | Yes | No |
| recommendation_interest | Interest in route recommendations | | Yes | No |

## 11. DELAY_REPORTS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| delay_id | Unique identifier for the delay report | PK | Yes | Yes |
| route_id | The route affected | FK | Yes | No |
| stop_id | The stop where the delay occurred | FK | Yes | No |
| delay_duration | Duration of the delay in minutes | | Yes | No |
| delay_cause | Cause of the delay | | Yes | No |
| report_date | Date the delay was reported | | Yes | No |

## 12. ROUTE_RECOMMENDATIONS
| Column | Meaning | Key | Required | Unique |
| :--- | :--- | :--- | :--- | :--- |
| recommendation_id | Unique identifier for the recommendation | PK | Yes | Yes |
| origin_area_id | Starting area for the journey | FK | Yes | No |
| destination_area_id | Destination area for the journey | FK | Yes | No |
| route_id | Recommended route | FK | Yes | No |
| estimated_duration | Estimated journey duration | | Yes | No |
| transfer_count | Number of transfers required | | Yes | No |
| recommendation_date | Date the recommendation was generated | | Yes | No |

*(PK = Primary Key, FK = Foreign Key)*
