
DROP TABLE if exists File;

DROP TABLE if exists Comment;

DROP TABLE if exists IS_IN;

DROP TABLE if exists User_IN_Project;

DROP TABLE if exists Task_Report;

DROP TABLE if exists Report;

DROP TABLE if exists Doing;

DROP TABLE if exists Assign;

DROP TABLE if exists Task;

DROP TABLE if exists Task_Column;

DROP TABLE if exists Milestone;

DROP TABLE if exists Project;

DROP TABLE if exists Company;

DROP TABLE if exists Tag;

DROP TABLE if exists Person;

CREATE TABLE Person
(
	U_Email              VARCHAR(64) NOT NULL,
	Full_Name            VARCHAR(64) NULL,
	Password             CHAR(120) NULL,
	Work_Type            VARCHAR(16) NULL,
	CONSTRAINT XPKUser PRIMARY KEY (U_Email)
);

CREATE TABLE Tag
(
	Name                 VARCHAR(16) NULL,
	Color                CHAR(7) NULL,
	U_Email              VARCHAR(64) NOT NULL,
	Tag_ID               INTEGER NOT NULL AUTO_INCREMENT,
	CONSTRAINT XPKTag PRIMARY KEY (Tag_ID),
	CONSTRAINT CREATE_4 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Company
(
	Name                 VARCHAR(32) NULL,
	U_Email              VARCHAR(64) NOT NULL,
	Comp_ID              INTEGER NOT NULL AUTO_INCREMENT,
	CONSTRAINT XPKCompany PRIMARY KEY (Comp_ID),
	CONSTRAINT CREATE_2 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Project
(
	Name                 VARCHAR(32) NULL,
	Description          VARCHAR(256) NULL,
	U_Email              VARCHAR(64) NOT NULL,
	P_ID                 INTEGER NOT NULL AUTO_INCREMENT,
	Comp_ID              INTEGER NOT NULL,
	CONSTRAINT XPKProject PRIMARY KEY (P_ID),
	CONSTRAINT CREATE_1 FOREIGN KEY (U_Email) REFERENCES Person (U_Email),
	CONSTRAINT BELONGS_TO FOREIGN KEY (Comp_ID) REFERENCES Company (Comp_ID)
);

CREATE TABLE Milestone
(
	Name                 VARCHAR(32) NULL,
	Description          VARCHAR(256) NULL,
	Due_Date             DATE NULL,
	U_Email              VARCHAR(64) NOT NULL,
	M_ID                 INTEGER NOT NULL AUTO_INCREMENT,
	P_ID                 INTEGER NOT NULL,
	CONSTRAINT XPKMilestone PRIMARY KEY (M_ID),
	CONSTRAINT HAVE_5 FOREIGN KEY (P_ID) REFERENCES Project (P_ID),
	CONSTRAINT CREATE_3 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Task_Column
(
	Name                 VARCHAR(20) NULL,
	U_Email              VARCHAR(64) NOT NULL,
	P_ID                 INTEGER NOT NULL,
	Col_ID               VARCHAR(20) NOT NULL,
	CONSTRAINT XPKColumn PRIMARY KEY (Col_ID),
	CONSTRAINT HAVE FOREIGN KEY (P_ID) REFERENCES Project (P_ID),
	CONSTRAINT CREATE_6 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Task
(
	Name                 VARCHAR(32) NULL,
	Description          VARCHAR(256) NULL,
	Due_Date             DATE NULL,
	M_ID                 INTEGER NULL,
	Col_ID               VARCHAR(20) NOT NULL,
	Task_ID              INTEGER NOT NULL AUTO_INCREMENT,
	CONSTRAINT XPKTask PRIMARY KEY (Task_ID),
	CONSTRAINT HAVE_4 FOREIGN KEY (M_ID) REFERENCES Milestone (M_ID),
	CONSTRAINT CONTAIN FOREIGN KEY (Col_ID) REFERENCES Task_Column (Col_ID)
);

CREATE TABLE Assign
(
	U_Email              VARCHAR(64) NOT NULL,
	Tag_ID               INTEGER NOT NULL,
	Task_ID              INTEGER NOT NULL,
	CONSTRAINT XPKAssign PRIMARY KEY (Tag_ID,Task_ID),
	CONSTRAINT ASSIGNS FOREIGN KEY (U_Email) REFERENCES Person (U_Email),
	CONSTRAINT ASSIGNED_TO FOREIGN KEY (Tag_ID) REFERENCES Tag (Tag_ID),
	CONSTRAINT IS_ASSIGNED FOREIGN KEY (Task_ID) REFERENCES Task (Task_ID)
);

CREATE TABLE Doing
(
	U_Email              VARCHAR(64) NOT NULL,
	Task_ID              INTEGER NOT NULL,
	CONSTRAINT XPKDoing PRIMARY KEY (U_Email,Task_ID),
	CONSTRAINT R_34 FOREIGN KEY (Task_ID) REFERENCES Task (Task_ID),
	CONSTRAINT R_33 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Report
(
	Name                 VARCHAR(32) NULL,
	Submit_Date          DATE NULL,
	R_ID                 INTEGER NOT NULL AUTO_INCREMENT,
	CONSTRAINT XPKReport PRIMARY KEY (R_ID)
);

CREATE TABLE Task_Report
(
	R_ID                 INTEGER NOT NULL AUTO_INCREMENT,
	Task_ID              INTEGER NOT NULL,
	CONSTRAINT XPKTask_Report PRIMARY KEY (R_ID,Task_ID),
	CONSTRAINT IS_PART_2 FOREIGN KEY (R_ID) REFERENCES Report (R_ID),
	CONSTRAINT CONTAINS_2 FOREIGN KEY (Task_ID) REFERENCES Task (Task_ID)
);

CREATE TABLE User_IN_Project
(
	U_Email              VARCHAR(64) NOT NULL,
	P_ID                 INTEGER NOT NULL,
	User_Status          VARCHAR(10) NULL,
	Invite_Key           CHAR(8) NULL,
	Date                 DATE NULL,
	Favorite             boolean NULL,
	CONSTRAINT XPKUser_IN_Project PRIMARY KEY (U_Email,P_ID),
	CONSTRAINT CONTAINS_3 FOREIGN KEY (P_ID) REFERENCES Project (P_ID),
	CONSTRAINT IS_PART_3 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE IS_IN
(
	U_Email              VARCHAR(64) NOT NULL,
	Comp_ID              INTEGER NOT NULL,
	Invite_Key           CHAR(8) NULL,
	Date                 DATE NULL,
	User_Status          VARCHAR(10) NULL,
	CONSTRAINT XPKIS_IN PRIMARY KEY (U_Email,Comp_ID),
	CONSTRAINT CONSTAINS_4 FOREIGN KEY (Comp_ID) REFERENCES Company (Comp_ID),
	CONSTRAINT IS_PART_4 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE Comment
(
	Text                 VARCHAR(256) NULL,
	U_Email              VARCHAR(64) NOT NULL,
	Comm_ID              INTEGER NOT NULL AUTO_INCREMENT,
	Task_ID              INTEGER NOT NULL,
	CONSTRAINT XPKComment PRIMARY KEY (Comm_ID),
	CONSTRAINT IS_IN_3 FOREIGN KEY (Task_ID) REFERENCES Task (Task_ID),
	CONSTRAINT LEAVES_1 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);

CREATE TABLE File
(
	U_Email              VARCHAR(64) NOT NULL,
	URL                  VARCHAR(128) NOT NULL,
	Task_ID              INTEGER NOT NULL,
	CONSTRAINT XPKFile PRIMARY KEY (URL),
	CONSTRAINT BELONG_TO_3 FOREIGN KEY (Task_ID) REFERENCES Task (Task_ID),
	CONSTRAINT CREATE_5 FOREIGN KEY (U_Email) REFERENCES Person (U_Email)
);
