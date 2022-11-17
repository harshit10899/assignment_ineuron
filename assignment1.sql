create database assignment1;
use assignment1;

/*task 1*/

create table shopping_history(
product varchar(50) not null,
quantity integer not null,
unit_price integer not null
);

insert into shopping_history values ('milk',3,10);
insert into shopping_history values ('bread',7,3);
insert into shopping_history values ('milk',5,2);



select * from shopping_history;


select product,(quantity*unit_price) as total_price
from shopping_history
group by product
order by product desc;

/*task 2*/
/*1*/

create table phones(
`name` varchar(20) not null unique,
phone_number integer not null unique
);


create table calls(
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique(id)
);

insert into phones values ('jack',1234);
insert into phones values ('lena',3333);
insert into phones values ('mark',9999);
insert into phones values ('anaa',7582);



select * from phones;
insert into calls values(25,1234,7582,8);
insert into calls values(7,9999,7582,1);
insert into calls values(18,9999,3333,4);
insert into calls values(2,7582,3333,3);
insert into calls values(3,3333,1234,1);
insert into calls values(21,3333,1234,1);

select * from calls;



CREATE VIEW caller_view AS
SELECT caller,sum(duration) as duration
FROM calls
group by caller;

CREATE VIEW callee_view AS
SELECT callee,sum(duration) as duration
FROM calls
group by callee;


create view caller_id as
select * from callee_view 
union
select * from caller_view;

create view call_duration as
select callee,sum(duration) as duration from caller_id 
group by callee
;



select phones.`name`
from phones
left join call_duration on phones.phone_number = call_duration.callee
where call_duration.duration > 9
order by phones.`name`;

/*2*/
create table phones1(
`name` varchar(20) not null unique,
phone_number integer not null unique
);

insert into phones1 values ('john',6356);
insert into phones1 values ('addison',4315);
insert into phones1 values ('kate',8003);
insert into phones1 values ('ginny',9831);

create table calls1(
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique(id)
);

insert into calls1 values(65,8003,9831,7);
insert into calls1 values(100,9831,8003,3);
insert into calls1 values(145,4315,9831,18);

CREATE VIEW caller_view1 AS
SELECT caller,sum(duration) as duration
FROM calls1
group by caller;


CREATE VIEW callee_view1 AS
SELECT callee,sum(duration) as duration
FROM calls1
group by callee;


create view caller_id1 as
select * from callee_view1 
union
select * from caller_view1;

create view call_duration1 as
select callee,sum(duration) as duration from caller_id1
group by callee
;

select phones1.`name`
from phones1
left join call_duration1 on phones1.phone_number = call_duration1.callee
where call_duration1.duration > 9
order by phones1.`name`;

/*TASK3*/

create table transactions(
amount integer not null,
transaction_date date 
);


select * from transactions;



insert into transactions values(1000,'2020-01-06');
insert into transactions values(-10,'2020-01-14');
insert into transactions values(-75,'2020-01-20');
insert into transactions values(-5,'2020-01-25');
insert into transactions values(-4,'2020-03-29');
insert into transactions values(2000,'2020-03-10');
insert into transactions values(-75,'2020-03-12');
insert into transactions values(-20,'2020-03-15');
insert into transactions values(40,'2020-03-15');
insert into transactions values(-50,'2020-03-17');
insert into transactions values(200,'2020-10-10');
insert into transactions values(-200,'2020-10-10');


 
 
Select ( sum(a.total) - (12 - count(b.cnt ))*5 ) as balance From  
(Select sum(amount) as total , 'A' as name from  transactions  ) as a  left join  
(Select  count(amount) as cnt , 'A' as name
From transactions 
where amount < 0 
group by month(transaction_date) 
having not(count(amount) <3 or  sum(amount) > -100) ) as b 
on a.name = b.name ;





