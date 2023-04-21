SELECT
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	"Sex",
	"Hire_date",
	"Wages",
	"Professions"."Profession_name" AS "Profession",
	"Brigade_id",
	"Brigade_name"
FROM "Workers"
	INNER JOIN "Professions" USING("Profession_id")
	INNER JOIN "Brigades" USING("Brigade_id")
WHERE "Brigade_id" = 1;
