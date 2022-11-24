-- users can connect to all db's by default; revoke that
REVOKE ALL ON DATABASE template0 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE postgres FROM PUBLIC;
REVOKE ALL ON DATABASE ckb_explorer_development FROM PUBLIC;
REVOKE ALL ON DATABASE ckb_explorer_test FROM PUBLIC;

-- by default, users can create tables in the public schema; revoke that
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

CREATE ROLE readonly;

GRANT CONNECT ON DATABASE ckb_explorer_development TO readonly;

GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;

CREATE USER READONLY_USER WITH PASSWORD 'READONLY_PASSWORD' IN GROUP readonly;
