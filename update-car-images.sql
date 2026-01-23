-- Update Cars Table to add image_url column if it doesn't exist
ALTER TABLE cars ADD COLUMN IF NOT EXISTS image_url VARCHAR(500);

-- Update existing cars with image URLs
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1552820728-8ac41f1ce891?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Toyota' AND model = 'Camry';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1609708536965-bc6e90a279ba?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Honda' AND model = 'Civic';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1554744512-d2c5c7da7dc8?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Hyundai' AND model = 'Elantra';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1559056169-641ef7e3b404?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Mazda' AND model = 'Mazda3';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1517524008697-20bcc1f72e16?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Nissan' AND model = 'Altima';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Ford' AND model = 'Focus';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1552272412-c1ca2c9c2934?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Volkswagen' AND model = 'Golf';
UPDATE cars SET image_url = 'https://images.unsplash.com/photo-1571868552521-9b24ce49f1d1?auto=format&fit=crop&q=80&w=600' WHERE brand = 'Kia' AND model = 'Cerato';

-- Verify the updates
SELECT car_id, brand, model, image_url FROM cars;
