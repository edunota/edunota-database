-- +goose Up
-- +goose StatementBegin
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TYPE AccountTier AS ENUM ( 'BASIC', 'ENTERPRISE');

CREATE TYPE PersonType AS ENUM (  'REAL',  'LEGAL'   );

CREATE TABLE IF NOT EXISTS Persons (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    type PersonType DEFAULT 'REAL',
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    organisation_name VARCHAR(64),
    fk_acount UUID NOT NULL,
    PRIMARY KEY (id)
);
CREATE TYPE ResourceType AS ENUM ('IMAGE', 'DOCUMENT');
CREATE TABLE IF NOT EXISTS Resources (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    resource_type ResourceType DEFAULT 'IMAGE',
    source TEXT NOT NULL,
    alt TEXT,
    description TEXT
);
CREATE TABLE IF NOT EXISTS Profiles (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    friends uuid[],
    fk_profile_image BIGSERIAL REFERENCES Resources(id),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Accounts (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    account_tier AccountTier DEFAULT 'BASIC',
    password BYTEA NOT NULL,
    fk_profile_id UUID NOT NULL,
    fk_person_id UUID NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_profile
        FOREIGN KEY (fk_profile_id) REFERENCES Profiles(id),
    CONSTRAINT fk_person
        FOREIGN KEY (fk_person_id) REFERENCES Persons(id)

);

ALTER TABLE Persons ADD CONSTRAINT fk_account FOREIGN KEY (fk_acount) REFERENCES Accounts(id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Accounts;
DROP TABLE  IF EXISTS Persons;
DROP  TABLE IF EXISTS Profiles;
DROP TABLE IF EXISTS Resources;
DROP TYPE IF EXISTS ResourceType;
DROP TABLE IF EXISTS Users;
DROP TYPE IF EXISTS AccountTier;
DROP TYPE IF EXISTS PersonType;
DROP EXTENSION IF EXISTS "uuid-ossp";
-- +goose StatementEnd