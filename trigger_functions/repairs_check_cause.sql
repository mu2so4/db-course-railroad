CREATE FUNCTION repairs_check_cause() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	is_satisfied BOOLEAN;
	inspection_date DATE;
	locomotive INTEGER;
BEGIN
	SELECT "Is_satisfied", "Inspection_date", "Locomotive"
	INTO is_satisfied, inspection_date, locomotive
	FROM "Technical_inspections"
	WHERE "Id" = NEW."Cause";
	
	IF(is_satisfied) THEN
		RAISE EXCEPTION 'repair cannot be caused by inspection which is satisfied';
	ELSIF(inspection_date > NEW."Start_date") THEN
		RAISE EXCEPTION 'repair cannot be caused by inspection which is before the repair';
	ELSIF(locomotive <> NEW."Locomotive") THEN
		RAISE EXCEPTION 'repair and caused inspection must have the same locomotive';
	END IF;
	RETURN NEW;
END;
$$;
