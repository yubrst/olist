Select order_id,order_approved_at, order_delivered_carrier_date,
round(JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp)),2) as оформление_подтверждение,
round(JULIANDAY(date(order_delivered_carrier_date))-JULIANDAY(date(order_approved_at)),2)as подтверждение_передача,
round(JULIANDAY(date(order_delivered_customer_date))-JULIANDAY(date(order_delivered_carrier_date)),2) as передача_доставка,
round(JULIANDAY(date(order_estimated_delivery_date))-JULIANDAY(date(order_delivered_customer_date)),2) as опоздание
from olist_orders_dataset 
where order_status = 'delivered' AND DATE(order_delivered_carrier_date) < DATE(order_approved_at)