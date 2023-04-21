CREATE FUNCTION trips_check_date_intersection() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	repair_intersection BOOLEAN;
	other_trips_intersection BOOLEAN;
BEGIN
	IF(NOT NEW."Is_cancelled") THEN
		SELECT
			BOOL_OR(is_intersecting(
				NEW."Start_date" + "Starts_1"."Departure_time",
				NEW."Start_date" + "Ends_1"."Arrival_time",
				"Other_trips"."Start_date" + "Starts_2"."Departure_time",
				"Other_trips"."Start_date" + "Ends_2"."Arrival_time"
			))
		INTO other_trips_intersection
		FROM "Trips"
			INNER JOIN "Starting_station_stops" "Starts_1" USING("Route_id")
			INNER JOIN "Ending_station_stops" "Ends_1" USING("Route_id")
			INNER JOIN "Trips" "Other_trips"
				ON "Trips"."Locomotive" = "Other_trips"."Locomotive" AND
					"Trips"."Trip_id" <> "Other_trips"."Trip_id" AND
					NOT "Other_trips"."Is_cancelled"
			INNER JOIN "Starting_station_stops" "Starts_2"
				ON "Other_trips"."Route_id" = "Starts_2"."Route_id"
			INNER JOIN "Ending_station_stops" "Ends_2"
				ON "Other_trips"."Route_id" = "Ends_2"."Route_id"
		WHERE
			"Trips"."Locomotive" = NEW."Locomotive" AND
			"Trips"."Trip_id" = NEW."Trip_id";

		IF(other_trips_intersection) THEN
			RAISE EXCEPTION 'trip with route % and start date % intersepts with other trips', NEW."Route_id", NEW."Start_date";
		END IF;
		
		SELECT
			BOOL_OR(is_intersecting(
				(NEW."Start_date" + "Starts"."Departure_time")::DATE,
				(NEW."Start_date" + "Ends"."Arrival_time")::DATE,
				"Repairs"."Start_date",
				"Repairs"."End_date"
			))
		INTO repair_intersection
		FROM "Trips"
			INNER JOIN "Starting_station_stops" "Starts" USING("Route_id")
			INNER JOIN "Ending_station_stops" "Ends" USING("Route_id")
			INNER JOIN "Repairs" USING("Locomotive")
		WHERE
			"Trips"."Locomotive" = NEW."Locomotive";
			
		IF(repair_intersection) THEN
			RAISE EXCEPTION 'trip with route % and start date % intersepts with locomotive''s repair(s)', NEW."Route_id", NEW."Start_date";
		END IF;
	END IF;
	RETURN NEW;
END;
$$;
