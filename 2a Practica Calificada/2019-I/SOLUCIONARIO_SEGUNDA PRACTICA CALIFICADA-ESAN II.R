########################################
#      SEGUNDA PRÁCTICA CALIFICADA     #
#         CLASES DESBALANCEADAS        # 
# K-NN, NAIVE BAYES Y REDES NEURONALES # 
#       Mg. Jesús Salinas Flores       # 
#         jsalinasf@esan.edu.pe        #
########################################

#---------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
options(scipen=999)

#-----------------------------------------------------------------
library(caret)
library(readxl)
library(gmodels)

######################
#  Lectura de datos  #
######################

# Los datos están relacionados con las campañas de marketing directo
# de una institución bancaria portuguesa. Las campañas de marketing 
# se basaron en llamadas telefónicas. A menudo, se requirió más de 
# un contacto para el mismo cliente, para poder acceder si el 
# producto (depósito a plazo bancario) estaría suscrito ('sí') 
# o no ('no').

data.bank <- read.csv("Bank_Seleccion_Variables.csv",sep=";")

str(data_bank)

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

# Luego de realizar un análisis de variables con variancia CERO o 
# CASI CERO se procedió a eliminar las variables default y pdays

data.bank$default <- NULL
data.bank$pdays   <- NULL

# 1.  Para las variables categóricas genere sus correspondientes 
#     variables dummies  (2 puntos)

# Usando el paquete caret
library(caret)
dummies <- dummyVars(y ~ ., data=data.bank,
                      fullRank = TRUE)
datos <- as.data.frame(predict(dummies, newdata=data.bank))
datos <- cbind(datos,y = data.bank$y)
str(datos)

# 2.  Particione la data 70% (train) y 30% (test) usando el paquete
#     caret() y usando set.seed(123)                  (1 punto)

library(caret)
set.seed(123) 

index   <- createDataPartition(datos$y, p=0.7, list=FALSE)
imbal_train    <- datos[ index, ]
imbal_testing  <- datos[-index, ]

# Verificando que se mantenga la proporción original
round(prop.table(table(datos$y))*100,2)
round(prop.table(table(imbal_train$y))*100,2)
round(prop.table(table(imbal_testing$y))*100,2)


# 3.	Realice un balanceo de datos con el método de OVERSAMPLING
#     (3 puntos)

# OverSampling
set.seed(123)
over_train <- upSample(x = imbal_train[, c(1:40)],
                       y = imbal_train$y,
                       yname="y")

addmargins(table(over_train$y))


# 4.  Entrene los modelos con Validación Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     Encuentre el mejor modelo (encuentre la mejor combinación
#     de hiperparámetros) con train() del paquete caret usando
#     a. Naive Bayes          (3 puntos)
#     b. k-nn                 (3 puntos)
#     c. Redes Neuronales     (3 puntos)


#-------------------------------------------------------------------
# 4.1 Aplicando el algoritmo Naive Bayes
#     con Validación Cruzada con el paquete caret

# Relación de parámetros a ajustar de un modelo
modelLookup(model='nb')

set.seed(123)
ctrl <- trainControl(method="cv", number=10)
# classProbs=TRUE,summaryFunction = twoClassSummary)

modelo_nb <- train(y ~ ., 
                   data = over_train, 
                   method = "nb", 
                   preProcess=c("range"),
                   trControl = ctrl, 
                   tuneLength = 2,
                   metric="Accuracy" )

modelo_nb 

plot(modelo_nb)

varImp(modelo_nb)

plot(varImp(modelo_nb))

clase.pred1 <- predict(modelo_nb,newdata = imbal_testing )
head(clase.pred1)

proba.pred1 <- predict(modelo_nb,newdata = imbal_testing, type="prob")
head(proba.pred1)
proba.pred1 <- proba.pred1[,2]

#-----------------------------------------------------------------
# Evaluando la performance del modelo

# Tabla de clasificación
library(gmodels)
CrossTable(x = imbal_testing$y, y = clase.pred1,
           prop.t=FALSE, prop.c=FALSE, prop.chisq = FALSE)

result1 <- caret::confusionMatrix(clase.pred1,
                                  imbal_testing$y,
                                  positive="yes")
result1$byClass["Sensitivity"] 

#-------------------------------------------------------------------
# 4.2 Aplicando el algoritmo k-nn
#     con Validación Cruzada con el paquete caret

# Relación de parámetros a ajustar de un modelo
modelLookup(model='knn')

set.seed(123)

ctrl <- trainControl(method="cv", number=10)
# classProbs=TRUE,summaryFunction = twoClassSummary)

modelo_knn <- train(y ~ ., 
                    data = over_train, 
                    method = "knn", 
                    preProcess=c("range"),
                    trControl = ctrl, 
                    tuneLength = 10,
                    metric="Accuracy" )

modelo_knn

plot(modelo_knn)

varImp(modelo_knn)

plot(varImp(modelo_knn))

clase.pred2 <- predict(modelo_knn,newdata = imbal_testing )
head(clase.pred2)

proba.pred2 <- predict(modelo_knn,newdata = imbal_testing, type="prob")
head(proba.pred2)

proba.pred2 <- proba.pred2[,2]
head(cbind(imbal_testing,proba.pred2,clase.pred2))

#------------------------------------------------------------
# Evaluando la performance del modelo

# Tabla de clasificación
CrossTable(x = imbal_testing$y, y = clase.pred2,
           prop.t=FALSE, prop.c=FALSE, prop.chisq = FALSE)

result2 <- caret::confusionMatrix(clase.pred2,
                                  imbal_testing$y,
                                  positive="yes")
result2$byClass["Sensitivity"] 


#-------------------------------------------------------------------
# 4.3 Aplicando Redes Neuronales
#     con Validación Cruzada con el paquete caret

# Relación de parámetros a ajustar de un modelo
modelLookup(model='nnet')

set.seed(123)

ctrl <- trainControl(method="cv", number=10)
# classProbs=TRUE,summaryFunction = twoClassSummary)

modelo_rn <- train(y ~ ., 
                  data = over_train, 
                    method = "nnet", 
                    preProcess=c("range"),
                    trControl = ctrl, 
                    tuneLength = 5,
                    #tuneGrid = expand.grid(size=seq(5,20,1),decay=0.1),
                    metric="Accuracy" )

modelo_rn

plot(modelo_rn)

varImp(modelo_rn)

plot(varImp(modelo_rn))

clase.pred3 <- predict(modelo_rn,newdata = imbal_testing )
head(clase.pred3)

proba.pred3 <- predict(modelo_rn,newdata = imbal_testing, type="prob")
head(proba.pred3)

proba.pred3 <- proba.pred3[,2]
head(cbind(imbal_testing,proba.pred3,clase.pred3))

#------------------------------------------------------------
# Evaluando la performance del modelo

# Tabla de clasificación
CrossTable(x = imbal_testing$y, y = clase.pred3,
           prop.t=FALSE, prop.c=FALSE, prop.chisq = FALSE)

result3 <- caret::confusionMatrix(clase.pred3,
                                  imbal_testing$y,
                                  positive="yes")
result3$byClass["Sensitivity"] 

#-----------------------------------------------------------------
# 5. Elija el mejor modelo en la data de prueba (test) usando 
#    la sensibilidad. (3 puntos) 
result1$byClass["Sensitivity"]   # Naive-Bayes      0.5641026
result2$byClass["Sensitivity"]   # k-nn             0.6025641
result3$byClass["Sensitivity"]   # Redes Neuronales 0.5448718

# 6. De los tres modelos indique cual tiene la menor variancia en
#    la muestra de entrenamiento. (2 puntos)
#-------------------------------------------------------------
# Comparando la muestras para los tres modelos
modelos  <- list(Naive_Bayes  = modelo_nb,
                 k_nn         = modelo_knn,
                 Red_Neuronal = modelo_rn)

comparacion_modelos <- resamples(modelos)
summary(comparacion_modelos)

densityplot(comparacion_modelos, 
            metric = "Accuracy",
            auto.key=TRUE)

# La red neuronal tiene menor variancia y mayor accuracy
# en el entrenamiento