SELECT MAX(price)FROM order_items WHERE price < (SELECT MAX(price) FROM order_items);