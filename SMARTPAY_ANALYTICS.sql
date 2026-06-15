CREATE DATABASE SMARTPAY_ANALYTICS;
USE SMARTPAY_ANALYTICS;

-- TABLE 1 -- Users 
CREATE TABLE users (
    user_id VARCHAR(10) PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    date_of_birth DATE NOT NULL,

    gender VARCHAR(10) NOT NULL,
    
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    street_address VARCHAR(255) NOT NULL,

    yearly_income DECIMAL(12,2) NOT NULL,
    total_debt DECIMAL(12,2) DEFAULT 0.00,

    credit_score INT NOT NULL,
    num_credit_cards INT DEFAULT 0,

    registration_date DATE NOT NULL,

    account_status VARCHAR(20) NOT NULL,
    kyc_status VARCHAR(20) NOT NULL,

    wallet_balance DECIMAL(12,2) DEFAULT 0.00,

    CHECK (credit_score BETWEEN 300 AND 850),

    CHECK (yearly_income >= 0),

    CHECK (wallet_balance >= 0),

    CHECK (num_credit_cards >= 0),

    CHECK (gender IN ('Male', 'Female')),

    CHECK (account_status IN ('Active', 'Inactive', 'Blocked')),

    CHECK (kyc_status IN ('Verified', 'Pending'))
);

-- Table 2 -Cards --
CREATE TABLE cards (
    card_id VARCHAR(10) PRIMARY KEY,

    user_id VARCHAR(10) NOT NULL,

    card_brand VARCHAR(20) NOT NULL,

    card_type VARCHAR(20) NOT NULL,

    masked_card_number VARCHAR(25) NOT NULL UNIQUE,

    expiry_date DATE NOT NULL,

    has_chip BOOLEAN NOT NULL,

    credit_limit DECIMAL(12,2),

    acct_open_date DATE NOT NULL,

    card_on_dark_web BOOLEAN DEFAULT FALSE,

    card_status VARCHAR(20) NOT NULL,

    contactless_enabled BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id),

    CHECK (card_brand IN ('Visa', 'Mastercard', 'Discover')),

    CHECK (card_type IN ('Debit', 'Credit', 'Prepaid')),

    CHECK (card_status IN ('Active', 'Inactive', 'Blocked')),

    CHECK (credit_limit >= 0)
);

-- TABLE 3 - MERCHANTS --
CREATE TABLE merchants (
    merchant_id VARCHAR(10) PRIMARY KEY,

    merchant_name VARCHAR(100) NOT NULL,

    merchant_category VARCHAR(50) NOT NULL,

    merchant_city VARCHAR(50) NOT NULL,

    merchant_state VARCHAR(50) NOT NULL,

    risk_level VARCHAR(10) NOT NULL,

    merchant_status VARCHAR(20) NOT NULL,

    merchant_type VARCHAR(20) NOT NULL,

    CHECK (risk_level IN ('Low', 'Medium', 'High')),

    CHECK (merchant_status IN ('Active', 'Suspended', 'Under Review')),

    CHECK (merchant_type IN ('Online', 'Offline', 'Hybrid'))
);

 -- TABLE 4 - TRANSACTION --
CREATE TABLE transactions (
    transaction_id VARCHAR(12) PRIMARY KEY,

    user_id VARCHAR(10) NOT NULL,

    card_id VARCHAR(10) NOT NULL,

    merchant_id VARCHAR(10) NOT NULL,

    transaction_date DATETIME NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    transaction_mode VARCHAR(20) NOT NULL,

    transaction_status VARCHAR(20) NOT NULL,

    failure_reason VARCHAR(100),

    FOREIGN KEY (user_id)
    REFERENCES users(user_id),

    FOREIGN KEY (card_id)
    REFERENCES cards(card_id),

    FOREIGN KEY (merchant_id)
    REFERENCES merchants(merchant_id),

    CHECK (amount > 0),

    CHECK (transaction_mode IN ('Chip', 'Swipe', 'Online', 'Tap')),

    CHECK (transaction_status IN ('Success', 'Failed'))
);


INSERT INTO users VALUES
('USR1001','Paul','Carter','1972-05-14','Male','Los Angeles','California','462 Rose Lane',59696.00,127613.00,787,5,'2023-02-15','Active','Verified',2450.75),
('USR1002','Andrew','Ramirez','1971-11-22','Male','Chicago','Illinois','3606 Federal Boulevard',77254.00,191349.00,701,5,'2022-08-11','Active','Verified',1520.00),
('USR1003','Lucas','Hall','1944-09-03','Male','Houston','Texas','766 Third Drive',33483.00,196.00,698,5,'2021-12-05','Inactive','Pending',250.50),
('USR1004','Patricia','Lewis','1962-01-19','Female','Phoenix','Arizona','3 Madison Street',249925.00,202328.00,722,4,'2024-01-10','Active','Verified',8450.25),
('USR1005','Barbara','Clark','1982-07-30','Female','Philadelphia','Pennsylvania','9620 Valley Stream Drive',109687.00,183855.00,675,1,'2023-09-21','Active','Verified',965.00),
('USR1006','Patricia','Ramirez','1983-04-15','Female','San Antonio','Texas','58 Birch Lane',41997.00,0.00,704,3,'2022-03-17','Blocked','Verified',120.00),
('USR1007','David','Hall','1989-12-08','Male','San Diego','California','5695 Fifth Street',51500.00,102286.00,672,3,'2024-05-06','Active','Pending',785.45),
('USR1008','Joshua','Johnson','1998-06-11','Female','Dallas','Texas','1941 Ninth Street',54623.00,114711.00,728,1,'2021-11-29','Active','Verified',3250.90),
('USR1009','Paul','Allen','1944-10-25','Male','San Jose','California','11 Spruce Avenue',42509.00,2895.00,755,5,'2023-06-14','Inactive','Verified',410.00),
('USR1010','Alexander','Flores','1990-03-02','Male','Austin','Texas','887 Grant Street',38190.00,81262.00,810,1,'2024-02-18','Active','Verified',9250.00);
INSERT INTO users VALUES
('USR1011','Henry','Young','1997-08-17','Male','Jacksonville','Florida','888 Fifth Lane',56164.00,15224.00,761,2,'2023-01-08','Active','Verified',1800.00),
('USR1012','Benjamin','Harris','1995-02-21','Female','Fort Worth','Texas','8677 Littlewood Lane',45727.00,94016.00,629,1,'2022-10-12','Blocked','Pending',90.00),
('USR1013','Matthew','Ramirez','2006-09-09','Male','Columbus','Ohio','829 Fourth Boulevard',69149.00,89214.00,776,1,'2024-04-22','Active','Verified',5150.35),
('USR1014','Jessica','Lewis','1990-11-01','Female','Charlotte','North Carolina','74786 Jefferson Drive',41442.00,78833.00,712,3,'2021-07-30','Inactive','Verified',640.00),
('USR1015','Mia','Jackson','1976-05-26','Female','San Francisco','California','781 East Street',20513.00,32509.00,599,1,'2023-08-19','Blocked','Pending',55.00),
('USR1016','Benjamin','Jones','1984-06-12','Male','Indianapolis','Indiana','40 Washington Drive',23123.00,5079.00,723,6,'2022-11-03','Active','Verified',3500.00),
('USR1017','Patricia','Campbell','1971-03-18','Female','Seattle','Washington','3994 Hillside Drive',36497.00,38333.00,719,6,'2023-12-09','Active','Verified',2780.80),
('USR1018','Joseph','Lopez','1949-09-29','Male','Denver','Colorado','172 Birch Street',27484.00,16803.00,660,4,'2021-05-28','Inactive','Pending',430.00),
('USR1019','David','King','2003-02-14','Male','Washington','District of Columbia','8145 Spruce Boulevard',53995.00,89056.00,683,3,'2024-03-14','Active','Verified',1120.00),
('USR1020','James','Clark','1959-08-20','Male','Boston','Massachusetts','153 Tenth Lane',35602.00,55369.00,661,5,'2022-06-16','Active','Verified',940.75),

('USR1021','Andrew','Green','1997-01-07','Male','El Paso','Texas','2473 Lake Avenue',25122.00,43205.00,819,3,'2024-02-01','Active','Verified',6100.00),
('USR1022','Kenneth','Walker','2006-10-11','Female','Nashville','Tennessee','970 Essex Drive',216740.00,0.00,700,2,'2023-04-23','Active','Verified',7850.00),
('USR1023','Mary','Adams','1949-12-05','Female','Detroit','Michigan','9186 Washington Avenue',41109.00,21486.00,698,2,'2022-01-19','Inactive','Pending',320.00),
('USR1024','Michael','Wilson','1955-06-28','Male','Oklahoma City','Oklahoma','5073 Wessex Avenue',26858.00,11245.00,712,2,'2021-09-11','Blocked','Verified',450.25),
('USR1025','Jennifer','Johnson','1980-04-13','Female','Portland','Oregon','195 Eighth Boulevard',34929.00,63849.00,714,1,'2023-05-17','Active','Verified',890.00),
('USR1026','Charlotte','Hill','1989-07-01','Female','Las Vegas','Nevada','801 Mill Boulevard',34317.00,61826.00,610,3,'2024-04-07','Blocked','Pending',150.00),
('USR1027','Aiden','Ramirez','1985-11-23','Female','Memphis','Tennessee','6914 Wessex Avenue',31377.00,59615.00,722,2,'2022-08-30','Active','Verified',1340.00),
('USR1028','Emily','White','1988-05-15','Female','Louisville','Kentucky','776 Norfolk Boulevard',43638.00,104052.00,627,1,'2021-11-21','Inactive','Pending',260.00),
('USR1029','Samuel','Brown','1984-02-10','Female','Baltimore','Maryland','2015 Bayview Avenue',32531.00,38260.00,766,2,'2023-03-13','Active','Verified',1890.50),
('USR1030','Steven','Campbell','1988-09-09','Male','Milwaukee','Wisconsin','108 Washington Street',42120.00,72801.00,739,4,'2022-12-05','Active','Verified',2425.00),

('USR1031','Charles','Scott','2006-01-17','Female','Albuquerque','New Mexico','660 Seventh Drive',57281.00,89114.00,850,1,'2024-05-12','Active','Verified',9255.00),
('USR1032','Matthew','Gonzalez','1976-10-30','Male','Tucson','Arizona','7505 Tenth Boulevard',38390.00,87923.00,783,4,'2021-06-18','Inactive','Verified',710.00),
('USR1033','Emily','Williams','1992-08-06','Female','Fresno','California','4930 Birch Drive',35670.00,58182.00,751,2,'2023-10-25','Active','Verified',1680.00),
('USR1034','Abigail','Williams','2004-12-27','Female','Sacramento','California','93 Plum Lane',61746.00,154817.00,637,2,'2022-04-14','Blocked','Pending',205.00),
('USR1035','Charlotte','Adams','1978-03-04','Female','Kansas City','Missouri','837 Lincoln Avenue',43496.00,114563.00,765,3,'2021-07-08','Active','Verified',3360.00),
('USR1036','Abigail','Wilson','1984-06-19','Female','Mesa','Arizona','51854 North Drive',72162.00,38210.00,737,2,'2024-01-27','Active','Verified',1470.00),
('USR1037','Michael','Taylor','1974-02-22','Male','Atlanta','Georgia','6323 Sussex Boulevard',34540.00,22641.00,793,5,'2023-02-09','Active','Verified',5240.00),
('USR1038','Alexander','Garcia','1979-11-18','Male','Omaha','Nebraska','8738 Fourth Street',41287.00,88151.00,662,1,'2022-09-29','Inactive','Pending',300.00),
('USR1039','William','Miller','1979-07-13','Male','Colorado Springs','Colorado','9344 Mill Drive',38054.00,63293.00,666,1,'2021-12-16','Blocked','Verified',410.00),
('USR1040','Lucas','Campbell','1966-05-08','Male','Raleigh','North Carolina','299 11th Street',80371.00,108499.00,822,1,'2024-03-01','Active','Verified',7450.00),

('USR1041','Harper','Robinson','1934-10-24','Female','Miami','Florida','5492 Maple Drive',84694.00,2149.00,741,7,'2023-08-08','Active','Verified',5200.00),
('USR1042','Lucas','Baker','1946-09-16','Male','Long Beach','California','829 Birch Boulevard',37503.00,14272.00,706,5,'2022-05-11','Inactive','Pending',550.00),
('USR1043','Elizabeth','Sanchez','1968-01-28','Female','Virginia Beach','Virginia','41011 Seventh Boulevard',65357.00,21844.00,685,4,'2021-10-20','Active','Verified',1780.00),
('USR1044','Jack','Johnson','1998-04-09','Male','Oakland','California','613 Little Creek Lane',22066.00,38967.00,842,1,'2024-02-22','Active','Verified',8620.00),
('USR1045','Henry','Roberts','1983-06-14','Male','Minneapolis','Minnesota','1942 Rose Avenue',44681.00,42011.00,770,3,'2023-01-31','Active','Verified',2140.00),
('USR1046','Donald','King','1998-11-03','Male','Tulsa','Oklahoma','5101 Birch Lane',51306.00,68198.00,675,1,'2022-07-15','Blocked','Pending',125.00),
('USR1047','Jennifer','Smith','2006-03-20','Female','Arlington','Texas','7 11th Drive',25847.00,46379.00,568,1,'2021-09-26','Inactive','Pending',75.00),
('USR1048','Steven','Wright','1964-12-01','Female','New Orleans','Louisiana','2468 Spruce Drive',46683.00,93126.00,788,5,'2024-04-11','Active','Verified',4670.00),
('USR1049','Olivia','Hill','1963-07-07','Female','Cleveland','Ohio','8001 Essex Boulevard',31579.00,52419.00,771,3,'2023-06-23','Active','Verified',2360.00),
('USR1050','Daniel','Moore','1989-09-25','Male','Charlotte','North Carolina','12475 George Street',28030.00,12475.00,829,2,'2022-11-18','Active','Verified',6890.00);

SELECT * FROM USERS;

INSERT INTO cards VALUES
('CARD5001','USR1001','Visa','Debit','*-*-**-6374','2028-05-31',1,NULL,'2021-03-15',0,'Active',1),
('CARD5002','USR1002','Visa','Debit','*-*-**-1147','2029-08-31',1,NULL,'2020-11-10',0,'Active',1),
('CARD5003','USR1003','Visa','Debit','*-*-**-7329','2027-12-31',1,NULL,'2022-01-18',0,'Inactive',1),
('CARD5004','USR1004','Visa','Credit','*-*-**-5641','2028-09-30',0,10000.00,'2021-06-25',0,'Active',0),
('CARD5005','USR1005','Mastercard','Prepaid','*-*-**-2377','2026-07-31',1,NULL,'2020-09-12',0,'Active',1),
('CARD5006','USR1006','Visa','Credit','*-*-**-3574','2029-11-30',1,20000.00,'2021-02-14',0,'Blocked',1),
('CARD5007','USR1007','Visa','Debit','*-*-**-9798','2027-03-31',1,NULL,'2022-04-20',0,'Active',1),
('CARD5008','USR1008','Mastercard','Debit','*-*-**-6147','2030-01-31',1,NULL,'2021-08-09',0,'Active',1),
('CARD5009','USR1009','Mastercard','Prepaid','*-*-**-3854','2028-06-30',1,NULL,'2020-12-22',0,'Inactive',1),
('CARD5010','USR1010','Mastercard','Prepaid','*-*-**-2914','2029-04-30',1,NULL,'2021-05-17',0,'Active',1);

INSERT INTO cards VALUES
('CARD5011','USR1011','Visa','Credit','*-*-**-7811','2028-08-31',1,12000.00,'2021-04-15',0,'Active',1),
('CARD5012','USR1012','Mastercard','Debit','*-*-**-4427','2027-11-30',1,NULL,'2020-12-20',0,'Blocked',1),
('CARD5013','USR1013','Visa','Credit','*-*-**-9518','2030-02-28',1,25000.00,'2022-02-14',0,'Active',1),
('CARD5014','USR1014','Discover','Debit','*-*-**-6724','2026-09-30',1,NULL,'2021-06-09',0,'Inactive',1),
('CARD5015','USR1015','Mastercard','Prepaid','*-*-**-3051','2027-05-31',0,NULL,'2023-01-25',0,'Blocked',0),
('CARD5016','USR1016','Visa','Credit','*-*-**-1489','2029-03-31',1,18000.00,'2020-08-18',0,'Active',1),
('CARD5017','USR1017','Mastercard','Credit','*-*-**-5293','2028-12-31',1,15000.00,'2021-03-07',0,'Active',1),
('CARD5018','USR1018','Discover','Debit','*-*-**-8740','2026-07-31',1,NULL,'2020-10-11',0,'Inactive',1),
('CARD5019','USR1019','Visa','Debit','*-*-**-3948','2029-01-31',1,NULL,'2022-05-22',0,'Active',1),
('CARD5020','USR1020','Mastercard','Credit','*-*-**-2285','2028-10-31',1,22000.00,'2021-09-16',0,'Active',1),

('CARD5021','USR1021','Visa','Credit','*-*-**-8401','2030-06-30',1,30000.00,'2022-11-04',0,'Active',1),
('CARD5022','USR1022','Mastercard','Debit','*-*-**-5519','2027-08-31',1,NULL,'2021-01-28',0,'Active',1),
('CARD5023','USR1023','Discover','Prepaid','*-*-**-9837','2026-12-31',0,NULL,'2020-07-13',0,'Inactive',0),
('CARD5024','USR1024','Visa','Debit','*-*-**-4702','2028-04-30',1,NULL,'2021-10-09',0,'Blocked',1),
('CARD5025','USR1025','Mastercard','Credit','*-*-**-1368','2029-09-30',1,17000.00,'2022-06-15',0,'Active',1),
('CARD5026','USR1026','Discover','Debit','*-*-**-6249','2027-03-31',1,NULL,'2021-05-01',0,'Blocked',1),
('CARD5027','USR1027','Visa','Credit','*-*-**-7924','2028-11-30',1,14000.00,'2020-12-18',0,'Active',1),
('CARD5028','USR1028','Mastercard','Prepaid','*-*-**-3480','2026-08-31',0,NULL,'2021-08-27',0,'Inactive',0),
('CARD5029','USR1029','Visa','Debit','*-*-**-9657','2029-02-28',1,NULL,'2022-02-09',0,'Active',1),
('CARD5030','USR1030','Discover','Credit','*-*-**-4811','2030-05-31',1,21000.00,'2021-11-11',0,'Active',1),

('CARD5031','USR1031','Visa','Credit','*-*-**-1294','2029-07-31',1,35000.00,'2023-03-14',0,'Active',1),
('CARD5032','USR1032','Mastercard','Debit','*-*-**-7720','2027-10-31',1,NULL,'2020-09-06',0,'Inactive',1),
('CARD5033','USR1033','Discover','Credit','*-*-**-4405','2028-06-30',1,16000.00,'2021-12-22',0,'Active',1),
('CARD5034','USR1034','Visa','Prepaid','*-*-**-3186','2026-11-30',0,NULL,'2022-04-02',0,'Blocked',0),
('CARD5035','USR1035','Mastercard','Credit','*-*-**-8561','2029-12-31',1,19500.00,'2021-01-19',0,'Active',1),
('CARD5036','USR1036','Discover','Debit','*-*-**-2473','2027-04-30',1,NULL,'2020-11-25',0,'Active',1),
('CARD5037','USR1037','Visa','Credit','*-*-**-6140','2028-09-30',1,28000.00,'2022-07-08',0,'Active',1),
('CARD5038','USR1038','Mastercard','Prepaid','*-*-**-7315','2026-05-31',0,NULL,'2021-02-17',0,'Inactive',0),
('CARD5039','USR1039','Discover','Debit','*-*-**-9024','2028-01-31',1,NULL,'2020-08-29',0,'Blocked',1),
('CARD5040','USR1040','Visa','Credit','*-*-**-5639','2030-03-31',1,40000.00,'2023-05-21',0,'Active',1),

('CARD5041','USR1041','Mastercard','Credit','*-*-**-7743','2029-08-31',1,24000.00,'2021-06-11',0,'Active',1),
('CARD5042','USR1042','Discover','Debit','*-*-**-4580','2027-12-31',1,NULL,'2020-10-14',0,'Inactive',1),
('CARD5043','USR1043','Visa','Credit','*-*-**-6902','2028-07-31',1,13000.00,'2021-09-19',0,'Active',1),
('CARD5044','USR1044','Mastercard','Debit','*-*-**-3157','2029-11-30',1,NULL,'2022-12-03',0,'Active',1),
('CARD5045','USR1045','Discover','Credit','*-*-**-8426','2030-04-30',1,17500.00,'2021-04-27',0,'Active',1),
('CARD5046','USR1046','Visa','Prepaid','*-*-**-2768','2026-06-30',0,NULL,'2020-12-30',0,'Blocked',0),
('CARD5047','USR1047','Mastercard','Debit','*-*-**-5311','2027-09-30',1,NULL,'2021-07-15',1,'Inactive',1),
('CARD5048','USR1048','Discover','Credit','*-*-**-9037','2029-05-31',1,26000.00,'2022-01-08',0,'Active',1),
('CARD5049','USR1049','Visa','Credit','*-*-**-1845','2028-10-31',1,14500.00,'2021-11-20',0,'Active',1),
('CARD5050','USR1050','Mastercard','Debit','*-*-**-6672','2030-02-28',1,NULL,'2023-02-10',0,'Active',1);

SELECT * FROM CARDS;

INSERT INTO merchants VALUES
('MER101','Walmart','Retail','New York','New York','Medium','Active','Offline'),
('MER102','Starbucks','Food & Beverage','Los Angeles','California','Low','Active','Offline'),
('MER103','Amazon','E-commerce','Chicago','Illinois','Medium','Active','Online'),
('MER104','Target','Retail','Houston','Texas','Low','Active','Offline'),
('MER105','Uber','Transport','Phoenix','Arizona','Medium','Active','Online'),
('MER106','Best Buy','Electronics','Philadelphia','Pennsylvania','Low','Active','Offline'),
('MER107','Subway','Food & Beverage','San Antonio','Texas','Low','Active','Offline'),
('MER108','Apple Store','Electronics','San Diego','California','High','Active','Hybrid'),
('MER109','McDonalds','Food & Beverage','Dallas','Texas','Low','Active','Offline'),
('MER110','Netflix','Entertainment','San Jose','California','Medium','Active','Online');

INSERT INTO merchants VALUES
('MER111','Flipkart','E-commerce','Austin','Texas','Medium','Active','Online'),
('MER112','Spotify','Entertainment','Jacksonville','Florida','Low','Active','Online'),
('MER113','Nike','Fashion','Fort Worth','Texas','Medium','Active','Hybrid'),
('MER114','Zara','Fashion','Columbus','Ohio','Low','Active','Offline'),
('MER115','Samsung','Electronics','Charlotte','North Carolina','High','Active','Hybrid'),
('MER116','Adidas','Fashion','San Francisco','California','Low','Active','Hybrid'),
('MER117','Puma','Fashion','Indianapolis','Indiana','Low','Active','Hybrid'),
('MER118','Dominos','Food & Beverage','Seattle','Washington','Low','Active','Hybrid'),
('MER119','LG','Electronics','Denver','Colorado','Medium','Active','Hybrid'),
('MER120','H&M','Fashion','Washington','District of Columbia','Low','Active','Offline'),

('MER121','Sony','Electronics','Boston','Massachusetts','Medium','Active','Hybrid'),
('MER122','KFC','Food & Beverage','El Paso','Texas','Low','Active','Offline'),
('MER123','Levis','Fashion','Nashville','Tennessee','Low','Active','Offline'),
('MER124','Burger King','Food & Beverage','Detroit','Michigan','Medium','Active','Offline'),
('MER125','OnePlus','Electronics','Oklahoma City','Oklahoma','High','Active','Online'),
('MER126','Reebok','Fashion','Portland','Oregon','Low','Active','Hybrid'),
('MER127','HP','Electronics','Las Vegas','Nevada','Medium','Active','Hybrid'),
('MER128','Taco Bell','Food & Beverage','Memphis','Tennessee','Low','Active','Offline'),
('MER129','Dell','Electronics','Louisville','Kentucky','Medium','Active','Hybrid'),
('MER130','Sephora','Beauty','Baltimore','Maryland','Low','Active','Offline'),

('MER131','Lenovo','Electronics','Milwaukee','Wisconsin','Medium','Active','Hybrid'),
('MER132','Pizza Hut','Food & Beverage','Albuquerque','New Mexico','Low','Active','Offline'),
('MER133','Asus','Electronics','Tucson','Arizona','Medium','Active','Hybrid'),
('MER134','Chipotle','Food & Beverage','Fresno','California','Low','Active','Offline'),
('MER135','Boat','Electronics','Sacramento','California','High','Active','Online'),
('MER136','Forever21','Fashion','Kansas City','Missouri','Low','Active','Offline'),
('MER137','Acer','Electronics','Mesa','Arizona','Medium','Active','Hybrid'),
('MER138','Dunkin Donuts','Food & Beverage','Atlanta','Georgia','Low','Active','Offline'),
('MER139','Xiaomi','Electronics','Omaha','Nebraska','High','Active','Online'),
('MER140','Macys','Retail','Colorado Springs','Colorado','Medium','Active','Offline'),

('MER141','Google Store','Electronics','Raleigh','North Carolina','Medium','Active','Online'),
('MER142','Panera Bread','Food & Beverage','Miami','Florida','Low','Active','Offline'),
('MER143','Microsoft Store','Electronics','Long Beach','California','Medium','Active','Hybrid'),
('MER144','Wendys','Food & Beverage','Virginia Beach','Virginia','Low','Active','Offline'),
('MER145','Rolex','Luxury','Oakland','California','High','Active','Offline'),
('MER146','Hollister','Fashion','Minneapolis','Minnesota','Low','Active','Offline'),
('MER147','Canon','Electronics','Tulsa','Oklahoma','Medium','Active','Hybrid'),
('MER148','Starbucks','Food & Beverage','Arlington','Texas','Low','Active','Offline'),
('MER149','HP Store','Electronics','New Orleans','Louisiana','Medium','Active','Hybrid'),
('MER150','Gap','Fashion','Cleveland','Ohio','Low','Active','Offline');

select * FROM MERCHANTS;

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO transactions VALUES
('TXN900001','USR1001','CARD5001','MER101','2025-01-05 10:15:22',245.50,'Swipe','Failed','Insufficient Balance'),
('TXN900002','USR1002','CARD5002','MER102','2025-01-05 11:22:10',520.00,'Chip','Success',NULL),
('TXN900003','USR1003','CARD5003','MER103','2025-01-06 09:18:45',1200.75,'Online','Success',NULL),
('TXN900004','USR1004','CARD5004','MER104','2025-01-06 14:10:12',89.99,'Chip','Failed','Technical Error'),
('TXN900005','USR1005','CARD5005','MER105','2025-01-07 16:05:33',430.25,'Online','Success',NULL),
('TXN900006','USR1006','CARD5006','MER106','2025-01-07 18:45:17',980.00,'Swipe','Success',NULL),
('TXN900007','USR1007','CARD5007','MER107','2025-01-08 08:20:11',150.00,'Chip','Success',NULL),
('TXN900008','USR1008','CARD5008','MER108','2025-01-08 20:40:29',2200.00,'Chip','Failed','Suspected Fraud'),
('TXN900009','USR1009','CARD5009','MER109','2025-01-09 12:14:05',75.60,'Swipe','Success',NULL),
('TXN900010','USR1010','CARD5010','MER110','2025-01-09 21:33:48',640.80,'Online','Success',NULL);

INSERT INTO transactions VALUES
('TXN900011','USR1011','CARD5011','MER111','2025-01-10 09:27:16',315.45,'Chip','Failed','Card Declined'),
('TXN900012','USR1012','CARD5012','MER112','2025-01-10 13:55:42',870.90,'Online','Success',NULL),
('TXN900013','USR1013','CARD5013','MER113','2025-01-11 17:12:30',1299.99,'Swipe','Success',NULL),
('TXN900014','USR1014','CARD5014','MER114','2025-01-11 19:40:27',455.70,'Chip','Success',NULL),
('TXN900015','USR1015','CARD5015','MER115','2025-01-12 11:25:18',2500.00,'Online','Failed','Suspected Fraud'),
('TXN900016','USR1016','CARD5016','MER116','2025-01-12 15:02:36',190.30,'Swipe','Success',NULL),
('TXN900017','USR1017','CARD5017','MER117','2025-01-13 10:45:09',760.40,'Chip','Success',NULL),
('TXN900018','USR1018','CARD5018','MER118','2025-01-13 14:28:44',88.20,'Online','Success',NULL),
('TXN900019','USR1019','CARD5019','MER119','2025-01-14 16:39:11',1430.00,'Chip','Failed','Technical Error'),
('TXN900020','USR1020','CARD5020','MER120','2025-01-14 18:50:23',670.10,'Swipe','Success',NULL),

('TXN900021','USR1021','CARD5021','MER121','2025-01-15 09:35:50',2345.00,'Chip','Success',NULL),
('TXN900022','USR1022','CARD5022','MER122','2025-01-15 12:20:18',95.99,'Online','Success',NULL),
('TXN900023','USR1023','CARD5023','MER123','2025-01-16 13:42:07',520.55,'Swipe','Success',NULL),
('TXN900024','USR1024','CARD5024','MER124','2025-01-16 17:05:39',180.75,'Chip','Failed','Network Error'),
('TXN900025','USR1025','CARD5025','MER125','2025-01-17 20:14:56',2750.00,'Online','Failed','Suspected Fraud'),

('TXN900026','USR1026','CARD5026','MER126','2025-01-17 21:48:12',330.60,'Swipe','Success',NULL),
('TXN900027','USR1027','CARD5027','MER127','2025-01-18 08:16:44',920.15,'Chip','Success',NULL),
('TXN900028','USR1028','CARD5028','MER128','2025-01-18 10:22:51',65.40,'Online','Success',NULL),
('TXN900029','USR1029','CARD5029','MER129','2025-01-19 13:05:38',1475.90,'Chip','Success',NULL),
('TXN900030','USR1030','CARD5030','MER130','2025-01-19 16:48:20',510.25,'Swipe','Failed','Card Declined'),

('TXN900031','USR1031','CARD5031','MER131','2025-01-20 09:33:17',2600.00,'Chip','Success',NULL),
('TXN900032','USR1032','CARD5032','MER132','2025-01-20 12:27:49',140.80,'Online','Success',NULL),
('TXN900033','USR1033','CARD5033','MER133','2025-01-21 14:55:36',890.45,'Swipe','Success',NULL),
('TXN900034','USR1034','CARD5034','MER134','2025-01-21 18:10:25',72.30,'Chip','Success',NULL),
('TXN900035','USR1035','CARD5035','MER135','2025-01-22 20:41:53',1999.99,'Online','Failed','Suspected Fraud'),

('TXN900036','USR1036','CARD5036','MER136','2025-01-22 22:15:42',410.60,'Swipe','Success',NULL),
('TXN900037','USR1037','CARD5037','MER137','2025-01-23 08:50:11',1350.25,'Chip','Success',NULL),
('TXN900038','USR1038','CARD5038','MER138','2025-01-23 11:36:57',54.90,'Online','Success',NULL),
('TXN900039','USR1039','CARD5039','MER139','2025-01-24 15:44:28',1700.00,'Chip','Failed','Technical Error'),
('TXN900040','USR1040','CARD5040','MER140','2025-01-24 18:05:39',620.70,'Swipe','Success',NULL),

('TXN900041','USR1041','CARD5041','MER141','2025-01-25 09:24:16',2450.80,'Chip','Success',NULL),
('TXN900042','USR1042','CARD5042','MER142','2025-01-25 12:42:33',110.35,'Online','Success',NULL),
('TXN900043','USR1043','CARD5043','MER143','2025-01-26 14:17:09',980.60,'Swipe','Success',NULL),
('TXN900044','USR1044','CARD5044','MER144','2025-01-26 17:58:46',78.50,'Chip','Failed','Insufficient Balance'),
('TXN900045','USR1045','CARD5045','MER145','2025-01-27 20:10:55',2890.00,'Online','Failed','Suspected Fraud'),

('TXN900046','USR1046','CARD5046','MER146','2025-01-27 22:36:14',350.20,'Swipe','Success',NULL),
('TXN900047','USR1047','CARD5047','MER147','2025-01-28 09:48:31',1250.75,'Chip','Success',NULL),
('TXN900048','USR1048','CARD5048','MER148','2025-01-28 13:15:27',69.99,'Online','Success',NULL),
('TXN900049','USR1049','CARD5049','MER149','2025-01-29 16:20:18',1590.30,'Chip','Success',NULL),
('TXN900050','USR1050','CARD5050','MER150','2025-01-29 19:44:52',430.90,'Swipe','Failed','Network Error');

SELECT * FROM TRANSACTIONS;

-- SmartPay Analytics: Improving Customer Growth, Transaction Success & Risk Management --

-- SmartPay Analytics: Improving Customer Growth, Transaction Success & Risk Management
-- Business Scenario --

-- SmartPay is a digital payment company facing three major challenges: -- 
--  Growing the customer base and increasing engagement. -- 
-- Reducing financial and fraud-related risks. -- 
-- Increasing transaction volume and revenue. --

-- Management wants data-driven answers to improve decision-making. -- 


-- SECTION 1 -CUSTOMER GROWTH &  ENGAGEMENT 

-- Query 1 - Which states contribute the most customers? --
-- Why business cares? -- 
-- To identify markets where SmartPay is strongest and where expansion opportunities exist.--

select * from users;

select state,
count(user_id) as total_users
 from users
 group by state 
 order by total_users desc
 limit 5;
 
-- query -2-- Which customer segment has the highest wallet balance?

-- Why business cares? -- Wallet balance is a direct indicator of customer engagement and platform usage. --

-- Business Impact -- Helps target inactive users with reactivation campaigns. --

select * from users;

select account_status,avg(wallet_balance) as avg_wallet_balance 
from users
group by account_status
order by avg_wallet_balance desc;

-- Query 3 -- Who are the most valuable customers based on wallet balance? -- or (Identify financially risky customers.)
-- Why business cares? -- Top-value customers generate the highest platform activity. -- 
-- Business Impact -- Useful for loyalty programs and VIP rewards.-- 

select * from users;
select user_id,first_name,last_name,wallet_balance
from users
order by wallet_balance desc
limit 5;

-- SECTION 2 — CREDIT & RISK MANAGEMENT --
-- Query 4: Which customers have low credit scores and high debt burdens?-- 
-- Why Business Cares -- These users may be more likely to default or experience payment issues.-- 

select first_name,last_name,credit_score,total_debt,yearly_income
from users
where credit_score<650
and total_debt>yearly_income
order by total_debt desc;


-- query 5- What percentage of cards are blocked or inactive?/What is the distribution of active, inactive, and blocked cards?
-- Why business cares? - Blocked cards can indicate fraud, misuse, or operational issues.

select * from cards;

select card_status, count(card_status) as counted_card_status 
from cards
group by card_status
order by counted_card_status desc;



-- section 3 -- Transaction Performace --
-- query 6 - What is the transaction success rate? / Measure overall payment performance.
-- Why business cares? -Success rate directly affects customer experience and revenue.

select * from transactions;

select transaction_status,count(transaction_status) as transaction_rate 
from transactions 
group by transaction_status
order by transaction_rate desc;

-- Query 7: What are the top reasons for transaction failures?
-- Business Problem -- Identify the major causes of failed transactions.
-- Why Business Cares -- Reducing failures improves customer experience and revenue generation.

select transaction_status, failure_reason,count(failure_reason) as transaction_failure
from transactions
where transaction_status ="failed"
group by failure_reason
order by transaction_failure desc;

-- section 4 - Merchant performance --
-- Query 8: Which merchant categories generate the highest revenue?
-- Business Problem -- Identify the most profitable merchant segments.
-- Why Business Cares -- Understanding revenue drivers helps optimize merchant partnerships.
-- Business Impact -- Supports strategic investment in high-performing merchant categories.

select * from transactions ;
select * from merchants ;

select sum(t.amount) as highest_revenue,
m.merchant_category 
from transactions t
inner join merchants m
on t.merchant_id=m.merchant_id
group by m.merchant_category
order by highest_revenue desc
limit 3 ;

-- SECTION 5 — CUSTOMER VALUE ANALYTICS
-- Query 9 (Window Function)-  Who are the highest-spending customers?
-- Business Impact -- Creates customer segmentation and VIP programs.

select * from users;
select * from transactions;

select u.user_id,u.first_name,
sum(t.amount) as total_spent,
rank()over( order by sum(t.amount) desc ) as spending_rank
from  users u
inner join transactions t 
on u.user_id = t.user_id
where t.transaction_status="success"
group by u.user_id,u.first_name
LIMIT 5;

-- section 6-  Revenue Opportunity Analysis -- 
-- query 10 -- Which customers spend above average? --
-- Business Impact -- Identifies the most profitable customer segment. -- 

SELECT
u.user_id,
u.first_name,
SUM(t.amount) total_spent
FROM users u
JOIN transactions t
ON u.user_id=t.user_id
GROUP BY u.user_id,u.first_name
HAVING SUM(t.amount) >
(
SELECT AVG(total_amount)
FROM
(
SELECT SUM(amount) total_amount
FROM transactions
GROUP BY user_id
) x
);


select * from users;

select * from transacations;

select * from merchants;

select * from  cards;

select gender,count(user_id) as gender_count
from users
group by gender;

