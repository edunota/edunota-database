-- +goose Up
-- +goose StatementBegin

CREATE TABLE IF NOT EXISTS Jk_faculty_user_roles (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    fk_faculty_id BIGSERIAL REFERENCES faculties (id),
    fk_profile_id UUID REFERENCES profiles (id),
    fk_role_id BIGSERIAL REFERENCES roles (id)
);
CREATE TABLE IF NOT EXISTS Jk_faculty_users (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    fk_faculty_id BIGSERIAL REFERENCES Faculties(id),
    fk_profile_id UUID REFERENCES Profiles (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Jk_faculty_user_roles;
DROP TABLE IF EXISTS Jk_faculty_users;
-- +goose StatementEnd
