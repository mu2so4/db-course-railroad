SELECT
	COUNT(*)
FROM "Tickets"
WHERE
	"Return_time" IS NOT NULL AND
	"Passage_id" = ?;
