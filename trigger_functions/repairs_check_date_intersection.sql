CREATE FUNCTION repairs_check_date_intersection() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	is_intersecting BOOLEAN;
BEGIN
	SELECT
			BOOL_OR(is_intersecting(NEW."Start_date", NEW."End_date",
					("Start_date" + "Starting_station_stops"."Departure_time")::date,
					("Start_date" + "Ending_station_stops"."Arrival_time")::date))
	INTO is_intersecting
	FROM "Trips"
		INNER JOIN "Starting_station_stops" USING("Route_id")
		INNER JOIN "Ending_station_stops" USING("Route_id")
	WHERE
		"Locomotive" = NEW."Locomotive" AND
		NOT "Is_cancelled";
		
	IF(is_intersecting) THEN
		RAISE EXCEPTION 'repair of locomotive % from % to % intersects with some trips', NEW."Locomotive", NEW."Start_date", NEW."End_date";
	END IF;
	RETURN NEW;
END;
$$;
