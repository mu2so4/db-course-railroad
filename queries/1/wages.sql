SELECT *
FROM "Employees_view"
WHERE
	"Wages" BETWEEN 30000::money AND 40000::money
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	"Wages" BETWEEN 30000::money AND 40000::money;
