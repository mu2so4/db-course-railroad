WITH "Pure_counts" AS (
	SELECT
		"Locomotive" AS "Locomotive_number",
		COUNT(*) AS "Trip_count"
	FROM "Trips"
	WHERE
		NOT "Is_cancelled"
	GROUP BY
		"Locomotive"
)
SELECT
	"Locomotive_number",
	COALESCE("Pure_counts"."Trip_count", 0) AS "Trip_count"
FROM "Locomotives"
	LEFT OUTER JOIN "Pure_counts" USING("Locomotive_number")
ORDER BY
	"Locomotive_number"
