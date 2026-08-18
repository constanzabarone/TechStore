# Pipeline ETL en Power BI

## Entrega Módulo 6

En esta entrega desarrollé un proceso ETL en Power BI utilizando Power Query, partiendo de un archivo Excel con información de clientes, productos, ventas y categorías.

El objetivo fue importar los datos, analizar su calidad, realizar las transformaciones necesarias y dejar las tablas preparadas para su posterior utilización en Power BI.

---

## 1. Importación de los datos

El proceso comenzó con la conexión al archivo Excel desde Power BI mediante la opción **Obtener datos**.

Se importaron las cuatro hojas disponibles en el archivo:

- clientes
- productos
- ventas
- categorias

### Evidencia

<img width="698" height="388" alt="image" src="https://github.com/user-attachments/assets/9f2e93a3-d66b-4519-85b9-4fbf966405e4" />


Luego se verificaron y seleccionaron las cuatro hojas desde el Navegador de Power BI antes de ingresar a Power Query.

<img width="698" height="392" alt="image" src="https://github.com/user-attachments/assets/6ec90f6c-906f-4a33-bfd0-7dc66d365bdb" />


---

## 2. Análisis inicial de calidad de datos

Antes de comenzar con las transformaciones, utilicé las herramientas de perfilado de Power Query para revisar la calidad de los datos.

Esto permitió detectar, entre otros problemas:

- registros duplicados;
- valores nulos;
- filas sin identificador;
- campos descriptivos incompletos;
- tipos de datos que debían corregirse.

### Evidencia

<img width="698" height="382" alt="image" src="https://github.com/user-attachments/assets/217201c5-cf1b-4f66-b597-3b6e9697ff12" />


A partir de este análisis tomé distintas decisiones según la importancia de cada campo. No todos los valores nulos fueron tratados de la misma manera, ya que su impacto depende del tipo de dato y de su función dentro del modelo.

---

## 3. Limpieza y transformación

### Dim_Clientes

En la tabla de clientes se realizaron las siguientes transformaciones:

- Promoción de encabezados.
- Asignación de tipos de datos.
- Eliminación de duplicados utilizando `id_cliente`.
- Reemplazo de valores nulos en `email` por **"Sin datos"**.
- Reemplazo de valores nulos en `ciudad` por **"Sin datos"**.
- Eliminación del registro que no tenía `id_cliente`.
- Conversión de `fecha_registro` al tipo Fecha.

La decisión de eliminar el registro sin `id_cliente` se debe a que este campo funciona como identificador del cliente y es necesario para poder relacionarlo correctamente con las ventas.

En cambio, los nulos de `email` y `ciudad` se conservaron como registros válidos y se reemplazaron por **"Sin datos"**, ya que la ausencia de esos atributos descriptivos no justifica eliminar al cliente completo.

---

### Dim_Productos

En la tabla de productos se realizaron tareas de limpieza y control similares:

- Promoción de encabezados.
- Eliminación de registros duplicados por `id_producto`.
- Tratamiento de la categoría faltante como **"Sin categoría"**.
- Corrección de los tipos de datos.
- Revisión del precio nulo detectado.

En el caso del precio faltante se decidió conservar el valor como `null` en lugar de reemplazarlo por 0. Esta decisión evita interpretar la ausencia de información como si el producto tuviera realmente un precio igual a cero.
Luego de la limpieza, `Dim_Productos` quedó con **12 registros**.

---

### Dim_Categorias

La tabla de categorías fue revisada y tipada correctamente.

La consulta quedó compuesta por **4 registros**, correspondientes a las categorías disponibles en el dataset.

---

### Fact_Ventas

En la tabla de ventas se verificaron y corrigieron los tipos de datos de acuerdo con el contenido de cada columna:

- IDs y cantidades: número entero.
- `fecha_venta`: fecha.
- precios, descuentos y totales: número decimal.
- `canal`: texto.

### Evidencia de tipos de datos

<img width="698" height="491" alt="image" src="https://github.com/user-attachments/assets/517f6120-17d9-4a00-ab17-51530ecba0a9" />


---

## 4. Combinación de consultas

Para enriquecer la tabla `Fact_Ventas` con información descriptiva de los productos, realicé un Merge entre:

**Fact_Ventas → Dim_Productos**

utilizando `id_producto` como campo de coincidencia.

Se utilizó una combinación **Externa izquierda (Left Outer)** para conservar todos los registros de ventas y agregar la información del producto cuando existiera una coincidencia.

### Evidencia del Merge

<img width="304" height="272" alt="image" src="https://github.com/user-attachments/assets/c69af622-199a-4b84-8b4c-a6d30bc701b5" />



Luego de realizar la combinación, expandí únicamente las columnas:

- `nombre_producto`
- `categoria`

No se expandieron el resto de los campos de `Dim_Productos` porque no eran necesarios para el objetivo de esta transformación y se buscó evitar incorporar información redundante.

### Evidencia de expansión

<img width="451" height="448" alt="image" src="https://github.com/user-attachments/assets/6891cab6-69d7-4729-8e0b-3ba8fe2fc115" />
<img width="438" height="801" alt="image" src="https://github.com/user-attachments/assets/7b367865-97c9-40bb-b6a1-0d85424f2ac1" />


El resultado final de `Fact_Ventas` mantiene las **50 ventas originales** y agrega los atributos descriptivos seleccionados.

---

## 5. Documentación del proceso en lenguaje M

Además de utilizar la interfaz gráfica de Power Query, revisé el código M generado en el Editor Avanzado.

Se renombraron pasos para que fueran más descriptivos y se incorporaron comentarios con `//` explicando las principales decisiones técnicas tomadas durante la transformación.

### Dim_Clientes

Se documentaron, entre otras decisiones:

- eliminación de duplicados;
- tratamiento de valores nulos;
- eliminación de registros sin clave;
- asignación de tipos de datos.

<img width="698" height="452" alt="image" src="https://github.com/user-attachments/assets/34836b30-e466-4c72-b858-7158160fc3fb" />
<img width="310" height="270" alt="image" src="https://github.com/user-attachments/assets/41c8325a-201e-41f8-8a43-43a77e6ac287" />


### Fact_Ventas

También se documentaron los pasos correspondientes a:

- asignación de tipos;
- Merge con `Dim_Productos`;
- elección de la combinación Left Outer;
- expansión de `nombre_producto` y `categoria`.

<img width="698" height="452" alt="image" src="https://github.com/user-attachments/assets/2cacbc2d-87b6-4f32-8d53-1def9fff0cb4" />
<img width="304" height="272" alt="image" src="https://github.com/user-attachments/assets/e7ee33c4-6878-4e03-af12-756fa107478d" />


---

## 6. Resultado del pipeline ETL

Una vez finalizadas las transformaciones, se utilizó **Cerrar y aplicar** para cargar los resultados en Power BI.

### Evidencia

<img width="691" height="369" alt="image" src="https://github.com/user-attachments/assets/ddd762a5-b660-48cd-b3b1-87ceb44eb75e" />


El resultado final contiene las siguientes consultas:

| Consulta | Filas finales |
|---|---:|
| Dim_Clientes | 11 |
| Dim_Productos | 12 |
| Dim_Categorias | 4 |
| Fact_Ventas | 50 |

Las cuatro tablas quedaron cargadas sin errores y con la nomenclatura `Dim_` y `Fact_` correspondiente.

### Modelo cargado en Power BI

<img width="698" height="372" alt="image" src="https://github.com/user-attachments/assets/c27eeab1-1587-4ae9-bcd7-526eb9626592" />


En esta instancia el objetivo principal fue desarrollar y documentar el pipeline ETL. La construcción definitiva del modelo analítico y sus relaciones se continuará en la etapa de modelado correspondiente.

---

## Conclusión

Esta práctica me permitió trabajar el proceso ETL completo dentro de Power BI: desde la importación y evaluación inicial de la calidad de los datos hasta su limpieza, tipado, combinación y carga final.

Una de las principales conclusiones del ejercicio es que la limpieza de datos no consiste solamente en eliminar nulos o duplicados. Cada decisión debe analizarse según el significado del campo. Por ejemplo, un cliente sin email puede seguir siendo un registro válido, mientras que un registro sin `id_cliente` no puede identificarse ni relacionarse correctamente.

También pude aplicar un Merge entre consultas y trabajar directamente sobre el código M generado por Power Query, agregando nombres descriptivos y comentarios para que el proceso sea más fácil de entender, mantener y revisar.
