select strftime('%Y-%m', order_purchase_timestamp)as дата_оформления, count(order_id) as колво_доставленных,
sum(case when date(order_estimated_delivery_date)<DATE(order_delivered_customer_date)  then 1 else 0 end) as колво_опоздавших,
round((1.0*sum(case when date(order_estimated_delivery_date)<DATE(order_delivered_customer_date)  then 1 else 0 end)/count(order_id))*100,2) as доля_опозданий
from olist_orders_dataset 
where order_status='delivered'
group by strftime('%Y-%m', order_purchase_timestamp)