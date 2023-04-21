CREATE FUNCTION repairs_check_end_date() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	IF(NOW()::date < NEW."End_date") THEN
		RAISE EXCEPTION 'a repair end % cannot be after today', NEW."End_date";
	END IF;

	RETURN NEW;
END;
$$;
