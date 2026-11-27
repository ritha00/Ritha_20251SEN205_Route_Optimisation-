CREATE INDEX idx_routes_agency_id ON routes(agency_id);
CREATE INDEX idx_bus_stops_area_id ON bus_stops(area_id);
CREATE INDEX idx_route_stops_route_id ON route_stops(route_id);
CREATE INDEX idx_route_stops_stop_id ON route_stops(stop_id);
CREATE INDEX idx_bus_schedules_route_id ON bus_schedules(route_id);
CREATE INDEX idx_fares_agency_id ON fares(agency_id);
CREATE INDEX idx_survey_passenger_id ON survey_responses(passenger_id);
CREATE INDEX idx_survey_origin_id ON survey_responses(origin_area_id);
CREATE INDEX idx_survey_dest_id ON survey_responses(destination_area_id);
CREATE INDEX idx_delay_route_id ON delay_reports(route_id);
CREATE INDEX idx_delay_stop_id ON delay_reports(stop_id);
CREATE INDEX idx_recs_origin_id ON route_recommendations(origin_area_id);
CREATE INDEX idx_recs_dest_id ON route_recommendations(destination_area_id);
CREATE INDEX idx_recs_route_id ON route_recommendations(route_id);

CREATE INDEX idx_route_stops_composite ON route_stops(route_id, stop_id);
CREATE INDEX idx_routes_long_name_upper ON routes(UPPER(route_long_name));
