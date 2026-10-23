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
select product_name, model_year, sum(quantity), stores.store_id
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


-- b
select staffs.staff_id, first_name, last_name, count(orders.order_id) as num_orders
from staffs
left join orders on
(orders.staff_id = staffs.staff_id)
group by staffs.staff_id, first_name, last_name

-- c
select order_items.order_id, (sum(list_price*quantity*(1-discount)) - order_price.average) as variance, order_price.average as order_avg
from order_items, (
				select avg(list_price*quantity*(1-discount)) as average
				from order_items) as order_price
group by order_items.order_id, order_price.average
order by variance asc

-- d
select staffs.staff_id,
case
	when month(orders.order_date) is null then 0
	else month(orders.order_date)
	end as month, 
case
	when month(orders.order_date) is null then 0
	else avg(list_price*quantity*(1-discount)) 
	end as turnover_per_month
from order_items, staffs
left join orders on 
(orders.staff_id = staffs.staff_id)
where orders.staff_id = staffs.staff_id and order_items.order_id = orders.order_id or orders.staff_id is null
group by staffs.staff_id, month(orders.order_date)
order by month(orders.order_date) asc, staffs.staff_id asc

-- task 03
-- a
with employee_hierarchy(manager_id, manager_name, employee_id, employee_name) as (
select m.staff_id, m.first_name, e.staff_id, e.first_name
from staffs as m left join staffs as e
on m.staff_id = e.manager_id

union all

select eh.manager_id, eh.manager_name, se.staff_id, se.first_name
from employee_hierarchy as eh, staffs as se
where eh.employee_id = se.manager_id and eh.employee_id is not null
)

select * from employee_hierarchy;

-- b
with employee_hierarchy(manager_id, manager_name, employee_id, employee_name, directly_managed) as (
select m.staff_id, m.first_name, e.staff_id, e.first_name, cast('yes' as varchar(3))
from staffs as m left join staffs as e
on m.staff_id = e.manager_id

union all

select
eh.manager_id, eh.manager_name, 
se.staff_id, se.first_name, 
cast('no' as varchar(3))
from employee_hierarchy as eh, staffs as se
where eh.employee_id = se.manager_id and eh.employee_id is not null
)

select * from employee_hierarchy;

-- c
with employee_hierarchy(manager_id, manager_name, employee_id, employee_name, directly_managed, reports_via) as (
select m.staff_id, m.first_name, e.staff_id, e.first_name, cast('yes' as varchar(3)), cast('' as varchar(max))
from staffs as m left join staffs as e
on m.staff_id = e.manager_id

union all

select
eh.manager_id, eh.manager_name, 
se.staff_id, se.first_name, 
cast('no' as varchar(3)),
case
	when directly_managed = 'yes' then cast(eh.employee_name as varchar(max))
	when directly_managed = 'no' then reports_via
end
from employee_hierarchy as eh, staffs as se
where eh.employee_id = se.manager_id and eh.employee_id is not null
)

select * from employee_hierarchy;

-- d not correct but dont wanna do it
with employee_hierarchy(manager_id, manager_name, employee_id, employee_name, directly_managed, reports_via, level) as (
select m.staff_id, m.first_name, e.staff_id, e.first_name, cast('yes' as varchar(3)), cast('' as varchar(max)), 0
from staffs as m left join staffs as e
on m.staff_id = e.manager_id

union all

select
eh.manager_id, eh.manager_name, 
se.staff_id, se.first_name, 
cast('no' as varchar(3)),
case
	when directly_managed = 'yes' then cast(eh.employee_name as varchar(max))
	when directly_managed = 'no' then reports_via
end,
level + 1
from employee_hierarchy as eh, staffs as se
where eh.employee_id = se.manager_id and eh.employee_id is not null
)

select * from ( 
	select manager_name, manager_id, count(employee_id) as employees_managed
	from employee_hierarchy group by manager_name, manager_id, employee_id) as managers
	left join
	(select staffs.staff_id as id, isnull(month(orders.order_date), 0) as month,
	isnull(avg(list_price*quantity*(1-discount)), 0) as turnover_per_month
	from order_items, staffs left join orders 
	on (orders.staff_id = staffs.staff_id)
	where orders.staff_id = staffs.staff_id and order_items.order_id = orders.order_id or orders.staff_id is null
	group by staffs.staff_id, month(orders.order_date)) as sales
	on managers.manager_id = sales.id
	order by sales.month, employees_managed, sales.turnover_per_month