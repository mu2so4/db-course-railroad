WITH "Next_repairs" AS (
	SELECT
		"Locomotive_number",
		MIN("Start_date") AS "Nearest_repair_date"
	FROM "Locomotives"
		LEFT OUTER JOIN "Repairs"
			ON "Locomotives"."Locomotive_number" = "Repairs"."Locomotive" AND
				"Start_date" >= '2023-01-11' --param
	WHERE
		"Home_station" = current_station_id()
	GROUP BY
		"Locomotive_number"
	ORDER BY
		"Locomotive_number"
)

SELECT
	"Locomotive_number",
	"Model",
	"Build_date",
	COUNT("Trips"."Trip_id") AS "Trip_count"
FROM "Locomotives"
	INNER JOIN "Next_repairs" USING("Locomotive_number")
	LEFT OUTER JOIN "Trips"
		ON "Locomotives"."Locomotive_number" = "Trips"."Locomotive" AND
		NOT "Is_cancelled" AND
		("Nearest_repair_date" IS NULL OR "Start_date" BETWEEN
			'2023-01-11' AND "Nearest_repair_date")
GROUP BY
	"Locomotive_number"