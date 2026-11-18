SELECT
    c.customer_state,
    COUNT(o.order_id) AS количество_заказов,
    ROUND(AVG(JULIANDAY(DATE(o.order_delivered_carrier_date))- JULIANDAY(DATE(o.order_approved_at))), 2) AS среднее_время_передачи,
MIN(JULIANDAY(DATE(o.order_delivered_carrier_date))- JULIANDAY(DATE(o.order_approved_at))) AS минимальное_время,
MAX(JULIANDAY(DATE(o.order_delivered_carrier_date))- JULIANDAY(DATE(o.order_approved_at))) AS максимальное_время
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
    AND o.order_approved_at IS NOT NULL
    AND o.order_delivered_carrier_date IS NOT NULL
    AND DATE(o.order_delivered_carrier_date) >= DATE(o.order_approved_at)
GROUP BY c.customer_state
