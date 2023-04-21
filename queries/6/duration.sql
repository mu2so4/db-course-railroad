SELECT
	"Trip_id",
	"Departure_station",
	"Arrival_station",
	"Arrival_time" - "Departure_time" AS "Duration"
FROM "Timetable"
WHERE
	NOT "Is_cancelled" AND
	'2023-01-17 16:20:38' BETWEEN "Departure_time" AND "Arrival_time" AND -- param
	"Arrival_time" - "Departure_time" BETWEEN '48:00' AND '72:00' -- params
ORDER BY
	"Trip_id"
