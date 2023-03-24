SELECT
	"Employees"."Personnel_number",
	"Employees"."Last_name",
	"Employees"."First_name",
	"Employees"."Patronymic",
	"Employees"."Birthday",
	"Genders"."Gender_name" AS "Sex",
	"Employees"."Hire_date",
	"Employees"."Wages",
	"Professions"."Profession_name" AS "Profession",
	"Employees"."Children_count",
	"Brigade_id",
	"Brigade_type"
FROM "Employees"
	INNER JOIN "Genders"
		ON "Employees"."Sex" = "Genders"."Gender_id"
	INNER JOIN "Professions" USING("Profession_id")
	INNER JOIN "Brigade_employees" USING("Personnel_number")
	INNER JOIN "Brigades" USING("Brigade_id")
WHERE "Brigade_id" = 1;
