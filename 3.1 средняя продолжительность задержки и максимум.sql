
SELECT
round(avg(round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)),2) as средняя_продолжиьельность,
max(round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)) as максимальная_задержка
FROM olist_orders_dataset 
where round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date ))),0)>0 and order_status = 'delivered'


