SELECT
	"Locomotive_number",
	"Model",
	"Inspection_date",
	"Is_satisfied",
	"Comment"
FROM "Locomotives"
	INNER JOIN "Technical_inspections"
		ON "Locomotives"."Locomotive_number" = "Technical_inspections"."Locomotive"
WHERE
	"Home_station" = current_station_id() AND
	"Inspection_type" = 2 AND
	"Inspection_date" BETWEEN '2023-01-07' AND '2023-01-13' -- params
ORDER BY
	"Inspection_date"
