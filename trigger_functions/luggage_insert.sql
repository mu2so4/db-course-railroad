CREATE FUNCTION luggage_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE "Tickets"
	SET
		"Luggage_count" = "Luggage_count" + 1,
		"Sum_luggage_weight" = "Sum_luggage_weight" + NEW."Weight",
		"Cost_coefficient" = "Cost_coefficient" + get_luggage_coefficient(NEW."Weight")
	WHERE "Ticket_id" = NEW."Ticket_id";

	RETURN NEW;
END;
$$;
