-- +goose Up
-- +goose StatementBegin

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE AccountStatus AS ENUM(
    'UNVERIFIED',
    'VERIFIED',
    'RESTRICTED'
);

CREATE TYPE AccountTier AS ENUM(
    'BASIC',
    'ENTERPRISE'
);

CREATE TYPE AccountType AS ENUM(
    'REAL',
    'LEGAL'
);

CREATE TABLE IF NOT EXISTS Accounts(
    id UUID DEFAULT uuid_generate_v4(),
    email VARCHAR(64) NOT NULL,
    password BYTEA NOT NULL,
    account_status AccountStatus DEFAULT 'UNVERIFIED',
    account_tier AccountTier DEFAULT 'BASIC',
    account_type AccountType DEFAULT 'REAL',
    PRIMARY KEY (id)
);



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS Accounts;

DROP TYPE AccountStatus;
DROP TYPE AccountTier;
DROP TYPE AccountType;

DROP EXTENSION "uuid-ossp";


-- +goose StatementEnd
