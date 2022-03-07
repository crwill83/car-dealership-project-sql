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


-- let's create a stored procedure for a 5% discount
CREATE OR REPLACE PROCEDURE holiday_discount_invoice(
	customer INTEGER,
	discount DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Update invoice amount for 5% discount
	UPDATE invoice
	SET invoice_amount = invoice_amount * discount 
	WHERE customer_id = customer;
	
	-- Commit the above statement inside of a transaction
	COMMIT;
	
END;
$$

-- now we'll call that procedure
CALL holiday_discount_invoice(1 , 0.95); 

-- now we'll add a procedure that gives a free oil change with purchase of 4 snow tires and apply it to Julie
CREATE OR REPLACE PROCEDURE free_oil_with_tires(
	customer INTEGER,
	discount DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Update service_ticket to apply $40 discount
	UPDATE service_ticket 
	SET service_amount = service_amount - discount
	WHERE parts = 'snow tires';
	
	-- Commit the above statement inside of a transaction
	COMMIT;
	
END;
$$

-- and we'll call this one too
CALL free_oil_with_tires (5 , 40)


-- stored function to add a customer
CREATE OR REPLACE FUNCTION add_customer(_c_id INTEGER, _f_name VARCHAR, _l_name VARCHAR, _age_ INTEGER , _address_ VARCHAR , _email VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO "Customer"(customer_id,first_name,last_name,age,address,email)
	VALUES(_c_id , _f_name, _l_name, _age_, _address_, _email);
END;
$MAIN$
LANGUAGE plpgsql;

-- now we'll add a customer
SELECT add_customer(6,'Jack','Sparrow',47,'143 Black Pearl','captain@blackpearl.com')


-- one more stored function to add a car since stock is getting low
CREATE OR REPLACE FUNCTION add_car(_c_id INTEGER, _make VARCHAR, _model VARCHAR, _c_year INTEGER , _license VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO car(car_id,car_make,car_model,car_year,license_plate)
	VALUES(_c_id , _make, _model, _c_year, _license);
END;
$MAIN$
LANGUAGE plpgsql;

-- now we call the function and add a car
SELECT add_car(6,'ford','F650',2018,'LA6789')


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