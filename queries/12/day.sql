SELECT
	"Trips"."Trip_id",
	"Place_count",
	"Place_count" - COUNT("Tickets"."Ticket_id") AS "Remaining_count"
FROM "Trips"
	INNER JOIN "Station_stops" "Our_stops"
		ON "Trips"."Route_id" = "Our_stops"."Route_id" AND
		current_station_id() =  "Our_stops"."Station_id"
	LEFT OUTER JOIN "Tickets"
		ON "Trips"."Trip_id" = "Tickets"."Trip_id" AND
		"Return_time" IS NULL
WHERE
	("Start_date" + "Our_stops"."Departure_time")::date = '2023-01-19'
GROUP BY
	"Trips"."Trip_id"
ORDER BY
	"Trips"."Trip_id"
