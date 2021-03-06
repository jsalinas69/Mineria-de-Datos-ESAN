###############################
# SEGUNDA PR�CTICA CALIFICADA #
#   CLASES DESBALANCEADAS     # 
#  Mg. Jes�s Salinas Flores   # 
#   jsalinasf@esan.edu.pe     #
###############################

#---------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#---------------------------------------------------------------
library(caret)
library(readxl)
library(gmodels)

######################
#  Lectura de datos  #
######################

###############################
# CASO:  BANCO EUROPEO ALEXIA #
###############################

# Lectura de datos 

# Alexia es un gran banco europeo, con una oficina muy
# cercana a la sede de la Comisi�n Europea en Bruselas. 
# Esto hace que esta oficina sea la que tiene el mayor
# n�mero de clientes internacionales. 
# De una base de datos de clientes que previamente
# solicitaron un pr�stamo, filtra a esos clientes de
# otros pa�ses. Luego extrae de la lista resultante de
# clientes una muestra aleatoria de tama�o 3000. 
# Con algunos atributos seleccionados, planea desarrollar 
# un modelo para predecir el incumplimiento.

# The variables are:
# DEFAULT (Yes/No), whether the client defaulted.(TARGET)
# GENDER (Male/Female).
# AGE, the age in years.
# CITIZEN (DE/FR/GE/GR/HO/IT/PO/SP/UK), the client�s citizenship.
# PART (Yes/No), whether the client had a part-time job.
# INCOME, the client�s annual income, in euros.
# BALANCE, the client�s balance when the application 
#          for the loan was filed, in euros.

library(readxl)
datos.a         <- read_excel("alexia.xls")
datos.a         <- as.data.frame(datos.a)

datos.a$DEFAULT <- as.factor(datos.a$DEFAULT)
datos.a$GENDER  <- as.factor(datos.a$GENDER)
datos.a$CITIZEN <- as.factor(datos.a$CITIZEN)
datos.a$PART    <- as.factor(datos.a$PART)

str(datos.a)

dim(datos.a)
# [1] 3000    7

contrasts(datos.a$DEFAULT)

table(datos.a$DEFAULT)
round(prop.table(table(datos.a$DEFAULT)),3)*100

library(DataExplorer)
plot_missing(datos.a)

# Donde corresponda asignar una semilla aleatoria, use:
# set.seed(123)                                      


# 1.  Para las variables categ�ricas genere sus dummies. 
#     Elimine las que no son necesarias
#     Particione la data 70% (train) y 30% (test) usando el
#     paquete caret. (2 puntoS)


# 2.	Realice un balanceo de datos con:
#     Undersampling, Oversampling y SMOTE
#     (4 puntos)


# 3.  Entrene los modelos con Validaci�n Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     usando Regresi�n Log�stica con train() del paquete caret
#     Para los cuatro modelos (incluya los datos sin balancear)
#     use la estandarizaci�n range [0,1] para las variables
#     num�ricas. Use como indicador en el train el Accuracy
#     (4 puntos)

# 4. De los cuatro modelos indique cual tiene la menor 
#    variancia en la muestra de entrenamiento. 
#    Comente o justifique su respuesta  (2 puntos)


# 5. Presente los siguientes indicadores en el testing: 
#    Sensibilidad, Especificidad, Accuracy, Log-Loss y
#    AROC para los siguientes modelos:
#    Datos sin balancear con punto de corte 0.5
#    Datos sin balancear con punto de corte �ptimo
#    Datos con undersampling con punto de corte 0.5
#    Datos con undersampling con punto de corte �ptimo
#    Datos con oversampling con punto de corte 0.5
#    Datos con oversampling con punto de corte �ptimo
#    Datos con smote con punto de corte 0.5
#    Datos con smote con punto de corte �ptimo

# El punto de corte �ptimo (umbral) b�squelo seg�n el 
# que de la mayor sensibilidad + especificidad

# Finalmente indique cu�l ser�a el modelo escogido. 
# Justifique su respuesta (8 puntos)