#######################################
#     PRIMERA PRÁCTICA CALIFICADA     #
#      PREPROCESAMIENTO DE DATOS      # 
#      Mg. Jesús Salinas Flores       # 
#        jsalinasf@esan.edu.pe        #
#######################################

#--------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algún dataset 
# o información cargada
rm(list = ls())

#--------------------------------------------------------------
# Para limpiar el área de gráficos
dev.off()

#--------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#--------------------------------------------------------------
# Paquetes
# Paquetes
library(pacman)
p_load(DataExplorer,VIM,naniar,dplyr,caret,ggplot2,
       fastDummies,DMwR,readr)

###############################
# 1. Descripción de los datos #
###############################

# El archivo Seguros.xlsx contiene información sobre 
# 2463 personas a las cuales se les aprobó (SI) o se les 
# denegó (NO) un seguro de vida premium

# Target : Seguro
# Predictoras: Edad, Número de hijos, Número de tarjetas 
#              de crédito, Sexo, Ingresos, Educación, 
#              Automóvil y Trabajo.

library(readxl)
datos.s  <- read_excel("Seguros.xlsx")
datos.s  <- as.data.frame(datos.s)

str(datos.s)

datos.s$Seguro    <- factor(datos.s$Seguro)
datos.s$T_credito <- factor(datos.s$T_credito)
datos.s$Sexo      <- factor(datos.s$Sexo)
datos.s$Ingresos  <- factor(datos.s$Ingresos)
datos.s$Educacion <- factor(datos.s$Educacion)
datos.s$Automovil <- factor(datos.s$Automovil)
datos.s$Trabajo   <- factor(datos.s$Trabajo)

str(datos.s)

dim(datos.s)
# [1] 2463    9

table(datos.s$Seguro)
round(prop.table(table(datos.s$Seguro)),3)*100

#########################################
# 2. Análisis Exploratorio de los datos #
#########################################

# Para cada una de las variables predictoras indique si podrían
# ser buenas o malas predictoras de la variable target Seguro
# justifique numéricamente o gráficamente su respuesta
# (8 puntos)


#################################
# 3. Pre-procesamiento de datos #
#################################

# Trabaje en esta pregunta con el archivo Seguros_NA.csv

library(readr)
datos.p  <- read_csv("Seguros_NA.csv")

datos.p <- as.data.frame(datos.p)

str(datos.p)

datos.p$Seguro    <- factor(datos.p$Seguro)
datos.p$T_credito <- factor(datos.p$T_credito)
datos.p$Sexo      <- factor(datos.p$Sexo)
datos.p$Ingresos  <- factor(datos.p$Ingresos)
datos.p$Educacion <- factor(datos.p$Educacion)
datos.p$Automovil <- factor(datos.p$Automovil)
datos.p$Trabajo   <- factor(datos.p$Trabajo)

str(datos.p)

dim(datos.p)
# [1] 2463    9

# Realice el pre-procesamiento de datos que Ud. considere 
# el más adecuado (12 puntos)
# Debe justificar en cada paso la o lás técnicas usadas 
# y mostrar como comentario la o las principales salidas
# obtenidas

# El pre-procesamiento deberá incluir (aunque no 
# necesariamente en ese orden) los siguientes puntos:

# - Diagnóstico de datos faltantes
# - Verificación de la lectura correcta de las 
#   variables según la descripción de los datos
# - Detección y tratamiento de outliers
# - Creación de variables dummies
# - Imputación de los datos faltantes 
# - Transformación de datos donde corresponda
# - Detección y tratamiento de datos con variancia cero o
#   casi cero. 

# Finalmente, genere el archivo Seguros_procesada.csv 
# con los datos finales luego del preprocesamiento.

# Nota
# Se tomará en cuenta el orden y la documentación de su
# script
 
# Deberá subir al aula virtual un archivo comprimido que 
# contenga los siguientes archivos:
# 1. Seguros.xlx
# 2. Seguros_NA.csv
# 3. Seguros_procesada.csv
# 4. Examen_Apellidos_Nombres.R