CREATE TABLE "service_ticket_mechanic" (
  "service_mechanic_id" SERIAL,
  "service_id" INTEGER,
  "mechanic_id" INTEGER,
  PRIMARY KEY ("service_mechanic_id")
);
--
CREATE TABLE "salesperson" (
  "sales_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  PRIMARY KEY ("sales_id")
);
--
CREATE TABLE "Customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "age" INTEGER,
  "address" VARCHAR(150),
  "email" VARCHAR(50),
  PRIMARY KEY ("customer_id")
);
--
update TABLE "invoice" (
  "invoice_id" SERIAL,
  "customer_id" INTEGER,
  "sales_id" INTEGER,
  "car_id" INTEGER,
  "invoice_amount" NUMERIC(8,2),
  "invoice_date" DATE,
  PRIMARY KEY ("invoice_id"),
	FOREIGN KEY (customer_id)
	  REFERENCES "Customer"(customer_id),
	FOREIGN KEY (sales_id)
	  REFERENCES salesperson(sales_id),
	  FOREIGN KEY (car_id)
	  REFERENCES car(car_id)
);
--
CREATE TABLE "car" (
  "car_id" SERIAL,
  "car_make" VARCHAR(50),
  "car_model" VARCHAR(50),
  "car_year" INTEGER,
  "license_plate" VARCHAR(6),
  PRIMARY KEY ("car_id")
);
--
CREATE TABLE "service_ticket" (
  "service_id" SERIAL,
  "customer_id" INTEGER,
  "car_id" INTEGER,
  "parts" VARCHAR(50),
  "service_amount" NUMERIC(6,2),
  "service_type" VARCHAR(50),
  PRIMARY KEY ("service_id"),
  CONSTRAINT "FK_service_ticket.car_id"
    FOREIGN KEY ("car_id")
      REFERENCES "car"("car_id"),
  CONSTRAINT "FK_service_ticket.service_id"
    FOREIGN KEY ("service_id")
      REFERENCES "service_ticket_mechanic"("service_mechanic_id")
);
--
CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  PRIMARY KEY ("mechanic_id")
);

-- didn't check code from Lucidchart so invoice keys were entered incorrectly and had to be altered
alter table invoice  
ADD foreign key (customer_id) references "Customer"(customer_id);
--
alter table invoice  
ADD foreign key (sales_id) references salesperson(sales_id);
--
alter table invoice  
ADD foreign key (car_id) references car(car_id);


-- also have to alter service_ticket_mechanic 
alter table service_ticket_mechanic 
ADD foreign key (service_id) references service_ticket(service_id);
--
alter table service_ticket_mechanic 
ADD foreign key (mechanic_id) references mechanic(mechanic_id);


-- and also the service ticket, had to delete current FKs and redo them, so much extra work when you don't check stuff
alter table service_ticket 
ADD foreign key (customer_id) references "Customer"(customer_id);
--
alter table service_ticket 
ADD foreign key (car_id) references car(car_id);



