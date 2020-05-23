"
Proyecto Final
Métodos Computacionales para las Políticas Públicas (MCPP)

Alejandro Nieves

Evaluación espacial de los paraderos del SITP en Bogotá
"

# Fijar la ruta

setwd("C:/Users/MANB/Documents/Rosario/MCPP/Proyecto")

# Importar base de datos

base_cenefas <- read.csv("~/Rosario/MCPP/Proyecto/Frecuencia paraderos.csv", encoding="UTF-8")

# Estadísticas descriptivas

table(base_cenefas$Frecuencia)

# Crear variable categórica de tipos de paraderos
"
Tipo 1: De 1 a 2 rutas
Tipo 2: De 3 a 5 rutas
Tipo 3: De 6 a 8 rutas
Tipo 4: De 9 a 11 rutas
Tipo 5: De 12 a 20 rutas
"

base_cenefas$tipo <- ifelse(base_cenefas$Frecuencia == 0, 0, ifelse(base_cenefas$Frecuencia >= 1 & base_cenefas$Frecuencia <= 2, 1, ifelse(base_cenefas$Frecuencia >= 3 & base_cenefas$Frecuencia <= 5, 2, ifelse(base_cenefas$Frecuencia >= 6 & base_cenefas$Frecuencia <= 8, 3, ifelse(base_cenefas$Frecuencia >= 9 & base_cenefas$Frecuencia <= 11, 4, ifelse(base_cenefas$Frecuencia >= 12, 5, 10))))))
table(base_cenefas$tipo)

# Porcentaje según tipo de paradero

cenefaProp <- table(base_cenefas$tipo)
paraderoTipos <- cbind(cenefaProp,(prop.table(cenefaProp)*100))
paraderoTipos

# Crear dummies para cada categoría

install.packages("dummies")
library(dummies)
data <- cbind(base_cenefas, dummy(base_cenefas$tipo))

# Guardar bases de datos

write.csv(data, "base_cenefas.csv", fileEncoding="UTF-8")

"
Estadísticas de los datos obtenidos en QGIS.
En QGIS generé el conteo de paraderos según el tipo para diferentes niveles de agregación geográfica
En esta parte generaré las proporciones
"

setwd("C:/Users/MANB/Documents/Rosario/MCPP/Proyecto/Estadísticas")
getwd()

# Localidades

Localidades_Stats <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Localidades/Localidades - Stats.csv")

Localidades_Stats <- cbind(Localidades_Stats, q = Localidades_Stats[, 7:12] / Localidades_Stats$pt)

View(Localidades_Stats)
write.csv(Localidades_Stats, "~/Rosario/MCPP/Proyecto/Estadísticas/Localidades/Localidades - Stats.csv", fileEncoding="UTF-8")

# UPZ

UPZ_Stats <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/UPZ/UPZ - Stats.csv")
UPZ_Stats <- cbind(UPZ_Stats, q = UPZ_Stats[, 40:45] / UPZ_Stats$pt)

View(UPZ_Stats)
write.csv(UPZ_Stats, "~/Rosario/MCPP/Proyecto/Estadísticas/UPZ/UPZ - Stats.csv", fileEncoding="UTF-8")

# Zonas SITP

Zonas_Stats <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Zonas SITP/Zonas - Stats.csv")
Zonas_Stats <- Zonas_Stats[order(Zonas_Stats$NOMBRE_ZON),]

zonas_names <- c("Neutra", "Usaquén", "Suba Oriental", "Suba Centro", "Calle 80", "Engativá", "Fontibón", "Tintal-Zona Franca", "Kennedy", "Bosa", "Perdomo", "Ciudad Bolívar", "Usme", "San Cristóbal")

Zonas_Stats <- cbind(Zonas_Stats, zonas_names)

Zonas_Stats <- cbind(Zonas_Stats, q = Zonas_Stats[, 11:16] / Zonas_Stats$pt)

View(Zonas_Stats)
write.csv(Zonas_Stats, "~/Rosario/MCPP/Proyecto/Estadísticas/Zonas SITP/Zonas - Stats.csv", fileEncoding="UTF-8")

# Estratos

tipo0 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo0 - Stats.csv")
tipo0 <- tipo0[order(tipo0$ESTRATO),]
tipo0 <- tipo0[,1:2]
colnames(tipo0) <- c("Estrato","tipo0")

tipo1 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo1 - Stats.csv")
tipo1 <- tipo1[order(tipo1$ESTRATO),]
tipo1 <- tipo1[,1:2]
colnames(tipo1) <- c("Estrato","tipo1")

tipo2 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo2 - Stats.csv")
tipo2 <- tipo2[order(tipo2$ESTRATO),]
tipo2 <- tipo2[,1:2]
colnames(tipo2) <- c("Estrato","tipo2")

tipo3 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo3 - Stats.csv")
tipo3 <- tipo3[order(tipo3$ESTRATO),]
tipo3 <- tipo3[,1:2]
colnames(tipo3) <- c("Estrato","tipo3")

tipo4 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo4 - Stats.csv")
tipo4 <- tipo4[order(tipo4$ESTRATO),]
tipo4 <- tipo4[,1:2]
colnames(tipo4) <- c("Estrato","tipo4")

tipo5 <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Tipo5 - Stats.csv")
tipo5 <- tipo5[,1:2]
colnames(tipo5) <- c("Estrato","tipo5")

tipo5 <- rbind(tipo5, c(1, 0), c(5, 0))
tipo5 <- tipo5[order(tipo5$Estrato),]

# Unir la base de los estratos
Estratos <- cbind(tipo0, tipo1, tipo2, tipo3, tipo4, tipo5)
Estratos <- Estratos[, !duplicated(colnames(Estratos))]

colnms=c("tipo0", "tipo1", "tipo2", "tipo3", "tipo4", "tipo5")
Estratos$tipot<-rowSums(Estratos[,colnms])

Estratos <- cbind(Estratos, q = Estratos[, 2:7] / Estratos$tipot)
write.csv(Estratos, "~/Rosario/MCPP/Proyecto/Estadísticas/Estratos/Estratos - Stats.csv", fileEncoding="UTF-8")