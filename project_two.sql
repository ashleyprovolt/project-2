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

create table artist (
	artist_ID int not null identity primary key,
	artist_FName varchar(100) not null,
	artist_LName varchar(100) null,
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
	genre_ID int not null references genre(genre_ID),
	status_ID int not null references status(status_ID)
);

create table CD_artist (
	artist_ID int not null identity references artist(artist_ID),
	CD_ID int not null references CD(CD_ID),
	primary key(artist_ID, CD_ID) 	
);

create table borrower_CD (
	borrower_ID int not null references borrower(borrower_ID),
	CD_ID       int not null references CD(CD_ID),
	borrower_date smalldatetime not null,
	returned_date smalldatetime null
	primary key(borrower_ID, CD_ID, borrower_date)
);
--create index PK_borrower_CD on borrower_CD(borrower_ID, CD_ID, borrower_date);

--create table diskhasBorrower (
--	borrower_ID int not null references borrower(borrower_ID),
--	disk_ID     int not null, --refernces disk(disk_id)
--	borrower_date smalldatetime not null,
--	returned_date smalldatetime null
--);

--create table diskHasArtist (
--	disk_id  int not null, --refernce disk(disk_id)
--	artist_ID int not null references artist(artist_ID)
--);
--create index PK_diskHasArtist on diskHasArtist(disk_id, artist_ID)




if SUSER_ID('disk_inventoryap') is null
create login diskap with password = 'MSPress#1',
	DEFAULT_DATABASE = disk_inventoryap;

if USER_ID('diskap') is null
create user diskap;

alter role db_datareader add member diskap;
go
