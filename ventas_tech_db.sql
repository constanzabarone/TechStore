-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Constanza Barone
-- Fecha: 28/07/2026
-- ══════════════════════════════════════════
/* Consulta 1
Utilizo SELECT * porque en este caso quiero explorar la tabla completa y conocer
todas sus columnas. Es útil para una primera exploración, pero no es recomendable
cuando solo necesitamos datos específicos, ya que puede traer información innecesaria
y afectar el rendimiento.
*/
-- Consulta 1: Exploración general de la tabla sales

SELECT * FROM sales;


/* Consulta 2
Selecciono únicamente los datos que necesita el equipo de finanzas:
cliente, producto y monto de la venta.
*/
-- Consulta 2: Selección de columnas específicas para finanzas

SELECT 
    customer_id,
    product_id,
    total_amount 
FROM sales;

/* Consulta 3
Utilizo alias para presentar los nombres de las columnas en español y hacer
que el resultado sea más claro para usuarios no técnicos.
*/
-- Consulta 3: Selección con alias en español para stakeholders

SELECT 
    order_date AS fecha_pedido,
    product_name AS nombre_producto,
    quantity AS cantidad_unidades
FROM sales;

