SELECT
	"Trip_id",
	"Route_id",
	"Departure_station",
	"Arrival_station",
	"Departure_time",
	"Arrival_time",
	"Start_time",
	"Delay_size"
FROM "Timetable"
	INNER JOIN "Delays" USING("Trip_id")
