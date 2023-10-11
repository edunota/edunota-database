-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Jk_institution_roles (
    id BIGSERIAL NOT NULL  PRIMARY KEY ,
    fk_institution_id BIGSERIAL REFERENCES institutions(id),
    fk_role_id BIGSERIAL REFERENCES Roles(id)
);
-- +goose StatementEnd

