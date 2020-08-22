#############################################
#        SEGUNDA PRÁCTICA CALIFICADA        #
#           CLASES DESBALANCEADAS,          # 
# REGRESIÓN LOGÍSTICA, K-NN Y NAIVE BAYES   # 
#         Mg. Jesús Salinas Flores          # 
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

# Basándose en los resultados de un correo de prueba, el dpto. 
# de marketing de una empresa desea generar perfiles de los 
# tipos de clientes con más posibilidades de responder a la
# oferta, en función de la información demográfica

# Archivo: dmdata.sav

# Variable de identificación: 
# ID          Código del cliente

# Variables Independientes:
# Edad	      Edad en años
# Ingreso	    Ingreso en categorías
# Educación	  Nivel de educación
# Residencia	Años de residencia
# Género	    0 Masculino, 1 Femenino
# Casado	    1 Casado, 0 No Casado
# Hijos	      N° de hijos
# Región	    1 Norte, 2 Sur, 3 Este, 4 Oeste

# Variable Dependiente:  
# Respuesta	  1 Si adquirió , 0 No adquirió  

#######################
# 2. Lectura de datos #
#######################

library(foreign)
datosm <- read.spss("dmdata.sav",
                    use.value.labels=TRUE, 
                    to.data.frame=TRUE)

attr(datosm,"variable.labels")<- NULL

str(datosm)

# No considerar la variable de identificación ID
datosm$ID <- NULL
str(datosm)

attach(datosm)

contrasts((datosm$Respuesta))

round(prop.table(table(Respuesta)),3)*100

# Donde corresponde asignar una semilla aleatoria, use:
# RNGkind(sample.kind = "Rounding") 
# set.seed(123)                                      


# 1.  Para las variables categóricas genere sus correspondientes 
#     variables dummies. Elimine las que no son necesarias
#     (2 puntos)



# 2.  Particione la data 70% (train) y 30% (test) usando el paquete
#     caret() (1 punto)


# 3.	Realice un balanceo de datos con el método de OVERSAMPLING
#     (3 puntos)


# 4.  Entrene los modelos con Validación Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     Encuentre el mejor modelo (encuentre la mejor combinación
#     de hiperparámetros donde corresponde) con train() del 
#     paquete caret usando:
#     a. Regresión Logística  (3 puntos)
#     b. k-nn                 (3 puntos)
#     c. Naive Bayes          (3 puntos)


#    Para los tres modelos use la estandarización range [0,1] para 
#    las variables numéricas. Use como indicador en el train el
#    Accuracy


# 5. Elija el mejor modelo en la data de prueba (test) usando 
#    la sensibilidad. Presente la sensibilidad con los tres
#    modelos en la data de prueba (3 puntos) 


# 6. De los tres modelos indique cual tiene la menor variancia en
#    la muestra de entrenamiento. Comente o justifique su respuesta
#    (2 puntos)
