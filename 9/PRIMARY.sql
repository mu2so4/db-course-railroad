WITH "Counts" AS (
	SELECT
		"Route_id",
		COUNT(*) AS "Sold_count"
	FROM "Trips"
		INNER JOIN "Tickets" USING("Trip_id")
	GROUP BY
		"Route_id"
)

SELECT
	"Route_id",
	COALESCE("Counts"."Sold_count", 0) AS "Sold_count"
FROM "Routes"
	LEFT OUTER JOIN "Counts" USING("Route_id")
ORDER BY
	"Route_id"
