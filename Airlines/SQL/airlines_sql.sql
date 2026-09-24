create database airlines;
use airlines;


select * from airlines;
select * from airports;
select * from cancellation_codes;
select * from flights;


describe airlines;

describe airports;

describe cancellation_codes;

describe flights;


#checking counts

select count(*) as total_airlines
from airlines;

select count(*) as total_airports
from airports;

select count(*) as total_cancellation_codes
from cancellation_codes;

select count(*) as total_flights
from flights;


#checking duplicates 

select iata_code, count(*) as count
from airlines
group by iata_code
having count(*) > 1;


select iata_code, count(*) as count
from airports
group by iata_code
having count(*) > 1;


select cancellation_reason, count(*) as count
from cancellation_codes
group by cancellation_reason
having count(*) > 1;


select year, month, day, airline, flight_number, origin_airport, destination_airport, count(*) as count
from flights
group by year, month, day, airline, flight_number, origin_airport, destination_airport
having count(*) > 1;



#checking nulls

select
    sum(iata_code is null) as missing_iata,
    sum(airport is null) as missing_airport,
    sum(city is null) as missing_city,
    sum(state is null) as missing_state,
    sum(country is null) as missing_country,
    sum(latitude is null) as missing_latitude,
    sum(longitude is null) as missing_longitude
from airports;


select
    sum(iata_code is null) as missing_iata,
    sum(airline is null) as missing_airline
from airlines;


select
    sum(cancellation_reason is null) as missing_reason,
    sum(cancellation_description is null) as missing_description
from cancellation_codes;


select
    sum(year is null) as missing_year,
    sum(month is null) as missing_month,
    sum(day is null) as missing_day,
    sum(airline is null) as missing_airline,
    sum(origin_airport is null) as missing_origin,
    sum(destination_airport is null) as missing_destination,
    sum(departure_delay is null) as missing_departure_delay,
    sum(arrival_delay is null) as missing_arrival_delay
from flights;


#triming

set sql_safe_updates=0;

update airlines
set iata_code = trim(iata_code),
airline = trim(airline);
    
update airports
set iata_code = trim(iata_code),
airport = trim(airport),
city = trim(city),
state = trim(state),
country = trim(country);
    
update cancellation_codes
set cancellation_reason = trim(cancellation_reason),
cancellation_description = trim(cancellation_description);


#checking flight distance if negative 

select
min(distance) as minimum_distance,
max(distance) as maximum_distance,
avg(distance) as average_distance
from flights;

select count(*) as invalid_distance
from flights
where distance < 0;



#checking lat and long

select *
from airports
where latitude < -90
or latitude > 90
or longitude < -180
or longitude > 180;
