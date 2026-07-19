-- Exercise 2

-- delete tables
drop table R, S;

-- Create tables
create table R(
	A int,
	Y int,
	Z int
);
create table S(
	Y int,
	Z int,
	B int
);

-- Insert data
insert into R (A,Y,Z) values
(1,1,2),
(2,1,1),
(3,1,1),
(9,3,4),
(7,2,2);

insert into S (Y,Z,B) values 
(1,2,6),
(1,2,7),
(1,1,8),
(7,8,9),
(2,1,5),
(3,9,4),
(2,4,2),
(9,4,1);


-- Queries
--a)
select Z, Y from S where Y=1
intersect
select Z, Y from S where Y=1;

--b)
select * from
(select A from R where A < 3) a, 
(select B from S where B > 7) b;

--solution b)
select distinct R.A, S.B from R,S where R.A<3 and S.B>7
--distinct: removes duplicates

--c)
select Y, Z from R
except
select Y, Z from S;

--d)
select distinct R.Y, R.Z
from R
where exists (select S.Y, S.Z 
from S where S.Y = R.Y and S.Z = R.Z);
--solution d)
select Y,Z from R
intersect
select Y,Z from S

--e)
select Y, Z from R where Y = 1 or Z = 2
union
select Y, Z from S where Y = 1 or Z = 2;


-- R x S
select * from R, S;

