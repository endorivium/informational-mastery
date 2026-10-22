--use Vorlesung_DB;
/*Übung 2*/

use examples;

create table Students(
	Name varchar(30),
	Matriculation decimal(4,0),
	primary key (Matriculation),
	constraint matrikel_nicht_negativ check(Matriculation>=0)
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

-- Additional Task
alter table Students add Birthday date;
update Students set Birthday='19000101' where Birthday is null;
alter table Students alter column Birthday date not null;

-- Alternative
alter table Students add constraint my_birthday_constraint default '1990-01-01' for Birthday

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
	('Eva',3333,'1990-03-01'),
	('Luise',3334,'1990-06-02'),
	('Daniel',3335,'1990-07-01'),
	('Dominik',3336,'1990-08-01');

insert into Student_in_Event (Student, Event, Semester) values 
	(3333,'Beachvolleyball','ss18'),
	(3334,'Beachvolleyball','ss18'),
	(3335,'Beachvolleyball','ss18'),
	(3333,'Hang-gliding','ss17'),
	(3336,'Hang-gliding','ss17'),
	(3334,'Dance Gymnastics','ws17'),
	(3335,'Dance Gymnastics','ws17'),
	(3334,'Beachvolleyball','ss17'),
	(3335,'Beachvolleyball','ss17');

update Student_in_Event set Grade=4.0 where Event='Beachvolleyball' and (Grade<4.0 or Grade is null);
update Lecturers set Office='D22' where Name='Maria';

delete from Student_in_Event where Student='3333'

-- Maria aus den Dozenten löschen
delete from Student_in_Event where Event in (Select name from Events where Lecturer='Maria')
delete from Events where Lecturer = 'Maria'
delete from Lecturers where name='Maria';

drop table Student_in_Event;
drop table Events;
drop table Students;
drop table Lecturers;
