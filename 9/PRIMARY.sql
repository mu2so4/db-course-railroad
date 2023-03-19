SELECT
	"Ticket_id",
	"Trips"."Trip_id",
	"Last_name",
	"First_name",
	"Patronymic",
	"Genders"."Gender_name" AS "Sex",
	"Passport_number",
	"Cost",
	"Departure_stations"."Full_name" AS "Departure_station",
	"Trips"."Start_date" + "Departure_stops"."Departure_time" AS "Departure_time",
	"Arrival_stations"."Full_name" AS "Arrival_station",
	"Trips"."Start_date" + "Arrival_stops"."Arrival_time" AS "Arrival_time",
	"Place",
	"Purchase_time",
	"Return_time"
FROM "Tickets"
	INNER JOIN "Trips"
		ON "Tickets"."Trip_id" = "Trips"."Trip_id"
	INNER JOIN "Stations" AS "Departure_stations"
		ON "Tickets"."Departure_station" = "Departure_stations"."Station_id"
	INNER JOIN "Station_stops" AS "Departure_stops"
		ON "Departure_stations"."Station_id" = "Departure_stops"."Station_id" AND
			"Trips"."Route_id" = "Departure_stops"."Route_id"
	INNER JOIN "Stations" AS "Arrival_stations"
		ON "Tickets"."Arrival_station" = "Arrival_stations"."Station_id"
	INNER JOIN "Station_stops" AS "Arrival_stops"
		ON "Arrival_stations"."Station_id" = "Arrival_stops"."Station_id" AND
			"Trips"."Route_id" = "Arrival_stops"."Route_id"
	INNER JOIN "Genders"
		ON "Tickets"."Sex_id" = "Genders"."Gender_id"
