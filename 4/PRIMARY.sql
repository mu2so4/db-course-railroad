SELECT
	"Locomotive_number",
	"Model",
	"Build_date",
	"Home_station",
	"Stations"."Full_name" AS "Station_name",
	"Locomotive_brigade",
	"Locomotive_brigades"."Brigade_name" as "Locomotive_brigade_name",
	"Repair_brigade",
	"Repair_brigades"."Brigade_name" as "Repair_brigade_name"
FROM "Locomotives"
	INNER JOIN "Stations"
		ON "Locomotives"."Home_station" = "Stations"."Station_id"
	INNER JOIN "Locomotive_brigades"
		ON "Locomotives"."Locomotive_brigade" = "Locomotive_brigades"."Brigade_id"
	INNER JOIN "Repair_brigades"
		ON "Locomotives"."Repair_brigade" = "Repair_brigades"."Brigade_id";
