SELECT *
FROM "Employees_view"
WHERE
	get_age("Birthday") = ?
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic"


SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	get_age("Birthday") = ?;
