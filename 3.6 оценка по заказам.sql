SELECT
    CASE
        WHEN JULIANDAY(DATE(o.order_delivered_customer_date)) -
             JULIANDAY(DATE(o.order_estimated_delivery_date)) BETWEEN 1 AND 3
            THEN '1–3 дня'
        WHEN JULIANDAY(DATE(o.order_delivered_customer_date)) -
             JULIANDAY(DATE(o.order_estimated_delivery_date)) BETWEEN 4 AND 7
            THEN '4–7 дней'
        WHEN JULIANDAY(DATE(o.order_delivered_customer_date)) -
             JULIANDAY(DATE(o.order_estimated_delivery_date)) BETWEEN 8 AND 14
            THEN '8–14 дней'
        ELSE 'Более 14 дней'
    END AS интервал_задержки,
    COUNT(*) AS количество_заказов,
    ROUND(AVG(r.средняя_оценка), 2) AS средняя_оценка
FROM olist_orders_dataset o
JOIN (
    SELECT
        order_id,
        AVG(review_score) AS средняя_оценка
    FROM olist_order_reviews_dataset
    GROUP BY order_id) r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND DATE(o.order_delivered_customer_date) >
      DATE(o.order_estimated_delivery_date)
GROUP BY интервал_задержки
ORDER BY
    CASE интервал_задержки
        WHEN '1–3 дня' THEN 1
        WHEN '4–7 дней' THEN 2
        WHEN '8–14 дней' THEN 3
        ELSE 4
    END;