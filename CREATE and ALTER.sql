CREATE TABLE department (
  id INTEGER,
  name VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE employees (
        id INTEGER,
        department_id INTEGER,
        name VARCHAR(255),
        PRIMARY KEY (id)
);

CREATE TABLE customer (
        id INTEGER,
        customer_name VARCHAR(255),
        location VARCHAR(255),
        PRIMARY KEY (id)
);

CREATE TABLE contract (
        id INTEGER,
        customer_id INTEGER,
        amount INTEGER,
        PRIMARY KEY (id)
);

CREATE TABLE executor (
	tab_no INTEGER,
	contract_id INTEGER
);

ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES department (id);
ALTER TABLE executor ADD FOREIGN KEY (tab_no) REFERENCES employees (id);
ALTER TABLE executor ADD FOREIGN KEY (contract_id) REFERENCES contract (id);
ALTER TABLE contract ADD FOREIGN KEY (customer_id) REFERENCES customer (id);