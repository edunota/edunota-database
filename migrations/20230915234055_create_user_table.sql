-- +goose Up
-- +goose StatementBegin

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TYPE AccountType AS ENUM ('LEGAL', 'REAL');
create TYPE ResourceType AS ENUM ('IMAGE', 'DOCUMENT');

CREATE TABLE IF NOT EXISTS Accounts (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    password BYTEA NOT NULL,
    user_name VARCHAR(64),
    account_type AccountType NOT NULL DEFAULT 'LEGAL',
    fist_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL
);


CREATE TABLE IF NOT EXISTS Resources (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    resource_type ResourceType DEFAULT 'IMAGE',
    source TEXT NOT NULL,
    alt TEXT,
    description TEXT
);
CREATE TABLE IF NOT EXISTS Profiles (
    id UUID DEFAULT uuid_generate_v4() NOT NULL,
    fk_profile_photo BIGSERIAL NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_profile_photo 
        FOREIGN KEY(fk_profile_photo) REFERENCES Resources(id) ON DELETE CASCADE
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
        ON DELETE NO ACTION
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS JK_Friends;

DROP TABLE IF EXISTS Accounts;

DROP TABLE  IF EXISTS Profiles;



DROP TABLE IF EXISTS Resources;
-- +goose StatementEnd
-- +goose StatementBegin
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP TYPE IF EXISTS ResourceType;
DROP TYPE IF EXISTS AccountType;
DROP TYPE IF EXISTS accountstatus;
DROP TYPE IF EXISTS accounttier;
-- +goose StatementEnd