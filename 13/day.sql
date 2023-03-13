SELECT
	COUNT(*)
FROM "Tickets"
WHERE
	"Return_time"::date = ?;
