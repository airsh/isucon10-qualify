DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    nega_popularity  INTEGER AS (-popularity) NOT NULL,
    location   POINT AS (POINT(latitude, longitude)) STORED NOT NULL -- spatial index を貼るため
);

CREATE INDEX idx_rent_id ON isuumo.estate (rent, id);
CREATE INDEX idx_nega_popularity_id ON isuumo.estate (nega_popularity ASC, id ASC);
CREATE SPATIAL INDEX idx_spatial ON isuumo.estate (location);

CREATE INDEX idx_estate_door_width_rent ON isuumo.estate(door_width, rent);
CREATE INDEX idx_estate_door_height_rent ON isuumo.estate(door_height, rent);
CREATE INDEX idx_estate_sort ON isuumo.estate(door_height, door_width, rent, nega_popularity, id);
CREATE INDEX idx_estate_filters_sort ON isuumo.estate(door_height, door_width, rent, nega_popularity, id);

CREATE INDEX idx_estate_filter_sort ON isuumo.estate(door_width, door_height, nega_popularity, id);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);

CREATE INDEX idx_price_id ON isuumo.chair (price, id);
CREATE INDEX idx_chair_stock_price_id ON isuumo.chair(stock, price, id);

ALTER TABLE isuumo.chair ADD INDEX chair_price_idx(price, stock);
ALTER TABLE isuumo.chair ADD INDEX chair_height_idx(height, stock);
ALTER TABLE isuumo.chair ADD INDEX chair_kind_idx(kind, stock);

