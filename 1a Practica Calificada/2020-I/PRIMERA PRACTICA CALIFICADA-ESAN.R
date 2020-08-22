#######################################
#     PRIMERA PRÁCTICA CALIFICADA     #
#      PREPROCESAMIENTO DE DATOS      # 
#      Mg. Jesús Salinas Flores       # 
#        jsalinasf@esan.edu.pe        #
#######################################

#----------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#----------------------------------------------------------
# Para limpiar el área de gráficos
dev.off()

#----------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#----------------------------------------------------------
# Paquetes
library(DataExplorer)
library(VIM)
library(naniar)
library(caret)
library(cowplot)
library(missForest)
library(dummies)
library(tictoc)
library(data.table)
library(DMwR)
library(arules)
library(funModeling)
library(ggplot2)
library(plotly)
library(dplyr)
library(rpart)
library(rpart.plot)


###############################
# 1. Descripción de los datos #
###############################

# El archivo australian-datos-faltantes.csv se refiere
# a las solicitudes de tarjetas de crédito. 

# 1. Title: Australian Credit Approval
# 2. Relevant Information:
#    This file concerns credit card applications.  
#    All attribute names and values have been changed
#    to meaningless symbols to protect
#    confidentiality of the data.

# This dataset is interesting because there is a
# good mix of attributes -- continuous, nominal with
# small numbers of values, and nominal with larger numbers
# of values.  There are also a few missing values.

# 3.  Number of Instances: 690
# 4.  Number of Attributes: 14 + class attribute (A15)
# 5.  Attribute Information:   THERE ARE 6 NUMERICAL
#     AND 8 CATEGORICAL ATTRIBUTES.

# 
#  A1:	0,1    					                  CATEGORICAL        	
#  A2:							                      continuous
#  A3:							                      continuous
#  A4:	1,2,3         				            CATEGORICAL         	
#  A5:  1,2,3,4,5,6,7,8,9,10,11,12,13,14  CATEGORICAL
#  A6:	1,2,3,4,5,6,7,8,9    			        CATEGORICAL 
#  A7:							                      continuous
#  A8:	1, 0       					              CATEGORICAL     
#  A9: 	1, 0	    					              CATEGORICAL     
# A10:							                      continuous
# A11:  1, 0	    					              CATEGORICAL     
# A12:  1, 2, 3    					              CATEGORICAL 
# A13:							                      continuous
# A14:							                      continuous
# A15:   1,2           +,-         		(class attribute)

# 6.  Class Distribution   A15 (target variable)

# +: 307 (44.5%)    CLASS 2
# -: 383 (55.5%)    CLASS 1

#######################
# 2. Lectura de datos #
#######################

# Lectura de los datos 
datos <- read.csv("australian-datos-faltantes.csv",
                stringsAsFactors = T, dec = ",",
                sep=";",
                na.strings = "")

# Viendo la estructura de los datos
str(datos)

#################################
# 3. Pre-procesamiento de datos #
#################################

# Realice el pre-procesamiento de datos que Ud. considere 
# el más adecuado
# Debe justificar en cada paso la o lás técnicas usadas 
# y mostrar como comentario la o las principales salidas
# obtenidas

# El pre-procesamiento deberá incluir (aunque no 
# necesariamente en ese orden) los siguientes puntos:

# - Diagnóstico de datos faltantes
# - Verificacion de la lectura correcta de las 
#   variables según la descripción de los datos
# - Detección y tratamiento de outliers
# - Creación de variables dummies
# - Imputación de los datos faltantes 
# - Transformación de datos donde corresponda
# - Detección y tratamiento de datos con variancia cero o
#   casi cero. 

# Finalmente presente el archivo australian-procesada.csv 
# con los datos finales luego del preprocesamiento.

# Nota
# Se tomará en cuenta el orden y la documentación de su
# script
 
# Deberá subir al aula virtual únicamente dos archivos:
# 1. Examen-Apellidos-Nombres.R
# 2. australian-procesada.csv


