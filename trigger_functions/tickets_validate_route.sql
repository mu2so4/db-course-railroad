CREATE FUNCTION tickets_validate_route() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	route_id INTEGER;
	departure_time INTERVAL;
	arrival_time INTERVAL;
BEGIN
	SELECT "Route_id"
	INTO route_id
	FROM "Trips"
	WHERE "Trip_id" = NEW."Trip_id";

	IF(NEW."Departure_station" NOT IN (SELECT "Station_id" FROM "Station_stops" WHERE "Route_id" = route_id)) THEN
		RAISE EXCEPTION 'departure station % is not in the trip % of the route %', NEW."Departure_station", NEW."Trip_id", route_id;
	ELSIF(NEW."Arrival_station" NOT IN (SELECT "Station_id" FROM "Station_stops" WHERE "Route_id" = route_id)) THEN
		RAISE EXCEPTION 'arrival station % is not in the trip % of the route %', NEW."Arrival_station", NEW."Trip_id", route_id;
	END IF;
	
	SELECT "Departure_time"
	INTO departure_time
	FROM "Station_stops"
	WHERE "Station_id" = NEW."Departure_station" AND "Route_id" = route_id;
	
	SELECT "Arrival_time"
	INTO arrival_time
	FROM "Station_stops"
	WHERE "Station_id" = NEW."Arrival_station" AND "Route_id" = route_id;
	
	IF(departure_time IS NULL OR arrival_time IS NULL OR departure_time >= arrival_time) THEN
		RAISE EXCEPTION 'cannot purchase a ticket from station % to station % of the train %', NEW."Departure_station", NEW."Arrival_station", NEW."Trip_id";
	END IF;
	RETURN NEW;
END;
$$;
