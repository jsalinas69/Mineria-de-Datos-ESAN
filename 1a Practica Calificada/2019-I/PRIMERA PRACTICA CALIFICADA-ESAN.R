#######################################
#     PRIMERA PR�CTICA CALIFICADA     #
#      PREPROCESAMIENTO DE DATOS      # 
#      Mg. Jes�s Salinas Flores       # 
#        jsalinasf@esan.edu.pe        #
#######################################

#---------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------------
# Para limpiar el �rea de gr�ficos
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

###############################
# 1. Descripci�n de los datos #
###############################

# Los datos Risk.sav contiene la informaci�n financiera de m�s 
# de 4000 clientes. El objetivo es predecir la variable riesgo. 

# Variable Dependiente o Target:  
#           RIESGO   (0=Bajo, 1=Alto)
#
# Variables Independentes o Predictoras:
#           EDAD          (Edad del cliente en a�os)  
#           GENERO        (G�nero del cliente, 
#                          1=Masculino 2=Femenino)
#           EST_MARITAL   (Estado civil del cliente, 
#                          1=Casado 2=Soltero, 3=Otros) 
#           HIJOS         (N�mero de hijos del cliente)
#           INGRESO       (Ingresos anuales familiares del
#                          cliente en d�lares)
#           TARJETAS      (N�mero de tarjetas de cr�dito)  
#           PRESTAMO      (N�mero de pr�stamos)
#           PAGO          (Forma de pago, 1=mensual 2=semanal)
#           HIPOTECA      (Cuenta con hipoteca, 1=No 2=Si)
#
# Variable de identificaci�n: 
#           ID      (C�digo del cliente)

#######################
# 2. Lectura de datos #
#######################

library(foreign)
datos <- read.spss("Risk.sav",
                   use.value.labels=TRUE, 
                   to.data.frame=TRUE)
str(datos)

# No considerar la variable de identificaci�n ID
datos$ID <- NULL
str(datos)

# Etiquetando las opciones de las variables categ�ricas
levels(datos$GENERO) <- c("Masc","Fem")
str(datos)

attach(datos)

#########################################
# 3. An�lisis Exploratorio de los datos #
#########################################

# Para cada una de las variables predictoras indique si podr�an
# ser buenas o malar predictoras de la variable target RIESGO
# justifique num�ricamente o gr�ficamente su respuesta
# (9 puntos)


#################################
# 4. Preprocesamiento de datos  #
#################################

datosp <- read.csv("Risk con NA.csv")

datosp$ID <- NULL

str(datosp)

attach(datosp)

# Para todo el caso use un set.seed(123)

#------------------------------------------------------------------------------------
# Pregunta 2. Identifique las variables con datos perdidos
#             y el % de datos perdidos
#             (3 puntos)


#------------------------------------------------------------------------------------
# Pregunta 3.  Impute los datos perdidos
#              (tanto los cuantitativos como los categ�ricos)
#              Recomendaci�n : Use missForest o knnImputation
#              Almacene los datos completos en el objeto 
#              datos_imp    
#              (4 puntos)

# Pregunta 4. Trabaje con datos_imp y genere las variables 
#             variables dummy correspodientes y almacene
#             en el objeto datos_dum (4 puntos)
