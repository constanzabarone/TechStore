-- =====================================================
-- PROYECTO RETAILPRO
-- MÓDULO 5 - CONSULTAS CON JOINS Y UNION ALL
-- Archivo: m5_consultas_joins.sql
-- Autora: Constanza Romina Barone
-- =====================================================

USE Ventas_Tech_DB;
GO

IF OBJECT_ID('territorios', 'U') IS NULL
BEGIN
    CREATE TABLE territorios (
        id_territorio INT PRIMARY KEY,
        region VARCHAR(50) NOT NULL
    );
END;
GO

SELECT *
FROM territorios;

-- =====================================================
-- CARGA DE DATOS EN TERRITORIOS
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM territorios
    WHERE id_territorio = 1
)
BEGIN
    INSERT INTO territorios (
        id_territorio,
        region
    )
    VALUES
    (1, 'Buenos Aires'),
    (2, 'Centro'),
    (3, 'Litoral'),
    (4, 'Cuyo'),
    (5, 'Norte');
END;
GO

-- =====================================================
-- ADAPTACIÓN DE LA TABLA CLIENTES
-- =====================================================

IF COL_LENGTH('clientes', 'segmento') IS NULL
BEGIN
    ALTER TABLE clientes
    ADD segmento VARCHAR(50);
END;
GO

IF COL_LENGTH('clientes', 'id_territorio') IS NULL
BEGIN
    ALTER TABLE clientes
    ADD id_territorio INT;
END;
GO

SELECT *
FROM clientes;

-- =====================================================
-- ACTUALIZACIÓN DE SEGMENTO Y TERRITORIO DE CLIENTES
-- =====================================================

UPDATE clientes
SET segmento = 'Minorista', id_territorio = 1
WHERE id_cliente = 1;

UPDATE clientes
SET segmento = 'Empresa', id_territorio = 2
WHERE id_cliente = 2;

UPDATE clientes
SET segmento = 'Minorista', id_territorio = 3
WHERE id_cliente = 3;

UPDATE clientes
SET segmento = 'Empresa', id_territorio = 4
WHERE id_cliente = 4;

UPDATE clientes
SET segmento = 'Minorista', id_territorio = 5
WHERE id_cliente = 5;
GO

SELECT *
FROM clientes;

-- =====================================================
-- RELACIÓN ENTRE CLIENTES Y TERRITORIOS
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_Clientes_Territorios'
)
BEGIN
    ALTER TABLE clientes
    ADD CONSTRAINT FK_Clientes_Territorios
    FOREIGN KEY (id_territorio)
    REFERENCES territorios(id_territorio);
END;
GO

SELECT
    c.nombre,
    c.segmento,
    t.region
FROM clientes AS c
INNER JOIN territorios AS t
    ON c.id_territorio = t.id_territorio;

-- =====================================================
-- ADAPTACIÓN DE LA TABLA VENTAS
-- =====================================================

IF COL_LENGTH('ventas', 'canal') IS NULL
BEGIN
    ALTER TABLE ventas
    ADD canal VARCHAR(20);
END;
GO

SELECT *
FROM ventas;

UPDATE ventas
SET canal = 'Online'
WHERE id_venta IN (1, 3, 5, 7, 9);

UPDATE ventas
SET canal = 'Presencial'
WHERE id_venta IN (2, 4, 6, 8, 10);
GO

SELECT
    id_venta,
    fecha_venta,
    canal
FROM ventas;

SELECT *
FROM ventas;

-- =====================================================
-- CLIENTE SIN VENTAS
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM clientes
    WHERE id_cliente = 6
)
BEGIN
    INSERT INTO clientes (
        id_cliente,
        nombre,
        email,
        ciudad,
        fecha_registro,
        segmento,
        id_territorio
    )
    VALUES (
        6,
        'Diego Fernández',
        'diego@mail.com',
        'Salta',
        '2024-03-18',
        'Minorista',
        5
    );
END;
GO

SELECT *
FROM clientes;

SELECT *
FROM categorias;

-- =====================================================
-- PRODUCTO SIN VENTAS
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM productos
    WHERE id_producto = 7
)
BEGIN
    INSERT INTO productos (
        id_producto,
        nombre_producto,
        id_categoria,
        precio,
        stock,
        activo
    )
    VALUES (
        7,
        'Webcam Full HD',
        2,
        75.00,
        20,
        1
    );
END;
GO

SELECT *
FROM productos;

SELECT *
FROM clientes;

-- =====================================================
-- CONSULTA 1: VISTA BASE DEL PROYECTO
-- =====================================================
-- Combina ventas, clientes, productos, categorías
-- y territorios para obtener una vista enriquecida.

SELECT
    v.fecha_venta AS fecha,
    c.nombre AS nombre_cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta,
    v.canal
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS ca
    ON p.id_categoria = ca.id_categoria
INNER JOIN territorios AS t
    ON c.id_territorio = t.id_territorio;
GO

-- =====================================================
-- CONSULTA 2: CLIENTES SIN VENTAS
-- =====================================================
-- Identifica clientes registrados que todavía
-- no realizaron ninguna compra.

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO

-- =====================================================
-- CONSULTA 3: PRODUCTOS SIN VENTAS
-- =====================================================
-- Identifica productos del catálogo que todavía
-- no tienen ninguna venta registrada.

SELECT
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS ca
    ON p.id_categoria = ca.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
GO

-- =====================================================
-- CONSULTA 4: CONSOLIDADO DE VENTAS POR CANAL
-- =====================================================
-- Combina las ventas Online y Presencial mediante
-- UNION ALL y calcula el total vendido por canal.

SELECT
    canal,
    SUM(total_venta) AS total_por_canal
FROM (
    SELECT
        v.id_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Online' AS canal
    FROM ventas AS v
    WHERE v.canal = 'Online'

    UNION ALL

    SELECT
        v.id_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Presencial' AS canal
    FROM ventas AS v
    WHERE v.canal = 'Presencial'
) AS ventas_consolidadas
GROUP BY canal;
GO

