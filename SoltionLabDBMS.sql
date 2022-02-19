create database TravelOnTheGo;

use TravelOnTheGo; 

/* Question 1 */

/* create query to the passenger table */

create table passenger(passenger_id int primary key,passenger_name varchar(32),category varchar(32),gender varchar(1),boarding_city varchar(32),destination_city varchar(32),distance int,bus_type varchar(20));

/* create query to the price table */

create table price(price_id int primary key,bus_type varchar(20),price int,distance int);

/* Question 2 */

/* insert queries for the passenger table */

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (1,"Sejal","AC","F","Bengaluru","Chennai",350,"Sleeper");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (2,"Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (3,"Pallavi","AC","F","Panaji","Bengaluru",600,"Sleeper");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (4,"Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (5,"Udit","Non-AC","M","Trivandrum","Panaji",1000,"Sleeper");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (6,"Anchur","AC","M","Nagpur","Hyderabad",500,"Sitting");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (7,"Hemant","Non-AC","M","Panaji","Mumbai",700,"Sleeper");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (8,"Manish","Non-AC","M","Hyderabad","chennai",500,"Sitting");

insert into passenger(passenger_id,passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) values (9,"Piyush","AC","M","Pune","Nagpur",700,"Sitting");

/* insert queries for the price table */

insert into price(price_id,bus_type,price,distance) values (1,"Sleeper",770,350);

insert into price(price_id,bus_type,price,distance) values(2,"Sleeper",1100,500);

insert into price(price_id,bus_type,price,distance) values(3,"Sleeper",1320,600);

insert into price(price_id,bus_type,price,distance) values(4,"Sleeper",1540,700);

insert into price(price_id,bus_type,price,distance) values(5,"Sleeper",2200,1000);

insert into price(price_id,bus_type,price,distance) values(6,"Sleeper",2640,1200);

insert into price(price_id,bus_type,price,distance) values(7,"Sleeper",2700,1500);

insert into price(price_id,bus_type,price,distance) values(8,"Sitting",620,500);

insert into price(price_id,bus_type,price,distance) values(9,"Sitting",744,600);

insert into price(price_id,bus_type,price,distance) values(10,"Sitting",868,700);

insert into price(price_id,bus_type,price,distance) values(11,"Sitting",1240,1000);

insert into price(price_id,bus_type,price,distance) values(12,"Sitting",1488,1200);

insert into price(price_id,bus_type,price,distance) values(13,"Sitting",1860,1500);

/*Question 3 */

/*  How many females and how many male passengers travelled for a minimum distance of 600 KM s?  */

select p.gender, Count(*) from passenger p where p.distance<=600 group by p.gender ;

/*Question 4 */

/* Find the minimum ticket price for Sleeper Bus */

select p.bus_type,p.distance,min(p.price) as price from price p where p.bus_type="Sleeper"; 

/*Question 5 */

/*  Select passenger names whose names start with character 'S'  */

select p.* from passenger p where p.passenger_name Like "S%";

/*Question 6 */

/* Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output */

SELECT p.passenger_name as Passenger,p.boarding_city as BoardingCity,p.destination_city as DestinationCity,p.Bus_type as BusType, pi.price as Price
FROM passenger p
INNER JOIN price pi ON p.bus_type = pi.bus_type and p.distance=pi.distance group by p.passenger_name;

/*Question 7 */

/* What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s */

SELECT p.passenger_name as Passenger, pi.price as Price
FROM passenger p
INNER JOIN price pi ON p.bus_type = pi.bus_type and p.distance=pi.distance and
p.distance>=1000 and p.bus_type="sitting";

/*Question 8 */

/* What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? */

SELECT p.passenger_name as Passenger, pi.price as Price,pi.Bus_type as BusType
FROM passenger p
INNER JOIN price pi ON  p.distance=pi.distance and
p.passenger_name="Pallavi";

/*Question 9*/

/* List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order */

select distinct p.distance from passenger p order by p.distance desc;

/*Question 10*/

/* Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables */

SELECT  p.passenger_name as passengerName,p.distance,
p.distance * 100/(SELECT SUM(pa.distance) FROM passenger pa) as 'Percentage of Distance Travelled'
From passenger p;

/*Question 11*/

/*  Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/

delimiter &&
create procedure NamingPrice()
begin
select price.bus_type,price.distance,price.price,
case 
when price>=1000 then 'Expensive Cost'
when price<=1000 and price>=500 then 'Average Cost'
else
'Cheap'
End as verdict from price;
end &&
delimiter ;

call NamingPrice();
