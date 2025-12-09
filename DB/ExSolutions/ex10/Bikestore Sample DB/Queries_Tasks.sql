use BikeStore
-- task 01
-- a
select email, orders.order_id
from customers
left join orders on
(customers.customer_id = orders.customer_id)
where orders.order_id is null

-- b
select email, orders.order_id
from customers
left join orders on
(customers.customer_id = orders.customer_id)
left join order_items on
(orders.order_id = order_items.order_id)
where orders.order_id is not null and order_items.order_id is null

-- c
select product_name, model_year, quantity
from products
left join stocks on
(products.product_id = stocks.product_id)
where model_year in (2018, 2019) and quantity < 20

-- task 02
-- a
select store_name, sum(list_price*quantity*(1-discount)) as 'turnover'
from order_items, stores, orders
where orders.store_id = stores.store_id and order_items.order_id = orders.order_id
group by stores.store_name

select staffs.staff_id, first_name, last_name, count(orders.order_id) as num_orders
from staffs
left join orders on
(orders.staff_id = staffs.staff_id)
group by staffs.staff_id, first_name, last_name

select staffs.staff_id, first_name, last_name, count(orders.order_id) as num_orders
from staffs
left join orders on
(orders.staff_id = staffs.staff_id)
group by staffs.staff_id, first_name, last_name

-- b)
select order_items.order_id, (sum(list_price*quantity*(1-discount)) - order_price.average) as variance, order_price.average as order_avg
from order_items, (
				select avg(list_price*quantity*(1-discount)) as average
				from order_items) as order_price
group by order_items.order_id, order_price.average
order by variance asc

-- c
select staffs.staff_id,
case
	when month(orders.order_date) is null then 0
	else month(orders.order_date)
	end as month, 
case
	when month(orders.order_date) is null then 0
	else sum(list_price*quantity*(1-discount)) 
	end as turnover_per_month
from order_items, staffs
left join orders on 
(orders.staff_id = staffs.staff_id)
where orders.staff_id = staffs.staff_id and order_items.order_id = orders.order_id or orders.staff_id is null
group by staffs.staff_id, month(orders.order_date)
order by month(orders.order_date) asc, staffs.staff_id asc

-- task 03
-- a

with employee_hierachy as (
select staff_id, manager_id as managed_by,  first_name, last_name, 0 as level, cast(first_name as varchar(1000)) as path
from staffs
where manager_id is null

union all

select 
	e.staff_id, 
	e.manager_id, 
	e.first_name, 
	e.last_name, 
	level + 1, 
	cast(eh.path + '->' + e.first_name as varchar(1000))
from staffs as e
inner join employee_hierachy eh on e.manager_id = eh.staff_id
)

select *
from employee_hierachy;