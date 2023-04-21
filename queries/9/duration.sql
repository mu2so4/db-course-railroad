SELECT
	"Ticket_id",
	"Trips"."Route_id",
	array_to_string(ARRAY["Last_name", "First_name", "Patronymic"], ' ', '-') AS "Full_name",
	"Departure_stops"."Full_name" AS "Departure_station",
	"Arrival_stops"."Full_name" AS "Arrival_station",
	"Arrival_stops"."Arrival_time" - "Departure_stops"."Departure_time" AS "Duration"
FROM "Tickets"
	INNER JOIN "Trips" USING("Trip_id")
	INNER JOIN "Station_stops_verbose" "Departure_stops"
		ON "Trips"."Route_id" = "Departure_stops"."Route_id" AND
		"Tickets"."Departure_station" = "Departure_stops"."Station_id"
	INNER JOIN "Station_stops_verbose" "Arrival_stops"
		ON "Trips"."Route_id" = "Arrival_stops"."Route_id" AND
		"Tickets"."Arrival_station" = "Arrival_stops"."Station_id"
WHERE
	"Arrival_stops"."Arrival_time" - "Departure_stops"."Departure_time" BETWEEN '18:00' AND '40:00' AND --params
	"Return_time" IS NULL
ORDER BY
	"Last_name",
	"First_name"
