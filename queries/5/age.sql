SELECT
	"Locomotive_number",
	"Model",
	"Build_date",
	get_age("Build_date") AS "Age"
FROM "Locomotives"
WHERE
	"Home_station" = current_station_id() AND
	get_age("Build_date") = 14 -- param
ORDER BY
	"Build_date"
