--  Create extensions
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--  Create schemas
CREATE SCHEMA IF NOT EXISTS app_public;
CREATE SCHEMA IF NOT EXISTS app_private;

-- Create roles
CREATE ROLE anonymous_user NOLOGIN;
CREATE ROLE app_user NOLOGIN;

-- Create types
CREATE TYPE app_public.jwt_token AS (
  id UUID,
  email VARCHAR(255),
  exp BIGINT,
  role VARCHAR(255),
  company_id UUID,
  company_role VARCHAR(255),
  company_title VARCHAR(255)
);

-- Add role permissions
GRANT USAGE ON SCHEMA app_public TO anonymous_user;
GRANT USAGE ON SCHEMA app_private TO app_user;

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION app_public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Lock created_at for updates
CREATE OR REPLACE FUNCTION app_public.lock_created_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_at = OLD.created_at;
  RETURN NEW;
END;
$$ language 'plpgsql';