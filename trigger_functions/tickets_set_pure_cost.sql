CREATE FUNCTION tickets_set_pure_cost() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	route_id INTEGER;
	departure_station_cost MONEY;
	arrival_station_cost MONEY;
BEGIN
	SELECT "Route_id"
	INTO route_id
	FROM "Trips"
	WHERE "Trip_id" = NEW."Trip_id";

	SELECT "Ticket_cost"
	INTO departure_station_cost
	FROM "Station_stops"
	WHERE
		"Station_id" = NEW."Departure_station" AND
		"Route_id" = route_id;
	
	SELECT "Ticket_cost"
	INTO arrival_station_cost
	FROM "Station_stops"
	WHERE
		"Station_id" = NEW."Arrival_station" AND
		"Route_id" = route_id;
	
	IF(departure_station_cost IS NULL) THEN
		RAISE EXCEPTION 'cannot purchase a ticket from a technical station';
	ELSIF(arrival_station_cost IS NULL) THEN
		RAISE EXCEPTION 'cannot purchase a ticket to a technical station';
	END IF;
	
	NEW."Pure_cost" = arrival_station_cost - departure_station_cost;
	RETURN NEW;
END;
$$;
