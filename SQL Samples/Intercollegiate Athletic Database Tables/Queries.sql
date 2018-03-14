--Queries

--Query 1
--List the city, state, and zip codes in the customer table.  
--Your result should not have duplicates.
SELECT DISTINCT city,state,zip FROM customer;

--Query 2
--List the name, department, phone number, and email address 
--of employees with a phone number beginning with “3-”.
SELECT empname,department,phone,email FROM employee WHERE phone LIKE '3-%';

--Query 3
--List all columns of the resource table with a rate between $10 and $20.
--Sort the result by rate.
SELECT * FROM resourcetbl WHERE rate BETWEEN 10 AND 20 ORDER BY rate;

--Query 4
--List the event requests with a status of “Approved” or “Denied” and an authorized date in July 2013.
--Include the event number, authorization date, and status in the output. 
SELECT eventno,
  DATEAUTH,
  status
FROM eventrequest
WHERE status IN('Approved','Denied')
AND dateauth BETWEEN '01-JUL-13' AND '31-JUL-13';

--Query 5
--List the location number and name of locations that are part of the “Basketball arena”. 
--Your WHERE clause should not have a condition involving the facility number compared to a constant (“F101”). 
--Instead, you should use a condition on the FacName column for the value of “Basketball arena”.
SELECT locno,
  locname
FROM location l
JOIN facility f
ON l.facno    =f.facno
WHERE facname = 'Basketball arena';

--Query 6
--For each event plan, list the plan number, count of the event plan lines, and 
--sum of the number of resources assigned.  For example, plan number “P100” has 4 lines 
--and 7 resources assigned.
--You only need to consider event plans that have at least one line.
SELECT planno,
  COUNT(lineno)  AS lines,
  SUM(numberfld) AS resources_assigned
FROM eventplanline
GROUP BY planno
HAVING COUNT(*)>1; 

--Query 7
--List the event number, date held, customer number, customer name, facility number,
--and facility name of 2013 events placed by Boulder customers.
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

--Query 8
--
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


--Query 9
--List the customer number, customer name, event number, date held, facility number, facility name, and estimated audience cost per person (EstCost / EstAudience)
--for events held on 2013, in which the estimated cost per person is less than $0.2
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

--Query 10
--
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

--Query 11
--Insert a new row into the Facility table with facility name “Swimming Pool”.
INSERT INTO facility
  (facno,facname
  ) VALUES
  ('F104','Swimming Pool'
  );

--Query 12
--Insert a new row in the Location table related to the Facility row. 
--The new row should have “Locker Room” for the location name.
INSERT INTO location
  (locno,facno,locname
  ) VALUES
  ('L108','F104','Locker Room'
  );

--Query 13
--Insert a new row in the Location table related to the Facility row. 
--The new row should have “Door” for the location name.
INSERT INTO location
  (locno,facno,locname
  ) VALUES
  ('L107','F104','Door'
  );

--Query 14
--Change the location name of “Door” to “Gate” for the row inserted in Query 13
UPDATE location SET locname='Gate' WHERE locno='L107';

--Query 15
--Delete the row inserted in modification Query 12.
DELETE FROM location WHERE locno='L108';

--Query 16
--For event requests, list the event number, event date (eventrequest.dateheld), and
--count of the event plans.  Only include event requests in the result 
--if the event request has more than one related event plan with a work date in December 2013.
SELECT eventrequest.eventno, dateheld, COUNT(*) "Number of Plans"
FROM eventrequest, eventplan
WHERE eventplan.workdate BETWEEN to_date('12/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventrequest.eventno = eventplan.eventno
GROUP BY eventrequest.eventno, dateheld
HAVING COUNT(*) > 1;

--Query 17
--List the plan number, event number, work date, and activity of event plans meeting the 
--following two conditions: (1) the work date is in December 2013 and (2) the event is held 
--in the “Basketball arena”.  Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. 
--Instead, you should use a condition on the FacName column for the value of “Basketball arena”.
SELECT eventplan.planno, eventrequest.eventno, workdate, activity
FROM eventrequest, eventplan, facility
WHERE eventplan.workdate BETWEEN to_date('12/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventrequest.eventno = eventplan.eventno 
      AND eventrequest.facno = facility.facno
      AND facname = 'Basketball arena';

--Query 18
--List the event number, event date, status, and estimated cost of events where there is 
--an event plan managed by Mary Manager and the event is held in the basketball arena in the 
--period October 1 to December 31, 2013.  Your query must not use the facility number (“F101”)
--of the basketball arena or the employee number (“E101”) of “Mary Manager” in the WHERE clause. Thus, the WHERE clause should not
--have conditions involving the facility number or employee number compared to constant values.
SELECT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan
WHERE dateheld BETWEEN to_date('10/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventplan.empno = employee.empno AND eventrequest.facno = facility.facno
      AND facname = 'Basketball arena' AND empname = 'Mary Manager'
      AND eventrequest.eventno = eventplan.eventno;

--Query 19
--List the plan number, line number, resource name, number of resources (eventplanline.number),
--location name, time start, and time end where the event is held at the basketball arena, the 
--event plan has activity of activity of “Operation”, and the event plan has a work date in the 
--period October 1 to December 31, 2013.  Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. 
--Instead, you should use a condition on the FacName column for the value of “Basketball arena”.
SELECT eventplan.planno, lineno, locname, resname, numberfld, 
                timestart, timeend
FROM facility, eventplan, eventplanline, resourcetbl, location
WHERE eventplan.workdate BETWEEN to_date('10/1/2013','mm/dd/yyyy') AND to_date('12/31/2013','mm/dd/yyyy')
      AND eventplan.planno = eventplanline.planno AND location.facno = facility.facno
      AND facname = 'Basketball arena' AND eventplanline.resno = resourcetbl.resno
      AND location.locno = eventplanline.locno 
      AND eventplan.activity = 'Operation';