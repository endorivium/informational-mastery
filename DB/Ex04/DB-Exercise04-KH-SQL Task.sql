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
select l.Name
from Lecturers as l
where l.Office like 'D%'


-- 1b
select sie.Student 
from Student_in_Event as sie
where sie.Semester='ss18' and sie.Grade is null

-- 1c
select Name as 'Student', datediff(year, Birthday, current_timestamp) as 'Age'
from Students
where datediff(year, Birthday, current_timestamp) between 20 and 40

-- 2a
select distinct s.Name, e.Name as 'Event', e.Room as 'Location'
from Students as s, Student_in_Event as sie, Events as e
where s.Matriculation=sie.Student and sie.Event=e.Name and sie.Semester='ss18'

-- 2b
select Name as 'Student', datediff(year, Birthday, current_timestamp) as 'Age'
from Students

select concat(s1.Name, ' is older than ', s2.Name) as 'Age Relation'
from Students as s1, Students as s2
where datediff(year, s1.Birthday, current_timestamp) > datediff(year, s2.Birthday, current_timestamp)
order by datediff(year, s1.Birthday, current_timestamp) desc, s1.Name

-- 2c
-- note: in a case all values must be the same data type, see grade comparison below
select concat( s.Name, 
' participated in the lecture ',
sie.Event, 
' during the ', 
	case
		when sie.semester='ws18'
			then 'winter semester 2018 '
		when sie.semester='ss17'
			then 'summer semester 2017 '
		when sie.semester='ss18'
			then 'summer semester 2018 '
	end,
'and ',
	case
		when sie.Grade like '5.0'
			then 'did not pass.'
		when sie.Grade is null
			then 'has no grade so far.'
		else concat('has obtained the grade ',sie.Grade,'. Congratulations!')
	end)
from Students as s, Student_in_Event as sie
where s.Matriculation = sie.Student

-- 3a
select e.Lecturer, e.Name, min(sie.Grade) as 'Best Grade'
from Events as e, Student_in_Event as sie
where e.Name = sie.Event and sie.Grade is not null
group by e.Lecturer, e.Name

-- 3b
select e.Lecturer, e.Name, min(sie.Grade) as 'Best Grade', max(sie.Grade) as 'Worst Grade'
from Events as e, Student_in_Event as sie
where e.Name = sie.Event and sie.Grade is not null
group by e.Lecturer, e.Name
