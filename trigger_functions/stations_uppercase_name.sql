CREATE FUNCTION stations_uppercase_name() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW."Full_name" = UPPER(NEW."Full_name");
	IF(NEW."Short_name" IS NULL) THEN
		NEW."Short_name" = NEW."Full_name";
	ELSE
		NEW."Short_name" = UPPER(NEW."Short_name");
	END IF;
	RETURN NEW;
END;
$$;
