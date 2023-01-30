

use BikeStore
GO
select first_name,last_name,order_date
from sales.customers as "C" join sales.orders  as "o"
on c.customer_id = o.customer_id


--Query returns the first customers with ids from range 1 to 10 and order them
select C.customer_id, first_name+' '+ last_name as 'fullName',product_name,category_name,P.list_price,order_date
from sales.customers as "C" join sales.orders as "O"
on C.customer_id =O.customer_id join sales.order_items as "Oi" 
on O.order_id=Oi.order_id join production.products as "P" 
on Oi.product_id = P.product_id join production.categories  as "ca"
on ca.category_id=P.category_id
where C.customer_id<10

order by customer_id , list_price desc

--Query return total product purshaced from the user

select customer_id,count(*) as "Number of orders", max(order_date) as "Last order Date", min(order_date) as "first order Date"
from sales.orders
group by customer_id
having count(*)>=2
order by count(*)
--Query returns for each category , list category_id,max price , min price , average price 
 
 select category_name , max(P.list_price) as "Highest product price in category" , min(P.list_price) as "Lowest product price in category" , count(*) as "Number of products"	
from  production.products as "P" join production.categories  as "ca"
on ca.category_id=P.category_id
group by category_name
order by count(*)



--Query returns the product number of each brand 

select brand_name,count(*) as "Number of products of the brand",max(list_price)  as "Highest price ",min(list_price) as "Lowest price"
from production.brands as "b" join production.products as "p"
on b.brand_id = p.brand_id

--Query returns name of each store and total orders delivered from each one 

select store_name,count(*) as "Number of orders"
from sales.orders as "o" join sales.stores as "s"
on o.store_id = s.store_id
group by store_name
having count(*)>300
order by count(*)

--Query to know how many times an specific brand is ordered
select brand_name,count(*) as "Times of ordered brand" from
sales.order_items as "oi" join production.products as "p"
on oi.product_id = p.product_id join production.brands as "b" 
on b.brand_id=p.brand_id
group by brand_name
order by count(*) desc

--

 --Query to return top 3 highest categories with highest products inside 
 select TOP 2  with ties category_name , max(P.list_price) as "Highest product price in category" , min(P.list_price) as "Lowest product price in category" , count(*) as "Number of products"	
from  production.products as "P" join production.categories  as "ca"
on ca.category_id=P.category_id
group by category_name
order by count(*) desc