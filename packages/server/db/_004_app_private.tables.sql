
CREATE TABLE app_private.profile (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES app_public.user(id) DEFAULT app_private.get_current_user_id() UNIQUE,
  profile JSONB NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMP
);
CREATE INDEX idx_profile_owner_id ON app_private.profile(owner_id);

CREATE RULE "_soft_deletion" AS ON DELETE TO app_private.profile DO INSTEAD (
  UPDATE app_private.profile SET deleted_at = NOW() WHERE id = OLD.id AND deleted_at IS NULL
);

CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON app_private.profile
  FOR EACH ROW EXECUTE PROCEDURE app_public.update_updated_at_column();
CREATE TRIGGER lock_profile_created_at BEFORE UPDATE ON app_private.profile
  FOR EACH ROW EXECUTE PROCEDURE app_public.lock_created_at_column();

ALTER TABLE app_private.profile ENABLE ROW LEVEL SECURITY;
  CREATE POLICY access_by_owner ON app_private.profile TO app_user
    USING (owner_id = app_private.get_current_user_id());

CREATE VIEW app_private.active_profile AS
  SELECT *
  FROM app_private.profile
  WHERE deleted_at IS NULL;


-- CREATE TABLE app_private.company (
--   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   name VARCHAR(255) NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   deleted_at TIMESTAMP
-- );

-- CREATE TABLE app_private.role (
--   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   company_id UUID NOT NULL REFERENCES app_private.company(id),
--   name VARCHAR(255) NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   deleted_at TIMESTAMP
-- );

-- CREATE INDEX idx_role_company_id ON app_private.role(company_id);

-- CREATE TABLE app_private.employee (
--   company_id UUID NOT NULL REFERENCES app_private.company(id),
--   user_id UUID NOT NULL REFERENCES app_public.user(id),
--   role_id UUID NOT NULL REFERENCES app_private.role(id),
--   title VARCHAR(255) NOT NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
--   deleted_at TIMESTAMP,
--   PRIMARY KEY (company_id, user_id)
-- );


-- access to this schema for authenticated users
GRANT ALL ON ALL TABLES IN SCHEMA app_private TO app_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA app_private TO app_user;