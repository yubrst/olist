select SUM(CASE WHEN date(order_estimated_delivery_date) >= DATE(order_delivered_customer_date) and order_status='delivered' THEN 1 ELSE 0 END) AS Заказы_вовремя, 
SUM(CASE WHEN date(order_estimated_delivery_date) < DATE(order_delivered_customer_date) and order_status='delivered' THEN 1 ELSE 0 END) as Заказы_с_опозданием, 
round((1.0*SUM(CASE WHEN date(order_estimated_delivery_date) >= DATE(order_delivered_customer_date) and order_status='delivered' THEN 1 ELSE 0 END)
/(select count(order_id) from olist_orders_dataset where order_status = 'delivered'))*100,2) as доля_вовремя,
round((1.0*SUM(CASE WHEN date(order_estimated_delivery_date) < DATE(order_delivered_customer_date) and order_status='delivered' THEN 1 ELSE 0 END)
/(select count(order_id) from olist_orders_dataset where order_status = 'delivered'))*100,2) as доля_опозданий
from olist_orders_dataset



