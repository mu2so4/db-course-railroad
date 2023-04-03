SELECT
	COUNT(*)
FROM "Tickets"
WHERE
	"Return_time" IS NOT NULL AND
	"Trip_id" = 56;
