SELECT
	"Routes"."Route_id",
	"Starting_station_stops"."Short_name" AS "Departure_station",
	"Ending_station_stops"."Short_name" AS "Arrival_station",
	"Route_types"."Type_name" AS "Route_type"
FROM "Routes"
	INNER JOIN "Starting_station_stops" USING("Route_id")
	INNER JOIN "Ending_station_stops" USING("Route_id")
	INNER JOIN "Route_types"
		ON "Routes"."Route_type" = "Route_types"."Type_id"
	INNER JOIN "Station_stops_verbose" AS "Destination_stop" USING("Route_id")
	INNER JOIN "Station_stops" AS "Current_stop"
		ON "Routes"."Route_id" = "Current_stop"."Route_id" AND
		"Current_stop"."Station_id" = current_station_id()
WHERE
	"Route_types"."Type_id" = 2 AND
	"Destination_stop"."Short_name" = upper('ташкент') AND
	"Current_stop"."Departure_time" < "Destination_stop"."Arrival_time";
