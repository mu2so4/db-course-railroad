CREATE FUNCTION luggage_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE "Tickets"
	SET
		"Luggage_count" = "Luggage_count" - 1,
		"Sum_luggage_weight" = "Sum_luggage_weight" - OLD."Weight",
		"Cost_coefficient" = "Cost_coefficient" - get_luggage_coefficient(OLD."Weight")
	WHERE "Ticket_id" = OLD."Ticket_id";

	RETURN NEW;
END;
$$;
