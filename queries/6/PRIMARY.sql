SELECT
	"Trip_id",
	"Route_id",
	"Departure_station",
	"Arrival_station",
	"Departure_time",
	"Arrival_time"
FROM "Timetable"
WHERE
	NOT "Is_cancelled"
