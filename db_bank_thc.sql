DROP TABLE IF EXISTS tbl_borrower;
DROP TABLE IF EXISTS tbl_depositor;
DROP TABLE IF EXISTS tbl_loan;
DROP TABLE IF EXISTS tbl_customer;
DROP TABLE IF EXISTS tbl_account;
DROP TABLE IF EXISTS tbl_branch;
use labdb;
CREATE TABLE tbl_branch (
    branchCode CHAR(5),
    br_name CHAR(20),
    br_street CHAR(30),
    br_city CHAR(20),
    br_assets DECIMAL(12,2)
);

CREATE TABLE tbl_account (
    accountNo CHAR(10),
    ac_balance DECIMAL(12,2),
    branchCode CHAR(5)
);

CREATE TABLE tbl_customer (
    CustomerID CHAR(10),
    cs_name CHAR(20),
    cs_street CHAR(30),
    cs_city CHAR(20)
);

CREATE TABLE tbl_loan (
    loanNo CHAR(10),
    ln_amount DECIMAL(12,2),
    branchCode CHAR(5)
);

CREATE TABLE tbl_depositor (
    accountNo CHAR(10),
    CustomerID CHAR(10),
    dp_date DATE
);

CREATE TABLE tbl_borrower (
    loanNo CHAR(10),
    CustomerID CHAR(10),
    bo_date DATE
);

ALTER TABLE tbl_customer
ADD COLUMN cs_bg ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-')
NOT NULL DEFAULT 'O+' ;

ALTER TABLE tbl_customer
ADD COLUMN cs_email char(50);

ALTER TABLE tbl_customer
ADD COLUMN cs_nid char (50);

ALTER TABLE tbl_branch
ADD CONSTRAINT pk_tbl_branch PRIMARY KEY (branchCode);

ALTER TABLE tbl_account
ADD CONSTRAINT pk_tbl_account PRIMARY KEY (accountNo);

ALTER TABLE tbl_customer
ADD CONSTRAINT pk_tbl_customer PRIMARY KEY (CustomerID);

ALTER TABLE tbl_loan
ADD CONSTRAINT pk_tbl_loan PRIMARY KEY (loanNo);

ALTER TABLE tbl_depositor
ADD CONSTRAINT pk_tbl_depositor PRIMARY KEY (accountNo, CustomerID);

ALTER TABLE tbl_borrower
ADD CONSTRAINT pk_tbl_borrower PRIMARY KEY (loanNo, CustomerID);

ALTER TABLE tbl_account
ADD CONSTRAINT fk_tbl_account_branch
FOREIGN KEY (branchCode)
REFERENCES tbl_branch(branchCode)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_loan
ADD CONSTRAINT fk_tbl_loan_branch
FOREIGN KEY (branchCode)
REFERENCES tbl_branch(branchCode)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_depositor
ADD CONSTRAINT fk_tbl_depositor_account
FOREIGN KEY (accountNo)
REFERENCES tbl_account(accountNo)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_depositor
ADD CONSTRAINT fk_tbl_depositor_customer
FOREIGN KEY (CustomerID)
REFERENCES tbl_customer(CustomerID)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_borrower
ADD CONSTRAINT fk_tbl_borrower_loan
FOREIGN KEY (loanNo)
REFERENCES tbl_loan(loanNo)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_borrower
ADD CONSTRAINT fk_tbl_borrower_customer
FOREIGN KEY (CustomerID)
REFERENCES tbl_customer(CustomerID)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE tbl_customer
ADD CONSTRAINT uq_cs_email UNIQUE (cs_email);

ALTER TABLE tbl_customer
ADD CONSTRAINT uq_cs_nid UNIQUE (cs_nid);

INSERT INTO tbl_branch (branchCode, br_name, br_street, br_city, br_assets)
VALUES
('B001', 'Dhaka Main', 'Motijheel', 'Dhaka', 5000000.00),
('B002', 'Chittagong Branch', 'Agrabad', 'Chittagong', 3000000.00);

INSERT INTO tbl_account (accountNo, ac_balance, branchCode)
VALUES
('A1001', 100000.00, 'B001'),
('A1002', 50000.00, 'B002');

INSERT INTO tbl_customer (CustomerID, cs_name, cs_street, cs_bg, cs_city, cs_email, cs_nid)
VALUES
('C001', 'Rahim', 'Dhanmondi', 'A+', 'Dhaka', 'rahim@gmail.com', '113-502-116'),
('C002', 'Karim', 'Pahartali', 'B-', 'Chittagong', 'karim@gmail.com', '115-606-989');

INSERT INTO tbl_loan (loanNo, ln_amount, branchCode)
VALUES
('L001', 200000.00, 'B001'),
('L002', 150000.00, 'B002');

INSERT INTO tbl_depositor (accountNo, CustomerID, dp_date)
VALUES
('A1001', 'C001', '2026-03-31'),
('A1002', 'C002', '2026-03-30');

INSERT INTO tbl_borrower (loanNo, CustomerID, bo_date)
VALUES
('L001', 'C001', '2026-03-31'),
('L002', 'C002', '2026-03-30');

desc tbl_branch;
desc tbl_account;
desc tbl_customer;
desc tbl_loan;
desc tbl_depositor;
desc tbl_borrower;

SELECT * FROM tbl_branch;
SELECT * FROM tbl_account;
SELECT * FROM tbl_customer;
SELECT * FROM tbl_loan;
SELECT * FROM tbl_depositor;
SELECT * FROM tbl_borrower;

DELETE FROM tbl_customer WHERE CustomerID='C001';
SELECT * FROM tbl_customer;
SELECT * FROM tbl_depositor;
SELECT * FROM tbl_borrower;

UPDATE tbl_customer SET CustomerID='C809' WHERE CustomerID='C001';
SELECT * FROM tbl_customer;
SELECT * FROM tbl_depositor;
SELECT * FROM tbl_borrower;



