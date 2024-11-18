use master
go

drop database if exists Immunization;
go

if not exists ( select * from sys.databases where name=N'Immunization')
begin
CREATE DATABASE [Immunization]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Immunization', FILENAME = N'E:\Data\Immunization.mdf' , SIZE = 3510272KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Immunization_log', FILENAME = N'F:\Logs\Immunization_log.ldf' , SIZE = 177088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END
GO


USE [master]
GO
ALTER DATABASE [Immunization] SET  READ_WRITE 
GO




