
insert into Lecturers(Name, Office, Tel) output inserted.Name values
('Klaus', 'C201', 123)

insert into Events(Name, Semester, Room, Lecturer) values
('Gymnastics', 'ws17', 'D111', inserted.Name), ('Gymnastics', 'ss18', 'D111', inserted.Name),
('Sack Race', 'ws18', null, inserted.Name)

insert into Lecturers(Name, Office, Tel) output inserted.Name values
('Maria', 'D120', null)

insert into Events(Name, Semester, Room, Lecturer) values
('Hang-Gliding', 'ss17', 'Beach', inserted.Name), ('Volleyball', 'ss17', 'Beach', inserted.Name),
('Hang-Gliding', 'ws18', 'Beach', inserted.Name), ('Volleyball', 'ws18', 'Beach', inserted.Name)

insert into Students(Name, Student_ID) values
('Eva', 3333), ('Luise', 3334), ('Daniel', 3335), ('Dominik', 3336)

insert into Students_in_Events(Student, Event, Semester) values
(3333, 'Volleyball', 'ss18'), (3334, 'Volleyball', 'ss18'), ('Daniel', 'Volleyball', 'ss18')

insert into Students_in_Events(Student, Event, Semester) values
(3333, 'Hang-Gliding', 'ws17'), (3336, 'Hang-Gliding', 'ss17')

insert into Students_in_Events(Student, Event, Semester) values
(3334, 'Gymnastics', 'ws17'), (3335, 'Gymnastics', 'ws17')

insert into Students_in_Events(Student, Event, Semester) values
(3334, 'Volleyball', 'ss17'), (3335, 'Volleyball', 'ss17')

update Lecturers set Office='D22' where Name='Maria'

update Student_in_Events set Grade=4.0