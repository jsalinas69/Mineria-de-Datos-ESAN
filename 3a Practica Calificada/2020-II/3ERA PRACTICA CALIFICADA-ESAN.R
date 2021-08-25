####################################################
#          TERCERA PRÁCTICA CALIFICADA             #
# NAIVE BAYES, SVC, SVM Y ÁRBOLES DE CLASIFICACIÓN # 
#            Mg. Jesús Salinas Flores              # 
#              jsalinasf@esan.edu.pe               # 
####################################################

#---------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#---------------------------------------------------------------
# Pregunta 1
# En el archivo de Excel (Ejemplo Naive Bayes CREDITO.xlsx)
# complete las celdas necesarias (use fórmulas y funciones) 
# para hallar la probabilidad y la clase predicha para el 
# nuevo individuo requerido.
# (10 puntos)

# SOLUCIONARIO
# Ingresando todos los datos del caso de estudio
data.ejemplo <- read.csv("Caso Credito.csv",sep=";",
                           stringsAsFactors = T)
str(data.ejemplo)

library(e1071)  
modelo <- naiveBayes(Credito ~., 
                     data=data.ejemplo,
                     laplace = 1) 

modelo

data.nuevos <- data.frame(Edad="Joven",
                          AMEX="No",
                          Pago="Semanal",
                          Categoría="Administrativo",
                          stringsAsFactors = T)
data.nuevos

proba.pred <- predict(modelo,data.nuevos,type = "raw")
proba.pred
proba.pred <- proba.pred[,2]

clase.pred <- predict(modelo,data.nuevos,type = "class")
clase.pred

head(cbind(data.nuevos,proba.pred,clase.pred))


############################
# Descripción de los datos #
############################

# El archivo Seguros.xlsx contiene información sobre 
# 2463 personas a las cuales se les aprobó (SI) o se les 
# denegó (NO) un seguro de vida premium

# Target : Seguro
# Predictoras: Edad, Número de hijos, Número de tarjetas 
#              de crédito, Sexo, Ingresos, Educación, 
#              Automóvil y Trabajo.

library(readxl)
datos.s  <- read_excel("Seguros.xlsx")
datos.s  <- as.data.frame(datos.s)

str(datos.s)

datos.s$Seguro    <- factor(datos.s$Seguro)
datos.s$T_credito <- factor(datos.s$T_credito)
datos.s$Sexo      <- factor(datos.s$Sexo)
datos.s$Ingresos  <- factor(datos.s$Ingresos)
datos.s$Educacion <- factor(datos.s$Educacion)
datos.s$Automovil <- factor(datos.s$Automovil)
datos.s$Trabajo   <- factor(datos.s$Trabajo)

str(datos.s)

dim(datos.s)
# [1] 2463    9

contrasts(datos.s$Seguro)

table(datos.s$Seguro)
round(prop.table(table(datos.s$Seguro)),3)*100

#--------------------------------------------------------------
# Nota.-
# Use set.seed(2020) donde sea necesario
# Pregunta 2
# 1. - Para las variables categóricas genere sus 
#      correspondientes variables dummies
#    - Particione la data 80% (train) y 20% (test) usando el 
#      paquete caret() usando set.seed(2020) 
#    - Entrene los modelos con Validación Cruzada y usando el
#      accuracy
#      ctrl <- trainControl(method="cv", 
#                           number=10, classProbs =  TRUE)
#    - Para los modelos use la estandarización range [0,1] para 
#      las variables numéricas
#    - Encuentre el mejor modelo usando SVC, SVM, C5 y CART
#      Describa el procedimiento para obtener los mejores 
#      hiperparámetros para cada algoritmo 
#      (4 puntos)
#
# 2. - Comente sobre la estabilidad del modelo. Justifique su 
#      respuesta numérica y gráficamente (2 puntos)

# 3. - Compare y elija el mejor modelo (de los cuatro entrenados) 
#      en la data de prueba (test) usando la sensibilidad,
#      especificidad, accuracy y AROC 
#      Presente un Cuadro Comparativo:
#                  Sensibilidad  Especificidad  Accuracy AROC
#      SVC
#      SVM
#      C5
#      CART
#      (4 puntos)
