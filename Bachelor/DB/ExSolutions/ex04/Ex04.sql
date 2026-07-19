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
select SinE.Student 
from Student_in_Event as SinE
where SinE.Semester='ss18' and SinE.Grade is null

-- 1c
select Name as 'Student', datediff(year, Birthday, current_timestamp) as 'Age'
from Students
where datediff(year, Birthday, current_timestamp) between 20 and 40

-- solution (leap year)
select	Name as n,
	cast (datediff (day , Birthday ,CURRENT_TIMESTAMP)/365.25 as int) as 'Alter'
from Students
where datediff (day , Birthday ,CURRENT_TIMESTAMP)/365.25 between 20 and 40;


-- 2a
select distinct s.Name, e.Name as 'Event', e.Room as 'Location'
from Students as s, Student_in_Event as SinE, Events as e
where s.Matriculation=SinE.Student and SinE.Event=e.Name and SinE.Semester='ss18'

-- note: different possible solution to join two tables, does the same
select s.Name, s.Matriculation, e.Name, e.Room from 
	Student_in_Event as SinE 
	join Events as e on (SinE.Event = e.Name and SinE.Semester=e.Semester)
	join Students as s on (s.Matriculation=SinE.Student)
where SinE.Semester='ss18'


-- 2b
select concat(s1.Name, ' is older than ', s2.Name) as 'Age Relation'
from Students as s1, Students as s2
where datediff(year, s1.Birthday, current_timestamp) > datediff(year, s2.Birthday, current_timestamp)
order by datediff(year, s1.Birthday, current_timestamp) desc, s1.Name

 -- solution (note: should be in two columns), can apparently compare dates, so datediff is unnecessary
 select
	A.Name as Student , 
	B.Name as '.. is older than'
from
	Students as A, 
	Students as B
where
	A.Birthday<B. Birthday 
order by 
	A. Birthday asc


-- 2c
-- note: if using else, then all data types within the case clause must be the same data type
select concat( s.Name, 
' participated in the lecture ',
SinE.Event, 
' during the ', 
	case
		when SinE.semester='ws17'
			then 'winter semester 2017 '
		when SinE.semester='ss17'
			then 'summer semester 2017 '
		when SinE.semester='ss18'
			then 'summer semester 2018 '
	end,
'and ',
	case
		when SinE.Grade is null
			then 'has no grade so far.'
		when SinE.Grade>4
			then 'did not pass.'
		when SinE.Grade<=4
			then concat('has obtained the grade ',SinE.Grade,'. Congratulations!')
	end)
from Students as s, Student_in_Event as SinE
where s.Matriculation = SinE.Student and SinE.Semester in ('ws17', 'ss17', 'ss18')

-- also possible to solve without concat:
select *, s.Name +
' participated in the lecture ' +
SinE.Event +
' during the ' + 
	case
		when SinE.semester='ws17'
			then 'winter semester 2017 '
		when SinE.semester='ss17'
			then 'summer semester 2017 '
		when SinE.semester='ss18'
			then 'summer semester 2018 '
	end +
'and ' +
	case
		when SinE.Grade is null
			then 'has no grade so far.'
		when SinE.Grade>4
			then 'did not pass.'
		when SinE.Grade<=4
			then 'has obtained the grade ' + cast(SinE.Grade as varchar) +'. Congratulations!'
	end
from Students as s, Student_in_Event as SinE
where s.Matriculation = SinE.Student and SinE.Semester in ('ws17', 'ss17', 'ss18')

-- 3a, note: prof solution does not represent most efficient solution and instead makes use of all
select e.Lecturer, e.Name, min(SinE.Grade) as 'Best Grade'
from Events as e, Student_in_Event as SinE
where e.Name = SinE.Event
group by e.Lecturer, e.Name

-- alt: assign null
select e.Lecturer, e.Name, isnull(cast(min(SinE.Grade) as varchar), 'none') as 'Best Grade'
from Events as e, Student_in_Event as SinE
where e.Name = SinE.Event
group by e.Lecturer, e.Name

-- solution (not using min())
select distinct 
	L.Name, 
	E.Name, 
	concat ( 'Best Grade : ' , isnull(cast(SinE.Grade as varchar),'none')) 
from 
	Lecturers as L 
	inner join Events as E on E.Lecturer=L.Name -- does the same as a conditional where
	inner join Student_in_Event as SinE on SinE.Event = E.Name and SinE.Semester=E.Semester
where -- all: performs a comparison between a single column and a range of other values (as determined by the clause following it)
	SinE.Grade <= all ( 
							select Grade 
							from Student_in_Event as SinE2 
								inner join Events as E2 on SinE2.Event=E2.Name and SinE2. Semester=E2.Semester 
								inner join Lecturers as L2 on E2.Lecturer=L2.Name 
							where Grade is not null and E2.Name=E.Name and L2.Name=L.Name
							);
-- in the above, each grade is compared to all other grades via select (meaning the select needs to be copied)


-- 3b
select 
	e.Lecturer, 
	e.Name, 
	isnull(cast(min(SinE.Grade) as varchar), 'none') as 'Best Grade', 
	isnull(cast(max(SinE.Grade) as varchar), 'none') as 'Worst Grade'
from Events as e, Student_in_Event as SinE
where e.Name = SinE.Event
group by e.Lecturer, e.Name


-- solution: same as previous but done twice to find the worst grades as well
select distinct 
	L.Name, 
	E.Name, 
	concat ( 'Best Grade : ' , isnull(cast(SinE.Grade as varchar),'none')) 
from 
	Lecturers as L 
	inner join Events as E on E.Lecturer=L.Name 
	inner join Student_in_Event as SinE on SinE.Event = E.Name and SinE.Semester=E.Semester 
where  
	SinE.Grade <= all ( 
							select Grade 
							from Student_in_Event as SinE2 
								inner join Events as E2 on SinE2.Event=E2.Name and SinE2. Semester=E2.Semester 
								inner join Lecturers as L2 on E2.Lecturer=L2.Name 
							where Grade is not null and E2.Name=E.Name and L2.Name=L.Name
							)
union
select distinct 
	L.Name, 
	E.Name, 
	concat ( 'Worst Grade : ' , isnull(cast(SinE.Grade as varchar),'none')) 
from 
	Lecturers as L 
	inner join Events as E on E.Lecturer=L.Name 
	inner join Student_in_Event as SinE on SinE.Event = E.Name and SinE.Semester=E.Semester 
where  
	SinE.Grade >= all ( 
							select Grade 
							from Student_in_Event as SinE2 
								inner join Events as E2 on SinE2.Event=E2.Name and SinE2. Semester=E2.Semester 
								inner join Lecturers as L2 on E2.Lecturer=L2.Name 
							where Grade is not null and E2.Name=E.Name and L2.Name=L.Name
							);

-- 3c solution
select		count(*) as anz, 
			Student, Event, 
			Semester 
from		Student_in_Event 
group by	Student,Event, Semester 
having		count(*)>1;
