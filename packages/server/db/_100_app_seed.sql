INSERT INTO app_public."user" (name, email, password) VALUES
('John Doe', 'john.doe@example.com', crypt('password', gen_salt('bf', 8))),
('Alice Smith', 'alice.smith@example.com', crypt('password', gen_salt('bf', 8))),
('Bob Brown', 'bob.brown@example.com', crypt('password', gen_salt('bf', 8)));

INSERT INTO app_private.profile (owner_id, profile) VALUES
((SELECT id FROM app_public."user" WHERE email = 'john.doe@example.com'), '{"name": "John Doe", "bgColor": "#ff0000"}'),
((SELECT id FROM app_public."user" WHERE email = 'alice.smith@example.com'), '{"name": "Alice Smith", "bgColor": "#00ff00"}'),
((SELECT id FROM app_public."user" WHERE email = 'bob.brown@example.com'), '{"name": "Bob Brown", "bgColor": "#0000ff"}');

-- INSERT INTO app_private.company (name) VALUES
-- ('Acme Inc.'),
-- ('Globex Corp.');

-- INSERT INTO app_private.role (company_id, name) VALUES
-- ((SELECT id FROM app_private.company WHERE name = 'Acme Inc.'), 'Manager'),
-- ((SELECT id FROM app_private.company WHERE name = 'Acme Inc.'), 'Employee'),
-- ((SELECT id FROM app_private.company WHERE name = 'Globex Corp.'), 'Manager'),
-- ((SELECT id FROM app_private.company WHERE name = 'Globex Corp.'), 'Employee');

-- INSERT INTO app_private.employee (company_id, user_id, role_id, title) VALUES
-- (
--   (SELECT id FROM app_private.company WHERE name = 'Acme Inc.'),
--   (SELECT id FROM app_public."user" WHERE email = 'bob.brown@example.com'),
--   (SELECT id FROM app_private.role WHERE name = 'Manager' and company_id = (SELECT id FROM shift_manager.company WHERE name = 'Acme Inc.')),
--   'CEO'
-- ),
-- (
--   (SELECT id FROM app_private.company WHERE name = 'Acme Inc.'),
--   (SELECT id FROM app_public."user" WHERE email = 'alice.smith@example.com'),
--   (SELECT id FROM app_private.role WHERE name = 'Employee' and company_id = (SELECT id FROM shift_manager.company WHERE name = 'Acme Inc.')),
--   'Sales'
-- ),
-- (
--   (SELECT id FROM app_private.company WHERE name = 'Globex Corp.'),
--   (SELECT id FROM app_public."user" WHERE email = 'john.doe@example.com'),
--   (SELECT id FROM app_private.role WHERE name = 'Manager' and company_id = (SELECT id FROM shift_manager.company WHERE name = 'Globex Corp.')),
--   'CEO'
-- );
