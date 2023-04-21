WITH "Locomotive_stops" AS (
	SELECT
		"Locomotive_number",
		"Trip_id",
		"Trips"."Route_id",
		COALESCE("Start_date" + "Arrival_time", "Start_date" + "Departure_time" - interval '00:30') AS "Arrival_time",
		COALESCE("Start_date" + "Departure_time", "Start_date" + "Arrival_time" + interval '00:30') AS "Departure_time"
	FROM "Locomotives"
		INNER JOIN "Trips"
			ON "Locomotives"."Locomotive_number" = "Trips"."Locomotive"
		INNER JOIN "Station_stops"
			ON "Trips"."Route_id" = "Station_stops"."Route_id" AND
			"Station_stops"."Station_id" = current_station_id()
	WHERE
		NOT "Is_cancelled"
	)

SELECT *
FROM "Locomotive_stops"
WHERE
	"Arrival_time" BETWEEN '2023-01-31 19:00:00' AND '2023-01-31 21:00:00' -- params
ORDER BY "Arrival_time";
