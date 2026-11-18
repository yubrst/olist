SELECT
    CASE
        WHEN JULIANDAY(DATE(order_delivered_customer_date))
           - JULIANDAY(DATE(order_delivered_carrier_date)) = 0 THEN '0 дней'
        WHEN JULIANDAY(DATE(order_delivered_customer_date))
           - JULIANDAY(DATE(order_delivered_carrier_date)) <= 3 THEN '1–3 дня'
        WHEN JULIANDAY(DATE(order_delivered_customer_date))
           - JULIANDAY(DATE(order_delivered_carrier_date)) <= 7 THEN '4–7 дней'
        WHEN JULIANDAY(DATE(order_delivered_customer_date))
           - JULIANDAY(DATE(order_delivered_carrier_date)) <= 14 THEN '8–14 дней'
        WHEN JULIANDAY(DATE(order_delivered_customer_date))
           - JULIANDAY(DATE(order_delivered_carrier_date)) <= 30 THEN '15–30 дней'
        ELSE 'Более 30 дней'
    END AS интервал,
    COUNT(*) AS количество_заказов
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_carrier_date IS NOT NULL
GROUP BY интервал;