#Se cargan los datos del archivo 
datos_vinos <- read.csv("files/estadisticas_vinos.csv")

#Exploración Inicial de los Datos:

#Se muestra la primer parte del archivo 
head(datos_vinos)

#Estructura de la tabla
str(datos_vinos)

#Ver datos de variables
View(datos_vinos)

#resumen de los datos estadisticos

#saca la mediana, nulos, y cuartiles
summary(datos_vinos$points)
summary(datos_vinos$price)


mean(datos_vinos$price, na.rm = TRUE) #media
median(datos_vinos$price, na.rm = TRUE) #mediana


#Limpieza y Tratamiento de Datos:

#detectar valores duplicados 
sum(duplicated(datos_vinos))


#cambiar un dato nulo por la media y redondeada
datos_vinos$price[is.na(datos_vinos$price)] <- round(mean(datos_vinos$price, na.rm = TRUE))



# #Eliminar datos "Desconocidos" de las columnas
datos_vinos$designation <- replace(datos_vinos$designation, is.na(datos_vinos$designation) | datos_vinos$designation== "", "Desconocido")
datos_vinos$province <- replace(datos_vinos$province, is.na(datos_vinos$province) | datos_vinos$province== "", "Desconocido")
datos_vinos$country <- replace(datos_vinos$country, is.na(datos_vinos$designation) | datos_vinos$designation== "", "Desconocido")
datos_vinos$region_1 <- replace(datos_vinos$region_1, is.na(datos_vinos$region_1) | datos_vinos$region_1== "", "Desconocido")



#calcula cuartiles, limites, rango intercuatilico, elimina valores atipicos 
eliminar_atipicos <- function(datos, columna, coeficiente = 1.5) {
  Q1 <- quantile(datos[[columna]], 0.25, na.rm = TRUE)
  Q3 <- quantile(datos[[columna]], 0.75, na.rm = TRUE)
  IQR_columna <- Q3 - Q1
  limite_inferior <- Q1 - coeficiente * IQR_columna
  limite_superior <- Q3 + coeficiente * IQR_columna
  datos_filtrados <- datos[datos[[columna]] >= limite_inferior & datos[[columna]] <= limite_superior, ]
  return(datos_filtrados)
}

datos_vinos <- eliminar_atipicos(datos_vinos, "price")

datos_vinos <- eliminar_atipicos(datos_vinos, "points")


#reemplaza los valores fuera del diagrama por el cuartil mas cercano
replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
  iqr <- qrts[2]-qrts[1]
  h <- 1.5 * iqr
  x[x<qrts[1]-h] <- caps[1]
  x[x>qrts[2]+h] <- caps[2]
  x
}

datos_vinos$price <- replace_outliers(datos_vinos$price)




#Visualización de datos

#Cajas de dispercion 

boxplot(datos_vinos$price, main = "Diagrama de Caja de Precio", ylab = "Precio", col = "lightgreen")

boxplot(datos_vinos$points, main = "Diagrama de Caja de Puntos", ylab = "Puntos", col = "lightgreen")


#Histograma 
hist(datos_vinos$points, main = "Histograma de Puntuaciones de Vinos", xlab = "Puntuación", ylab = "Frecuencia")


# Crear vectores con los datos de cada columna
country <- c("US","France","Italy","Spain")
points <- c(88, 87, 90, 89)
price <- c(37,20,25,15)



# Crear un data frame con las variables country, points y price
library(ggplot2)

agrupacion_1 <- data.frame(
  country = c("US", "France", "Italy", "Spain"),
  points = c(88, 87, 90, 89),
  price = c(37, 20, 25, 15)
)


#Grafico pais por puntuacion
grafico <- ggplot(agrupacion_1, aes(x = country, y = points, fill = country)) +
  geom_bar(stat = "identity") +
  labs(title = "Puntuación por País", x = "País", y = "Puntuación") +
  theme_minimal()


print(grafico)

#Grafico pais por precio
grafico <- ggplot(agrupacion_1, aes(x = country, y = price, fill = country)) +
  geom_bar(stat = "identity") +
  labs(title = "Precio por País", x = "País", y = "Precio") +
  theme_minimal()


print(grafico)



#Análisis de Relaciones de Datos:

#Bivariable
precio_promedio <- aggregate(price ~ country, data=datos_vinos, FUN=mean)

# Crear un gráfico de barras
barplot(precio_promedio$price, names.arg=precio_promedio$country,
        main="Comparación de Precios Promedio por País de Origen",
        xlab="País de Origen", ylab="Precio Promedio")


#Univariable

tabla_frecuencias <- table(datos_vinos$country)

# Mostrar la tabla de frecuencias
print(tabla_frecuencias)


# Crear un gráfico de barras
barplot(tabla_frecuencias, 
        main="Distribución de Países de Origen",
        xlab="País de Origen", ylab="Frecuencia")








