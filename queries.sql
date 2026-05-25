-- reports sample
SELECT
    Delivery_Service.service_name,
    COUNT(*) AS total_orders
FROM Orders
JOIN Delivery_Service
    ON Orders.delivery_service_id = Delivery_Service.delivery_service_id
GROUP BY Delivery_Service.service_name;