
create table students(
name varchar (30),
--prev: matrnr int primary key CHECK(matrnr > 999 AND matrnr <=9999)
matrnr decimal(4,0) primary key check (matrnr >= 0)
);

create table lecturers(
name varchar (30) primary key,
office varchar (30) not null,
tel varchar (30) null
)

create table events(
name varchar (30),
semester varchar (4),
room varchar (8),
lecturer varchar (30),
primary key (name, semester),
foreign key (lecturer) references lecturers(name) on delete set null on update cascade,
)

create table students_in_event(
id int identity (10,2) primary key,
student decimal(4,0),
event varchar(30), 
semester varchar(4),
grade DECIMAL(2, 1) CHECK(grade BETWEEN 1 AND 5),
foreign key (student) references students(matrnr) on delete set null on update cascade,
foreign key (event, semester) references events(name, semester) on update cascade on delete cascade, --foreign key is (event, semester) not just event
--alt: constraint constraint_grade check(grade between 1 and 5),
unique (student, event, semester) --only one student per event per semester
)


--select * from students, lecturers, events, students_in_events;

drop table students_in_event, events, lecturers, students;
