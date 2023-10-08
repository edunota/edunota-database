-- +goose Up
-- +goose StatementBegin

CREATE TYPE TokenType AS ENUM(
    'VERIFICATION',
  'AUTHENTICATION'
);

CREATE TABLE IF NOT EXISTS Tokens(
    id BIGSERIAL PRIMARY KEY NOT NULL,
    fk_account_id  UUID REFERENCES Accounts(id),
    value TEXT NOT NULL,
    description VARCHAR(64),
    invalidate BOOLEAN DEFAULT FALSE,
    token_type TokenType DEFAULT 'AUTHENTICATION'
);


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS Tokens;
DROP TYPE TokenType;
-- +goose StatementEnd
