SELECT
	"Route_id",
	COUNT("Tickets"."Ticket_id") AS "Sold_count"
FROM "Routes"
	LEFT OUTER JOIN "Trips" USING("Route_id")
	LEFT OUTER JOIN "Tickets" USING("Trip_id")
GROUP BY
	"Route_id"
ORDER BY
	"Route_id"
