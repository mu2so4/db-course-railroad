CREATE FUNCTION tickets_check_place() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	place_count INTEGER;
	is_intersecting BOOLEAN;
BEGIN
	SELECT "Place_count"
	INTO place_count
	FROM "Trips"
	WHERE "Trip_id" = NEW."Trip_id";
	
	IF(NEW."Place" > place_count) THEN
		RAISE EXCEPTION 'place number % from the trip % is larger than place count %', NEW."Place", NEW."Trip_id", place_count;
	END IF;
	
	IF(NEW."Return_time" IS NOT NULL) THEN
		SELECT
			BOOL_OR(is_intersecting("Starts1"."Departure_time", "Ends1"."Arrival_time",
								   "Starts2"."Departure_time", "Ends2"."Arrival_time"))
		INTO is_intersecting
		FROM "Tickets"
			INNER JOIN "Trips" USING("Trip_id")
			INNER JOIN "Station_stops" "Starts1"
				ON "Trips"."Route_id" = "Starts1"."Route_id" AND
					NEW."Departure_station" = "Starts1"."Station_id"
			INNER JOIN "Station_stops" "Ends1"
				ON "Trips"."Route_id" = "Ends1"."Route_id" AND
					NEW."Arrival_station" = "Ends1"."Station_id"
			INNER JOIN "Station_stops" "Starts2"
				ON "Trips"."Route_id" = "Starts2"."Route_id" AND
					"Tickets"."Departure_station" = "Starts2"."Station_id"
			INNER JOIN "Station_stops" "Ends2"
				ON "Trips"."Route_id" = "Ends2"."Route_id" AND
					"Tickets"."Arrival_station" = "Ends2"."Station_id"
		WHERE
			"Tickets"."Trip_id" = NEW."Trip_id" AND
			"Tickets"."Place" = NEW."Place" AND
			"Tickets"."Ticket_id" <> NEW."Ticket_id" AND
			"Tickets"."Return_time" IS NULL;

		IF(is_intersecting) THEN
			RAISE EXCEPTION 'place % of the trip % is partially or completely taken by another person', NEW."Place", NEW."Trip_id";
		END IF;
	END IF;
	RETURN NEW;
END;
$$;
