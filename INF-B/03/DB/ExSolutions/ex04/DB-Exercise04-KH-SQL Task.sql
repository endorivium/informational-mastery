/*
drop table Student_in_Event;
drop table Events;
drop table Lecturers;
drop table Students;
*/

create table Students(
	Name varchar(30),
	Matriculation decimal(4,0),
	Birthday date,
	primary key (Matriculation),
	constraint matrikel_not_negative check(Matriculation>=0)
);
create table Lecturers(
	Name varchar(30),
	Office varchar(30) not null,
	Tel varchar(30),
	primary key(Name)
);
create table Events(
	Name varchar (30),
	Semester char(4),
	Room varchar (8),
	Lecturer varchar (30),
	primary key (Name, Semester),
	foreign key (Lecturer) references Lecturers(Name) on update cascade on delete set null
);
create table Student_in_Event(
	id int identity(10,2) primary key,
	Student decimal(4,0),
	Event varchar(30),
	Semester char(4),
	Grade Decimal(2,1),
	foreign key (Student) references Students(Matriculation) on update cascade on delete cascade,
	foreign key (Event, Semester) references Events(Name,Semester) on update cascade on delete cascade,
	constraint constraint_grade check(Grade >= 1 and Grade<=5),
	unique (Student, Event, Semester)
);

insert into Lecturers (Name, Tel, Office) values ('Klaus', '123', 'C201');

insert into Events (Lecturer, Name, Room, Semester) values 
	('Klaus','Dance Gymnastics','D111','ss18'),
	('Klaus','Dance Gymnastics','D111','ws17'),
	('Klaus','Sackhüpfen',null,'ws17');

insert into Lecturers (Name, Office) values ('Maria', 'D120');

insert into Events (Lecturer, Name, Room, Semester) values 
	('Maria','Hang-gliding','Beach','ss17'),
	('Maria','Hang-gliding','Beach','ss18'),
	('Maria','Beachvolleyball','Beach','ss17'),
	('Maria','Beachvolleyball','Beach','ss18');

insert into Students (Name, Matriculation, Birthday) values 
	('Eva',3333,'2000-03-01'),
	('Luise',3334,'2001-12-31'),
	('Daniel',3335,'2002-07-01'),
	('Dominik',3336,'2000-08-01'),
	('Problemchild',3337,'2022-12-24');

insert into Student_in_Event (Student, Event, Semester, Grade) values 
	(3333,'Beachvolleyball','ss18',1.0),
	(3334,'Beachvolleyball','ss18',1.3),
	(3335,'Beachvolleyball','ss18',2.0),
	(3333,'Hang-gliding','ss17',4.0),
	(3336,'Hang-gliding','ss17',5.0),
	(3334,'Dance Gymnastics','ws17',null),
	(3335,'Dance Gymnastics','ss18',null),
	(3334,'Beachvolleyball','ss17',3.3),
	(3335,'Beachvolleyball','ss17',3.7);

-- Task 1a	

