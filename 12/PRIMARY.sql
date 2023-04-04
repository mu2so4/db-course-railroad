SELECT
	"Trips"."Trip_id",
	"Place_count",
	"Place_count" - COUNT("Tickets"."Ticket_id") AS "Remaining_count"
FROM "Trips"
	LEFT OUTER JOIN "Tickets"
		ON "Trips"."Trip_id" = "Tickets"."Trip_id" AND
		"Return_time" IS NULL
	LEFT OUTER JOIN "Station_stops" "Departure_stops"
		ON "Trips"."Route_id" = "Departure_stops"."Route_id" AND
		"Tickets"."Departure_station" = "Departure_stops"."Station_id"
	LEFT OUTER JOIN "Station_stops" "Arrival_stops"
		ON "Trips"."Route_id" = "Arrival_stops"."Route_id" AND
		"Tickets"."Arrival_station" = "Arrival_stops"."Station_id"
	LEFT OUTER JOIN "Station_stops" "Our_stops"
		ON "Trips"."Route_id" = "Our_stops"."Route_id" AND
		current_station_id() = "Our_stops"."Station_id" AND
		"Our_stops"."Departure_time" BETWEEN "Departure_stops"."Departure_time" AND
			"Arrival_stops"."Arrival_time"
GROUP BY
	"Trips"."Trip_id"
ORDER BY
	"Trips"."Trip_id"
