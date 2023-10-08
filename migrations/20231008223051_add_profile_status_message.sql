-- +goose Up
-- +goose StatementBegin


ALTER TABLE Profiles ADD COLUMN profile_status_message TEXT; 

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

ALTER TABLE Profiles DROP COLUMN profile_status_message;

-- +goose StatementEnd
