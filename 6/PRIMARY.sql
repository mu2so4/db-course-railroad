SELECT
	"Trip_id",
	"Route_id",
	"Departure_station",
	"Arrival_station",
	"Departure_time",
	"Arrival_time"
FROM "Timetable"
WHERE
	NOT "Is_cancelled" AND
	'2023-01-17 16:20:38' BETWEEN "Departure_time" AND "Arrival_time" -- param
