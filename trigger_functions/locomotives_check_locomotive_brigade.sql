CREATE FUNCTION locomotives_check_locomotive_brigade() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	IF(NOT is_locomotive_brigade(NEW."Locomotive_brigade")) THEN
		RAISE EXCEPTION 'invalid brigade type for locomotive brigade: did you mix brigades?';
	END IF;
	RETURN NEW;
END;
$$;
