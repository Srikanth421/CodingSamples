DROP TABLE EVENTPLANLINE;
DROP TABLE EVENTPLAN;
DROP TABLE EVENTREQUEST;
DROP TABLE LOCATION;
DROP TABLE FACILITY;
DROP TABLE RESOURCETBL;
DROP TABLE CUSTOMER;
DROP TABLE EMPLOYEE;

-------------------- EMPLOYEE --------------------------------

 CREATE TABLE Employee 
  (EmpNo VARCHAR2(8) CONSTRAINT EmpNoNotNull NOT NULL, 
   EmpName VARCHAR2(35) CONSTRAINT EmpNameNotNull NOT NULL, 
   Department VARCHAR2(25) CONSTRAINT DepartmetnNotNull NOT NULL, 
   Email VARCHAR2(30) CONSTRAINT EmailNotNull NOT NULL, 
   Phone VARCHAR2(10) CONSTRAINT EPhoneNotNull NOT NULL, 
   CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EmpNo) ) ;

 COMMENT ON COLUMN EMPLOYEE.EMPNO IS 'Employee number';
 COMMENT ON COLUMN EMPLOYEE.EMPNAME IS 'Employee name';
 COMMENT ON COLUMN EMPLOYEE.DEPARTMENT IS 'Department';
 COMMENT ON COLUMN EMPLOYEE.EMAIL IS 'electronic mail address';

-------------------- CUSTOMER --------------------------------

  CREATE TABLE Customer 
   (CustNo VARCHAR2(8) CONSTRAINT CustNoNotNull NOT NULL, 
    CustName VARCHAR2(30) CONSTRAINT CustNameNotNull NOT NULL, 
    Address VARCHAR2(50) CONSTRAINT AddressNotNull NOT NULL, 
    Internal CHAR(1) CONSTRAINT InternalNotNull NOT NULL, 
    Contact VARCHAR2(35) CONSTRAINT ContractNotNull NOT NULL, 
    Phone VARCHAR2(11) CONSTRAINT CPhoneNotNull NOT NULL, 
    City VARCHAR2(30) CONSTRAINT CityNotNull NOT NULL,
    State VARCHAR2(2) CONSTRAINT StateNotNull NOT NULL, 
    Zip VARCHAR2(10) CONSTRAINT zipNotNull NOT NULL,
    CONSTRAINT PK_CUSTOMER PRIMARY KEY (CustNo) ) ;

  COMMENT ON COLUMN CUSTOMER.CUSTNO IS 'Customer number'; 
  COMMENT ON COLUMN CUSTOMER.CUSTNAME IS 'Customer name';   
  COMMENT ON COLUMN CUSTOMER.ADDRESS IS 'Customer address';
  COMMENT ON COLUMN CUSTOMER.INTERNAL IS 'Customer type (Yes if internal, No otherwise)';
  COMMENT ON COLUMN CUSTOMER.CONTACT IS 'Contact person'; 
  COMMENT ON COLUMN CUSTOMER.PHONE IS 'Contact phone number'; 
  COMMENT ON COLUMN CUSTOMER.CITY IS 'City';
  COMMENT ON COLUMN CUSTOMER.STATE IS 'State'; 
  COMMENT ON COLUMN CUSTOMER.ZIP IS 'Zip code';


-------------------- RESOURCETBL --------------------------------

  CREATE TABLE ResourceTbl
  (ResNo VARCHAR2(8) CONSTRAINT ResNoNotNull NOT NULL, 
   ResName VARCHAR2(30) CONSTRAINT ResNameNotNull NOT NULL, 
   Rate NUMBER(15,4) CONSTRAINT RateNotNull NOT NULL,
   CONSTRAINT RatePositive CHECK (Rate > 0), 
   CONSTRAINT PK_RESOURCE PRIMARY KEY (ResNo) );

   COMMENT ON TABLE RESOURCETBL  IS 'ORIGINAL NAME:Resource';

-------------------- FACILITY --------------------------------

  CREATE TABLE Facility
  (FacNo VARCHAR2(8) CONSTRAINT FacNoNotNull NOT NULL, 
   FacName VARCHAR2(30) CONSTRAINT FacNameNotNull NOT NULL,
   CONSTRAINT PK_FACILITY PRIMARY KEY (FacNo) );  

   COMMENT ON COLUMN FACILITY. FACNO IS 'Facility number';
   COMMENT ON COLUMN FACILITY.FACNAME IS 'Facility name';

-------------------- LOCATION --------------------------------

  CREATE TABLE Location
  (LocNo VARCHAR2(8) CONSTRAINT LocNoNotNull NOT NULL, 
   FacNo VARCHAR2(8) CONSTRAINT FacNoFKNotNull NOT NULL, 
   LocName VARCHAR2(30) CONSTRAINT LocNameNotNull NOT NULL,
   CONSTRAINT PK_LOCATION PRIMARY KEY (LocNo),
   CONSTRAINT FK_FACNO FOREIGN KEY (FacNo) REFERENCES FACILITY (FacNo) );

  COMMENT ON COLUMN LOCATION.LOCNO IS 'Location number';
  COMMENT ON COLUMN LOCATION.FACNO IS 'Facility number';
  COMMENT ON COLUMN LOCATION.LOCNAME IS 'Location name';

-------------------- EVENTREQUEST --------------------------------

  CREATE TABLE EventRequest
  (EventNo VARCHAR2(8) CONSTRAINT EventNoNotNull NOT NULL, 
   DateHeld DATE CONSTRAINT DateheldNotNull NOT NULL, 
   DateReq DATE CONSTRAINT DateReqNotNull NOT NULL, 
   CustNo VARCHAR2(8) CONSTRAINT CustNoFKNotNull NOT NULL, 
   FacNo VARCHAR2(8) CONSTRAINT FacNoFK2NotNull NOT NULL, 
   DateAuth DATE, 
   Status VARCHAR2(20 CHAR) CONSTRAINT StatusNotNull NOT NULL, 
   EstCost NUMBER(15,4) CONSTRAINT EstCostNotNull NOT NULL, 
   EstAudience NUMBER(11,0) CONSTRAINT EstAudienceNotNull NOT NULL, 
   BudNo VARCHAR2(8),
   CONSTRAINT ValidStatus CHECK (Status IN ('Pending', 'Denied', 'Approved')),
   CONSTRAINT EstAudiencePositive CHECK (EstAudience > 0),
   CONSTRAINT PK_EVENTREQUEST PRIMARY KEY (EventNo),
   CONSTRAINT FK_EVENT_FACNO FOREIGN KEY (FacNo) REFERENCES FACILITY (FacNo),
   CONSTRAINT FK_CUSTNO FOREIGN KEY (CustNo) REFERENCES CUSTOMER (CustNo) ); 

  COMMENT ON COLUMN EVENTREQUEST.EVENTNO IS 'Event number';
  COMMENT ON COLUMN EVENTREQUEST.DATEHELD IS 'Event date';
  COMMENT ON COLUMN EVENTREQUEST.DATEREQ IS 'Date requested';
  COMMENT ON COLUMN EVENTREQUEST.CUSTNO IS 'Customer number';
  COMMENT ON COLUMN EVENTREQUEST.FACNO IS 'Facility number';
  COMMENT ON COLUMN EVENTREQUEST.DATEAUTH IS 'Date authorized';
  COMMENT ON COLUMN EVENTREQUEST.STATUS IS 'Status of event request';
  COMMENT ON COLUMN EVENTREQUEST.ESTCOST IS 'Estimated cost';
  COMMENT ON COLUMN EVENTREQUEST.ESTAUDIENCE IS 'Estimated audience';
  COMMENT ON COLUMN EVENTREQUEST.BUDNO IS 'Budget number';

-------------------- EVENTPLAN --------------------------------

  CREATE TABLE EventPlan
  (PlanNo VARCHAR2(8) CONSTRAINT PlanNoNotNull NOT NULL, 
   EventNo VARCHAR2(8) CONSTRAINT EventNoFKNotNull NOT NULL, 
   WorkDate DATE CONSTRAINT WorkDateNotNull NOT NULL, 
   Notes VARCHAR2(50), 
   Activity VARCHAR2(50) CONSTRAINT ActivityNotNull NOT NULL, 
   EmpNo VARCHAR2(8),
   CONSTRAINT PK_EVENTPLAN PRIMARY KEY (PlanNo), 
   CONSTRAINT FK_EMPNO FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE (EmpNo),
   CONSTRAINT FK_EVENTNO FOREIGN KEY (EventNo) REFERENCES EVENTREQUEST (EventNo) ); 

  COMMENT ON COLUMN EVENTPLAN.PLANNO IS 'Event plan number';
  COMMENT ON COLUMN EVENTPLAN.EVENTNO IS 'Event number';
  COMMENT ON COLUMN EVENTPLAN.WORKDATE IS 'Work date';

-------------------- EVENTPLANLINE --------------------------------

  CREATE TABLE EventPlanLine
  (PlanNo VARCHAR2(8) CONSTRAINT PlanNoFKNotNull NOT NULL, 
   LineNo INTEGER CONSTRAINT LineNoNotNull NOT NULL, 
   TimeStart DATE CONSTRAINT TimeStartNotNull NOT NULL, 
   TimeEnd DATE CONSTRAINT TimeEndNotNull NOT NULL, 
   NumberFld INTEGER CONSTRAINT NumberFldNotNull NOT NULL, 
   LocNo VARCHAR2(8) CONSTRAINT LocNoFKNotNull NOT NULL, 
   ResNo VARCHAR2(8) CONSTRAINT ResNoFKNotNull NOT NULL,
   CONSTRAINT TimeStartEndRelationship CHECK (TimeStart < TimeEnd), 
   CONSTRAINT PK_EVENTPLANLINE PRIMARY KEY (PlanNo, LineNo),
   CONSTRAINT FK_LOCNO FOREIGN KEY (LocNo) REFERENCES LOCATION (LocNo), 
   CONSTRAINT FK_RESNO FOREIGN KEY (ResNo) REFERENCES RESOURCETBL (ResNo), 
   CONSTRAINT FK_PLANNO FOREIGN KEY (PlanNo) REFERENCES EVENTPLAN (PlanNo) ); 

  COMMENT ON COLUMN EVENTPLANLINE.PLANNO IS 'Event Event plan number';
  COMMENT ON COLUMN EVENTPLANLINE.LINENO IS 'line number';
  COMMENT ON COLUMN EVENTPLANLINE.TIMESTART IS 'Time start';
  COMMENT ON COLUMN EVENTPLANLINE.TIMEEND IS 'Time end';
  COMMENT ON COLUMN EVENTPLANLINE.NUMBERFLD IS 'ORIGINAL NAME:number , Number of resources needed';

  Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E100','Chuck Coordinator','Administration','chuck@colorado.edu','3-1111');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E101','Mary Manager','Football','mary@colorado.edu','5-1111');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E102','Sally Supervisor','Planning','sally@colorado.edu','3-2222');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E103','Alan Administrator','Administration','alan@colorado.edu','3-3333');

Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C100','Football','Box 352200','Y','Mary Manager','6857100','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C101','Men''s Basketball','Box 352400','Y','Sally Supervisor','5431700','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C103','Baseball','Box 352020','Y','Bill Baseball','5431234','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C104','Women''s Softball','Box 351200','Y','Sue Softball','5434321','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C105','High School Football','123 AnyStreet','N','Coach Bob','4441234','Louisville','CO','80027');

Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R100','attendant',10);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R101','police',15);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R102','usher',10);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R103','nurse',20);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R104','janitor',15);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R105','food service',10);

Insert into FACILITY (FACNO,FACNAME) values ('F100','Football stadium');
Insert into FACILITY (FACNO,FACNAME) values ('F101','Basketball arena');
Insert into FACILITY (FACNO,FACNAME) values ('F102','Baseball field');
Insert into FACILITY (FACNO,FACNAME) values ('F103','Recreation room');

Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L100','F100','Locker room');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L101','F100','Plaza');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L102','F100','Vehicle gate');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L103','F101','Locker room');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L104','F100','Ticket Booth');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L105','F101','Gate');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L106','F100','Pedestrian gate');

Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E100',to_date('25-OCT-13','DD-MON-RR'),to_date('06-JUN-13','DD-MON-RR'),'C100','F100',to_date('08-JUN-13','DD-MON-RR'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E101',to_date('26-OCT-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C100','F100',null,'Pending',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E103',to_date('21-SEP-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C100','F100',to_date('01-AUG-13','DD-MON-RR'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E102',to_date('14-SEP-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C100','F100',to_date('31-JUL-13','DD-MON-RR'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E104',to_date('03-DEC-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C101','F101',to_date('31-JUL-13','DD-MON-RR'),'Approved',2000,12000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E105',to_date('05-DEC-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C101','F101',to_date('01-AUG-13','DD-MON-RR'),'Approved',2000,10000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E106',to_date('12-DEC-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C101','F101',to_date('31-JUL-13','DD-MON-RR'),'Approved',2000,10000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E107',to_date('23-NOV-13','DD-MON-RR'),to_date('28-JUL-13','DD-MON-RR'),'C105','F100',to_date('31-JUL-13','DD-MON-RR'),'Denied',10000,5000,null);


Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P100','E100',to_date('25-OCT-13','DD-MON-RR'),'Standard operation','Operation','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P101','E104',to_date('03-DEC-13','DD-MON-RR'),'Watch for gate crashers','Operation','E100');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P102','E105',to_date('05-DEC-13','DD-MON-RR'),'Standard operation','Operation','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P103','E106',to_date('12-DEC-13','DD-MON-RR'),'Watch for seat switching','Operation',null);
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P104','E101',to_date('26-OCT-13','DD-MON-RR'),'Standard cleanup','Cleanup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P105','E100',to_date('25-OCT-13','DD-MON-RR'),'Light cleanup','Cleanup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P199','E102',to_date('10-DEC-13','DD-MON-RR'),'ABC','Operation','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P299','E101',to_date('26-OCT-13','DD-MON-RR'),null,'Operation','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P349','E106',to_date('12-DEC-13','DD-MON-RR'),null,'Setup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P85','E100',to_date('25-OCT-13','DD-MON-RR'),'Standard operation','Cleanup','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P95','E101',to_date('26-OCT-13','DD-MON-RR'),'Extra security','Cleanup','E102');

Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',1, to_date('25-OCT-13 8:00:00','DD-MON-RR HH24:MI:SS'), to_date('25-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),2,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',2, to_date('25-OCT-13 12:00:00','DD-MON-RR HH24:MI:SS'),to_date('25-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'), 2,'L101','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',3, to_date('25-OCT-13 7:00:00','DD-MON-RR HH24:MI:SS'), to_date('25-OCT-13 16:30:00','DD-MON-RR HH24:MI:SS'), 1,'L102','R102');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',4, to_date('25-OCT-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('25-OCT-13 22:00:00','DD-MON-RR HH24:MI:SS'),2,'L100','R102');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',1, to_date('3-DEC-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('3-DEC-13 20:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',2, to_date('3-DEC-13 18:30:00','DD-MON-RR HH24:MI:SS'),to_date('3-DEC-13 19:00:00','DD-MON-RR HH24:MI:SS'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',3, to_date('3-DEC-13 19:00:00','DD-MON-RR HH24:MI:SS'),to_date('3-DEC-13 20:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',1, to_date('5-DEC-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('5-DEC-13 19:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',2, to_date('5-DEC-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('5-DEC-13 21:00:00','DD-MON-RR HH24:MI:SS'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',3, to_date('5-DEC-13 19:00:00','DD-MON-RR HH24:MI:SS'),to_date('5-DEC-13 22:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',1, to_date('12-DEC-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('12-DEC-13 21:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',2, to_date('12-DEC-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('12-DEC-13 21:00:00','DD-MON-RR HH24:MI:SS'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',3, to_date('12-DEC-13 19:00:00','DD-MON-RR HH24:MI:SS'),to_date('12-DEC-13 22:00:00','DD-MON-RR HH24:MI:SS'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P104',1, to_date('26-OCT-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('26-OCT-13 22:00:00','DD-MON-RR HH24:MI:SS'),4,'L101','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P104',2, to_date('26-OCT-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('26-OCT-13 22:00:00','DD-MON-RR HH24:MI:SS'),4,'L100','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P105',1, to_date('25-OCT-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('25-OCT-13 22:00:00','DD-MON-RR HH24:MI:SS'),4,'L101','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P105',2, to_date('25-OCT-13 18:00:00','DD-MON-RR HH24:MI:SS'),to_date('25-OCT-13 22:00:00','DD-MON-RR HH24:MI:SS'),4,'L100','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P199',1, to_date('10-DEC-13 8:00:00','DD-MON-RR HH24:MI:SS'), to_date('10-DEC-13 12:00:00','DD-MON-RR HH24:MI:SS'),1,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P349',1, to_date('12-DEC-13 12:00:00','DD-MON-RR HH24:MI:SS'),to_date('12-DEC-13 15:30:00','DD-MON-RR HH24:MI:SS'),1,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',1,  to_date('25-OCT-13 9:00:00','DD-MON-RR HH24:MI:SS'), to_date('25-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),5,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',2,  to_date('25-OCT-13 8:00:00','DD-MON-RR HH24:MI:SS'), to_date('25-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),2,'L102','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',3, to_date('25-OCT-13 10:00:00','DD-MON-RR HH24:MI:SS'), to_date('25-OCT-13 15:00:00','DD-MON-RR HH24:MI:SS'),3,'L104','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',1, to_date('26-OCT-13 8:00:00','DD-MON-RR HH24:MI:SS'),  to_date('26-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),4,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',2, to_date('26-OCT-13 9:00:00','DD-MON-RR HH24:MI:SS'),  to_date('26-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),4,'L102','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',3, to_date('26-OCT-13 10:00:00','DD-MON-RR HH24:MI:SS'), to_date('26-OCT-13 15:00:00','DD-MON-RR HH24:MI:SS'),4,'L106','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',4, to_date('26-OCT-13 13:00:00','DD-MON-RR HH24:MI:SS'), to_date('26-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),2,'L100','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',5, to_date('26-OCT-13 13:00:00','DD-MON-RR HH24:MI:SS'), to_date('26-OCT-13 17:00:00','DD-MON-RR HH24:MI:SS'),2,'L101','R104');

select * from employee;
select * from resourcetbl;
select * from eventrequest;
select * from eventplan;
select * from eventplanline;
select * from customer;
select * from location;
select * from facility;

SELECT DISTINCT city,state,zip FROM customer;
SELECT empname,department,phone,email FROM employee WHERE phone LIKE '3-%';






SELECT * FROM resourcetbl WHERE rate BETWEEN 10 AND 20 ORDER BY rate;



SELECT eventno,
  DATEAUTH,
  status
FROM eventrequest
WHERE status IN('Approved','Denied')
AND dateauth BETWEEN '01-JUL-13' AND '31-JUL-13';

SELECT locno,
  locname
FROM location l
JOIN facility f
ON l.facno    =f.facno
WHERE facname = 'Basketball arena';

SELECT planno,
  COUNT(lineno)  AS lines,
  SUM(numberfld) AS resources_assigned
FROM eventplanline
GROUP BY planno
HAVING COUNT(*)>1; 
select * from eventplan;
SELECT er.eventno,
  dateheld,
  COUNT(planno)
FROM eventrequest er
INNER JOIN eventplan ep
ON er.EVENTNO=ep.EVENTNO
WHERE ep.WORKDATE BETWEEN '01-DEC-13' AND '31-DEC-13'
GROUP BY er.eventno,
  dateheld
HAVING COUNT(*)>1;
select * from facility;
select * from location;
select * from eventplan;
select * from eventrequest;
select * from eventplanline;
SELECT planno,
  ep.eventno,
  workdate,
  activity
FROM eventrequest er
INNER JOIN facility f
ON f.facno=er.facno
INNER JOIN eventplan ep
ON ep.eventno=er.eventno
WHERE workdate BETWEEN '01-DEC-13' AND '31-DEC-13'
AND facname='Basketball arena';
select * from employee;
SELECT er.eventno,dateheld,status,er.ESTCOST
FROM eventrequest er
INNER JOIN eventplan ep
ON ep.eventno=er.eventno
INNER JOIN employee e
ON e.EMPNO=ep.EMPNO
INNER JOIN facility f
ON f.facno=er.facno
WHERE e.empname LIKE 'Mary Manager'
AND f.facname LIKE 'Basketball arena'
AND er.dateheld BETWEEN '01-OCT-13' AND '31-DEC-13';

SELECT * FROM resourcetbl;
SELECT ep.planno,lineno,resname,numberfld,lo.locname,timestart,timeend
FROM facility f
INNER JOIN location lo
ON f.facno=lo.facno
INNER JOIN eventrequest er
ON f.facno=er.facno
INNER JOIN eventplan ep
ON ep.eventno=er.eventno
INNER JOIN eventplanline epl
ON ep.planno = epl.planno
INNER JOIN resourcetbl r
ON r.resno = epl.resno
WHERE activity LIKE 'Operation'
AND f.facname LIKE 'Basketball arena'
AND er.dateheld BETWEEN '01-OCT-13' AND '31-DEC-13';







INSERT INTO facility
  (facno,facname
  ) VALUES
  ('F104','Swimming Pool'
  );
SELECT * FROM facility;



INSERT INTO location
  (locno,facno,locname
  ) VALUES
  ('L108','F104','Locker Room'
  );
SELECT * FROM location;



UPDATE location SET locname='Gate' WHERE locno='L107';
SELECT * FROM location;



DELETE FROM location WHERE locno='L108';
SELECT * FROM location;



SELECT eventrequest.eventno, dateheld, COUNT(*) "Number of Plans"
FROM eventrequest, eventplan
WHERE eventplan.workdate BETWEEN to_date('12/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventrequest.eventno = eventplan.eventno
GROUP BY eventrequest.eventno, dateheld
HAVING COUNT(*) > 1;

SELECT eventplan.planno, eventrequest.eventno, workdate, activity
FROM eventrequest, eventplan, facility
WHERE eventplan.workdate BETWEEN to_date('12/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventrequest.eventno = eventplan.eventno 
      AND eventrequest.facno = facility.facno
      AND facname = 'Basketball arena';

SELECT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan
WHERE dateheld BETWEEN to_date('10/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventplan.empno = employee.empno AND eventrequest.facno = facility.facno
      AND facname = 'Basketball arena' AND empname = 'Mary Manager'
      AND eventrequest.eventno = eventplan.eventno;

SELECT eventplan.planno, lineno, locname, resname, numberfld, 
                timestart, timeend
                
FROM facility, eventplan, eventplanline, resourcetbl, location
WHERE eventplan.workdate BETWEEN to_date('10/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventplan.planno = eventplanline.planno AND location.facno = facility.facno
      AND facname = 'Basketball arena' AND eventplanline.resno = resourcetbl.resno
      AND location.locno = eventplanline.locno 
      
      AND eventplan.activity = 'Operation';




