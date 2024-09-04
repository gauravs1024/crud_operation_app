create database crud_operation;
create table users_crud_operation (name varchar(40),email varchar(40), password varchar(40),id int(20) primary key auto_increment) auto_increment=101;
insert into  users_crud_operation(name,email,password) values('harsh','HASO@GMAIL.COM','123');
SELECT * FROM users_crud_operation u;
drop table users_crud_operation;
create table users_crud_operation (name varchar(40),email varchar(40), password varchar(40),id int(20) primary key auto_increment) auto_increment=101;

