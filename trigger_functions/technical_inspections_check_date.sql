CREATE FUNCTION technical_inspections_check_date() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	build_date DATE;

BEGIN
	SELECT "Build_date"
	INTO build_date
	FROM "Locomotives"
	WHERE "Locomotive_number" = NEW."Locomotive";

	IF(NEW."Inspection_date" < build_date) THEN
		RAISE EXCEPTION 'technical inspection with date % is before locomotive''s build date %', NEW."Inspection_date", build_date;
	END IF;

	IF(NOW()::date < NEW."Inspection_date") THEN
		RAISE EXCEPTION 'technical inspection with date % is after today', NEW."Inspection_date";
	END IF;
	RETURN NEW;
END;
$$;
