#############################################
#        SEGUNDA PR�CTICA CALIFICADA        #
#           CLASES DESBALANCEADAS,          # 
# REGRESI�N LOG�STICA, K-NN Y NAIVE BAYES   # 
#         Mg. Jes�s Salinas Flores          # 
#          jsalinasf@esan.edu.pe            #
#############################################

#---------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#-----------------------------------------------------------------
library(caret)
library(readxl)
library(gmodels)

######################
#  Lectura de datos  #
######################

# Bas�ndose en los resultados de un correo de prueba, el dpto. 
# de marketing de una empresa desea generar perfiles de los 
# tipos de clientes con m�s posibilidades de responder a la
# oferta, en funci�n de la informaci�n demogr�fica

# Archivo: dmdata.sav

# Variable de identificaci�n: 
# ID          C�digo del cliente

# Variables Independientes:
# Edad	      Edad en a�os
# Ingreso	    Ingreso en categor�as
# Educaci�n	  Nivel de educaci�n
# Residencia	A�os de residencia
# G�nero	    0 Masculino, 1 Femenino
# Casado	    1 Casado, 0 No Casado
# Hijos	      N� de hijos
# Regi�n	    1 Norte, 2 Sur, 3 Este, 4 Oeste

# Variable Dependiente:  
# Respuesta	  1 Si adquiri� , 0 No adquiri�  

#######################
# 2. Lectura de datos #
#######################

library(foreign)
datosm <- read.spss("dmdata.sav",
                    use.value.labels=TRUE, 
                    to.data.frame=TRUE)

attr(datosm,"variable.labels")<- NULL

str(datosm)

# No considerar la variable de identificaci�n ID
datosm$ID <- NULL
str(datosm)

attach(datosm)

contrasts((datosm$Respuesta))

round(prop.table(table(Respuesta)),3)*100

# Donde corresponde asignar una semilla aleatoria, use:
# RNGkind(sample.kind = "Rounding") 
# set.seed(123)                                      


# 1.  Para las variables categ�ricas genere sus correspondientes 
#     variables dummies. Elimine las que no son necesarias
#     (2 puntos)



# 2.  Particione la data 70% (train) y 30% (test) usando el paquete
#     caret() (1 punto)


# 3.	Realice un balanceo de datos con el m�todo de OVERSAMPLING
#     (3 puntos)


# 4.  Entrene los modelos con Validaci�n Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     Encuentre el mejor modelo (encuentre la mejor combinaci�n
#     de hiperpar�metros donde corresponde) con train() del 
#     paquete caret usando:
#     a. Regresi�n Log�stica  (3 puntos)
#     b. k-nn                 (3 puntos)
#     c. Naive Bayes          (3 puntos)


#    Para los tres modelos use la estandarizaci�n range [0,1] para 
#    las variables num�ricas. Use como indicador en el train el
#    Accuracy


# 5. Elija el mejor modelo en la data de prueba (test) usando 
#    la sensibilidad. Presente la sensibilidad con los tres
#    modelos en la data de prueba (3 puntos) 


# 6. De los tres modelos indique cual tiene la menor variancia en
#    la muestra de entrenamiento. Comente o justifique su respuesta
#    (2 puntos)
