create sequence auto_increment
start with 1
increment by 1
maxvalue 10000
minvalue 1
nocycle;

create table shop(
ITEM_ID number primary key,
PRICE number not null);

create table payment_info(
payment_info_id number primary key,
price number);

create table purchase_order(
purchase_order_id number primary key,
item_id number,
payment_info_id number,
address varchar2(255));

insert into shop values(auto_increment.nextval,15000);

commit;