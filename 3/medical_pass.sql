SELECT
	"Id",
	"Examination_date",
	"Work_permit",
	"Comment",
	"Personnel_number",
	"Last_name",
	"First_name",
	"Patronymic",
	"Brigade_id",
	"Brigade_name"
FROM "Workers"
	INNER JOIN "Brigades" USING("Brigade_id")
	INNER JOIN "Medical_examinations"
		ON "Workers"."Personnel_number" = "Medical_examinations"."Employee"
WHERE
	"Profession_id" = 1 AND
	EXTRACT(year from "Examination_date") = 2020 -- param
	AND "Work_permit"
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";
