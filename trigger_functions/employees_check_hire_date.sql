CREATE FUNCTION employees_check_hire_date() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	IF(NEW."Hire_date" > NOW()::date) THEN
		RAISE EXCEPTION 'an employee cannot be hired after today';
	END IF;
	RETURN NEW;
END;
$$;
