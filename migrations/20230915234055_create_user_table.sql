-- +goose Up
-- +goose StatementBegin
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- +goose StatementEnd
-- +goose StatementBegin

CREATE TYPE AccountTier AS ENUM ( 'BASIC', 'ENTERPRISE');

CREATE TYPE PersonType AS ENUM (  'REAL',  'LEGAL'   );

CREATE TABLE IF NOT EXISTS Persons (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    type PersonType DEFAULT 'REAL',
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    organisation_name VARCHAR(64),
    users uuid[],
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Profiles (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    friends uuid[],
    profileImage TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Accounts (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    account_tier AccountTier DEFAULT 'BASIC',
    password BYTEA NOT NULL,
    profile UUID NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_profile
        FOREIGN KEY (profile) REFERENCES Profiles(id)
);



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Users;
-- +goose StatementEnd
-- +goose StatementBegin
DROP EXTENSION IF EXISTS "uuid-ossp";
-- +goose StatementEnd