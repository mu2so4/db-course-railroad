SELECT
	"Employees"."Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	"Genders"."Gender_name" AS "Sex",
	"Hire_date",
	"Salary",
	"Professions"."Profession_name" AS "Profession",
	"Children_count",
	"Departments"."Department_name" AS "Department"
FROM "Employees"
	INNER JOIN "Genders"
		ON "Employees"."Sex" = "Genders"."Gender_id"
	INNER JOIN "Professions"
		ON "Employees"."Profession_id" = "Professions"."Profession_id"
	INNER JOIN "Departments"
		ON "Employees"."Department_id" = "Departments"."Department_id"
WHERE
	"Department" = ?
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";

SELECT
	COUNT(*)
FROM "Employees"
	INNER JOIN "Departments"
		ON "Employees"."Department_id" = "Departments"."Department_id"
WHERE
	"Departments"."Department_id" = ?
