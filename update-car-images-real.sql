-- Update car images with real working URLs from Unsplash
USE used_car_marketplace;

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Toyota';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600' WHERE brand = 'BMW';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1609708536965-bc6e90a279ba?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Honda';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1606152421802-db97b9c7a11b?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Audi';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Porsche';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Ford';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1554744512-d2c5c7da7dc8?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Hyundai';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1559056169-641ef7e3b404?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Mazda';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1517524008697-20bcc1f72e16?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Nissan';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1552272412-c1ca2c9c2934?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Volkswagen';

UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1571868552521-9b24ce49f1d1?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Kia';

-- Verify the updates
SELECT car_id, brand, model, image_url FROM cars;
