SELECT CASE WHEN DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date) THEN 'С опозданием' ELSE 'Вовремя'END AS качество_доставки,
    COUNT(*) AS количество_заказов,
    ROUND(AVG(
        JULIANDAY(DATE(order_delivered_customer_date)) -
        JULIANDAY(DATE(order_delivered_carrier_date))), 2) AS средняя_длительность_дней_передачи_доставки,
    MIN(JULIANDAY(DATE(order_delivered_customer_date)) - JULIANDAY(DATE(order_delivered_carrier_date))) AS минимум_дней,
    MAX(JULIANDAY(DATE(order_delivered_customer_date)) - JULIANDAY(DATE(order_delivered_carrier_date))) AS максимум_дней
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_carrier_date IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  AND DATE(order_delivered_customer_date) >= DATE(order_delivered_carrier_date)
GROUP BY качество_доставки;