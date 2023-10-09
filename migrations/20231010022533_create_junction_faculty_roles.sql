-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Jk_faculty_roles (
    id BIGSERIAL PRIMARY KEY ,
    fk_faculty_id BIGSERIAL REFERENCES Faculties(id),
    fk_role_id BIGSERIAL REFERENCES Roles(id)
);
-- +goose StatementEnd

