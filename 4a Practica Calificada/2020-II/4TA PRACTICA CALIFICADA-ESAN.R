#######################################
#     CUARTA PRÁCTICA CALIFICADA      #
# ENSAMBLE Y STACKING DE ALGORITMOS   # 
#       Mg. Jesús Salinas Flores      # 
#        jsalinasf@esan.edu.pe        #
#######################################

#--------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset 
# o informacion cargada
rm(list = ls())

#--------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


###############################
# 1. Descripción de los datos #
###############################
# La información a analizar proviene de 8471 clientes a 
# los que se les otorgó un producto crediticio en una
# institución financiera. 
# El objetivo es predecir si un nuevo cliente de la 
# institución financiera podría ser clasificado como 
# moroso o no moroso.

# Se recolectaron datos respecto a 11 atributos 
# registrados de un cliente al momento que este se afilia
# a dicha institución financiera.

library(foreign)
datos.rm <- read.spss("Riesgo_morosidad.sav", 
                      use.value.labels = T,  
                      to.data.frame=TRUE)

attr(datos.rm,"variable.labels") <- NULL

dim(datos.rm)
# [1] 8471   12

str(datos.rm)

levels(datos.rm$morosidad)  <- c("No_Moroso","Si_Moroso")

contrasts(datos.rm$morosidad)

table(datos.rm$morosidad)
prop.table(table(datos.rm$morosidad))

contrasts(datos.s$Seguro)

# 1. Relice el preprocesamiento que considere adecuado
#    (eliminación de variables con poca variancia, selección 
#     de variables, etc). (4 puntos)
#    Describa el procedimiento que siguió
# 2. Trabaje con todos las variables que quedaron de la 
#    pregunta 1
#    - Para las variables categóricas genere sus correspondientes 
#      variables dummies
#    - Particione la data 80% (train) y 20% (test) usando el 
#      paquete caret() usando 
#      set.seed(2020)
#    - Entrene los modelos con Validación Cruzada y usando el accuracy
#      set.seed(2020)
#      ctrl <- trainControl(method="cv", 
#                           number=10,classProbs =  TRUE)
#    - Para los modelos use la estandarización range [0,1] para 
#      las variables numéricas
#     - Encuentre el mejor modelo usando 
#       a. Ensamble con por lo menos tres algoritmos o modelos 
#          no correlacionados. 
#          Puede usar cualquier algoritmo o modelo.
#       b. Stacking de por lo menos tres algoritmos o modelos no 
#          correlacionados. 
#       Para a y b puede usar cualquier algoritmo o modelo.
#       Verifique que los algoritmos o modelos del ensamble o 
#       stacking no estén correlacionados (12 puntos)
# 3.  Compare el mejor modelo (de a y b) en la data de prueba
#     (test) usando sensibilidad, especificidad, accuracy y AROC. (2 puntos)
#     Mejore cada uno de esos modelos encontrando el punto de 
#     corte óptimo que de mayor sensibilidad + especificidad
#     (4 puntos)

# Cuadro Comparativo 
#                  Sensibilidad  Especificidad  Accuracy AROC
# Ensamble
# Ensamble umbral
# Stacking
# Stacking umbral