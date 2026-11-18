SELECT
    CASE
        WHEN DATE(o.order_delivered_customer_date) >
             DATE(o.order_estimated_delivery_date)
        THEN 'С опозданием'
        ELSE 'Вовремя'
    END AS качество_доставки,
    COUNT(*) AS количество_заказов,
    SUM(CASE WHEN r.средняя_оценка <= 2 THEN 1 ELSE 0 END) AS негативные,
    ROUND(
        100.0 * SUM(CASE WHEN r.средняя_оценка <= 2 THEN 1 ELSE 0 END)
        / COUNT(*), 2) AS доля_негативных,
    SUM(CASE WHEN r.средняя_оценка = 3 THEN 1 ELSE 0 END) AS нейтральные,
    ROUND(
        100.0 * SUM(CASE WHEN r.средняя_оценка = 3 THEN 1 ELSE 0 END)
        / COUNT(*), 2) AS доля_нейтральных,
    SUM(CASE WHEN r.средняя_оценка >= 4 THEN 1 ELSE 0 END) AS положительные,
    ROUND(
        100.0 * SUM(CASE WHEN r.средняя_оценка >= 4 THEN 1 ELSE 0 END)
        / COUNT(*), 2) AS доля_положительных
FROM olist_orders_dataset o
JOIN (
    SELECT
        order_id,
        AVG(review_score) AS средняя_оценка
    FROM olist_order_reviews_dataset
    GROUP BY order_id) AS r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY качество_доставки;