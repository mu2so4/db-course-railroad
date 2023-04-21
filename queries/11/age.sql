SELECT
	"Ticket_id",
	"Trips"."Route_id",
	array_to_string(ARRAY["Last_name", "First_name", "Patronymic"], ' ', '-') AS "Full_name",
	"Departure_stops"."Full_name" AS "Departure_station",
	"Arrival_stops"."Full_name" AS "Arrival_station",
	"Start_date" + "Departure_stops"."Departure_time" AS "Departure_time",
	"Start_date" + "Arrival_stops"."Arrival_time" AS "Arrival_time",
	"Birthday",
	get_age("Birthday") AS "Age"
FROM "Tickets"
	INNER JOIN "Trips" USING("Trip_id")
	INNER JOIN "Station_stops_verbose" "Departure_stops"
		ON "Trips"."Route_id" = "Departure_stops"."Route_id" AND
		"Tickets"."Departure_station" = "Departure_stops"."Station_id"
	INNER JOIN "Station_stops_verbose" "Arrival_stops"
		ON "Trips"."Route_id" = "Arrival_stops"."Route_id" AND
		"Tickets"."Arrival_station" = "Arrival_stops"."Station_id"
WHERE
	"Return_time" IS NULL AND
	get_age("Birthday") BETWEEN 20 AND 30 -- params
ORDER BY
	"Last_name",
	"First_name"
