SELECT *
FROM "Employees_view"
WHERE
	"Children_count" = ?
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	"Children_count" = ?;
