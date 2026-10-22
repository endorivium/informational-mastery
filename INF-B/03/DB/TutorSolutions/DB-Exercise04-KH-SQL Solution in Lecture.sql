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

select * from lecturers where Office like 'D%'
select * from Student_in_Event where grade is null and semester = 'ss18'


select *, cast(datediff(day, Birthday, CURRENT_TIMESTAMP)/365.25 as int) as age
from students
where cast(datediff(day, Birthday, CURRENT_TIMESTAMP)/365.25 as int) between 20 and 40

select datediff(year, '2024-12-31', '2025-01-01')

select * from Student_in_Event as sinv, Events as e, students as s
where 
	sinv.event=e.name and sinv.semester=e.semester and
	s.Matriculation=sinv.student



select s.name, s.Matriculation, e.name, e.room from 
	Student_in_Event as sinv 
	join Events as e on(sinv.event=e.name and sinv.semester=e.semester)
	join students as s on (s.Matriculation=sinv.student)
where
	sinv.semester='ss18'


select s1.name, s2.name
from students as s1, students as s2
where s1.Birthday<s2.Birthday

select --*,
	s.name + ' participated in the lecture '
	+ sinv.event + ' during the '
	+ sinv.semester + ' and '
	+ case	
		when sinv.grade is null then 'has no grade so far'
		when sinv.grade > 4 then 'did not pass.'
		when sinv.grade <=4.0 then ' obtained the grade ' + cast(sinv.grade as varchar) + '. Congratulations!'
	end

from students as s join Student_in_Event as sinv on (sinv.student=s.Matriculation)
where sinv.semester in ('ws17','ss17','ss18')


select distinct Event from Student_in_Event

select * from Student_in_Event

select distinct sinv_outer.Event, cast (sinv_outer.Grade as varchar)
from Student_in_Event as sinv_outer
where 
	sinv_outer.Grade <= all (	select isnull(Grade, 9) 
								from Student_in_Event as sinv_inner
								where sinv_inner.Event=sinv_outer.Event)

union

(select Event, 'no grade so far'
from Student_in_Event

except

select Event, 'no grade so far'
from Student_in_Event
where Grade is not null)

select distinct sinv_outer.Event, cast (sinv_outer.Grade as varchar)
from Student_in_Event as sinv_outer
where 
	sinv_outer.Grade >= all (	select isnull(Grade, 0) 
								from Student_in_Event as sinv_inner
								where sinv_inner.Event=sinv_outer.Event)

union

(select Event, 'no grade so far'
from Student_in_Event

except

select Event, 'no grade so far'
from Student_in_Event
where Grade is not null)


select case when 4.0< null then 'it is smaller ' else 'larger' end
select * from Student_in_Event
select cast(isnull(cast(Grade as varchar), ' is a value that is null') as varchar) from Student_in_Event


select count(*)
from Student_in_Event
group by Student, Event, Semester