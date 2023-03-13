SELECT
	COUNT(*)
FROM "Tickets"
	INNER JOIN "Passages"
		ON "Tickets"."Passage_id" = "Passages"."Passage_id"
WHERE
	"Return_time" IS NOT NULL AND
	"Passages"."Route_id" = ?;
