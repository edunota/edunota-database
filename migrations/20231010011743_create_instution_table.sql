-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Institutions (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name VARCHAR(64),
    fk_account_id UUID REFERENCES accounts (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS  Institutions;
-- +goose StatementEnd
