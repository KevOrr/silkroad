-- Remove old backup
DROP SCHEMA IF EXISTS Backup CASCADE;

-- Move `Public` to `Backup`
CREATE SCHEMA IF NOT EXISTS Public;
ALTER SCHEMA Public RENAME TO Backup;

-- Create new `Public` schema with default permissions
CREATE SCHEMA Public;
GRANT ALL ON SCHEMA Public TO postgres;
GRANT ALL ON SCHEMA Public TO public;

-- Products and suppliers
CREATE TABLE Products (
    pid SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    color TEXT
);

CREATE TABLE Suppliers (
    supid SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE Supplies (
    pid INTEGER NOT NULL REFERENCES Products (pid),
    cost NUMERIC NOT NULL CHECK (cost >= 0),
    qty INTEGER NOT NULL CHECK (qty > 0),
    supid INTEGER NOT NULL REFERENCES Suppliers (supid)
);

-- Stores
CREATE TABLE Stores (
    sid SERIAL PRIMARY KEY,
    address TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    telno TEXT
);

CREATE TABLE Inventory (
    sid INTEGER NOT NULL REFERENCES Stores (sid),
    pid INTEGER NOT NULL REFERENCES Products (pid),
    price NUMERIC NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    special BOOL NOT NULL
);

-- Employees
CREATE TABLE Roles (
    roleid SERIAL PRIMARY KEY,
    role TEXT NOT NULL
);

CREATE TABLE Employees (
    eid SERIAL PRIMARY KEY,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    hourly BOOL NOT NULL,
    pay NUMERIC NOT NULL CHECK (pay >= 0),
    roleid INTEGER NOT NULL REFERENCES Roles (roleid)
);

CREATE TABLE Employment (
    sid INTEGER NOT NULL REFERENCES Stores (sid),
    eid INTEGER NOT NULL REFERENCES Employees (eid)
);

-- Users of our site
CREATE TABLE Users (
    uid SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    admin bool NOT NULL
);
