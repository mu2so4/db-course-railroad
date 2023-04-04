SELECT
	"Locomotive_number",
	"Model",
	COUNT("Repair_id") AS "Repair_count"
FROM "Locomotives"
	LEFT OUTER JOIN "Repairs"
		ON "Locomotives"."Locomotive_number" = "Repairs"."Locomotive"
WHERE
	"Home_station" = current_station_id()
GROUP BY
	"Locomotive_number"
HAVING
	COUNT("Repair_id") = 1 -- param
ORDER BY
	"Locomotive_number"
