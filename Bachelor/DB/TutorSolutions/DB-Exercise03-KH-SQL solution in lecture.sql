drop table Student_in_Event;
drop table events;
drop table lecturers;
drop table students;

create table students(
	name varchar (30),
	Matriculation int primary key check(Matriculation >0 and Matriculation <10000)
);
create table lecturers(
	name varchar (30) primary key,
	office varchar (30) not null,
	tel varchar (30) null,
);
create table events(
	name varchar (30),-- primary key,
	semester char(4),
	room char(8),
	lecturer varchar (30) null, -- foreign key refereces lecturers(name)
	foreign key (lecturer) references lecturers(name) on delete set null,
	primary key(name,semester)
);
create table Student_in_Event(
	student int references students(Matriculation) on update cascade on delete cascade,
	event varchar (30),
	semester char(4),
	grade decimal(2,1) check(grade >=1 and grade <=5),
	id int identity(10,2) primary key,
	foreign key (event, semester) references events(name,semester) on update cascade on delete cascade,
	unique(student,event,semester)

);

alter table students add Birthday date;



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

insert into Students (Name, Matriculation) values 
('Kai', 9999);

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

update students set Birthday='1990-03-01' where Matriculation=3333;

update students set Birthday='1000-01-01' where Birthday is null;
 
alter table Students alter column Birthday date not null;

select * from students