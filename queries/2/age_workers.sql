SELECT
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	get_age("Birthday") AS "Age",
	"Sex",
	"Hire_date"
FROM "Workers"
WHERE
	get_age("Birthday") BETWEEN 20 AND 30 --param
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";	
