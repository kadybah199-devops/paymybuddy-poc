-- La base de données est déjà créée par la variable MYSQL_DATABASE
-- Ce script initialise uniquement le schéma
USE paymybuddy;

CREATE TABLE IF NOT EXISTS users (
    id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    email    VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    sender_id   BIGINT         NOT NULL,
    receiver_id BIGINT         NOT NULL,
    amount      DECIMAL(10,2)  NOT NULL,
    description VARCHAR(255),
    created_at  DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender   FOREIGN KEY (sender_id)   REFERENCES users(id),
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_id) REFERENCES users(id)
);
