SELECT
    CASE
        WHEN (JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp))) = 0 THEN '0 дней'
        WHEN (JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp))) <= 3 THEN '1–3 дня'
        WHEN (JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp))) <= 7 THEN '4–7 дней'
        WHEN (JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp))) <= 14 THEN '8–14 дней'
        WHEN (JULIANDAY(date(order_approved_at))-JULIANDAY(date(order_purchase_timestamp))) <= 30 THEN '15–30 дней'
        ELSE 'Более 30 дней'
    END AS интервал,
    COUNT(*) AS количество_заказов
FROM olist_orders_dataset
where order_status = 'delivered' and order_purchase_timestamp IS NOT NULL AND order_approved_at IS NOT NULL
GROUP BY интервал;