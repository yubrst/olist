Select round(avg(round(JULIANDAY(date(order_delivered_carrier_date))-JULIANDAY(date(order_approved_at)),2)),2)*24 as среднее_между_подтверждением_передачей,
round(max(round(JULIANDAY(date(order_delivered_carrier_date))-JULIANDAY(date(order_approved_at)),2)),2)*24 as максимум_между_подтверждением_передачей
from olist_orders_dataset
where order_status = 'delivered' and order_delivered_carrier_date IS NOT NULL AND order_approved_at IS NOT NULL

