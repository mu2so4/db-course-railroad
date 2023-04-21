SELECT
	"Last_name",
	"First_name",
	"Patronymic",
	"Birthday",
	get_age("Birthday") AS "Age",
	"Brigade_id",
	"Brigade_name"
FROM "Workers"
	INNER JOIN "Brigades" USING("Brigade_id")
WHERE
	"Profession_id" = 1 AND
	get_age("Birthday") BETWEEN 20 AND 30 -- params
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";
