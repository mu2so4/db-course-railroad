SELECT *
FROM "Employees_view"
WHERE
	"Department_id" = 2
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	"Department_id" = 2;
