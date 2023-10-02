-- +goose Up
-- +goose StatementBegin

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TYPE TokenType AS ENUM (
    'VALIDATION',
    'AUTHENTICATION'
);
create TYPE ResourceType AS ENUM ('IMAGE', 'DOCUMENT');
CREATE Type AccountType AS ENUM ('LEGAL', 'REAL');
CREATE Type ResourceEncodingType AS ENUM (
    'SRC',    -- file path
    'BASE64', -- Base64
    'BYTEA'   -- byte array
);
CREATE TABLE IF NOT EXISTS Accounts (
    id UUID PRIMARY KEY NOT NULL,
    password BYTEA NOT NULL,
    account_type AccountType DEFAULT 'REAL',
    email VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS Resources (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    resource_type ResourceType DEFAULT 'IMAGE',
    source TEXT NOT NULL,
    alt TEXT,
    resource_encoding ResourceEncodingType DEFAULT 'SRC',
    mime VARCHAR(16),
    description TEXT
);
CREATE TABLE IF NOT EXISTS Profiles (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    profile_photo_id BIGSERIAL NOT NULL,
    account_id UUID,
    PRIMARY KEY(id),
    CONSTRAINT fk_profile_photo_id 
        FOREIGN KEY(profile_photo_id) REFERENCES Resources(id),
    CONSTRAINT fk_account_id
        FOREIGN KEY(account_id) REFERENCES Accounts(id)
);

CREATE TABLE IF NOT EXISTS JK_Friends (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    fk_user_profile UUID NOT NULL,
    fk_friend_profile UUID NOT NULL,
    CONSTRAINT fk_user_profile 
        FOREIGN KEY(fk_user_profile)
        REFERENCES Profiles(id) 
        ON DELETE NO ACTION,
    CONSTRAINT fk_friend_profile
        FOREIGN KEY(fk_friend_profile)
        REFERENCES Profiles(id)
);

CREATE TABLE IF NOT EXISTS Tokens (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    account_id UUID,
    value TEXT,
    token_type TokenType DEFAULT 'AUTHENTICATION',
    description TEXT,

    CONSTRAINT fk_account_id
        FOREIGN KEY (account_id) REFERENCES Accounts (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS Tokens;
DROP TABLE IF EXISTS JK_Friends;
DROP TABLE IF EXISTS Profiles;

DROP TABLE IF EXISTS Accounts;


DROP TABLE IF EXISTS Resources;
DROP TYPE IF EXISTS AccountType;
DROP TYPE IF EXISTS ResourceEncodingType;
DROP TYPE IF EXISTS ResourceType;
DROP TYPE IF EXISTS TokenType;
DROP EXTENSION IF EXISTS "uuid-ossp";
-- +goose StatementEnd