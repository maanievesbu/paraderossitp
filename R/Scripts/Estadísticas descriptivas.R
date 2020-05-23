"
Proyecto Final
Métodos Computacionales para las Políticas Públicas (MCPP)

Alejandro Nieves

Evaluación espacial de los paraderos del SITP en Bogotá

Este script reduce las bases de datos para presentar
la tabla de cada agregación geográfica únicamente con las variables descriptivas.
"

setwd("C:/Users/MANB/Documents/Rosario/MCPP/Proyecto")

# Requirements

library(readr)

# Localidades

Localidades <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Localidades/Localidades - Stats.csv")
keeps <- c("LocNombre","LocCodigo", "p0", "p1", "p2", "p3", "p4", "p5", "pt", "q.p0", "q.p1", "q.p2", "q.p3", "q.p4", "q.p5")
Localidades = Localidades[keeps]

# UPZ

Localidades <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Localidades/Localidades - Stats.csv")
keeps <- c("LocNombre","LocCodigo", "p0", "p1", "p2", "p3", "p4", "p5", "pt", "q.p0", "q.p1", "q.p2", "q.p3", "q.p4", "q.p5")
Localidades = Localidades[keeps]  # Mantener solamente las variables relevantes para las estadísticas descriptivas
Localidades <- Localidades[order(Localidades$pt, decreasing = TRUE),]  # Ordenar la base en orden descendente por número de paraderos
write.csv(Localidades, "~/Rosario/MCPP/Proyecto/R Output/Localidades - Descriptives.csv", fileEncoding="UTF-8")

# UPZ

UPZ <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/UPZ/UPZ - Stats.csv")
keeps <- c("cod_loc", "nomb_loc", "cod_upz", "nom_upz", "poblacion_u", "densidad_ur", "p0", "p1", "p2", "p3", "p4", "p5", "pt", "q.p0", "q.p1", "q.p2", "q.p3", "q.p4", "q.p5")
UPZ = UPZ[keeps] # Mantener solamente las variables relevantes para las estadísticas descriptivas
UPZ <- UPZ[order(UPZ$pt, decreasing = TRUE),]  # Ordenar la base en orden descendente por número de paraderos
write.csv(UPZ, "~/Rosario/MCPP/Proyecto/R Output/UPZ - Descriptives.csv", fileEncoding="UTF-8")

# Zonas SITP

Zonas <- read_csv("~/Rosario/MCPP/Proyecto/Estadísticas/Zonas SITP/Zonas - Stats.csv")
keeps <- c("NOMBRE_ZON", "zonas_names","OPERADOR_S", "LOCALIDAD_", "SERVICIOS_", "p0", "p1", "p2", "p3", "p4", "p5", "pt", "q.p0", "q.p1", "q.p2", "q.p3", "q.p4", "q.p5")
Zonas = Zonas[keeps] # Mantener solamente las variables relevantes para las estadísticas descriptivas
Zonas <- Zonas[order(Zonas$pt, decreasing = TRUE),]  # Ordenar la base en orden descendente por número de paraderos
write.csv(Zonas, "~/Rosario/MCPP/Proyecto/R Output/Zonas - Descriptives.csv", fileEncoding="UTF-8")

