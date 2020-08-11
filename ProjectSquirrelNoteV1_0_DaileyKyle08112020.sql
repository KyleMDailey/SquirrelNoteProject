/**********************************************************************************************************************************************************************************************************************
Author:  Kyle Dailey

Date:  08/11/2020 (Version 1.0)

Description:  This code creates a new set of project tables.  The overall project is a secure note taking application.  The tables created below will outline the three key components of the database:  the user data,
the note data, and a set of protect data containing the user's encryption information.

***********************************************************************************************************************************************************************************************************************
Revised: N/A

Revised by:  N/A

Revision:  N/A

**********************************************************************************************************************************************************************************************************************/

USE ProjectSquirrelNote;
--This is the initial using statement which calls the newly created ProjectSquirrelNote database.  This database was created specifically for this project from scratch.


--This code creates the main table for the project.  It is the user database which contains the user's information, password, and pin code.
CREATE TABLE [UserData] 
(
  [UserID]		INT					NOT NULL,
  [UserName]	NVARCHAR(25)		NOT NULL,
  [Password]	NVARCHAR(30)		NOT NULL,
  [LoginPin]	INT					NOT NULL,
  [FirstName]	NVARCHAR(25) 		NOT NULL,
  [LastName]	NVARCHAR(25)		NOT NULL,
  [Email]		NVARCHAR(25)		NOT NULL,
  [Phone]		NVARCHAR(25)		NOT NULL,
  [City]		NVARCHAR(25)		NOT NULL,
  [Country]		NVARCHAR(25)		NOT NULL,
  CONSTRAINT PK_UserData
  PRIMARY KEY ([UserID])
);

--This code creates the user's protected data, their individual encryption pin code and their encryption key hash.  It is linked to the user via the UserID.
CREATE TABLE [ProtectedData] 
(
  [UserID]			INT				NOT NULL,
  [EncryptionPin]	INT				NOT NULL,
  [EncryptionKey]	NVARCHAR(64)	NOT NULL,
);

--This code creates the foreign key constraint linking the ProtectedData table to the UserData table using the UserID
ALTER TABLE dbo.ProtectedData
	ADD CONSTRAINT FK_ProtectedData_UserData
	FOREIGN KEY(UserID)
	REFERENCES dbo.UserData(UserID);


--This code creates the NoteData table.  This will keep a log of the notes and basic user login data.
CREATE TABLE [NoteData] 
(
  [UserID]				INT				NOT NULL,
  [NoteID]				INT				NOT NULL,
  [NoteText]			NVARCHAR(250)	NULL,
  [NoteDate]			DATETIME		NOT NULL,
  [LoggedIn]			DATETIME		NOT NULL,
  [LoggedInDuration]	DATETIME		NOT NULL,
  CONSTRAINT PK_NoteData
  PRIMARY KEY ([NoteID])
);

--This code creates the foreign key constraint linking the NoteData table to the UserData table using the UserID
ALTER TABLE dbo.NoteData
	ADD CONSTRAINT FK_NoteData_UserData
	FOREIGN KEY(UserID)
	REFERENCES dbo.UserData(UserID);

