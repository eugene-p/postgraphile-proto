CREATE TABLE app_public.user (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMP
);

COMMENT ON TABLE app_public.user IS '@omit';

CREATE INDEX idx_user_email ON app_public.user(email);

CREATE TRIGGER update_user_updated_at BEFORE UPDATE ON app_public.user
FOR EACH ROW EXECUTE PROCEDURE app_public.update_updated_at_column();
CREATE TRIGGER lock_user_created_at BEFORE UPDATE ON app_public.user
FOR EACH ROW EXECUTE PROCEDURE app_public.lock_created_at_column();