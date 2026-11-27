ALTER TABLE delay_reports DROP CONSTRAINT fk_delay_stop;
ALTER TABLE delay_reports ADD CONSTRAINT fk_delay_stop 
    FOREIGN KEY (stop_id) REFERENCES bus_stops(stop_id);
