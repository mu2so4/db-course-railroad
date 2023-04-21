CREATE FUNCTION tickets_check_purchase_time() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	departure_time TIMESTAMP;
BEGIN
	SELECT
		"Trips"."Start_date" + "Station_stops"."Departure_time"
	INTO departure_time
	FROM "Trips"
	INNER JOIN "Station_stops"
		ON NEW."Departure_station" = "Station_stops"."Station_id" AND
			"Trips"."Route_id" = "Station_stops"."Route_id"
	WHERE "Trip_id" = NEW."Trip_id";

	IF(departure_time < NEW."Purchase_time") THEN
		RAISE EXCEPTION 'ticket was purchased at ''%'' when is the departure time is %', NEW."Purchase_time", departure_time;
	END IF;

	RETURN NEW;
END;
$$;
