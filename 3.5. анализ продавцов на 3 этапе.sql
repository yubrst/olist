SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id) AS количество_заказов,
    ROUND(AVG(
        JULIANDAY(DATE(o.order_delivered_carrier_date)) -
        JULIANDAY(DATE(o.order_approved_at))), 2) AS среднее_время_обработки_дней
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_approved_at IS NOT NULL
  AND o.order_delivered_carrier_date IS NOT NULL
  AND DATE(o.order_delivered_carrier_date) >=
      DATE(o.order_approved_at)
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT o.order_id) >= 50
