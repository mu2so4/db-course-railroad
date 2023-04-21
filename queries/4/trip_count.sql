SELECT
	"Locomotive_number",
	"Model",
	"Home_station",
	COUNT("Trip_id") AS "Trip_count"
FROM "Locomotives"
	LEFT OUTER JOIN "Trips"
		ON "Locomotives"."Locomotive_number" = "Trips"."Locomotive" AND
		NOT "Trips"."Is_cancelled"
GROUP BY
	"Locomotive_number"
ORDER BY
	"Locomotive_number"
