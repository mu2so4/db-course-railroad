SELECT
	COUNT(*)
FROM "Tickets"
	INNER JOIN "Trips" USING("Trip_id")
WHERE
	"Return_time" IS NOT NULL AND
	"Trips"."Route_id" = 2; -- param
