SELECT *
FROM "Employees_view"
WHERE
	("Children_count" <> 0) = true
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees"
WHERE
	("Children_count" <> 0) = true;
