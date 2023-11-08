CREATE OR REPLACE FUNCTION app_public.get_exp_for_token()
RETURNS BIGINT AS $$
DECLARE
  exp BIGINT;
BEGIN
  exp := extract(epoch from now() + interval '1 hour');
  RETURN exp;
END;
$$ language plpgsql strict security definer;

CREATE OR REPLACE FUNCTION app_public.get_default_uth_role()
RETURNS VARCHAR(255) AS $$
DECLARE
  role VARCHAR(255);
BEGIN
  role := 'app_user';
  RETURN role;
END;
$$ language plpgsql strict security definer;

CREATE OR REPLACE FUNCTION app_public.authorize(authemail VARCHAR(255), pwd VARCHAR(255))
RETURNS app_public.jwt_token AS $$
DECLARE
  uid UUID;
  hashed_password VARCHAR(255);
  token app_public.jwt_token;
BEGIN
  SELECT id, password INTO uid, hashed_password
  FROM "app_public"."user" WHERE email = authorize.authemail;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Invalid email or password';
  END IF;
  IF NOT crypt(authorize.pwd, hashed_password) = hashed_password THEN
    RAISE EXCEPTION 'Invalid email or password';
  END IF;
  IF uid IS NULL THEN
    RAISE EXCEPTION 'Invalid email or password';
  END IF;
  token.email := authorize.authemail;
  token.exp := app_public.get_exp_for_token();
  token.id := uid;
  token.role := app_public.get_default_uth_role();
  RETURN token::app_public.jwt_token;
EXCEPTION
  WHEN OTHERS THEN
    RAISE EXCEPTION 'Invalid email or password';
END;
$$ language plpgsql strict security definer;

-- Create user function
CREATE OR REPLACE FUNCTION app_public.create_user(
  name VARCHAR(255),
  email VARCHAR(255),
  password VARCHAR(255)
)
RETURNS app_public.jwt_token AS $$
DECLARE
  token app_public.jwt_token;
  uid UUID;
BEGIN
  INSERT INTO "app_public"."user" (name, email, password)
  VALUES (create_user.name, create_user.email, crypt(create_user.password, gen_salt('bf')));
  SELECT id INTO uid FROM "app_public"."user" as u WHERE u.email = create_user.email;
  token.email := create_user.email;
  token.exp := app_public.get_exp_for_token();
  token.role := app_public.get_default_uth_role();
  token.id := uid;
  RETURN token::app_public.jwt_token;

EXCEPTION
  WHEN OTHERS THEN
    RAISE EXCEPTION 'Invalid email or password';
END;
$$ language plpgsql strict security definer;

