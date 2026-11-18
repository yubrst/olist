 select  c.customer_state, count(o.order_id) as колво_заказов,
sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end) колво_опоздавших_заказов,
round(1.0*sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end)/count(o.order_id)*100,2) as доля_опозданий,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 1 and 3 then 1 else 0 end) as опоздали_1_3_дня, 
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 4 and 7 then 1 else 0 end) as опоздали_4_7_дней,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 8 and 14 then 1 else 0 end) as опоздали_8_14_дней,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)>14 then 1 else 0 end) as опоздали_более_14_дней,
round(1.0*(sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 1 and 3 then 1 else 0 end))/(sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end))*100,2) as доля_задержек_на1_3дней,
round(1.0*(sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 4 and 7 then 1 else 0 end))/(sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end))*100,2) as доля_задержек_на4_7дней,
round(1.0*(sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0) between 8 and 14 then 1 else 0 end))/(sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end))*100,2) as доля_задержек_на8_14дней,
round(1.0*(sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)>14 then 1 else 0 end))/(sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end))*100,2) as доля_задержек_на14дней,
ROUND(1.0 * SUM(CASE WHEN DATE(o.order_estimated_delivery_date) >= DATE(o.order_delivered_customer_date) THEN 1 ELSE 0 END) / COUNT(o.order_id) * 100,2) AS доля_вовремя
from olist_orders_dataset o join olist_customers_dataset c 
on c.customer_id = o.customer_id 
WHERE o.order_status = 'delivered' 
group by c.customer_state