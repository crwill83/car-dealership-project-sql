-- adding customers
insert into "Customer"(
	first_name,
	last_name,
	age,
	address,
	email
)
values
(
	'Gramps',
	'The Champs',
	92,
	'123 Sesame Street',
	'gramps@champs.com'
),
(
	'Jeremy',
	'Oppenheimer',
	32,
	'123 Pop Street',
	'jeremypop@email.com'
),
(
	'Mark',
	'Casey',
	42,
	'345 Next Street',
	'mcasey@email.com'
),
(
	'Cynthia',
	'Greene',
	38,
	'5265 Poplar Street',
	'cythia@email.com'
),
(
	'Julie',
	'Woodland',
	57,
	'267 Pismo Street',
	'jwqueen@email.com'
);

-- adding cars
insert into car (
	car_make,
	car_model,
	car_year,
	license_plate
)
values
(
	'ford',
	'tempo',
	1983,
	'LA1234'
),
(
	'vw',
	'passat',
	2014,
	'LA2345'
),
(
	'dodge',
	'viper',
	2013,
	'LA3456'
),
(
	'nissan',
	'sentra',
	2018,
	'LA4567'
),
(
	'toyota',
	'tacoma',
	2005,
	'LA5678'
);


-- adding salesperson
insert into salesperson (
	first_name,
	last_name
)
values
(
	'flash',
	'gordon'
),
(
	'jim',
	'bowie'
),
(
	'jared',
	'kushner'
),
(
	'ron',
	'perlman'
),
(
	'neo',
	'matrix'
)
 

-- adding mechanics
insert into mechanic (
	first_name,
	last_name
)
values
(
	'maria',
	'shriver'
),
(
	'katie',
	'couric'
),
(
	'barbara',
	'walters'
);






-- creating some invoices
-- Gramps bought a dodge viper with Neo for MSRP
insert into invoice (
	customer_id , sales_id , car_id , invoice_amount , invoice_date  
)
values (
	1 , 8 , 3 , 99390 , now()
);

-- he also bought a tacoma
insert into invoice (
	customer_id , sales_id , car_id , invoice_amount , invoice_date  
)
values (
	1 , 7 , 5 , 23870 , now()
);

-- let's try and create a service ticket, then we can create the service_ticket_mechanic
-- Julie had 4 tires and an oil change
insert into service_ticket (
	customer_id , car_id , parts , service_amount , service_type 
)
values (
	5 , 4 , 'snow tires' , 440 , 'oil change' 
)
-- add 2 mechanics to service_ticket 
insert into service_ticket_mechanic(
	service_id , mechanic_id
)
values (1 , 1),(1 , 3);


-- create new service ticket for just a service
insert into service_ticket (
	customer_id , car_id , service_amount , service_type 
)
values (
	2 , 2 , 160 , 'transmission flush' 
)

insert into service_ticket_mechanic(
	service_id , mechanic_id
)
values (2 , 2);


-- create new service ticket for just parts
insert into service_ticket (
	customer_id , car_id , parts , service_amount
)
values (
	4 , 1 , 'wipers' , 35
)

insert into service_ticket_mechanic(
	service_id , mechanic_id
)
values (3 , 1);



--
select * from "Customer"; 
--
select * from salesperson;
--
select * from mechanic;
--
select * from car;
--
select * from invoice;
--
select * from service_ticket;
--
select * from service_ticket_mechanic;