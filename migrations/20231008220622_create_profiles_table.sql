-- +goose Up
-- +goose StatementBegin


CREATE TABLE IF NOT EXISTS Profiles(
    id UUID DEFAULT uuid_generate_v4(),
    fk_account_id UUID REFERENCES Accounts (id) NOT NULL,
    fk_profile_photo BIGSERIAL REFERENCES Resources (id),
    PRIMARY KEY(id)

);



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Profiles;
-- +goose StatementEnd
