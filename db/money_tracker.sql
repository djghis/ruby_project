DROP TABLE IF EXISTS transactions_tags;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS budgets;

CREATE TABLE budgets (
  id SERIAL PRIMARY KEY,
  amount FLOAT
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  amount FLOAT,
  merchant_id INT REFERENCES merchants(id),
  time_inserted TIMESTAMP
);

CREATE TABLE transactions_tags (
  id SERIAL PRIMARY KEY,
  transaction_id INT REFERENCES transactions(id),
  tag_id INT REFERENCES tags(id)
);
