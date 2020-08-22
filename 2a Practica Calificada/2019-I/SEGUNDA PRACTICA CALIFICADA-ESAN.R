#######################################
#     SEGUNDA PRÁCTICA CALIFICADA     #
#        CLASES DESBALANCEADAS        # 
#    ALGORITMOS K-NN Y NAIVE BAYES    # 
#      Mg. Jesús Salinas Flores       # 
#        jsalinasf@esan.edu.pe        #
#######################################

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

# Los datos están relacionados con las campañas de marketing 
# directo de una institución bancaria portuguesa. Las campañas de 
# marketing se basaron en llamadas telefónicas. 
# A menudo, se requirió más de un contacto para el mismo cliente, 
# para poder acceder si el producto (depósito a plazo bancario) 
# estaría suscrito ('sí') o no ('no').

data.bank <- read.csv("Bank_Seleccion_Variables.csv",sep=";")

str(data.bank)

# bank client data:
# 1 - age (numeric)
# 2 - job : type of job (categorical: 'admin.','blue-collar','entrepreneur','housemaid','management','retired','self-employed','services','student','technician','unemployed','unknown')
# 3 - marital : marital status (categorical: 'divorced','married','single','unknown'; note: 'divorced' means divorced or widowed)
# 4 - education (categorical: 'basic.4y','basic.6y','basic.9y','high.school','illiterate','professional.course','university.degree','unknown')
# 5 - default: has credit in default? (categorical: 'no','yes','unknown')
# 6 - balance
# 7 - housing: has housing loan? (categorical: 'no','yes','unknown')
# 8 - loan: has personal loan? (categorical: 'no','yes','unknown')

# Variables related with the last contact of the current campaign:
# 9 - contact: contact communication type (categorical: 'cellular','telephone') 
# 10 - day: last contact day of month (numeric: 1, 2, 3, .... )  
# 11 - month: last contact month of year (categorical: 'jan', 'feb', 'mar', ..., 'nov', 'dec')
# 12 - duration: last contact duration, in seconds (numeric). Important note: this attribute highly affects the output target (e.g., if duration=0 then y='no'). Yet, the duration is not known before a call is performed. Also, after the end of the call y is obviously known. Thus, this input should only be included for benchmark purposes and should be discarded if the intention is to have a realistic predictive model.

# other attributes:
# 13 - campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
# 14 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric; 999 means client was not previously contacted)
# 15 - previous: number of contacts performed before this campaign and for this client (numeric)
# 16 - poutcome: outcome of the previous marketing campaign (categorical: 'failure','nonexistent','success')

# Output variable (desired target):
# 17 - y - has the client subscribed a term deposit? (binary: 'yes','no')

str(data.bank)

summary(data.bank)

table(data.bank$y)
round(prop.table(table(data.bank$y)),3)*100

# 1.	Realice un análisis de variables con variancia CERO o 
#     CASI CERO. Elimine del análisis al o las variables que
#     resultan TRUE en cualquiera de las dos situaciones. 			
#     (2 puntos)



# 2.  Para las variables categóricas genere sus correspondientes 
#     variables dummies. Elimine las que no son necesarias
#     (2 puntos)



# 3.  Particione la data 70% (train) y 30% (test) usando el paquete
#     caret() y usando set.seed(123)                  (1 punto)


# 4.	Realice un balanceo de datos con el método de OVERSAMPLING
#     (2 puntos)


# 5.  Entrene los modelos con Validación Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     Encuentre el mejor modelo con train() del paquete caret usando
#     a. Naive Bayes          (3 puntos)
#     b. Regresión Logística  (3 puntos)
#     c. k-nn                 (3 puntos)

#    Para los tres modelos use la estandarización range [0,1] para 
#    las variables numéricas. Use como indicador en el train el
#    Accuracy


# 6. Elija el mejor modelo en la data de prueba (test) usando 
#    la sensibilidad. (2 puntos) 


# 7. De los tres modelos indique cual tiene la menor variancia en
#    la muestra de entrenamiento. Justifique su respuesta
#    (2 puntos)
