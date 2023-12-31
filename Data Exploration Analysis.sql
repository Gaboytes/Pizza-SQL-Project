# Data exploration business 

-- Total revenue
SELECT sum(i.item_price* o.quantity) as total_Revenue
FROM orders o 
join item i on i.item_id = o.item_id 
;

-- Total costs
-- orders, item , recipe, ingredient
SELECT sum(p.ing_price) as total_cost_ingredient
FROM orders o 
join item i on i.item_id = o.item_id 
join recipe r on i.sku = r.recipe_id
join ingredient p on r.ing_id = p.ing_id

;
-- avarege total order value  option 1
with cte_average as (

SELECT sum(i.item_price* o.quantity) as average_order_value
FROM orders o 
join item i on i.item_id = o.item_id 
group by order_id
)
select avg(average_order_value) as average_order_value
from cte_average;

-- avarege total order value  option 2
SELECT (sum(i.item_price* o.quantity)/count(distinct(order_id))) as average_order_value
FROM orders o
join item i on i.item_id = o.item_id 
;

-- Total products Sold 

SELECT sum(quantity) as Total_products_sold
from orders o
;
-- Total Orders

SELECT count(distinct(order_id)) as Total_Orders
from orders o
;
-- Average products per order

SELECT round((sum(quantity)/count(distinct(order_id))),2) as average_products_order
FROM orders o
;

-- Now lets analize wich category is the best-sell 
select item_cat,sum(i.item_price* o.quantity) as revenue
from orders o 
join item i on i.item_id = o.item_id 
group by item_cat 
order by revenue desc
;
-- Total pizzas Sold 

SELECT sum(quantity) as Total_pizzas_sold
from orders o 
join item i on i.item_id = o.item_id 
where item_cat = "pizza"
;

-- Average pizza per order

SELECT round((sum(quantity)/count(distinct(order_id))),2) as average_pizza_order
from orders o 
join item i on i.item_id = o.item_id 
where item_cat = "pizza"
;

-- Daily trends for total orders 

Select dayname(created_at) ,  count(distinct(order_id))
from orders o 
group by dayname(created_at)
;
-- Hourly trends for total orders 

Select hour(created_at) as hour ,  count(distinct(order_id)) as orders
from orders o 
group by hour(created_at )

;

-- Porcentaje of sales  by  product category 
Select item_cat,  round(sum(i.item_price * o.quantity)/(select sum(i.item_price* o.quantity)from orders o join item i on i.item_id = o.item_id) *100,2) as percetaje_sold
from orders o 
join item i on i.item_id = o.item_id 
group by item_cat
;

-- Porcentaje of sales  by  Pizzas category 
Select i.item_name,  round(sum(i.item_price* o.quantity)/(select sum(i.item_price* o.quantity)from orders o join item i on i.item_id = o.item_id where i.item_cat = "pizza" ) *100,2) as percetaje_sold
from orders o 
join item i on i.item_id = o.item_id 
where i.item_cat = "pizza"
group by i.item_name
;


-- Porcentaje of sales by pizza size
Select i.item_size,  round(sum(i.item_price* o.quantity)/(select sum(i.item_price* o.quantity)from orders o join item i on i.item_id = o.item_id where i.item_cat = "pizza" ) *100,2) as percetaje_sold
from orders o 
join item i on i.item_id = o.item_id 
where i.item_cat = "pizza"
group by i.item_size

;

-- Top 5 best sellers Products
Select item_name, sum(quantity) as total_sold_pizzas
from orders o 
join item i on i.item_id = o.item_id 
group by item_name
order by total_sold_pizzas desc
limit 5
;

-- Top 5 best sellers Pizzas
Select item_name, sum(quantity) as total_sold_pizzas
from orders o 
join item i on i.item_id = o.item_id 
where item_cat='pizza'
group by item_name
order by total_sold_pizzas desc
limit 5

;
-- bottom 5 worst sellers products
Select item_name, sum(quantity) as total_sold_pizzas
from orders o 
join item i on i.item_id = o.item_id 
group by item_name
order by total_sold_pizzas asc
limit 5

;
-- bottom 5 worst sellers by total pizzas sold 
Select item_name, sum(quantity) as total_sold_pizzas
from orders o 
join item i on i.item_id = o.item_id 
where item_cat='pizza'
group by item_name
order by total_sold_pizzas asc
limit 5

;
-- Top 5 costumers Sells 
Select  c.cust_firstname, c.cust_lastname, sum(i.item_price* o.quantity) as total_Sells
from  orders o  
join item i on i.item_id = o.item_id 
join customers c on c.cust_id = o.cust_id
group by c.cust_firstname, c.cust_lastname
order by total_Sells desc
limit 5

;




