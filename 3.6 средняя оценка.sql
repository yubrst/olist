SELECT
    CASE
        WHEN DATE(o.order_delivered_customer_date) >
             DATE(o.order_estimated_delivery_date)
        THEN 'С опозданием'
        ELSE 'Вовремя'
    END AS качество_доставки,
    COUNT(*) AS количество_заказов,
    ROUND(AVG(r.средняя_оценка), 2) AS средняя_оценка
FROM olist_orders_dataset o
JOIN (SELECT
        order_id,
        AVG(review_score) AS средняя_оценка
    FROM olist_order_reviews_dataset
    GROUP BY order_id) r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY качество_доставки