CREATE OR REPLACE VIEW vw_route_details AS
SELECT r.route_id, r.route_short_name, a.agency_name, 
       COUNT(rs.stop_id) AS total_stops
FROM routes r
LEFT JOIN agencies a ON r.agency_id = a.agency_id
LEFT JOIN route_stops rs ON r.route_id = rs.route_id
GROUP BY r.route_id, r.route_short_name, a.agency_name;

CREATE OR REPLACE VIEW vw_agency_route_summary AS
SELECT a.agency_name, COUNT(r.route_id) AS number_of_routes
FROM agencies a
LEFT JOIN routes r ON a.agency_id = r.agency_id
GROUP BY a.agency_name;

CREATE OR REPLACE VIEW vw_active_fares AS
SELECT fare_id, price, currency_type, agency_id
FROM fares
WHERE price > 0
WITH READ ONLY;
