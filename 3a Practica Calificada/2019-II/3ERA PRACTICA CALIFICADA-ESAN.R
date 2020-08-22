#######################################
#     TERCERA PRÁCTICA CALIFICADA     #
# SVC, SVM Y ÁRBOLES DE CLASIFICACIÓN # 
#       Mg. Jesús Salinas Flores      # 
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


###############################
# 1. Descripción de los datos #
###############################

# Los datos están relacionados con las campañas de marketing directo
# de una institución bancaria portuguesa. Las campañas de marketing 
# se basaron en llamadas telefónicas. A menudo, se requirió más de 
# un contacto para el mismo cliente, para poder acceder si el 
# producto (depósito a plazo bancario) estaría suscrito ('sí') 
# o no ('no').

datos <- read.csv("bancomarketing.csv",sep=";")

str(datos)

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

# Variable Target (desired target):
# 17 - y - has the client subscribed a term deposit? (binary: 'yes','no')


# Etiquetando las opciones de las variables categoricas
levels(datos$y)
levels(datos$y) <- c("No_Suscrito","Suscrito")

contrasts(datos$y)
attach(datos)

# 1. Relice el preprocesamiento que considere adecuado
#    (eliminación de variables con poca variancia, selección 
#     de variables, etc). (4 puntos)
#    Describa el procedimiento que siguió
# 2. Trabaje con todos las variables que quedaron de la pregunta 1
#    y encuentre el árbol óptimo CART, comente el procedimiento 
#    que realizó e indique cual fue el cp óptimo (4 puntos)
# 3. Trabaje con todos las variables que quedaron de la pregunta 1
#    - Para las variables categóricas genere sus correspondientes 
#      variables dummies
#    - Particione la data 80% (train) y 20% (test) usando el 
#      paquete caret() usando 
#      RNGkind(sample.kind = "Rounding") 
#      set.seed(2019)
#    - Realice un balanceo usando oversampling
#    - Entrene los modelos con Validación Cruzada y usando el accuracy
#      RNGkind(sample.kind = "Rounding") 
#      set.seed(2019)
#      ctrl <- trainControl(method="cv", 
#                           number=10,classProbs =  TRUE)
#    - Para los modelos use la estandarización range [0,1] para 
#      las variables numéricas
#    - Encuentre el mejor modelo usando 
#      SVM, Random Forest y GBM
#      Describa el procedimiento para obtener los mejores 
#      hiperparámetros para cada algoritmo (8 puntos)
# 4. Elija el mejor modelo (de 3.) en la data de prueba (test) 
#    usando la sensibilidad  (4 puntos)
