# Documentación de Laboratorio 3 

## Michelle Castrillo, Yordi Morales 

Se utilizó el archivo de Estadisticas vino, se encontraron datos nulos en la columna precio y valores en blanco en las la mayoria de las columnas de texto 

![image](./Imagenes/Valores_Nulos.png "Valores nulos")

Se encontraron 932 nulos en precio, y las columnas ´Designation´, ´Province´, ´Region_1´, ´Country´ tienen valores en blanco

![image](./Imagenes/Cantidad_Nulos.png "Cantidad de nulos y en blanco")

Analisis de la columna precio y puntos

![image](./Imagenes/Media-cuartiles-min-max.png "Cantidad de nulos y en blanco")


Se cambian los valores en blanco por ´Desconocido´

![image](./Imagenes/Desconocido.png "Desconocido")

Caja de dispersión de precio con valores nulos y atipicos 

![image](./Imagenes/Precio_Nulos.png "Cantidad de nulos y atipicos")

Por tanto, se decide cambiar los valores nulos de precio por la media. A continuación, una caja de dispersión de precio sin valores nulos y con valores atipicos. 

![image](./Imagenes/Precio_Atipicos.png "Cantidad atipicos")

Se eliminan los valores atipicos por el valor del cuartil mas cercano. 

![image](./Imagenes/Precio_Corregido.png "Precio corregido")


Caja de dispersión de puntos con atipicos 

![image](./Imagenes/Puntos_Atipicos.png "Cantidad de nulos y en blanco")

Caja de dispersion de puntos sin atipicos

![image](./Imagenes/Puntos-sin-valores-atipicos.jpeg "Puntos sin atipicos")



Comparacion de precios por pais de origne

![image](./Imagenes/Analisis-bivariable.png)

Puntuacion por pais

Se hizo 4 vectores con los 4 datos mas repetitivos de la columna(pais,puntuacion y precio) se llego al analisis de que Italia es el mejor pais en vinos

![image](./Imagenes/Puntos-por-pais.png)

Y con los precios mas altos es Estados Unidos

![image](./Imagenes/Precio-por-pais.png)
