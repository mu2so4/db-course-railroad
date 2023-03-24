WITH "Brigade_averages" AS (
	SELECT
		"Brigade_id",
		"Brigade_name",
		AVG("Wages"::numeric)::money as "Average_wages"
	FROM "Brigades"
		INNER JOIN "Workers" USING("Brigade_id")
	GROUP BY
		"Brigade_id",
		"Brigade_name"
)

SELECT
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	"Sex",
	"Hire_date",
	"Brigade_id",
	"Brigade_name",
	"Brigade_averages"."Average_wages" AS "Average_brigade_wages"
FROM "Workers"
	INNER JOIN "Brigade_averages" USING("Brigade_id")
WHERE
	"Average_wages" BETWEEN 40000::money AND 42000::money
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";	

