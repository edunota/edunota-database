-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Faculties(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name VARCHAR(64),
    institution BIGSERIAL REFERENCES Institutions (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS  Faculties;
-- +goose StatementEnd
