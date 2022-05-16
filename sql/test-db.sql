

CREATE DATABASE test_db IF NOT EXISTS;

CREATE TABLE test_db.test_table IF NOT EXISTS (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO test_db.test_table (id, name) VALUES (1, 'working');