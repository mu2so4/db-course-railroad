CREATE FUNCTION repairs_check_start_date() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	build_date DATE;
BEGIN
	SELECT "Build_date"
	INTO build_date
	FROM "Locomotives"
	WHERE "Locomotive_number" = NEW."Locomotive";

	IF(NEW."Start_date" < build_date) THEN
		RAISE EXCEPTION 'a repair start % cannot be before building a locomotive', NEW."Start_date";
	END IF;
	RETURN NEW;
END;
$$;
