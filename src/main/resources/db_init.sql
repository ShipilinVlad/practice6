-- Практическая работа №6.
-- Перед выполнением создайте базу данных productdb.
-- Например, в psql: CREATE DATABASE productdb;

-- Таблица продуктов из практической работы №4.
CREATE TABLE IF NOT EXISTS product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    calories INT NOT NULL CHECK (calories > 0)
);

-- Таблицы пользователей и ролей для Spring Security.
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

INSERT INTO roles (role_name)
VALUES ('ROLE_USER')
ON CONFLICT (role_name) DO NOTHING;

INSERT INTO roles (role_name)
VALUES ('ROLE_ADMIN')
ON CONFLICT (role_name) DO NOTHING;

-- Предусмотренный пользователь-администратор.
-- Пароль администратора: admin123.
-- Хэш получен BCryptPasswordEncoder из Spring Security 5.8.
INSERT INTO users (username, password, enabled)
VALUES (
    'admin',
    '$2a$10$MUEaHdbXA4zMSWYENOcvUeZtq45mQiiiXfZbFgFtCbDhL8Fqef1MC',
    TRUE
)
ON CONFLICT (username) DO UPDATE
SET password = EXCLUDED.password,
    enabled = TRUE;

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u
JOIN roles r ON r.role_name = 'ROLE_ADMIN'
WHERE u.username = 'admin'
ON CONFLICT (user_id, role_id) DO NOTHING;

-- Начальные записи продуктов для демонстрации работы.
-- Повторный запуск скрипта не создает дубликаты.
INSERT INTO product (name, category, manufacturer, price, calories)
SELECT v.name, v.category, v.manufacturer, v.price, v.calories
FROM (VALUES
    ('Яблоки', 'Фрукты', 'Ферма "Сад"', 89.99, 52),
    ('Молоко', 'Молочные продукты', 'Молочный комбинат', 75.50, 42),
    ('Хлеб белый', 'Хлебобулочные изделия', 'Хлебзавод №1', 45.00, 265),
    ('Куриное филе', 'Мясо', 'Птицефабрика "Рассвет"', 320.00, 165),
    ('Картофель', 'Овощи', 'Агрофирма "Поле"', 55.00, 77),
    ('Сыр Гауда', 'Молочные продукты', 'Сыродельный завод', 450.00, 356),
    ('Шоколад молочный', 'Сладости', 'Кондитерская фабрика', 120.00, 546),
    ('Йогурт клубничный', 'Молочные продукты', 'Молочный комбинат', 65.00, 98),
    ('Помидоры', 'Овощи', 'Тепличный комплекс', 180.00, 18),
    ('Гречневая крупа', 'Крупы', 'Крупяной завод', 95.00, 343)
) AS v(name, category, manufacturer, price, calories)
WHERE NOT EXISTS (SELECT 1 FROM product);
