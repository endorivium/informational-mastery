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
select
	name
from
	Lecturers
where
	Office like 'D%';

-- Task 1b
select distinct 
	Student 
from 
	Student_in_Event where Semester='ss18' and Grade is null ;

-- Task 1c
-- Unfortunately, that looks easy, but datediff just subtracts the year part of a date. Look at Luise!  
-- Example: select datediff(year,'2000-12-31','2001-01-01') is 1, but that is wrong when calculating an age.
-- In MySQL for example is select timestampdiff(year,'2019-01-28','2020-01-02') = 0, which is better
select
	Name as n , 
	datediff (year , Birthday ,CURRENT_TIMESTAMP) as 'Alter'
from
	Students
where
	datediff (year , Birthday ,CURRENT_TIMESTAMP) between 20 and 40;

-- We could go for the following solution, that matches most application cases
-- But since the sun year is shorter and every now and then we skip a leap year,
-- depending on the calendar used, this also results in problmes regarding 
-- the exact calculation of ages of very old items.  
select
	Name as n , 
	cast (datediff (day , Birthday ,CURRENT_TIMESTAMP)/365.25 as int) as 'Alter'
from
	Students
where
	datediff (day , Birthday ,CURRENT_TIMESTAMP)/365.25 between 20 and 40;


-- A more stable solution that also works for decades and relying on th einternal calendar would be:
select
	Name as n , 
	CASE 
		WHEN	(MONTH(Birthday) > MONTH(GETDATE())) OR 
				(MONTH(Birthday) = MONTH(GETDATE()) AND DAY(Birthday) > DAY(GETDATE())) 
		THEN	datediff (year , Birthday ,CURRENT_TIMESTAMP)-1 
		ELSE	datediff (year , Birthday ,CURRENT_TIMESTAMP)
	END as 'Age'
from
	Students
where
	CASE 
		WHEN	(MONTH(Birthday) > MONTH(GETDATE())) OR 
				(MONTH(Birthday) = MONTH(GETDATE()) AND DAY(Birthday) > DAY(GETDATE())) 
		THEN	datediff (year , Birthday ,CURRENT_TIMESTAMP)-1 
		ELSE	datediff (year , Birthday ,CURRENT_TIMESTAMP)
	END between 20 and 30;	


-- Task 2a
select
	S.Name as 'Student', 
	E.Name as 'Event', 
	E.Semester
from
	Students as S 
	inner join Student_in_Event as SinE on S.Matriculation = SinE.Student
	inner join Events as E on SinE.Event=E.Name and SinE.Semester=E.Semester
where
	E.Semester = 'ss18';

-- Task 2b
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

-- Task 2c
select
	concat(
		S.Name, 
		' participated in the lecture ',
		SinE.Event,
		' during the ',
		case 
			when SinE.Semester='ss17' then 'summer semester 2017' 
			when SinE.Semester='ws17' then 'winter semester 2017' 
			when SinE.Semester='ss18' then 'summer semester 2018' 
		end,
		' and ',
		case 
			when SinE.Grade is null then 'obtained no grade so far.' 
			when SinE.Grade<=4 then concat ( 'obtained the grade ' , SinE.Grade , ' Congratulations!') 
			when SinE.Grade>4 then ' did not pass.' 
		end) as 'Text'
from
	Students as S 
	inner join Student_in_Event as SinE on S.Matriculation=SinE. Student
where
	SinE.Semester in ( 'ws17' , 'ss17' , 'ss18' );

-- Task 3a
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
							);

-- Task 3b
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
	
-- Task 3c We will se this in "Advanced SQL" but basically
-- we are counting how many double entries we have for each combination.
select		count(*) as anz, 
			Student, Event, 
			Semester 
from		Student_in_Event 
group by	Student,Event, Semester 
having		count(*)>1;

drop table Student_in_Event;
drop table Events;
drop table Lecturers;
drop table Students;
