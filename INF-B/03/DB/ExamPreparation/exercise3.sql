create table students(
    Name varchar(30),
    MatriculationNr int check (MatriculationNr > 0 and MatriculationNr <= 9999),
    primary key (MatriculationNr)
);

create table lecturers(
Name varchar(30),
Office varchar(30) not null,
Tel varchar(30) null
primary key (Name)
);

create table events(
Name varchar(30),
Semester varchar(4),
Room varchar(8),
Lecturer varchar(30),
foreign key (Lecturer) references lecturers(Name) on delete set null on update cascade,
primary key(Name, Semester)
);

create table student_in_events(
Student int,
Event varchar(30),
Semester varchar(4),
Grade decimal(2, 1) check (Grade >= 1 and Grade <= 5) null,
ID int identity(10,2),
foreign key(Student) references students(MatriculationNr) on update cascade on delete cascade,
foreign key(Event, Semester) references events(Name, Semester) on update cascade on delete cascade,
primary key(ID),
unique(Student, Event, Semester)
);

insert into lecturers (Name, Office, Tel) values
('Klaus', 'C201', '123');

insert into events (Name, Semester, Room, Lecturer) values
('Dance Gymnastics', 'ws17', 'D111', 'Klaus'),
('Dance Gymnastics', 'ss18', 'D111', 'Klaus'),
('Sack Race', 'ws18', null, 'Klaus');

insert into lecturers (Name, Office) values
('Maria', 'D120');

insert into events (Name, Semester, Room, Lecturer) values
('Hang Gliding', 'ss17', 'Beach', 'Maria'),
('Hang Gliding', 'ss18', 'Beach', 'Maria'),
('Volleyball', 'ss17', 'Beach', 'Maria'),
('Volleyball', 'ss18', 'Beach', 'Maria');

insert into students (Name, MatriculationNr) values
('Eva', 3333),
('Luise', 3334),
('Daniel', 3335),
('Dominik', 3336);

insert into student_in_events (Student, Event, Semester) values
(3333, 'Volleyball', 'ss18'),
(3334, 'Volleyball', 'ss18'),
(3335, 'Volleyball', 'ss18');

insert into student_in_events (Student, Event, Semester) values
(3336, 'Hang Gliding', 'ss17'),
(3333, 'Hang Gliding', 'ss17');

update student_in_events set Grade=4.0 where Event = 'Volleyball' and (Grade < 4 or Grade is null);

update lecturers set Office='D22' where Name='Maria'

alter table students add Birthday date;
update students set Birthday = '19000101' where Birthday is null;
alter table students alter column Birthday date not null;

update students set Birthday='19900301' where Name='Eva';
update students set Birthday='19900401' where Name='Luise';
update students set Birthday='19900501' where Name='Daniel';
update students set Birthday='19900601' where Name='Dominik';

select * from students;
select * from lecturers;
select * from events;
select * from student_in_events;