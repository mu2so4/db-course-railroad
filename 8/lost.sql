SELECT
	"Timetable"."Trip_id",
	"Route_id",
	"Timetable"."Departure_station",
	"Timetable"."Arrival_station",
	"Start_time",
	"Delay_size",
	COUNT("Tickets"."Ticket_id") AS "Returned_ticket_count"
FROM "Timetable"
	INNER JOIN "Delays" USING("Trip_id")
	LEFT OUTER JOIN "Tickets"
		ON "Timetable"."Trip_id" = "Tickets"."Trip_id" AND
		"Tickets"."Return_time" BETWEEN "Delays"."Start_time" AND "Delays"."Start_time" + "Delays"."Delay_size"
GROUP BY
	"Timetable"."Trip_id",
	"Route_id",
	"Timetable"."Departure_station",
	"Timetable"."Arrival_station",
	"Start_time",
	"Delay_size"
ORDER BY
	"Timetable"."Trip_id"
