--create table #quantity(quantity int);
--insert into #quantity values (0), (NULL);

-- task1
-- a
select distinct product_name, quantity
from products
left join stocks on products.product_id = stocks.product_id
left join stores on stores.store_id = stocks.store_id
where quantity is null or quantity = 0
order by product_name

-- a using division
select product_name 
from products
except
select product_name
from (select product_name, 0 as quantity from products
	except
	select product_name, quantity
	from products
		left join stocks on products.product_id = stocks.product_id) as not_in_stock
union
select distinct product_name
from products
	left join stocks on products.product_id = stocks.product_id
	left join stores on stores.store_id = stocks.store_id
where quantity is null
order by product_name

-- b
--create table #all_stores (store_id int);
--insert into #all_stores values (1), (2), (3);

select product_name 
from products
join stocks on products.product_id = stocks.product_id
join stores on stocks.store_id = stores.store_id
except
select product_name
from (select product_name, store_id from products, #all_stores
	except
	select product_name, stores.store_id
	from products
		join stocks on products.product_id = stocks.product_id
		join stores on stocks.store_id = stores.store_id) as not_in_store



-- for this to work only product name needs to be selected
-- essentially the inner division finds all products that do not have the given attribute
-- by first creating all potential tuple, then removing the ones that do exist, leaving only the products
-- that do not exist (with the given attribute), those products are then removed from the upper
-- select leaving only the products that do have the given attribute