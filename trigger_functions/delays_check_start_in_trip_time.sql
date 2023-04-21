CREATE FUNCTION delays_check_start_in_trip_time() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	departure_time TIMESTAMP;
	arrival_time TIMESTAMP;
BEGIN
	SELECT "Trips"."Start_date" + "Starting_station_stops"."Departure_time"
	INTO departure_time
	FROM "Trips"
		INNER JOIN "Starting_station_stops" USING("Route_id")
	WHERE "Trip_id" = NEW."Trip_id";
	
	SELECT "Trips"."Start_date" + "Ending_station_stops"."Arrival_time"
	INTO arrival_time
	FROM "Trips"
		INNER JOIN "Ending_station_stops" USING("Route_id")
	WHERE "Trip_id" = NEW."Trip_id";
	
	IF(NEW."Start_time" NOT BETWEEN departure_time AND arrival_time) THEN
		RAISE EXCEPTION 'start delay time % is not in the trip % time', NEW."Start_time", NEW."Trip_id";
	END IF;
	RETURN NEW;
END;
$$;
