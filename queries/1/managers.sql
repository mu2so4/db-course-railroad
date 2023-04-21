SELECT *
FROM "Employees_view"
WHERE
	"Profession" = 'Начальник отдела'
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";


SELECT
	COUNT(*)
FROM "Employees_view"
WHERE
	"Profession" = 'Начальник отдела';
