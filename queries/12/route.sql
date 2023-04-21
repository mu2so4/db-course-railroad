SELECT
	"Trips"."Trip_id",
	"Place_count",
	"Place_count" - COUNT("Tickets"."Ticket_id") AS "Remaining_count"
FROM "Trips"
	LEFT OUTER JOIN "Tickets"
		ON "Trips"."Trip_id" = "Tickets"."Trip_id" AND
		"Return_time" IS NULL
WHERE
	"Route_id" = 123 -- param
GROUP BY
	"Trips"."Trip_id"
ORDER BY
	"Trips"."Trip_id"
