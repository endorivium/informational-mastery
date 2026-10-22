-- Task 1
select product_id from products
except
	select product_id from (
		select product_id, store_id from products, stores --order by product_id
		except
		select product_id, store_id from stocks where quantity > 0 --order by product_id
	) as x;

-- Task 2
-- requested properties: values ('window'),('2nd'),('premium_tv')
with 

available_seats(id, flight) as (
	select id, flight from seats
	except
	select seat, flight from bookings
),

available_seats_with_properties(id, flight) as 
(
	-- all available seats
	select id, flight 
	from available_seats
	except
	select id, flight from (
		-- all available seats with possible properties
		select id, flight, property 
		from available_seats, (values ('window'),('2nd'),('premium_tv')) as p(property)
		except
		-- all available seats with actual properties
		select id, available_seats.flight, property 
		from available_seats join bookingProperty on (available_seats.flight=bookingProperty.flight and  available_seats.id=bookingProperty.seat)
	) as x
),

recursive_flights(start, destination, departure_time, arrival_time, path, seat_booking) as (

	select	start, destination, departure_time, arrival_time, 
			cast(start+'#'+destination as varchar(1000)) as path,
			cast(available_seats_with_properties.id as varchar(1000)) as seat_booking
	from flights
	join available_seats_with_properties on (available_seats_with_properties.flight=flights.no)
	where start='München'
	

union all

	select	recursive_flights.start, flights.destination, recursive_flights.departure_time, flights.arrival_time, 
			cast(path+'#'+flights.destination as varchar(1000)),
			cast(concat(seat_booking,', ',available_seats_with_properties.id) as varchar(1000)) as seat_booking
	from flights join available_seats_with_properties on (available_seats_with_properties.flight=flights.no),  
		recursive_flights 
		
	where 
	recursive_flights.destination=flights.start 
	and recursive_flights.arrival_time<flights.departure_time 
	and charindex(flights.destination, path) = 0
)
select * from recursive_flights where destination='New York'