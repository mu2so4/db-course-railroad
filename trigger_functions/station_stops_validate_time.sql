CREATE FUNCTION station_stops_validate_time() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	is_intersecting BOOLEAN;
	invalid_costs BOOLEAN;
BEGIN
	IF(NEW."Arrival_time" IS NULL) THEN
		SELECT
			BOOL_OR(NEW."Departure_time" >= "Arrival_time")
		INTO is_intersecting
		FROM "Station_stops"
		WHERE
			"Route_id" = NEW."Route_id" AND
			"Station_id" <> NEW."Station_id";
			
		IF(is_intersecting) THEN
			RAISE EXCEPTION 'starting station stop % of route % is after other stops of this route', NEW."Station_id", NEW."Route_id";
		END IF;
	ELSIF(NEW."Departure_time" IS NULL) THEN
		SELECT
			BOOL_OR("Departure_time" >= NEW."Arrival_time"),
			BOOL_OR("Ticket_cost" >= NEW."Ticket_cost")
		INTO is_intersecting, invalid_costs
		FROM "Station_stops"
		WHERE
			"Route_id" = NEW."Route_id" AND
			"Station_id" <> NEW."Station_id";
			
		IF(is_intersecting) THEN
			RAISE EXCEPTION 'ending station stop % of route % is before other stops of this route', NEW."Station_id", NEW."Route_id";
		ELSIF(invalid_costs) THEN
			RAISE EXCEPTION 'station % of the route % has greater ticket cost than the ending station', NEW."Station_id", NEW."Route_id";
		END IF;
	ELSE
		SELECT
			BOOL_OR(is_intersecting(NEW."Arrival_time", NEW."Departure_time",
									"Arrival_time", "Departure_time")),
			NOT BOOL_AND(("Ticket_cost" > NEW."Ticket_cost" AND "Arrival_time" > NEW."Arrival_time") OR
						("Ticket_cost" < NEW."Ticket_cost" AND "Departure_time" < NEW."Departure_time"))
		INTO is_intersecting, invalid_costs
		FROM "Station_stops"
		WHERE
			"Route_id" = NEW."Route_id" AND
			"Station_id" <> NEW."Station_id" AND
			"Departure_time" IS NOT NULL AND
			"Arrival_time" IS NOT NULL;
			
		IF(is_intersecting) THEN
			RAISE EXCEPTION 'station stop % of the route % intersects with other stops', NEW."Station_id", NEW."Route_id";
		ELSIF(invalid_costs) THEN
			RAISE EXCEPTION 'station stop % of the route % has less ticket cost than one of prev or next stations', NEW."Station_id", NEW."Route_id";
		END IF;
		
		SELECT
			NEW."Arrival_time" <= "Departure_time"
		INTO is_intersecting
		FROM "Station_stops"
		WHERE
			"Route_id" = NEW."Route_id" AND
			"Station_id" <> NEW."Station_id" AND
			"Arrival_time" IS NULL;
		
		IF(is_intersecting) THEN
			RAISE EXCEPTION 'station % of the route % is before the starting station or intersects with it', NEW."Station_id", NEW."Route_id";
		END IF;
			
		SELECT
			"Arrival_time" <= NEW."Departure_time",
			"Ticket_cost" <= NEW."Ticket_cost"
		INTO is_intersecting, invalid_costs
		FROM "Station_stops"
		WHERE
			"Route_id" = NEW."Route_id" AND
			"Station_id" <> NEW."Station_id" AND
			"Departure_time" IS NULL;
		
		IF(is_intersecting) THEN
			RAISE EXCEPTION 'station % of the route % is after the ending station or intersects with it', NEW."Station_id", NEW."Route_id";
		ELSIF(invalid_costs) THEN
			RAISE EXCEPTION 'station % of the route % has ticket cost greater than the ending station', NEW."Station_id", NEW."Route_id";
		END IF;
	END IF;
	
	RETURN NEW;
END;
$$;
