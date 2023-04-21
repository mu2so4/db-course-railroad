CREATE FUNCTION routes_check_begining_ending() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	beginning_station_count INTEGER;
	ending_station_count INTEGER;
BEGIN
	SELECT COUNT(*)
	INTO beginning_station_count
	FROM "Station_stops"
	WHERE "Arrival_time" IS NULL AND "Route_id" = NEW."Route_id";
	
	IF(beginning_station_count = 0) THEN
		RAISE EXCEPTION 'not set the beginning station of route % (a station with null arrival time)', NEW."Route_id";
	ELSIF(beginning_station_count > 1) THEN
		RAISE EXCEPTION 'set too many beginning stations of route % (stations with null arrival time)', NEW."Route_id";
	END IF;
	
	SELECT COUNT(*)
	INTO ending_station_count
	FROM "Station_stops"
	WHERE "Departure_time" IS NULL AND "Route_id" = NEW."Route_id";
	
	IF(ending_station_count = 0) THEN
		RAISE EXCEPTION 'not set the ending station of route % (a station with null departure time)', NEW."Route_id";
	ELSIF(ending_station_count > 1) THEN
		RAISE EXCEPTION 'set too many ending stations of route % (stations with null departure time)', NEW."Route_id";
	END IF;
	RETURN NEW;
END;
$$;
