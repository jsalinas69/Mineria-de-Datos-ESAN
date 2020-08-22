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
# En el archivo de Excel (Ejemplo Naive Bayes Deportes.xlsx)
# complete las celdas necesarias (use fórmulas y funciones) 
# para hallar la probabilidad y la clase predicha para el 
# nuevo individuo requerido
# (8 puntos)


############################
# Descripción de los datos #
############################

# Se tienen los siguientes 400 datos hipotéticos para poder 
# entrar a una maestría en Informática en una universidad.
# Este conjunto de datos tiene una respuesta binaria
# (resultado, dependiente) con variable llamada admit, 
# que es igual a 1 si el individuo fue admitido a la
# universidad y 0 en caso contrario. 

# Hay tres variables predictoras: 
# GRE, GPA y rango. Vamos a tratar las variables GRE y GPA
# como continuas. 
# La variable de rango toma los valores 1 a 4. 
# Las instituciones con un rango de 1 tienen el más alto 
# prestigio, mientras que aquellos con un rango de 4 tienen 
# los más bajos. 

datos.a <- read.csv("BD-Admision.csv")

dim(datos.a)
# [1] 400   4

str(datos.a)

datos.a$admit         <- factor(datos.a$admit)
levels(datos.a$admit) <- c("No_Admitido","Si_Admitido")

str(datos.a)

contrasts(datos.a$admit)

table(datos.a$admit)
prop.table(table(datos.a$admit))

#---------------------------------------------------------------
# Pregunta 2               
# Trabaje con todos los datos y encuentre el árbol con el 
# cp óptimo usando el algoritmo CART
# Use set.seed(2020) donde corresponda. 
# Comente el patrón encontrado para los que fueron y los que
# no fueron admitidos  (4 puntos)

#---------------------------------------------------------------
# Pregunta 3
# - Particione la data 80% (train) y 20% (test) usando el 
#   paquete caret() usando 
#   set.seed(2020)
#   ctrl <- trainControl(method="cv", 
#                        number=10,classProbs =  TRUE)
# - Para los modelos use la estandarización range [0,1] para 
#   las variables numéricas
# - Encuentre el mejor modelo usando SVC, SVM y C5
#   Describa el procedimiento para obtener los mejores 
#   hiperparámetros para cada algoritmo 
# - Compare y elija el mejor modelo (de los tres entrenados) 
#   en la data de prueba (test) usando la sensibilidad,
#   especificidad y accuracy
#   (8 puntos)