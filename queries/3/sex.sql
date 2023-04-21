SELECT
	"Last_name",
	"First_name",
	"Patronymic",
	"Brigade_id",
	"Brigade_name"
FROM "Workers"
	INNER JOIN "Brigades" USING("Brigade_id")
WHERE
	"Profession_id" = 1 AND
	"Sex" = 'Ж' -- param
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";
