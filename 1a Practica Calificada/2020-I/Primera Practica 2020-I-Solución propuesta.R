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
# - Verificacion de la lectura correcta de las variables según la descripción de los datos 
# - Detección y tratamiento de outliers
# - Creación de variables dummies
# - Imputación de los datos faltantes 
# - Transformación de datos donde corresponda
# - Detección y tratamiento de datos con variancia cero o casi cero. 

# Finalmente presente el archivo australian-procesada.csv 
# con los datos finales luego del preprocesamiento.

# Nota
# Se tomará en cuenta el orden y la documentación de su
# script
 
# Deberá subir al aula virtual únicamente dos archivos:
# 1. Examen-Apellidos-Nombres.R
# 2. australian-procesada.csv

# 1. Verificacion de la lectura correcta de las variables según la descripción de los datos
str(datos)
datos$A1 <- as.factor(datos$A1)
datos$A4 <- as.factor(datos$A4)
datos$A5 <- as.factor(datos$A5)
datos$A6 <- as.factor(datos$A6)
datos$A8 <- as.factor(datos$A8)
datos$A9 <- as.factor(datos$A9)
datos$A11 <- as.factor(datos$A11)
datos$A12 <- as.factor(datos$A12)
datos$A10 <- as.numeric(datos$A10)
datos$A13 <- as.numeric(datos$A13)
datos$A14 <- as.numeric(datos$A14)
datos$A15 <- as.factor(datos$A15)
str(datos)


# 3. Diagnostico de datos faltantes.

library(DataExplorer)
plot_missing(datos)
sum(is.na(datos))

#Vemos que en las variables A5, A4, A7, A2, A1 y A14 presentan datos perdidos.
#Ahora veremos que tipo de datos perdidos son estos 58 datos.

vis_miss(datos, cluster = TRUE)

# Identificamos que son datos MCAR porque no tienen una relaciòn entre las otras variables

# 4. Imputación de los datos faltantes 
# 5. Transformación de datos donde corresponda
#    vamos a preprocesar los datos por el proceso KNN
#    esta primera etapa solo lo haremos con las numericas, porque KNN solo trabaja con numericas
library(caret)
preProcValues1 <- preProcess(datos,
                             method=c("knnImpute"))
preProcValues1

datos_transformado1 <- predict(preProcValues1, datos)

# Y ahora para poder imputar los datos categoricos utilizaremos Randomforest
library(missForest)
impu_cate           <- missForest(datos_transformado1)
datos_transformado1 <- impu_cate$ximp

# Verificamos que no haya datos perdidos
sum(is.na(datos_transformado1))

# 6. Detección y tratamiento de datos con variancia cero o casi cero

# Verificamos la variabilidad de los datos esperando encontrar que sean muy variables
nearZeroVar(datos_transformado1, saveMetrics= TRUE)

#freqRatio percentUnique zeroVar   nzv
#A1       2.14         0.290   FALSE FALSE
#A2       1.33        52.174   FALSE FALSE
#A3       1.11        31.159   FALSE FALSE
#A4       3.25         0.435   FALSE FALSE
#A5       1.85         2.029   FALSE FALSE
#A6       2.96         1.159   FALSE FALSE
#A7       1.77        20.435   FALSE FALSE
#A8       1.10         0.290   FALSE FALSE
#A9       1.34         0.290   FALSE FALSE
#A10      5.56         3.333   FALSE FALSE
#A11      1.18         0.290   FALSE FALSE
#A12     10.96         0.435   FALSE FALSE
#A13      3.77        24.783   FALSE FALSE
#A14      9.72        36.377   FALSE FALSE
#A15      1.25         0.290   FALSE FALSE
#Concluimos que todas las variables no tienen variabilidad 0, en otras palabras nos sirven
#para realizar continuar con el preprocesamiento, toda sirven para realizar el modelo.

# 7. Creación de variables dummies

library(caret)
dummies2 <- dummyVars(A15 ~ ., data=datos_transformado1,
                      fullRank = TRUE)
datos_transformado2 <- as.data.frame(predict(dummies2, 
                                             newdata=datos_transformado1))
datos_transformado2 <- cbind(datos_transformado2,
                             A15 = datos_transformado1$A15)


# 8. Deteción y tratamiento de outliers
# Verificamos que hay datos outliers 

datos_1 <- datos

outliers1 <- boxplot(datos$A2)$out
outliers1 ; length(outliers1)
summary(outliers1)

datos_1$A2 <- cut(datos_1$A2, 
                         breaks = c(-Inf,25,40,Inf),
                         labels = c("Menos de 25", 
                                    "De 25 a menos de 40",
                                    "De 40 a mas"),
                         right = FALSE)


outliers2 <- boxplot(datos$A3)$out
outliers2 ; length(outliers2)
summary(outliers2)

datos_1$A3 <- cut(datos_1$A3, 
                  breaks = c(-Inf,1,8,Inf),
                  labels = c("Menos de 1", 
                             "De 1 a menos de 8",
                             "De 8 a mas"),
                  right = FALSE)

outliers3 <- boxplot(datos$A7)$out
outliers3 ; length(outliers3)
summary(outliers3)

datos_1$A7 <- cut(datos_1$A7, 
                  breaks = c(-Inf,0.5,4,Inf),
                  labels = c("Menos de 0.5", 
                             "De 0.5 a menos de 4",
                             "De 4 a mas"),
                  right = FALSE)

outliers4 <- boxplot(datos$A10)$out
outliers4 ; length(outliers4)
summary(outliers4)

datos_1$A10 <- cut(datos_1$A10, 
                  breaks = c(-Inf,0,6,Inf),
                  labels = c("Menos de 0", 
                             "De 0 a menos de 6",
                             "De 6 a mas"),
                  right = FALSE)


outliers5 <- boxplot(datos$A13)$out
outliers5 ; length(outliers5)
summary(outliers5)

datos_1$A13 <- cut(datos_1$A13, 
                  breaks = c(-Inf,100,400,Inf),
                  labels = c("Menos de 100", 
                             "De 100 a menos de 400",
                             "De 400 a mas"),
                  right = FALSE)

outliers6 <- boxplot(datos$A14)$out
outliers6 ; length(outliers6)
summary(outliers16)

datos_1$A14 <- cut(datos_1$A14, 
                  breaks = c(-Inf,1000,2000,Inf),
                  labels = c("Menos de 1000", 
                             "De 1000 a menos de 2000",
                             "De 2000 a mas"),
                  right = FALSE)

# Todas las variables numericas tienen outliers :( y no puedo usar el java aun me sale el error de instalacion

write.csv(datos_1,"australian-procesada.csv")
