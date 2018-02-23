-- ------------ CREATE Apaccustomers Database -------------------------
--DROP DATABASE IF EXISTS apaccustomers;

--CREATE DATABASE apaccustomers;

--use apaccustomers;

--
-- Table structure for table ACCOUNT
--

CREATE TABLE account (
  AccountId decimal(18,0) NOT NULL,
  CustID varchar(12) NOT NULL,
  AccountType char(10) DEFAULT NULL,
  AccountStatus char(10) DEFAULT NULL,
  DATEOPENED datetime NOT NULL,
  DATECLOSED datetime DEFAULT NULL,
  PRIMARY KEY (AccountId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table ACCOUNTHOLDINGS
--

CREATE TABLE accountholdings (
  TransactionID varchar(12) NOT NULL,
  AccountID decimal(18,0) NOT NULL,
  ProductID varchar(12) NOT NULL,
  PURCHASEDATE datetime NOT NULL,
  ProductShares decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (TransactionID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table CUSTOMER
--

CREATE TABLE customer (
  CustID varchar(12) NOT NULL,
  F_name varchar(25) NOT NULL,
  L_name varchar(25) NOT NULL,
  M_name varchar(15) DEFAULT NULL,
  StreetAddress varchar(50) NOT NULL,
  StreetAddress2 varchar(50) DEFAULT NULL,
  CITY varchar(25) NOT NULL,
  StateProvince varchar(25) DEFAULT NULL,
  POSTALCODE varchar(15) DEFAULT NULL,
  COUNTRY varchar(10) DEFAULT NULL,
  PhoneNumber varchar(30) DEFAULT NULL,
  PRIMARY KEY (CustID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- CREATE CONSTRAINTS  ----------------------------

ALTER TABLE accountholdings ADD CONSTRAINT FK_Acctholdings_AcctID FOREIGN KEY (accountid)
      REFERENCES account (accountid)  
      ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE account ADD CONSTRAINT FK_Account_CustID FOREIGN KEY (custid)
      REFERENCES customer (custid)  
      ON UPDATE RESTRICT ON DELETE RESTRICT;

--
-- Dumping data for table CUSTOMER
--

INSERT INTO customer VALUES ('CST02010','Cladius','Earl','Chance','14 Central Ave',NULL,'Brisbane','Queensland','2150','AU','(61)0011-555-8181'),('CST02011','Ken','Chan',NULL,'1017 Kwai Fong',NULL,'Hong Kong',NULL,NULL,'PRC','(852)555-1870'),('CST02012','Athene','Chambers','Elswyth','1212 Berkeley Gardens','Apt 215','Milton','NSW','2100','AU','(61)0011-555-1720'),('CST02013','John','Albee','Fredrick','99 George Street',NULL,'Parramatta','NSW','2124','AU','(61)0011-555-6709'),('CST02014','Lifeng','Chen',NULL,'7/F Fortune Plaza','No. 7','Beijing','Zhonglu','100020','China','(86)10-555-5402'),('CST02015','Sanjeev','Chauhan',NULL,'54 Swami Vivekanand Rd','Apartment 2','Mumbai','Maharashtra','400 302','India','(91)22-555-9120'),('CST02016','Nanda','Chaudhari',NULL,'27 Marve Rd',NULL,'Mumbai','Maharashtra','400 120','India','(91)555-6225 '),('CST02017','Kaustubh','Chawla',NULL,'58 Marigold Ave',NULL,'Pune',NULL,'411 014','India','(91)555-2367'),('CST02018','Simon','Chen','Keat','No. 5 Hengyang Road',NULL,'Taipei City',NULL,'100','Taiwan','(886)45.23.68.89'),('CST02019','Hong','Choong',NULL,'112 Robinson Road',NULL,'Singapore',NULL,'12210','Singapore','(65)0300-076548'),('CST02020','Xizhen','Lim',NULL,'1101 Nanking Street',NULL,'Beijing','Zhonglu','100020','China','(86)10-555-5402'),('CST02021','Lawrence','Du',NULL,'1217 Queen Street',NULL,'Milton','NSW','2100','AU','(61)0011-563-4318');

--
-- Dumping data for table ACCOUNT
--

INSERT INTO account VALUES ('20160210','CST02010','Personal','Active','2016-10-12 00:00:00',NULL),('20160211','CST02011','Personal','Active','2016-11-03 00:00:00',NULL),('20170212','CST02012','Personal','Active','2017-01-20 00:00:00',NULL),('20170213','CST02013','Personal','Active','2017-02-01 00:00:00',NULL),('20170214','CST02014','Personal','Active','2017-03-15 00:00:00',NULL),('20170216','CST02015','Personal','Active','2017-05-15 00:00:00',NULL),('20170217','CST02016','Personal','Active','2017-07-18 00:00:00',NULL),('20170218','CST02017','Personal','Active','2017-07-19 00:00:00',NULL),('20170223','CST02018','Personal','Active','2017-02-13 00:00:00',NULL),('20170224','CST02019','Personal','Active','2017-05-18 00:00:00',NULL),('20170225','CST02020','Personal','Closed','2017-06-26 00:00:00','2018-02-22 00:00:00'),('20170226','CST02021','Personal','Active','2017-07-25 00:00:00','2018-02-22 00:00:00');

--
-- Dumping data for table ACCOUNTHOLDINGS
--

INSERT INTO accountholdings VALUES ('TXT001016','20160210','PRD01090','2016-10-12 00:00:00','85.000000'),('TXT001017','20160211','PRD01075','2016-11-03 00:00:00','110.000000'),('TXT001018','20170212','PRD01091','2017-01-20 00:00:00','150.000000'),('TXT001019','20170213','PRD01072','2017-02-01 00:00:00','165.000000'),('TXT001020','20170214','PRD01027','2017-03-15 00:00:00','225.750000'),('TXT001022','20170216','PRD01047','2017-05-15 00:00:00','123.000000'),('TXT001024','20170217','PRD01041','2017-07-18 00:00:00','183.875000'),('TXT001025','20170218','PRD01051','2017-07-19 00:00:00','222.500000'),('TXT001026','20170217','PRD01063','2017-08-15 00:00:00','95.000000'),('TXT001027','20170218','PRD01016','2017-08-30 00:00:00','45.000000'),('TXT001035','20160210','PRD01028','2017-01-26 00:00:00','50.000000'),('TXT001036','20170223','PRD01035','2017-02-13 00:00:00','112.000000'),('TXT001038','20170212','PRD01031','2017-04-26 00:00:00','135.000000'),('TXT001039','20170224','PRD01053','2017-05-18 00:00:00','105.500000'),('TXT001040','20170225','PRD01059','2017-06-26 00:00:00','140.625000'),('TXT001041','20170226','PRD01060','2017-07-25 00:00:00','126.875000'),('TXT001042','20170226','PRD01064','2017-07-25 00:00:00','80.000000'),('TXT001047','20170218','PRD01092','2017-10-12 00:00:00','45.000000'),('TXT001048','20170226','PRD01086','2017-10-16 00:00:00','250.000000'),('TXT001049','20160210','PRD01021','2017-10-17 00:00:00','140.000000'),('TXT001054','20170224','PRD01008','2017-11-16 00:00:00','80.000000'),('TXT001062','20170212','PRD01099','2017-01-29 00:00:00','175.000000'),('TXT001068','20160211','PRD01094','2017-03-07 00:00:00','102.000000');
