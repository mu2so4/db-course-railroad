SELECT
	"Locomotive_number",
	"Model",
	"Start_date",
	"End_date",
	"Repair_types"."Type_name"
	"Comment"
FROM "Locomotives"
	INNER JOIN "Repairs"
		ON "Locomotives"."Locomotive_number" = "Repairs"."Locomotive"
	INNER JOIN "Repair_types"
		ON "Repairs"."Repair_type" = "Repair_types"."Type_id"
WHERE
	"Home_station" = current_station_id() AND
	"Start_date" BETWEEN '2023-01-07' AND '2023-01-13' -- params
ORDER BY
	"Start_date"
