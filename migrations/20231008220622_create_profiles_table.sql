-- +goose Up
-- +goose StatementBegin


CREATE TABLE IF NOT EXISTS Profiles(
    id UUID DEFAULT uuid_generate_v4(),
    fk_account_id UUID REFERENCES accounts(id) NOT NULL,
    fk_profile_photo_id BIGINT,
    CONSTRAINT fk_profile_photo FOREIGN KEY
        (fk_profile_photo_id) REFERENCES Resources(id),
    PRIMARY KEY(id)

);



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Profiles;
-- +goose StatementEnd
