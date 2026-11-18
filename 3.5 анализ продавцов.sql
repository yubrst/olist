SELECT
    seller_id,
    COUNT(*) AS количество_заказов,
    SUM(CASE WHEN DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date) THEN 1 ELSE 0 END) AS количество_опозданий,
    ROUND(100.0 * SUM(CASE WHEN DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date) THEN 1 ELSE 0 END) / COUNT(*),2) AS доля_опозданий,
ROUND(AVG(JULIANDAY(DATE(order_delivered_carrier_date)) - JULIANDAY(DATE(order_approved_at))), 2) AS среднее_время_до_передачи
FROM (SELECT DISTINCT
        oi.seller_id,
        o.order_id,
        o.order_approved_at,
        o.order_delivered_carrier_date,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_approved_at IS NOT NULL
      AND o.order_delivered_carrier_date IS NOT NULL
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL
      AND DATE(o.order_delivered_carrier_date) >=
          DATE(o.order_approved_at)) AS seller_orders
GROUP BY seller_id
HAVING COUNT(*) >= 50
ORDER BY доля_опозданий DESC;