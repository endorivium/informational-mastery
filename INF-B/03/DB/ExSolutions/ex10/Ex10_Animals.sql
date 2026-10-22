--drop table animal_eats;

create table animal_eats(
	animal varchar(30),
	eats varchar (30)
);


insert into animal_eats (animal, eats) values
	('Ape','Banana'),
	('Ape','Apple'),
	('Ape','Frog'),
	('Frog','Fly'),
	('Fly','Apple'),
	('Fly','Sugarwater'),
	('Jackal','Ape'),
	('Wolf','Jackal'),
	--('Fly','Wolf'),
	('Wolf','Apple');


-- Insert the following line to generate a circle
insert into animal_eats (animal, eats) values
	('Fly','Wolf');

-- task 04
-- a
with food_chain as (
select ae.animal, ae.eats, cast(ae.animal +  ' eats ' + ae.eats as varchar(max)) as chain
from animal_eats as ae

union all

select fc.animal, ae2.eats, cast(chain + ' eats ' + ae2.eats as varchar(max))
from food_chain as fc, animal_eats as ae2
where fc.eats = ae2.animal
)

select * from food_chain;

-- b
with cycle_food_chain as (
select ae.animal, ae.eats, cast(ae.animal +  ' eats ' + ae.eats as varchar(max)) as chain
from animal_eats as ae

union all

select cfc.animal, ae2.eats, cast(chain + ' eats ' + ae2.eats as varchar(max))
from cycle_food_chain as cfc, animal_eats as ae2
where cfc.eats = ae2.animal and chain not like '%'+ae2.eats+'%'
)

select * from cycle_food_chain;

-- c
with indirect_food_chain as (
select ae.animal, ae.eats as eats, cast('' as varchar(max)) as indirectly_eats, cast(ae.animal +  ' eats ' + ae.eats as varchar(max)) as chain
from animal_eats as ae

union all

select ifc.animal, ae2.eats, cast(ae2.eats as varchar(max)) as indirectly_eats, cast(chain + ' eats ' + ae2.eats as varchar(max))
from indirect_food_chain as ifc, animal_eats as ae2
where ifc.eats = ae2.animal and chain not like '%'+ae2.eats+'%'
)

select * from indirect_food_chain