
select 
round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) 
FROM olist_orders_dataset 
WHERE order_status = 'delivered'
  AND DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date)