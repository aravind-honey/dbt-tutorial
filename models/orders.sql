WITH orders as (
    select
        id as order_id,
        user_id as customer_id
    from raw.jaffle_shop.orders
),

payments AS(
    Select 
        "orderID" AS order_id, amount 
    from raw.stripe.payment)

SELECT * FROM orders
JOIN payments using(order_id)