SELECT
	"Personnel_number" AS "Табельный номер",
	"Last_name" AS "Фамилия",
	"First_name" AS "Имя",
	"Patronymic" AS "Отчество",
	"Birthday" AS "Дата рождения",
	"Genders"."Gender_name" AS "Пол",
	"Hire_date" AS "Дата приёма на работу",
	"Salary" AS "Зарплата, р",
	"Professions"."Profession_name" AS "Профессия",
	"Children_count" AS "Количество детей",
	"Departments"."Department_name" AS "Отдел"
FROM "Employees"
	INNER JOIN "Professions"
		ON "Employees"."Profession_id" = "Professions"."Profession_id"
	INNER JOIN "Departments"
		ON "Employees"."Department_id" = "Departments"."Department_id"
	INNER JOIN "Genders"
		ON "Employees"."Sex" = "Genders"."Gender_id"
WHERE
	"Professions"."Profession_name" = 'Машинист';
