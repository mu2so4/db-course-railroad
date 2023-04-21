SELECT
	"Trip_id",
	"Trips"."Route_id",
	"Start_date" + "Departure_stations"."Departure_time" AS "Departure_time",
	"Start_date" + "Arrival_stations"."Arrival_time" AS "Arrival_time",
	"Arrival_stations"."Ticket_cost" - "Departure_stations"."Ticket_cost" AS "Cost"
FROM "Trips"
	INNER JOIN "Station_stops_verbose" "Departure_stations"
		ON "Trips"."Route_id" = "Departure_stations"."Route_id" AND
		"Departure_stations"."Short_name" = UPPER('новосибирск') -- param
	INNER JOIN "Station_stops_verbose" "Arrival_stations"
		ON "Trips"."Route_id" = "Arrival_stations"."Route_id" AND
		"Arrival_stations"."Short_name" = UPPER('красноярск') AND --param
		"Departure_stations"."Departure_time" < "Arrival_stations"."Arrival_time"
WHERE
	NOT "Is_cancelled" AND
	"Arrival_stations"."Ticket_cost" - "Departure_stations"."Ticket_cost" BETWEEN 900::money AND 1100::money --params
ORDER BY
	"Start_date" + "Departure_stations"."Departure_time"
