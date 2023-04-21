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
	LEFT OUTER JOIN "Medical_examinations"
		ON "Workers"."Personnel_number" = "Medical_examinations"."Employee" AND
		EXTRACT(year from "Examination_date") = 2021 -- param
WHERE
	"Profession_id" = 1 AND
	(NOT "Work_permit" OR "Work_permit" IS NULL)
ORDER BY
	"Last_name",
	"First_name",
	"Patronymic";
