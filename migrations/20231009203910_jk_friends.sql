-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS Jk_Friends(
     id BIGSERIAL PRIMARY KEY not null,
     fk_profile_id UUID REFERENCES Profiles(id),
     fk_friends_id UUID REFERENCES Profiles(id)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS Jk_Friends;
-- +goose StatementEnd
