-- No access to this schema for anonymous users
REVOKE ALL ON SCHEMA app_private FROM anonymous_user;


-- helper functions for getting current user info from JWT token
CREATE OR REPLACE FUNCTION app_private.get_current_user_id()
RETURNS uuid AS $$
BEGIN
  RETURN current_setting('jwt.claims.id', true)::uuid;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION app_private.get_current_user_email()
RETURNS varchar AS $$
BEGIN
  RETURN current_setting('jwt.claims.email', true)::varchar;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION app_private.get_current_user_role()
RETURNS varchar AS $$
BEGIN
  RETURN current_setting('jwt.claims.role', true)::varchar;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION app_private.get_current_user_company_id()
RETURNS uuid AS $$
BEGIN
  RETURN current_setting('jwt.claims.company_id', true)::uuid;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION app_private.get_current_user_company_role()
RETURNS varchar AS $$
BEGIN
  RETURN current_setting('jwt.claims.company_role', true)::varchar;
END;
$$ LANGUAGE plpgsql;
