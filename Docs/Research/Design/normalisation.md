# Phase II — Normalization (UNF → 1NF → 2NF → 3NF)

This document shows how the raw GTFS data and survey data are normalized into 3NF using the table names from the project schema.

## 1. Unnormalized Form (UNF)

The raw GTFS data arrives as separate flat `.txt` files. If we combine them into one flat view (as a data analyst might first do), we get repeating groups and mixed entities.

**Raw Data Example (UNF):**

| route_id | agency_name | route_short_name | route_desc | shape_id | shape_pt_lat | shape_pt_lon | trip_id | headway_secs | fare_price | currency |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | KBS | 101 | Remera Taxi Park-Sonatubes... | 22456199 | -1.934768 | 30.17409 | 24626201 | 1200 | 220 | RWF |
| 101 | KBS | 101 | Remera Taxi Park-Sonatubes... | 22456199 | -1.934986 | 30.174126 | 24626201 | 1200 | 220 | RWF |
| 101 | KBS | 101 | Remera Taxi Park-Sonatubes... | 22456199 | -1.935269 | 30.174126 | 24626201 | 1200 | 220 | RWF |
| 301 | RFTC | 301 | Kinyinya - Nyarutarama... | 22466898 | -1.979207 | 30.223349 | 24729990 | 1200 | 297 | RWF |

*Issues:* Repeating groups (multiple GPS points per route), mixed entities (agency, route, shape, schedule, fare all in one row), and partial dependencies.

---

## 2. First Normal Form (1NF)

**Rule:** Remove repeating groups; every column must hold a single value; assign a primary key.

We separate the GPS points into their own table. The repeating group `(shape_pt_lat, shape_pt_lon)` is moved to a `ROUTE_STOPS` table.

**1NF Table: `RAW_ROUTE_DATA`**

| route_id | agency_name | route_short_name | trip_id | headway_secs | fare_price | shape_id | shape_pt_sequence | shape_pt_lat | shape_pt_lon |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | KBS | 101 | 24626201 | 1200 | 220 | 22456199 | 0 | -1.934768 | 30.17409 |
| 101 | KBS | 101 | 24626201 | 1200 | 220 | 22456199 | 1 | -1.934986 | 30.174126 |
| 301 | RFTC | 301 | 24729990 | 1200 | 297 | 22466898 | 0 | -1.979207 | 30.223349 |

*Key:* `(route_id, shape_pt_sequence)` identifies a unique row.

---

## 3. Second Normal Form (2NF)

**Rule:** Remove partial dependencies (columns that depend on only part of the primary key).

Looking at the 1NF table:
- `agency_name` depends on `route_id` (not on the whole key).
- `trip_id` and `headway_secs` depend on `trip_id` and `route_id` (schedule details).
- `fare_price` depends on `route_id`.
- `shape_pt_lat` and `shape_pt_lon` depend entirely on `(shape_id, shape_pt_sequence)`.

We split the 1NF table into separate tables using the project’s planned names:

**`ROUTES` Table (Partial dependency removed):**
| route_id | route_short_name | route_long_name | route_type | route_desc | agency_name |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | 101 | KBS - Zone I - 101 | 3 | Remera Taxi Park-Sonatubes... | KBS |
| 301 | 301 | RFTC - Zone III and IV - 301 | 3 | Kinyinya - Nyarutarama... | RFTC |

**`ROUTE_STOPS` Table (Partial dependency removed):**
| route_stop_id | route_id | stop_id | latitude | longitude | sequence |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 101 | 1 | -1.934768 | 30.17409 | 0 |
| 2 | 101 | 2 | -1.934986 | 30.174126 | 1 |
| 3 | 301 | 1 | -1.979207 | 30.223349 | 0 |

**`BUS_SCHEDULES` Table (Partial dependency removed):**
| schedule_id | trip_id | route_id | start_time | end_time | headway_secs |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 24626201 | 101 | 15:00:00 | 18:00:00 | 1200 |
| 2 | 24729990 | 301 | 06:00:00 | 10:00:00 | 1200 |

**`FARES` Table (Partial dependency removed):**
| fare_id | route_id | price | currency_type |
| :--- | :--- | :--- | :--- |
| 0 | 101 | 220 | RWF |
| 29 | 301 | 297 | RWF |

---

## 4. Third Normal Form (3NF)

**Rule:** Remove transitive dependencies (non-key columns depending on other non-key columns).

- In the `ROUTES` table, `agency_name` depends on `agency_id`, not directly on `route_id`. We move agency data to its own table (`AGENCIES`).
- In the `BUS_SCHEDULES` table, `route_id` is a foreign key, which is fine, but we ensure no other transitive dependencies exist.
- In the `FARES` table, `currency_type` and `price` depend on the fare, but `agency_id` also defines the fare structure. We separate `AGENCIES` from `FARES`.

**Final 3NF Tables (using instructor’s names):**

**`AGENCIES`**
| agency_id | agency_name | agency_timezone |
| :--- | :--- | :--- |
| 1 | KBS | (blank) |
| 3 | RFTC | (blank) |
| 2 | Royal Express | (blank) |

**`ROUTES`**
| route_id | agency_id | route_short_name | route_long_name | route_type | route_desc |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | 1 | 101 | KBS - Zone I - 101 | 3 | Remera Taxi Park-Sonatubes... |
| 301 | 3 | 301 | RFTC - Zone III and IV - 301 | 3 | Kinyinya - Nyarutarama... |

**`ROUTE_STOPS`**
| route_stop_id | route_id | stop_id | latitude | longitude | sequence |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 101 | 1 | -1.934768 | 30.17409 | 0 |
| 2 | 101 | 2 | -1.934986 | 30.174126 | 1 |
| 3 | 301 | 1 | -1.979207 | 30.223349 | 0 |

**`BUS_SCHEDULES`**
| schedule_id | trip_id | route_id | start_time | end_time | headway_secs |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 24626201 | 101 | 15:00:00 | 18:00:00 | 1200 |
| 2 | 24729990 | 301 | 06:00:00 | 10:00:00 | 1200 |

**`FARES`**
| fare_id | price | currency_type | payment_method | transfers | agency_id |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 220 | RWF | 0 | 0 | 1 |
| 29 | 297 | RWF | 0 | 0 | 3 |

---

## 5. Dependency Summary

| Table | Original Issue | Dependency Removed |
| :--- | :--- | :--- |
| `ROUTES` | `agency_name` was in the raw row. | Transitive dependency: `route_id` → `agency_id` → `agency_name`. Moved to `AGENCIES`. |
| `ROUTE_STOPS` | Repeating GPS points in a single row. | Repeating group removed (1NF). |
| `BUS_SCHEDULES` | `headway_secs` mixed with route data. | Partial dependency removed (2NF). |
| `FARES` | `price` and `currency` were mixed with routes. | Partial dependency removed (2NF); `agency_id` kept as a foreign key. |
