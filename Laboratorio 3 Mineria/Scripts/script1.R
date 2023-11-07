#Se cargan los datos del archivo 
datos_vinos <- read.csv("files/estadisticas_vinos.csv")

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

#detectar valores duplicados 
sum(duplicated(datos_vinos))


#cambiar un dato nulo por la media y redondeada
datos_vinos$price[is.na(datos_vinos$price)] <- round(mean(datos_vinos$price, na.rm = TRUE))

#Ver los nulos por columnas
sapply(datos_vinos, function(x) sum(is.na(x)))
sapply(datos_vinos, function(x) sum(x == ""))

# Cambiamos los valores en blanco por columna 
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

#datos_vinos <- eliminar_atipicos(datos_vinos, "points")

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

#datos_vinos$points <- replace_outliers(datos_vinos$points)





#Cajas de dispercion 

boxplot(datos_vinos$price, main = "Diagrama de Caja de Precio", ylab = "Precio", col = "lightgreen")

boxplot(datos_vinos$points, main = "Diagrama de Caja de Puntos", ylab = "Puntos", col = "lightgreen")


#HISTOGRAMAS 
hist(datos_vinos$points, main = "Histograma de Puntuaciones de Vinos", xlab = "Puntuación", ylab = "Frecuencia")


#DIAGRAMA DE DISPERCION precio vrs puntuacion
plot(datos_vinos$price, datos_vinos$points, main = "Precio vs. Puntuación", xlab = "Precio", ylab = "Puntuación")

#Diagrama de barras
barplot(table(datos_vinos$region_1), main = "Cantidad de Vinos por Región", xlab = "Región", ylab = "Cantidad de Vinos")







