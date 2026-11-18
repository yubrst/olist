select  c.customer_state, count(o.order_id) as колво_заказов,
sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end) колво_опоздавших_заказов,
round(1.0*sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end)/count(o.order_id)*100,2) as доля_опозданий,
ROUND(AVG(CASE WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date) THEN JULIANDAY(DATE(o.order_delivered_customer_date)) -JULIANDAY(DATE(o.order_estimated_delivery_date)) END),2) AS средняя_продолжительность_задержки,
max(CASE WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date) THEN JULIANDAY(DATE(o.order_delivered_customer_date)) -JULIANDAY(DATE(o.order_estimated_delivery_date)) end) as максимальная_продолжительность_задержки,
sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)>14 then 1 else 0 end) as опоздали_более_14_дней,
round(1.0*(sum(case when round(JULIANDAY(date(order_delivered_customer_date))-(JULIANDAY(date(order_estimated_delivery_date))),0)>14 then 1 else 0 end))/(sum(case when date(o.order_estimated_delivery_date)<DATE(o.order_delivered_customer_date) then 1 else 0 end))*100,2) as доля_задержек_на14дней
from olist_orders_dataset o join olist_customers_dataset c 
on c.customer_id = o.customer_id 
WHERE o.order_status = 'delivered' 
group by c.customer_state