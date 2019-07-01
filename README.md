# La huerta de Toni - Defensa del TP

## Extensión al modelo

### Trigo enano
Toni decidió agregar una nueva planta a sus cultivos. Las tres especies que hasta el momento produce Toni son: _maíz_, _trigo_ y _tomaco_.
La nueva planta es una variedad de _trigo_ muy buscada que se llama _**trigo enano**_.

Al venderse un _**trigo enano**_ se obtienen 120 monedas más de oro que lo que correspondería a un trigo normal en las mismas condiciones. Por ejemplo, al venderse un trigo enano en etapa de evolución 2 se obtienen 220 monedas, en lugar de 100 que es lo que corresponde a un trigo normal.

Pero el _**trigo enano**_ también es particularmente sensible a la escarcha, si está escarchado **NO** se puede cosechar. Agregar un método `escarchar()` que lo deje escarchado. 

Por último, cuando se riega un _**trigo enano**_, además de pasar de etapa como cualquier trigo, se le va la escarcha.


 ### Valor de mercado
 Agregar a todas las plantas el método `valorDeMercado()` que determina el **valor de mercado** de la planta. 
 El **valor de mercado** de cada planta se define así:
- si la planta está lista para cosechar, entonces es 0;
- si no, es el 80% de las monedas de oro que produce la planta al ser vendida. La cuenta es: `oro * 0.8`.

### Conviene cosechar
Agregar a Toni el método `convieneCosechar()` que determina si le conviene cosechar o no.
A Toni le conviene cosechar si todas las plantas que tiene sembradas están listas para cosechar.

## Test de la extensión
Realizar los siguientes tests:
- Verificar las monedas de oro obtenidas al venderse un _**trigo enano**_ cuando se encuentre en la etapa de evolución 2 y 3.
- Escarchar un _**trigo enano**_, luego regarlo, y por ultimo validar que ya no se encuentre escarchado.
- Controlar el valor de mercado para cada tipo de planta, _maíz_, _trigo_,  _tomaco_ y _trigo enano_, estén listas o no para cosechar.
- Consultar si a Toni le conviene cosechar o no, primero con todas las plantas listas para ser cosechadas y luego con algunas listas y otras no.
