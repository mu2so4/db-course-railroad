SELECT
	"Locomotive_number",
	"Model",
	"Build_date",
	"Locomotive_brigade",
	"Repair_brigade"
FROM "Locomotives"
	LEFT OUTER JOIN "Locomotive_workers"
		ON "Locomotives"."Locomotive_number" = "Locomotive_workers"."Locomotive"
WHERE
	"Home_station" = current_station_id()
ORDER BY
	"Build_date"
