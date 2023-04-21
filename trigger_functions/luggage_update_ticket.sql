CREATE FUNCTION luggage_update_ticket() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE "Tickets"
	SET "Luggage_count" = "Luggage_count" - 1
	WHERE "Ticket_id" = OLD."Ticket_id";

	UPDATE "Tickets"
	SET "Luggage_count" = "Luggage_count" + 1
	WHERE "Ticket_id" = NEW."Ticket_id";

	RETURN NEW;
END;
$$;
