-- Motor utilizado: SQL Server
-- Proyecto: Ventas_Tech_DB
-- Autora: Constanza Barone
-- Consulta 1 - Resumen Ejecutivo Mensual-

SELECT 
	MONTH(fecha_venta) AS Mes,
	SUM(cantidad * precio_unitario) AS Total_Facturado,
	COUNT (*) AS Cantidad_Pedidos,
	AVG(cantidad * precio_unitario) AS Ticket_Promedio
FROM dbo.ventas
GROUP BY (fecha_venta)
ORDER BY Mes;


-- Consulta 2 - Ranking de productos-

SELECT TOP 5
	id_producto AS Producto,
	SUM (cantidad * precio_unitario) AS Total_facturado,
	SUM (Cantidad) AS Unidades_vendidas
FROM dbo.ventas
GROUP BY id_producto
ORDER BY Total_facturado DESC;

-- Consulta 3 - Clientes Recurrentes-

SELECT
	id_cliente AS Cliente,
	COUNT (*) AS Cantidad_Pedidos,
	SUM (cantidad * precio_unitario) AS Total_Gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT (*) >1;

-- Consulta 4 - Meses por encima/por debajo del promedio-

WITH ventas_mensuales AS(
SELECT 
	MONTH (fecha_venta) AS Mes,
	SUM (cantidad * precio_unitario) AS Total_Facturado
FROM dbo.ventas
GROUP BY MONTH (fecha_venta)
)
SELECT
	Mes,
	Total_facturado,
	CASE
		WHEN Total_Facturado > (
			SELECT AVG(Total_Facturado)
			FROM ventas_mensuales
)
		THEN 'Por encima'
		ELSE 'Por debajo'
	END AS Estado
FROM ventas_mensuales
ORDER BY Mes;


--Bloque de cierre --
-- ============================================
-- Hallazgos encontrados
-- ============================================

-- 1. El producto 1 fue el de mayor facturación del período,
--    superando ampliamente al resto de los productos analizados.

-- 2. Aunque el producto 2 fue el que más unidades vendió (13),
--    el producto 1 generó una facturación mucho mayor debido a su precio unitario.

-- 3. Todos los clientes registrados realizaron más de un pedido,
--    por lo que pueden considerarse clientes recurrentes durante el período analizado.

