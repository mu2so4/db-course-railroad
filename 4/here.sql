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
	timestamp '2023-01-31 20:01' BETWEEN "Arrival_time" AND "Departure_time" -- param
ORDER BY "Arrival_time";
