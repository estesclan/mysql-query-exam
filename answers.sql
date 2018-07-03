/*
1) Select a distinct list of ordered airports codes.
*/
SELECT distinct departAirport as Airports from flight;

/*
2) Provide a list of flights with a delayed status that depart from San Francisco (SFO).
*/
SELECT name, flightNumber, scheduledDepartDateTime, arriveAirport, status
FROM flight JOIN airline
ON airline.ID = flight.airlineID
WHERE departAirport = 'SFO'
HAVING status = 'delayed';

/*
3) Provide a distinct list of cities that American Airlines departs from.
*/
SELECT distinct departAirport as Cities
FROM flight JOIN airline
ON airline.ID = flight.airlineID
WHERE airline.name = 'American';

/*
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/
SELECT distinct name as Airline
FROM flight JOIN airline
ON airline.ID = flight.airlineID
WHERE departAirport = 'ATL';

/*
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/
SELECT name, flightNumber, departAirport, arriveAirport
FROM flight JOIN airline
ON airline.ID = flight.airlineID
WHERE scheduledDepartDateTime = actualDepartDateTime;

/*
6) Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. 
Order your results by the arrival time.
*/

SELECT name as Airline, flightNumber as Flight, gate as Gate, time(scheduledArriveDateTime) as Arrival, status as Status
FROM flight JOIN airline
ON airline.ID = flight.airlineID
WHERE arriveAirport = 'CLT' and date(scheduledArriveDateTime) = '2017-10-30'




/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/
SELECT flightNumber as flight, count(passengerID) as reservations
FROM flight JOIN reservation
ON flight.ID = reservation.flightID
GROUP BY flightNumber
ORDER BY reservations desc;

/*
8) List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/
SELECT name as airline, departAirport, arriveAirport, avg(cost) as AverageCost
FROM airline JOIN flight
ON airline.ID = flight.airlineID
JOIN reservation 
ON flight.ID = reservation.flightID
WHERE class = 'coach'
GROUP BY arriveAirport
ORDER BY AverageCost desc;

/*
9) Which route is the longest?
*/
SELECT departAirport, arriveAirport, miles
FROM flight
ORDER BY miles desc
LIMIT 1;

/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/
SELECT firstName, lastName, sum(miles) as miles
FROM passenger JOIN reservation
ON passenger.ID = reservation.passengerID
JOIN flight
ON flight.ID = reservation.flightID
GROUP BY lastName
ORDER BY miles desc
limit 5;

/*
11) Provide a list of American airline flights ordered by route and arrival date and time.
*/
SELECT name as Name, concat(departAirport, ' --> ', arriveAirport) as Route, 
date(scheduledArriveDateTime) as 'Arrive Date', time(scheduledArriveDateTime) as 'Arrive Time' 
FROM airline JOIN flight
ON airline.ID = flight.airlineID
WHERE Name = 'American'
ORDER BY Route;

/*
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) 
by Airline, flight, and route. Order the report by total revenue in descending order.
*/
SELECT name as Airline,  flightNumber as Flight, concat(departAirport, ' --> ', arriveAirport) as Rout,
count(passengerID) as 'Reservation Count', sum(cost) as Revenue
FROM airline JOIN flight
ON airline.ID = flight.airlineID
JOIN reservation
ON flight.ID = reservation.flightID
GROUP BY Flight
ORDER BY Revenue desc;

/*
13) List the average cost per reservation by route. Round results down to the dollar.
*/
SELECT concat(departAirport, ' --> ', arriveAirport) as Route, floor(avg(cost)) as 'Avg Revenue'
FROM flight JOIN reservation
ON flight.ID = reservation.flightID
GROUP BY route
ORDER BY floor(avg(cost)) desc;

/*
14) List the average miles per flight by airline.
*/
SELECT name as Airline, avg(miles) as 'Avg Miles Per Flight'
FROM airline JOIN flight
ON airline.ID = flight.airlineID
GROUP BY name;

/*
15) Which airlines had flights that arrived early?
*/
SELECT distinct name as Airline
FROM airline JOIN flight
ON airline.ID = flight.airlineID
WHERE scheduledArriveDateTime > actualArriveDateTime;












