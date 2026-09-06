# RetailPro - Análisis de Ventas

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos comerciales desarrollado con SQL Server y Power BI.

El objetivo es organizar e integrar información de ventas, clientes, productos, categorías y territorios para analizar la facturación, el comportamiento de los clientes, el desempeño de los productos y los diferentes canales de venta.

## Herramientas utilizadas

- SQL Server
- SQL Server Management Studio (SSMS)
- Power BI
- GitHub

## Principales análisis

El proyecto incluye consultas para analizar:

- Facturación y cantidad de pedidos.
- Ranking de productos por facturación y unidades vendidas.
- Clientes recurrentes.
- Ventas respecto del promedio.
- Información integrada de ventas, clientes, productos, categorías y territorios.
- Clientes registrados sin ventas.
- Productos sin ventas.
- Facturación por canal Online y Presencial.

## Ejecución de los scripts SQL

1. Abrir SQL Server Management Studio (SSMS).
2. Conectarse a SQL Server.
3. Seleccionar la base `Ventas_Tech_DB`.
4. Ejecutar los scripts respetando el orden de los módulos.
5. Ejecutar las consultas de análisis.
6. Validar los resultados antes de utilizarlos como fuente para Power BI.

Por ejemplo, `m4_consultas_negocio.sql` contiene las consultas orientadas al análisis comercial y `m5_consultas_joins.sql` incorpora la integración de las diferentes tablas y los análisis mediante JOIN y UNION ALL.

## Validación de datos

Antes de utilizar los resultados se recomienda verificar:

- La cantidad de registros obtenidos.
- Que las relaciones entre las tablas sean correctas.
- Que los JOIN no eliminen registros necesarios para el análisis.
- Que los totales calculados coincidan con los datos de origen.
- Que no existan valores duplicados o faltantes que puedan modificar las conclusiones.

## Limitaciones

Los datos utilizados actualmente corresponden a una base de tamaño reducido y a un período limitado. Por este motivo, los resultados sirven para desarrollar y validar el proceso analítico, pero no deberían generalizarse a períodos más amplios sin incorporar nuevos datos.

## Continuidad del proyecto

Otro analista puede continuar el proyecto incorporando nuevos períodos de ventas y profundizando los indicadores existentes.

También sería posible agregar información de costos y márgenes para diferenciar facturación de rentabilidad, ampliar el análisis de clientes y productos y desarrollar nuevas visualizaciones en Power BI.
