SELECT *
FROM "Employees_view"
WHERE
	LOWER("Sex") = LOWER('Женский')
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	LOWER("Sex") = LOWER('Женский');
