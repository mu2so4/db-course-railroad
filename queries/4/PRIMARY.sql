SELECT
	"Locomotive_number",
	"Model",
	"Build_date",
	"Home_station",
	"Stations"."Full_name" AS "Station_name",
	"Locomotive_brigade",
	"Repair_brigade"
FROM "Locomotives"
	INNER JOIN "Stations"
		ON "Locomotives"."Home_station" = "Stations"."Station_id"
	LEFT OUTER JOIN "Locomotive_workers"
		ON "Locomotives"."Locomotive_number" = "Locomotive_workers"."Locomotive"
ORDER BY
	"Build_date"
