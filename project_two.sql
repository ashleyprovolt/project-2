/************************************************************
  Project 2
  Date		   programmer        Note
  10/3/2019    Ashley Provolt	  created database and tables
*****************************************************************/

use master
go

if DB_ID('disk_inventoryap')  is not null
	drop database disk_inventoryap
go

create database disk_inventoryap
go

use disk_inventoryap;
go

--creating tables

create table borrower (
	borrower_ID int not null identity primary key,
	borrower_FName varchar(100) not null,
	borrower_LName varchar(100) not null
);

create table artist_type	(
	 artist_type_ID int not null primary key,
	 artist_description varchar(100) not null
);

create table artist (
	artist_ID int not null identity primary key,
	artist_type_ID int not null references artist_type(artist_type_ID),
	artist_FName varchar(100) not null,
	artist_LName varchar(100) null
);

create table genre (
	genre_ID int not null primary key,
	description varchar(255) not null
);

create table status (
	status_ID int not null primary key,
	description varchar(255) not null
);

create table CD (
	CD_ID int not null identity primary key,
	CD_Name varchar(100) not null,
	release_Date smalldatetime not null,
	genre_ID int not null references genre(genre_ID),
	status_ID int not null references status(status_ID)
);

create table CD_artist (
	artist_ID int not null identity references artist(artist_ID),
	CD_ID int not null references CD(CD_ID),
	primary key(artist_ID, CD_ID) 	
);

--drop table borrower_CD;

create table borrower_CD (
	borrower_ID int not null references borrower(borrower_ID),
	CD_ID       int not null references CD(CD_ID),
	borrower_date smalldatetime not null,
	returned_date smalldatetime null
	primary key(borrower_ID, CD_ID, borrower_date)
);



if SUSER_ID('disk_inventoryap') is null
create login diskap with password = 'MSPress#1',
	DEFAULT_DATABASE = disk_inventoryap;

if USER_ID('diskap') is null
create user diskap;

alter role db_datareader add member diskap;
go
