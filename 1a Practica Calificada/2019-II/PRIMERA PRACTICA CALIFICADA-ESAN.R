#######################################
#     PRIMERA PRÁCTICA CALIFICADA     #
#      PREPROCESAMIENTO DE DATOS      # 
#      Mg. Jesús Salinas Flores       # 
#        jsalinasf@esan.edu.pe        #
#######################################

#---------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------------
# Para limpiar el área de gráficos
dev.off()

#---------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#---------------------------------------------------------------
# Paquetes
library(foreign)
library(funModeling)
library(gmodels)
library(vcd)
library(gplots)
library(partykit)
library(rpart)
library(rpart.plot)
library(rattle)
library(caret)
library(caTools)
library(InformationValue)
library(DataExplorer)

###############################
# 1. Descripción de los datos #
###############################

# Los datos historicos muestran si los clientes hicieron o no un
# deposito. Indicado en la variable "deposit" (variable a predecir).

#######################
# 2. Lectura de datos #
#######################

library(foreign)
datos <- read.csv("bank_2.csv",sep=";")

#########################################
# 3. Análisis Exploratorio de los datos #
#########################################

# Para cada una de las variables predictoras indique si podrían
# ser buenas o malas predictoras de la variable target DEPOSIT
# justifique numéricamente o gráficamente su respuesta
# (9 puntos)


#################################
# 4. Preprocesamiento de datos  #
#################################

datosp <- read.csv("Bank_missing.csv",sep=";")

attach(datosp)

# Para todo el caso use un set.seed(123)

#------------------------------------------------------------------------------------
# Pregunta 2. Usando datosp, identifique las variables con datos
#             perdidos y el % de datos perdidos
#             (3 puntos)


#------------------------------------------------------------------------------------
# Pregunta 3.  Usando datosp, impute los datos perdidos
#              (tanto los cuantitativos como los categóricos)
#              Almacene los datos completos en el objeto 
#              datos_imp    
#              (4 puntos)

# Pregunta 4. Trabaje con datos_imp y genere las variables 
#             variables dummy correspondientes y almacene
#             en el objeto datos_dum (4 puntos)
