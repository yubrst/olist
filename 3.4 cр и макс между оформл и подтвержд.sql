Select round(avg(round(JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp)),2)),2)*24 as среднее_между_оформлением_подтверждением,
round(max(round(JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp)),2)),2)*24 as максимум_между_оформлением_подтверждением
from olist_orders_dataset
where order_status = 'delivered' and order_purchase_timestamp IS NOT NULL AND order_approved_at IS NOT NULL

