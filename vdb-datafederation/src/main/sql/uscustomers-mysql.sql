--
-- Current Database: uscustomers
--
--DROP DATABASE IF EXISTS uscustomers;

--CREATE DATABASE uscustomers;

--use uscustomers;

--
-- Table structure for table account
--

CREATE TABLE account (
  AccountID decimal(18,0) NOT NULL,
  SSN varchar(12) NOT NULL,
  AccountType char(10) DEFAULT NULL,
  AccountStatus char(10) DEFAULT NULL,
  DATEOPENED datetime NOT NULL,
  DATECLOSED datetime DEFAULT NULL,
  PRIMARY KEY (AccountID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table accountholdings
--

CREATE TABLE accountholdings (
  TransactionID varchar(12) NOT NULL,
  AccountID decimal(18,0) NOT NULL,
  ProductID varchar(12) NOT NULL,
  PURCHASEDATE datetime NOT NULL,
  ProductShares decimal(20,6) NOT NULL,
  PRIMARY KEY (TransactionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table customer
--

CREATE TABLE customer (
  SSN varchar(12) NOT NULL,
  FIRSTNAME varchar(25) NOT NULL,
  LASTNAME varchar(25) NOT NULL,
  MIDDLEInitial varchar(15) DEFAULT NULL,
  StreetAddress1 varchar(50) NOT NULL,
  AptNumber varchar(50) DEFAULT NULL,
  CITY varchar(25) NOT NULL,
  State varchar(25) DEFAULT NULL,
  ZipCode varchar(15) NOT NULL,
  Phone varchar(30) DEFAULT NULL,
  PRIMARY KEY (SSN)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE marketdata (
  SYMBOL varchar(25) NOT NULL,
  PRICE varchar(10) NOT NULL,
  PRIMARY KEY (SYMBOL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- CREATE CONSTRAINTS  ----------------------------

ALTER TABLE accountholdings ADD CONSTRAINT FK_Acctholdings_AcctID FOREIGN KEY (accountid)
      REFERENCES account (accountid)  
      ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE account ADD CONSTRAINT FK_Account_SSN FOREIGN KEY (ssn)
      REFERENCES customer (ssn)  
      ON UPDATE RESTRICT ON DELETE RESTRICT;
--
-- Dumping data for table customer
--

INSERT INTO marketdata VALUES('RHT','143.42'),('AAPL','868.01'),('GOOGL','1111.34'),('PNRA','84.97'),('SY','24.30'),('BTU','41.25'),('IBM','80.89'),('DELL','10.75'),('HPQ','31.52'),('GE','16.45'),('MRK','27.20'),('DIS','20.53'),('MCD','54.55'),('DOW','21.80'),('GM','3.15'),('SBGI','2.19'),('COLM','33.89');

INSERT INTO customer VALUES ('CST01002','Joseph','Smith',NULL,'1234 Main Street','Apartment 56','New York','New York','10174','(646)555-1776'),('CST01003','Nicholas','Ferguson','Robert','202 Palomino Drive',NULL,'Pittsburgh','Pennsylvania','15071','(412)555-4327'),('CST01004','Jane','Aire',NULL,'15 State Street',NULL,'Philadelphia','Pennsylvania','19154','(814)555-6789'),('CST01005','Charles','Jones','Howard','1819 Maple Street','Apartment 17F','Stratford','Connecticut','06614','(203)555-3947'),('CST01006','Virginia','Jefferson','Louise','1710 South 51st Street','Apartment 3245','New York','New York','10175','(718)555-2693'),('CST01007','Ralph','Bacon','Herbert','57 Barn Swallow Avenue',NULL,'Charlotte','North Carolina','28205','(704)555-4576'),('CST01008','Bonnie','Dragon','Anne','88 Cinderella Lane',NULL,'Jacksonville','Florida','32225','(904)555-6514'),('CST01009','Herbert','Smith','Lomas','12225 Waterfall Way','Building 100, Suite 9','Portland','Oregon','97220','(971)555-7803'),('CST01015','Jack','Corby','Thomas','1 Lone Star Way',NULL,'Dallas','Texas','75231','(469)555-8023'),('CST01019','Robin','Evers','Lynn','1814 Falcon Avenue',NULL,'Atlanta','Georgia','30355','(470)555-4390'),('CST01020','Lloyd','Abercrombie','Henry','1954 Hughes Parkway',NULL,'Los Angeles','California','90099','(213)555-2312'),('CST01021','Scott','Watters','George','24 Mariner Way',NULL,'Seattle','Washington','98124','(206)555-6790'),('CST01022','Sandra','King','Rose','96 Lakefront Parkway',NULL,'Minneapolis','Minnesota','55426','(651)555-9017'),('CST01027','Maryanne','Peters',NULL,'35 Grand View Circle','Apartment 5F','Cincinnati','Ohio','45232','(513)555-9067'),('CST01034','Corey','Snyder','James','1760 Boston Commons Avenue','Suite 543','Boston','Massachusetts','02136 ','(617)555-3546'),('CST01035','Henry','Thomas','Karl','345 Hilltop Parkway',NULL,'San Francisco','California','94129','(415)555-2093'),('CST01036','James','Drew','Carey','876 Lakefront Lane',NULL,'Cleveland','Ohio','44107','(216)555-6523');

--
-- Dumping data for table account
--

INSERT INTO account VALUES ('20160002','CST01002','Personal','Active','2016-02-01 00:00:00',NULL),('20160003','CST01003','Personal','Active','2016-03-06 00:00:00',NULL),('20160004','CST01004','Personal','Active','2016-03-07 00:00:00',NULL),('20160005','CST01005','Personal','Active','2016-06-15 00:00:00',NULL),('20160006','CST01006','Personal','Active','2016-09-15 00:00:00',NULL),('20160007','CST01007','Personal','Active','2016-01-20 00:00:00',NULL),('20160008','CST01008','Personal','Active','2016-04-16 00:00:00',NULL),('20160009','CST01009','Business','Active','2016-06-25 00:00:00',NULL),('20170015','CST01015','Personal','Closed','2017-04-20 00:00:00','2017-06-22 00:00:00'),('20170019','CST01019','Personal','Active','2017-10-08 00:00:00',NULL),('20170020','CST01020','Personal','Active','2017-10-20 00:00:00',NULL),('20170021','CST01021','Personal','Active','2017-12-05 00:00:00',NULL),('20170022','CST01022','Personal','Active','2017-01-05 00:00:00',NULL),('20170027','CST01027','Personal','Active','2017-08-22 00:00:00',NULL),('20170034','CST01034','Business','Active','2017-01-22 00:00:00',NULL),('20170035','CST01035','Personal','Active','2017-02-12 00:00:00',NULL),('20170036','CST01036','Personal','Active','2017-03-22 00:00:00',NULL);

--
-- Dumping data for table accountholdings
--

INSERT INTO accountholdings VALUES ('TXT001002','20160002','PRD01008','2016-02-01 00:00:00','50.000000'),('TXT001003','20160002','PRD01042','2016-02-01 00:00:00','25.250000'),('TXT001004','20160003','PRD01002','2016-03-06 00:00:00','100.000000'),('TXT001005','20160003','PRD01029','2016-03-06 00:00:00','25.000000'),('TXT001006','20160003','PRD01055','2016-03-06 00:00:00','50.500000'),('TXT001007','20160004','PRD01062','2016-03-07 00:00:00','30.125000'),('TXT001008','20160005','PRD01050','2016-06-15 00:00:00','18.000000'),('TXT001009','20160006','PRD01046','2016-09-15 00:00:00','200.000000'),('TXT001010','20160007','PRD01067','2016-01-20 00:00:00','65.000000'),('TXT001011','20160008','PRD01052','2016-04-16 00:00:00','102.125000'),('TXT001012','20160007','PRD01068','2016-05-11 00:00:00','85.000000'),('TXT001013','20160008','PRD01076','2016-05-21 00:00:00','105.000000'),('TXT001014','20160009','PRD01060','2016-06-25 00:00:00','120.375000'),('TXT001015','20160003','PRD01048','2016-07-22 00:00:00','150.000000'),('TXT001021','20170015','PRD01032','2017-04-20 00:00:00','135.000000'),('TXT001023','20160006','PRD01030','2017-06-12 00:00:00','90.625000'),('TXT001028','20170019','PRD01042','2017-10-08 00:00:00','350.750000'),('TXT001029','20170020','PRD01030','2017-10-20 00:00:00','126.875000'),('TXT001030','20170020','PRD01018','2017-11-14 00:00:00','100.000000'),('TXT001031','20170019','PRD01031','2017-11-15 00:00:00','125.000000'),('TXT001032','20170021','PRD01037','2017-12-05 00:00:00','400.000000'),('TXT001033','20170022','PRD01058','2017-01-05 00:00:00','236.625000'),('TXT001034','20160008','PRD01015','2017-01-23 00:00:00','180.000000'),('TXT001037','20160005','PRD01038','2017-03-23 00:00:00','125.000000'),('TXT001043','20170027','PRD01076','2017-08-22 00:00:00','70.000000'),('TXT001052','20170020','PRD01006','2017-11-14 00:00:00','125.000000'),('TXT001053','20160003','PRD01049','2017-11-15 00:00:00','100.000000'),('TXT001057','20170021','PRD01011','2017-12-18 00:00:00','44.000000'),('TXT001058','20170027','PRD01021','2017-12-19 00:00:00','115.000000'),('TXT001060','20170034','PRD01055','2017-01-22 00:00:00','188.875000'),('TXT001061','20160009','PRD01102','2017-01-24 00:00:00','30.000000'),('TXT001063','20170035','PRD01058','2017-02-12 00:00:00','110.125000'),('TXT001064','20170035','PRD01083','2017-02-13 00:00:00','70.000000'),('TXT001065','20170034','PRD01088','2017-02-22 00:00:00','25.000000'),('TXT001066','20170019','PRD01089','2017-02-26 00:00:00','195.000000'),('TXT001067','20160004','PRD01090','2017-03-05 00:00:00','250.000000'),('TXT001069','20170021','PRD01014','2017-03-12 00:00:00','300.000000'),('TXT001070','20170027','PRD01024','2017-03-14 00:00:00','136.000000'),('TXT001071','20170036','PRD01012','2017-03-22 00:00:00','54.000000'),('TXT001072','20170036','PRD01037','2017-03-26 00:00:00','188.875000'),('TXT001075','20160005','PRD01068','2017-04-01 00:00:00','26.000000');
