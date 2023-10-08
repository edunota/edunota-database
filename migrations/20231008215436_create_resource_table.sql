-- +goose Up
-- +goose StatementBegin

CREATE TYPE ResourceType AS ENUM(
    'IMAGE',
    'DOCUMENT'
);

CREATE TYPE ResourceEncodingType AS ENUM(
    'SRC',
  'BASE64',
  'BYTEA'
);



CREATE TABLE IF NOT EXISTS Resources(
    id BIGSERIAL PRIMARY KEY NOT NULL,
    resource_type ResourceType DEFAULT 'IMAGE',
    source TEXT NOT NULL,
    alt TEXT ,
    resource_encoding  ResourceEncodingType DEFAULT 'SRC',
    description TEXT,
    mime VARCHAR(16)
);



-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS Resources;

DROP TYPE ResourceType;
DROP TYPE ResourceEncodingType;


-- +goose StatementEnd
