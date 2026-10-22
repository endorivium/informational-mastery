-- drop table bus

create table bus(
departure varchar(30),
destination varchar(30),
line varchar(10),
departure_time time,
arrival_time time,
day varchar(10)
)

insert into bus (departure, destination, line, departure_time, arrival_time, day) values
-- Line 10 1st run
('Stadtmitte',					'Max-Bram-Pl./FiWaG',			'10',	'08:00','08:04','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Innsbrucker Str./Freibad',		'10',	'08:04','08:07','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Giessenbachstr.',				'10',	'08:07','08:10','Mo-Fr'),
('Giessenbachstr.',				'Knigsseestr./Unterfhrung',	'10',	'08:10','08:12','Mo-Fr'),
('Knigsseestr./Unterfhrung',	'Freibad',						'10',	'08:12','08:15','Mo-Fr');

-- Line 1 1st run
insert into bus (departure, destination, line, departure_time, arrival_time, day) values
('Stadtmitte',					'Ignaz Gnther Gymnasium',		'1',	'08:00','08:05','Mo-Fr'),
('Ignaz Gnther Gymnasium',		'Hohenzollernstr.',				'1',	'08:05','08:07','Mo-Fr'),
('Hohenzollernstr.',			'Berufsschule',					'1',	'08:07','08:12','Mo-Fr'),
('Berufsschule',				'Marienbergerstr.',				'1',	'08:12','08:14','Mo-Fr'),
('Marienbergerstr.',			'TH',							'1',	'08:14','08:17','Mo-Fr'),
('TH',							'Kaserne',						'1',	'08:17','08:20','Mo-Fr'),
('Kaserne',						'Lessingstr.',					'1',	'08:20','08:22','Mo-Fr'),
('Lessingstr.',					'Hoppenbichlerstr.',			'1',	'08:22','08:25','Mo-Fr'),
('Hoppenbichlerstr.',			'Am Stocket',					'1',	'08:25','08:26','Mo-Fr'),
('Ignaz Gnther Gymnasium',			'Stadtmitte',					'1',	'08:25','08:26','Mo-Fr');




select b1.departure, b2.destination 
from bus as b1 join bus as b2 on (b1.destination=b2.departure) 
where b1.departure='Stadtmitte';

with one_hop(departure, destination) as (
	select b1.departure, b1.destination 
	from bus as b1 
	where b1.departure='Stadtmitte'
),

second_hop (departure,destination) as (
	select one_hop.departure, bus.destination
	from one_hop join bus on (one_hop.destination=bus.departure)
),

third_hop (departure,destination) as (
	select second_hop.departure, bus.destination
	from second_hop join bus on (second_hop.destination=bus.departure)
)

select * from third_hop;

with all_dest_from_stadtmitte (departure, destination, duration, number_of_hops, way) as (
	-- init of recursion
	select b1.departure, b1.destination, datediff(minute, departure_time, arrival_time), 1, cast(concat('###',b1.departure,'###', b1.destination) as varchar(1000))
	from bus as b1 
	where b1.departure='Stadtmitte'

	union all

	-- recursive step
	select all_dest_from_stadtmitte.departure, 
	bus.destination, 
	duration+datediff(minute, departure_time, arrival_time),
	number_of_hops +1,
	cast(concat(way,'###',bus.destination) as varchar(1000))
	from all_dest_from_stadtmitte join bus on (all_dest_from_stadtmitte.destination=bus.departure)
	where way not like '%###'+bus.destination+'###%'
)

select * from all_dest_from_stadtmitte;

-- Example for direct connections
select	departure, destination 
from	bus
where	departure='Stadtmitte';

-- Now with 'with'
with bus_from_stadtmitte (departure, destination) as (
	select	departure, destination 
	from	bus
	where	departure='Stadtmitte'
)
select * from bus_from_stadtmitte;

-- Now with two stops
with 
bus_from_stadtmitte_1 (departure, destination) as (
	select	departure, destination 
	from	bus
	where	departure='Stadtmitte'
),
bus_from_stadtmitte_2 (departure, destination) as (
	select	bus_from_stadtmitte_1.departure, bus.destination 
	from	bus_from_stadtmitte_1, bus
	where	bus_from_stadtmitte_1.destination=bus.departure
)

select * from bus_from_stadtmitte_1
union
select * from bus_from_stadtmitte_2;

-- Now with three stops
with 
bus_from_stadtmitte_1 (departure, destination) as (
	select	departure, destination 
	from	bus
	where	departure='Stadtmitte'
),
bus_from_stadtmitte_2 (departure, destination) as (
	select	bus_from_stadtmitte_1.departure, bus.destination 
	from	bus_from_stadtmitte_1, bus
	where	bus_from_stadtmitte_1.destination=bus.departure
),
bus_from_stadtmitte_3 (departure, destination) as (
	select	bus_from_stadtmitte_2.departure, bus.destination 
	from	bus_from_stadtmitte_2, bus
	where	bus_from_stadtmitte_2.destination=bus.departure
)

select * from bus_from_stadtmitte_1
union
select * from bus_from_stadtmitte_2
union
select * from bus_from_stadtmitte_3;


-- Now with three stops
with 
bus_from_stadtmitte_1 (departure, destination) as (
	select	departure, destination 
	from	bus
	where	departure='Stadtmitte'
),
bus_from_stadtmitte_2 (departure, destination) as (
	select	bus_from_stadtmitte_1.departure, bus.destination 
	from	bus_from_stadtmitte_1, bus
	where	bus_from_stadtmitte_1.destination=bus.departure
),
bus_from_stadtmitte_3 (departure, destination) as (
	select	bus_from_stadtmitte_2.departure, bus.destination 
	from	bus_from_stadtmitte_2, bus
	where	bus_from_stadtmitte_2.destination=bus.departure
),
bus_from_stadtmitte_4 (departure, destination) as (
	select	bus_from_stadtmitte_3.departure, bus.destination 
	from	bus_from_stadtmitte_3, bus
	where	bus_from_stadtmitte_3.destination=bus.departure
)

select * from bus_from_stadtmitte_1
union
select * from bus_from_stadtmitte_2
union
select * from bus_from_stadtmitte_3
union
select * from bus_from_stadtmitte_4;

-- Now with recursion
with 
bus_from_stadtmitte (departure,destination) as (
	select	departure, destination 
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination 
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure
)

select * from bus_from_stadtmitte;-- OPTION (MAXRECURSION 200);

-- Now we calculate the stops
with 
bus_from_stadtmitte (departure,destination,stops) as (
	select	departure, destination,1 
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination, stops+1  
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure
)
select * from bus_from_stadtmitte where stops <5;


-- Now we calculate the duration and stops
with 
bus_from_stadtmitte (departure,destination,duration,stops) as (
	select	departure, destination,DATEDIFF(minute,departure_time,arrival_time),1 
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination, duration+DATEDIFF(minute,bus.departure_time,bus.arrival_time),stops+1  
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure
)

select * from bus_from_stadtmitte;


-- Now we remember the way
with bus_from_stadtmitte (departure,destination,way) as (
	select	departure, destination, cast(departure+'->'+destination as varchar(max))
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination, way+'->'+bus.destination
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure
)

select * from bus_from_stadtmitte;

select * from bus where departure='Stadtmitte';

-- Now we add the cricles

insert into bus (departure, destination, line, departure_time, arrival_time, day) values
('Freibad',						'Innsbrucker Str./Freibad',		'10',	'08:15','08:18','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Max-Bram-Pl./FiWaG',			'10',	'08:18','08:21','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Stadtmitte',					'10',	'08:21','08:25','Mo-Fr'),

-- Line 10 2nd run
('Stadtmitte',					'Max-Bram-Pl./FiWaG',			'10',	'08:30','08:34','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Innsbrucker Str./Freibad',		'10',	'08:34','08:37','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Giessenbachstr.',				'10',	'08:37','08:40','Mo-Fr'),
('Giessenbachstr.',				'Knigsseestr./Unterfhrung',	'10',	'08:40','08:42','Mo-Fr'),
('Knigsseestr./Unterfhrung',	'Freibad',						'10',	'08:42','08:45','Mo-Fr'),
('Freibad',						'Innsbrucker Str./Freibad',		'10',	'08:45','08:48','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Max-Bram-Pl./FiWaG',			'10',	'08:48','08:51','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Stadtmitte',					'10',	'08:51','08:55','Mo-Fr'),

-- Line 10 3rd run
('Stadtmitte',					'Max-Bram-Pl./FiWaG',			'10',	'09:00','09:04','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Innsbrucker Str./Freibad',		'10',	'09:04','09:07','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Giessenbachstr.',				'10',	'09:07','09:10','Mo-Fr'),
('Giessenbachstr.',				'Knigsseestr./Unterfhrung',	'10',	'09:10','09:12','Mo-Fr'),
('Knigsseestr./Unterfhrung',	'Freibad',						'10',	'09:12','09:15','Mo-Fr'),
('Freibad',						'Innsbrucker Str./Freibad',		'10',	'09:15','09:18','Mo-Fr'),
('Innsbrucker Str./Freibad',	'Max-Bram-Pl./FiWaG',			'10',	'09:18','09:21','Mo-Fr'),
('Max-Bram-Pl./FiWaG',			'Stadtmitte',					'10',	'09:21','09:25','Mo-Fr');

insert into bus (departure, destination, line, departure_time, arrival_time, day) values
('Am Stocket',					'Ignaz Gnther Gymnasium',		'1',	'08:26','08:30','Mo-Fr'),
('Ignaz Gnther Gymnasium',		'Stadtmitte',					'1',	'08:30','08:35','Mo-Fr'),

-- Line 1 2nd run
('Stadtmitte',					'Ignaz Gnther Gymnasium',		'1',	'08:40','08:45','Mo-Fr'),
('Ignaz Gnther Gymnasium',		'Hohenzollernstr.',				'1',	'08:45','08:47','Mo-Fr'),
('Hohenzollernstr.',			'Berufsschule',					'1',	'08:47','08:52','Mo-Fr'),
('Berufsschule',				'Marienbergerstr.',				'1',	'08:52','08:54','Mo-Fr'),
('Marienbergerstr.',			'TH',							'1',	'08:54','08:57','Mo-Fr'),
('TH',							'Kaserne',						'1',	'08:57','09:00','Mo-Fr'),
('Kaserne',						'Lessingstr.',					'1',	'09:00','09:02','Mo-Fr'),
('Lessingstr.',					'Hoppenbichlerstr.',			'1',	'09:02','09:05','Mo-Fr'),
('Hoppenbichlerstr.',			'Am Stocket',					'1',	'09:05','09:06','Mo-Fr'),
('Am Stocket',					'Ignaz Gnther Gymnasium',		'1',	'09:06','09:10','Mo-Fr'),
('Ignaz Gnther Gymnasium',		'Stadtmitte',					'1',	'09:10','09:15','Mo-Fr');

with 
bus_from_stadtmitte (departure,destination,way, departure_time, arrival_time) as (
	select	departure, destination, cast(departure+'->'+destination as varchar(max)), departure_time, arrival_time
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination, way+'->'+bus.destination, bus_from_stadtmitte.departure_time, bus.arrival_time
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure and
			way not like '%'+bus.destination+'%' and
			bus_from_stadtmitte.arrival_time=bus.departure_time
)

select * from bus_from_stadtmitte where destination='Giessenbachstr.';

with 
bus_from_stadtmitte (departure,destination,way) as (
	select	departure, destination, cast(departure+'->'+destination as varchar(max))
	from	bus
	where	departure='Stadtmitte'

	union all 

	select	bus_from_stadtmitte.departure, bus.destination, way+'->'+bus.destination
	from	bus_from_stadtmitte, bus
	where	bus_from_stadtmitte.destination=bus.departure and
			way not like '%'+bus.destination+'%' 
)

select distinct * from bus_from_stadtmitte 

