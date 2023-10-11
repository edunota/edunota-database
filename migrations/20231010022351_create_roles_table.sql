-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Roles (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name VARCHAR(32) NOT NULL ,
    description TEXT,
    permissions BYTEA
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS jk_faculty_roles;
DROP TABLE IF EXISTS jk_institution_roles;
DROP TABLE IF EXISTS Roles;
-- +goose StatementEnd
