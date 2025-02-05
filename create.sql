-- SQL - structured query languange
-- database server: Microsoft SQL Server
-- infoman1: mysql or mariadb
-- Database -> schemas -> tables

-- to create schema
create schema forum;

-- to create TABLES
-- syntax: CREATE TABLE TableName (
        -- columnName1 datataype [default value] [constraint]
--)

-- create user table
create table [forum].[User](
    UserId int Identity(1,1)  primary key,
    UserName varchar(50) not null,
    Email varchar(64) not null,
    Password varchar(64) not null
);



CREATE TABLE Forum.[Profile](
    ProfileId int identity(1,1) primary key,
    FirstName varchar(50) not null,
    LastName varchar(50),
    Bio varchar(255),
    UserId int,
    -- fk
    CONSTRAINT FK_Profile_User foreign key (UserId) references forum.[User] (UserId)
        on update CASCADE on delete cascade
);

-- to drop a table
DROP TABLE Forum.[User];