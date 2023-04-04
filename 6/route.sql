SELECT
	"Trip_id",
	"Departure_station",
	"Arrival_station",
	"Departure_time",
	"Arrival_time"
FROM "Timetable"
WHERE
	NOT "Is_cancelled" AND
	"Route_id" = 348; -- param
