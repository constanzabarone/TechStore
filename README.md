# sql-select-fundamentals
## ¿Por qué es mala práctica usar SELECT * en producción?

No es recomendable utilizar SELECT * en producción porque estamos solicitando toda la información de una tabla, aunque muchas veces solo necesitemos algunos datos. Esto puede hacer que la consulta sea más lenta y consuma recursos innecesariamente.

Además, seleccionar solamente las columnas que necesitamos hace que la consulta sea más clara y fácil de mantener. También evitamos mostrar información que no necesitamos y que podría ser sensible.


## ¿Por qué son importantes los alias para un stakeholder no técnico?

Los alias permiten cambiar temporalmente el nombre de una columna para que sea más fácil de interpretar por una persona que no conoce los nombres técnicos de la base de datos.

Por ejemplo, en lugar de mostrar una columna llamada `total_amount`, podemos utilizar:

`total_amount AS monto_total`

De esta manera, una persona del equipo de finanzas puede entender rápidamente qué información está viendo, sin necesidad de conocer cómo están nombradas las columnas originalmente en la base de datos.
