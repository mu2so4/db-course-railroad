CREATE FUNCTION luggage_update_weight() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE "Tickets"
	SET
		"Sum_luggage_weight" = "Sum_luggage_weight" - OLD."Weight",
		"Cost_coefficient" = "Cost_coefficient" - get_luggage_coefficient(OLD."Weight")
	WHERE "Ticket_id" = OLD."Ticket_id";

	UPDATE "Tickets"
	SET
		"Sum_luggage_weight" = "Sum_luggage_weight" + NEW."Weight",
		"Cost_coefficient" = "Cost_coefficient" + get_luggage_coefficient(NEW."Weight")
	WHERE "Ticket_id" = NEW."Ticket_id";

	RETURN NEW;
END;
$$;
