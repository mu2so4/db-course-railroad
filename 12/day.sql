WITH "Sold_counts" AS (
	SELECT
		"Trip_id",
		COUNT(*) AS "Sold_count"
	FROM "Trips"
		INNER JOIN "Tickets" USING("Trip_id")
		INNER JOIN "Station_stops" "Departure_stops"
			ON "Trips"."Route_id" = "Departure_stops"."Route_id" AND
			"Tickets"."Departure_station" = "Departure_stops"."Station_id"
		INNER JOIN "Station_stops" "Arrival_stops"
			ON "Trips"."Route_id" = "Arrival_stops"."Route_id" AND
			"Tickets"."Arrival_station" = "Arrival_stops"."Station_id"
		INNER JOIN "Station_stops" "Our_stops"
			ON "Trips"."Route_id" = "Our_stops"."Route_id" AND
			current_station_id() = "Our_stops"."Station_id"
	WHERE
		"Our_stops"."Departure_time" BETWEEN "Departure_stops"."Departure_time" AND
			"Arrival_stops"."Arrival_time" AND
		"Return_time" IS NULL
	GROUP BY
		"Trip_id"
)
SELECT
	"Trips"."Trip_id",
	"Place_count",
	"Place_count" - COALESCE("Sold_count", 0) AS "Remaining_count",
	("Start_date" + "Our_stops"."Departure_time")::date AS "Departure_date"
FROM "Trips"
	LEFT OUTER JOIN "Sold_counts" USING("Trip_id")
	INNER JOIN "Station_stops" "Our_stops"
		ON "Trips"."Route_id" = "Our_stops"."Route_id" AND
		current_station_id() = "Our_stops"."Station_id"
WHERE
	("Start_date" + "Our_stops"."Departure_time")::date = '2023-01-05' -- param
ORDER BY
	"Trip_id"
