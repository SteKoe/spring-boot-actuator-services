-- liquibase formatted sql

-- changeset liquibase:1
CREATE SCHEMA IF NOT EXISTS liquibase;
CREATE TABLE liquibase.test_table (test_id INT, test_column VARCHAR, PRIMARY KEY (test_id));

-- changeset liquibase:2
CREATE TABLE liquibase.another_test_table (test_id INT, test_column VARCHAR, PRIMARY KEY (test_id));
