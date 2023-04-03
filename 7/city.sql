SELECT
	"Route_id",
	"Trip_types"."Type_name",
	"Starting_station_stops"."Short_name" AS "Starting_station_name",
	"Ending_station_stops"."Short_name" AS "Ending_station_name",
	"Starting_station_stops"."Departure_time" + "Start_date" AS "Departure_timestamp",
	"Ending_station_stops"."Arrival_time" + "Start_date" AS "Arrival_timestamp",
	"Place_count"
FROM "Trips"
	INNER JOIN "Trip_types"
		ON "Trips"."Trip_type" = "Trip_types"."Type_id"
	INNER JOIN "Starting_station_stops" USING("Route_id")
	INNER JOIN "Ending_station_stops" USING("Route_id")
	INNER JOIN "Station_stops_verbose" USING("Route_id")
WHERE
	"Is_cancelled" = TRUE AND
	"Station_stops_verbose"."Short_name" = UPPER('барнаул');
	
