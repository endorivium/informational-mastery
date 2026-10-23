use BikeStore;

-- Joins
-- list of customers, that have never placed an order
select customers.first_name, customers.last_name, customers.customer_id, customers.email
from customers left join orders on (customers.customer_id=orders.customer_id)
where orders.customer_id is null

-- list of customers, that have never ordered a product with their employee that recieved the order
select distinct customers.first_name, customers.last_name, customers.customer_id, staffs.first_name, staffs.last_name
from customers join orders on (customers.customer_id=orders.customer_id) join staffs on (staffs.staff_id=orders.staff_id) left join order_items on (orders.order_id=order_items.order_id)
where order_items.order_id is null

-- task from before as right join
select distinct customers.first_name, customers.last_name, customers.customer_id
from order_items right join orders on (order_items.order_id=orders.order_id) right join customers on (customers.customer_id=orders.customer_id)
where order_items.order_id is null

-- list of products together with their total sum of stocked units over all stores from model year 2018 or 2019 and less than 20 in stocks
select products.product_name, sum(isnull(stocks.quantity,0.0)) as sum
from products left join stocks on (products.product_id=stocks.product_id)
where model_year=2018 or model_year=2019
group by products.product_name
having sum(isnull(stocks.quantity,0.0))<20
order by sum

-- Aggregates

-- turnover per store
select		stores.store_name,
			sum(order_items.list_price*(1-order_items.discount)*order_items.quantity) 
from		stores
			left join orders on (orders.store_id=stores.store_id)
			left join order_items on (order_items.order_id=orders.order_id) 
where		orders.shipped_date between '2017-01-01' and '2017-12-31'
group by	stores.store_name;

-- orders per person
select		staffs.first_name, staffs.last_name, count(orders.order_id)
from		staffs
			left join orders on (orders.staff_id=staffs.staff_id)
where		orders.order_date between '2017-01-01' and '2017-03-31'
group by	staffs.first_name, staffs.last_name;

-- average price per order, variance per order
select cast(isnull(var(spo.sum_per_order),0.0) as decimal(10,2)), cast(isnull(avg(spo.sum_per_order),0.0) as decimal(10,2))
from(
select sum(oi.list_price*(1-oi.discount)*quantity) as sum_per_order
from orders as o left join order_items as oi on (oi.order_id=o.order_id)
group by o.order_id --order by sum_per_order
) as spo;

-- average turnover per employee per month.
select first_name, last_name, staff_id, avg(sum_per_order) as total
from (
select staffs.first_name, staffs.last_name, staffs.staff_id , isnull(sum(list_price*(1-discount)*quantity),0) as sum_per_order, month(orders.order_date) as month, year(orders.order_date) as year
from staffs left join orders on (orders.staff_id=staffs.staff_id) left join order_items on (order_items.order_id=orders.order_id)
group by staffs.last_name, staffs.first_name, staffs.staff_id, month(orders.order_date), year(orders.order_date)) as sums
group by first_name, last_name, staff_id
order by total desc;




-- Recursion
with my_staff (first_name, last_name, staff_id, employee_first_name, employee_second_name, employee_id, direct_report, reports_via, level) as(
	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('yes' as char(3)), 
			cast('' as varchar(255)),
			cast(0 as int) as level
	from	staffs as p 
			left join staffs as s on (p.staff_id=s.manager_id)

	union all

	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('no' as char(3)), 
			case	when direct_report='yes'	then cast(employee_first_name+' '+employee_second_name as varchar(255))
					when direct_report='no'		then reports_via
			end,
			level=level+1
	from my_staff as p join staffs as s on (p.employee_id=s.manager_id) where p.employee_id is not null
)

select * from my_staff order by last_name;
select * from staffs; 


with my_staff (first_name, last_name, staff_id, employee_first_name, employee_second_name, employee_id, direct_report, reports_via, level) as(
	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('yes' as char(3)), 
			cast('' as varchar(255)),
			cast(0 as int) as level
	from	staffs as p 
			left join staffs as s on (p.staff_id=s.manager_id)

	union all

	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('no' as char(3)), 
			case	when direct_report='yes'	then cast(employee_first_name+' '+employee_second_name as varchar(255))
					when direct_report='no'		then reports_via
			end,
			level=level+1
	from my_staff as p join staffs as s on (p.employee_id=s.manager_id) where p.employee_id is not null
)

select * from (
	select first_name, last_name, staff_id, count(employee_id) as number_of_people_managed 
	from my_staff group by first_name, last_name, staff_id) as managers 
	left join (
		select first_name, last_name, staff_id, avg(sum_per_order) as total
		from (
			select staffs.first_name, staffs.last_name, staffs.staff_id , isnull(sum(list_price*discount),0) as sum_per_order, month(orders.order_date) as month, year(orders.order_date) as year
			from staffs left join orders on (orders.staff_id=staffs.staff_id) left join order_items on (order_items.order_id=orders.order_id)
			group by staffs.last_name, staffs.first_name, staffs.staff_id, month(orders.order_date), year(orders.order_date)) as sums
		group by first_name, last_name, staff_id
	) as sales on (managers.staff_id=sales.staff_id)
order by number_of_people_managed desc