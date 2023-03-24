SELECT
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	"Sex",
	"Hire_date",
	"Brigade_id",
	"Brigade_name"
FROM "Workers"
	INNER JOIN "Brigades" USING("Brigade_id")
	INNER JOIN "Our_locomotives"
		ON "Workers"."Brigade_id" IN ("Our_locomotives"."Locomotive_brigade", "Our_locomotives"."Repair_brigade")
WHERE
	"Locomotive_number" = 5 -- param
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";	
