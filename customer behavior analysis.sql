-- create database customer_behaviour
-- use customer_behaviour;

-- Q1. What is the Total Amount genrated by Male vs Female Customer
-- select gender, sum(purchase_amount) as revenue from customer group by gender

-- Q2. Witch Customer used a Discount but still spent more then the average purchase amount
-- select customer_id, purchase_amount 
-- from customer 
-- where discount_applied like 'Yes' 
-- and purchase_amount >= (
-- select avg(purchase_amount) 
-- from customer
-- );

-- Q3. Which are the top 5 product with the highest average review rating
-- select item_purchased, round(avg(review_rating),2) as avg_product_rating 
--  from customer 
--  group by item_purchased order by avg_product_rating desc limit 5;

-- Q4. Compare the Average Purchase Amount Between Standerd and Express Shipping 
-- select shipping_type, round(avg(purchase_amount), 2) 
-- from customer 
-- where shipping_type in ('Express', 'Standard')
-- group by shipping_type

-- Q5. Do subscribed customers spend more? Compare average spend and total revenue --between subscribers and non-subscribers.I
-- select subscription_status, 
-- count(customer_id) as total_customer,
-- round(avg(purchase_amount), 2) as avg_spend, 
-- sum(purchase_amount) as total_revenue 
-- from customer 
-- group by subscription_status
-- order by total_revenue, avg_spend desc

-- Q6. Witch 5 Products have the highest percentage of purchases with discount applied
-- select item_purchased, 
-- round(
-- 100.0 * sum(case when discount_applied like 'Yes' then 1 else 0 end) / count(*), 
-- 2) as chances 
-- from customer 
-- group by item_purchased 
-- order by chances
-- desc limit 5

-- Q7. Segment customers into New, Returning, and Loyal based on their total
-- number of previous purchases, and show the count of each segment.
-- with customer_type as (
-- select customer_id, previous_purchases, 
-- case
-- 	when previous_purchases = 1 then 'New'
--     when previous_purchases between 2 and 10 then 'Returning'
--     else 'Loyal'
--     end as customer_segment
-- from customer
-- )

-- select customer_segment, count(*) as 'Number of customer' from customer_type group by customer_segment

-- select 
-- case
-- 	when previous_purchases = 1 then 'New'
--     when previous_purchases between 2 and 10 then 'Returning'
--     else 'Loyal'
--     end as customer_segment,
-- count(previous_purchases)
-- from customer group by customer_segment

-- Q8. What are the top 3 most purchased products within each category?
-- with cte as (
-- 	select category, item_purchased, count(item_purchased) as 'total_order',
-- 	row_number() over(partition by category order by count(item_purchased) desc) as 'rank_'
-- 	from customer
-- 	group by category, item_purchased
-- )

-- select * from cte where rank_ <= 3

-- 09. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
-- select subscription_status, 
-- count(subscription_status) as repeat_buyers 
-- from customer where previous_purchases > 5 
-- group by subscription_status

-- Q16. What is the revenue contribution of each age group?
-- select age_group, 
-- sum(purchase_amount) as revenue 
-- from customer 
-- group by age_group 
-- order by revenue desc