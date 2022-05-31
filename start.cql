describe keyspaces;

create keyspace public with replication = { 'class' : 'SimpleStrategy', 'replication_factor' : 1};

describe keyspace public;

create table public.employee(userId bigint, page text, duration int, primary key (userId));

drop table public.employee;

describe table public.employee;

insert into public.employee (userId, page, duration) values (1231231, 'market', 123123);
insert into public.employee (userId, page, duration) values (1237777, 'bank', 128768687);

select * from public.employee;

alter table public.employee add header text;

select * from public.employee;

describe table public.employee;

create type public.address (city text, street text, num int, zip int);

-- indexes
select * from public.employee;

select * from public.employee where userId = 1231231;

select * from public.employee where page = 'market';

create index on public.employee (page);

select * from public.employee where page = 'market';

describe table public.employee;


CREATE KEYSPACE test WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}
                      AND durable_writes = true;

use test;

Create table users
(
    Email       text,
    name        text,
    age         int,
    date_joined date,
    primary key ((email))
    );

drop materialized view user_by_name_age;

create materialized view if not exists user_by_name_age as
select *
from users
where name is not null
  and age is not null
  and Email is not null
    primary key ((name), email);


drop table numbers;

Create table numbers
(
    Id text,
    t  text,
    s  set<int>,
    l  list<int>,
    m  map<text,int>,
    primary key ((id), t)
    );

Insert into numbers (id, t, s, l, m)
values ('x', 'a', {1,2,3}, [1,2,3], {'a':1,'b':2,'c':3});

Insert into numbers (id, t, s, l, m)
values ('x', 'b', {2,3,4}, [2,3,4], {'b':2,'c':3,'d':4});


CREATE TABLE Emp_record
(
    E_id    int PRIMARY KEY,
    E_score int,
    E_name  text,
    E_city  text
);

INSERT INTO Emp_record(E_id, E_score, E_name, E_city)
values (101, 85, 'ashish', 'Noida');
INSERT INTO Emp_record(E_id, E_score, E_name, E_city)
values (102, 90, 'ankur', 'Noida');
INSERT INTO Emp_record(E_id, E_score, E_name, E_city)
values (103, 99, 'shivang', 'Noida');
INSERT INTO Emp_record(E_id, E_score, E_name, E_city)
values (104, 85, 'abi', 'meerut');
INSERT INTO Emp_record(E_id, E_score, E_city)
values (105, 95, 'meerut');

select E_city, sum(E_score)
FROM Emp_record;



CREATE TYPE ADDRESS (street TEXT,city TEXT,state TEXT,postal_code TEXT);

CREATE TABLE users
(
    id      TEXT,
    address ADDRESS,
    primary key ((id))
    );

INSERT INTO users (id, address)
VALUES ('ABC12345', {street: '1100 congress ave',city:'Austin',postal_code:'78701'});

select *
from users
where id = 'ABC12345';

UPDATE users
SET address = address + {state: 'TX'}
where id = 'ABC12345'; // INCORRECT
UPDATE users
SET address.state = 'TX'
where id = 'ABC12345';


-- Consider the CQL statements:

CREATE TABLE folders_by_user
(
    username TEXT,
    label    TEXT,
    color    TEXT,
    PRIMARY KEY ((username), label)
    );

INSERT INTO folders_by_user (username, label, color)
values ('marry@gmail.com', 'inbox', 'green');

UPDATE folders_by_user
SET color = 'orange'
where username = 'marry@gmail.com'
  and label = 'inbox';
UPDATE folders_by_user
SET color ='purple';
UPDATE folders_by_user
SET color ='red'
where username = 'marry@gmail.com';
-- What value will color have after executing all the CQL statements ?


drop table popular_count;
CREATE TABLE popular_count
(
    id         UUID PRIMARY KEY,
    popularity text
);
UPDATE popular_count
SET popularity = 'Test'
WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
SELECT *
FROM popular_count;


-- Question 16: Correct
-- Consider below create and CLQ statements :

CREATE TABLE t
(
    k text,
    s text STATIC,
    i int,
    PRIMARY KEY (k, i)
);
INSERT INTO t (k, s, i)
VALUES ('k', 'I''m shared', 0);
INSERT INTO t (k, s, i)
VALUES ('k', 'I''m still shared', 1);
SELECT *
FROM t;


-- Question 17: Correct
Create table tem_by_sensor
(
    sensor    TEXT,
    date      DATE,
    timestamp TIMESTAMP,
    value     FLOAT,
    PRIMARY KEY ((Sensor, date), timestamp)
    ) with CLUSTERING ORDER BY (timestamp DESC);

SELECT *
FROM tem_by_sensor
where sensor = 's1003'
  and date = '2020-07-06'
  and value = 100;

-- which secondary index can be used to support the query?


-- Question 19: Incorrect
-- Consider create statement and CQL insert

CREATE TABLE User_data
(
    User_Id uuid,
    Name    text,
    City    text,
    Country text,
    Primary key (User_Id)
);

INSERT INTO User_data(User_Id, Name, City, Country)
values (04a5626c-c0d7-477c-521d-6c1b69a95d23, 'Ashish', 'california', 'USA');
Insert into User_data(User_Id, Name, City, Country)
values (55b8fd28-b1ed-4e46-bf79-3170687cba50, 'Rana', 'mumbai', 'India');
Insert into User_data(User_Id, Name, City, Country)
values (66b8fd28-b1ed-4e46-bf69-3170687cba20, 'Abi', 'Bangalore', 'India');

select * from User_data;

UPDATE User_data
SET City ='New Delhi'
WHERE User_Id IN ( 45b8fd28-b1ed-4e46-bf79-3170687cba40,
                   04a5626c-c0d7-477c-521d-6c1b69a95d23,
                   66b8fd28-b1ed-4e46-bf69-3170687cba20);

select *
from User_data
WHERE User_Id IN (
                      45b8fd28-b1ed-4e46-bf79-3170687cba40,
                      04a5626c-c0d7-477c-521d-6c1b69a95d23,
                      66b8fd28-b1ed-4e46-bf69-3170687cba20);

-- Assuming table is not empty , what would be the best choice of answer




-- Question 20: Incorrect
-- Consider the table definition and CQL query:

drop table folders_by_user;

CREATE TABLE folders_by_user (username TEXT, label TEXT, color TEXT, PRIMARY KEY ((username),label));
INSERT INTO folders_by_user (username, label, color ) VALUES ('Vadim','xxxx','red' );
INSERT INTO folders_by_user (username, label, color ) VALUES ('Vadim','xxxx1','red' );
INSERT INTO folders_by_user (username, label, color ) VALUES ('Vadim','xxxx2','green' );
select * from folders_by_user;
SELECT label, color FROM folders_by_user WHERE username ='Vadim' and label ='xxxx2';
-- Assuming that the table is populated and the query result is not empty, What is expected query result ?



-- Question 22: Incorrect
-- Consider the CQL statements:

DROP TABLE users;

CREATE TABLE users (id UUID, name TEXT, PRIMARY KEY ((id)));

select * from users;

INSERT INTO users (id, name) values (uuid(),'Joe');
INSERT INTO users (id, name) values (uuid(),'Joe');
INSERT INTO users (id, name) values (now(),'Joe');
INSERT INTO users (id, name) values (totimestamp(now()),'Joe');
-- How many rows will the table have after executing all the CQL statements ?



-- Question 26: Incorrect
-- Consider the CQL statements:
Create table product_rating_stats (id text, num_ratings counter, sum_ratings counter, Primary Key ((id)));
Insert into product_rating_stats (id, num_ratings, sum_ratings) values ( 'ABC12345',10,100);

select * from product_rating_stats;

update product_rating_stats
set num_ratings = num_ratings + 1,
    sum_ratings = sum_ratings + 7
where id ='ABC12345';

update product_rating_stats
set num_ratings -= 1,
    sum_ratings -= 7
where id ='ABC12345';

-- Note that one of the CLQ statements should generate an error message
-- what values will counters num_ratings and sum_ratings have after executing all the CQL statements?





-- Question 30: Incorrect
CREATE KEYSPACE orders WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}
                      AND durable_writes = true;


USE orders;

drop table orders_by_user;

Create table orders_by_user (
                                username TEXT, order_id TEXT, status TEXT, PRIMARY KEY ((username), order_id));

select * from orders_by_user;

INSERT INTO orders_by_user (username, order_id, status)
values ('Joe', 'ABC1234','received');

UPDATE orders_by_user SET status ='processing'
WHERE username ='Joe' and order_id = 'ABC1234' IF status = 'received';

UPDATE orders_by_user SET status ='canceled'
WHERE username ='joe' and order_id = 'ABC1234' IF status ='received';

DELETE FROM orders_by_user
WHERE username ='joe'
  and order_id = ABC1234
    IF status =' canceled';

-- What is the order status value after executing all the CQL statements?


