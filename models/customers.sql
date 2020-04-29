with customers as (
    select
        id as customer_id,
        first_name,
        last_name
    from raw.jaffle_shop.customers
),

orders as (
    select
        id as order_id,
        user_id as customer_id
    from raw.jaffle_shop.orders
),

payment_amount AS(
    Select 
    "orderID" AS order_id, amount 
    from raw.stripe.payment),

lifetime_value AS(
select customer_id, SUM(amount) AS lifetime_value
from {{ ref('orders') }}
JOIN customers
using(customer_id)
group by 1)

Select * from customers
LEFT JOIN lifetime_value
using(customer_id)