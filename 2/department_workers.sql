SELECT
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	"Sex",
	"Hire_date",
	"Department_id",
	"Department_name"
FROM "Workers"
	INNER JOIN "Brigades" USING("Brigade_id")
	INNER JOIN "Departments" USING("Department_id")
WHERE
	"Department_id" = 4 -- param
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";	
