select * from orders

--1. Total revenue
select sum(revenue) as total_revenue
from orders

--2. Revenue by city (which cities earn the most)
select city, sum(revenue) as revenue_by_city
from orders
group by city
order by revenue_by_city desc

--3. Top categories by revenue
select category, sum(revenue) as total_revenue
from orders
group by category
order by total_revenue desc
limit 3

--4. Orders by status (how many are cancelled or returned)
select order_status, count(*) as total_order
from orders
group by order_status

--5. Revenue by payment mode
select payment_mode, sum(revenue) as total_revenue, count(*) as num_orders
from orders
group by payment_mode

--6. Monthly revenue trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS total
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

--7. Average order value, excluding cancelled and returned
select avg(revenue) as avg_ord_val
from orders
where order_status not in ('Cancelled', 'Returned')

--8. Top customers by spending
select customer_name, sum(revenue) as total_spent
from orders
group by customer_name
order by total_spent desc
limit 5

--9. Which products get the highest average discount
select product, avg(discount) as avg_dis
from orders
group by product
order by avg_dis
limit 5

--10. Cancellation rate by city
select city,
       count(*) as total_orders,
       sum(case when order_status = 'Cancelled' then 1 else 0 end) as cancelled,
       round(100.0 * sum(case when order_status = 'Cancelled' then 1 else 0 end) / count(*), 1) as cancel_rate_pct
from orders
group by city
order by cancel_rate_pct desc;


