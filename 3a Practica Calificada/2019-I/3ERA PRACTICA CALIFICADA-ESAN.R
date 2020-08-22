###################################
#   TERCERA PRÁCTICA CALIFICADA   #
#     MODELOS DE CLASIFICACIÓN    # 
#     Mg. Jesús Salinas Flores    # 
#      jsalinasf@esan.edu.pe      #
###################################

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

# La información a analizar proviene de un producto crediticio de
# una institución financiera. 
# El objetivo es predecir si un nuevo cliente de la institución
# financiera podría ser clasificado como moroso o no moroso.
# Se recolectaron datos respecto a 11 atributos registrados de un
# cliente al momento que este se afilia a dicha institución 
# financiera.

library(foreign)
datos <- read.spss("Riesgo_morosidad.sav", 
                   use.value.labels = T,  
                   to.data.frame=TRUE)

attr(datos,"variable.labels") <- NULL

prop.table(table(datos$morosidad))

contrasts(datos$morosidad)
levels(datos$morosidad)  <- c("No_Moroso","Si_Moroso")
attach(datos)

# 1. Realice el pre-procesamiento que considere el más adecuado
# 2. Realice la partición train-test (80-20) usando una semilla
#    de 123
# 3. Realice entrenamiento usando por los menos 3 algoritmos de
#    clasificación (con tuneo y/o grid de hiperparámetros) y un
#    ensamble o stacking.
#    El indicador usado para escoger el mejor modelo será el AUC
