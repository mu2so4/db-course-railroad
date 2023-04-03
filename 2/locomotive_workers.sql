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
	INNER JOIN "Locomotive_workers"
		ON "Workers"."Brigade_id" IN ("Locomotive_workers"."Locomotive_brigade", "Locomotive_workers"."Repair_brigade")
WHERE
	"Locomotive" = 5 -- param
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";	
