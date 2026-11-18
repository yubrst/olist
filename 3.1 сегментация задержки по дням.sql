select 
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 1 and 3 then 1 else 0 end) as задержка_1_3_дня, 
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 4 and 7 then 1 else 0 end) as задержка_4_7_дней,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 8 and 14 then 1 else 0 end) as задержка_8_14_дней,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) >14  then 1 else 0 end) as задержка_более_14дней
FROM olist_orders_dataset 
WHERE order_status = 'delivered'
  AND DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date)