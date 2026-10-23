use BikeStore;

-- Task 2a: all products that are not available in every store
select distinct product_name from(	
	select product_name, store_id
	from products, stores

	except
	
	select product_name, stocks.store_id
	from products join stocks on(stocks.product_id=products.product_id)
	where stocks.quantity >0
) as x;

-- Task 2b: all products that are available in every store
Select product_name
from products

except 

select product_name
from (
	select product_name, store_id
	from products, stores

	except
	
	select product_name, stocks.store_id
	from products join stocks on(stocks.product_id=products.product_id)
	where stocks.quantity >0
) as p
order by product_name

