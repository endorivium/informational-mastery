drop table Student_in_Event, Students;

create table Students(
Name char (30),
Student_ID int CHECK(Student_ID > 999 AND Student_ID <=9999) primary key
);

drop table Students;