CREATE FUNCTION locomotives_check_repair_brigade() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	IF(NOT is_repair_brigade(NEW."Repair_brigade")) THEN
		RAISE EXCEPTION 'invalid brigade type for repair brigade: did you mix brigades?';
	END IF;
	RETURN NEW;
END;
$$;
