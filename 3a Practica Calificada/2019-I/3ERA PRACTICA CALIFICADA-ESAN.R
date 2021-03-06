###################################
#   TERCERA PR�CTICA CALIFICADA   #
#     MODELOS DE CLASIFICACI�N    # 
#     Mg. Jes�s Salinas Flores    # 
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
# 1. Descripci�n de los datos #
###############################

# La informaci�n a analizar proviene de un producto crediticio de
# una instituci�n financiera. 
# El objetivo es predecir si un nuevo cliente de la instituci�n
# financiera podr�a ser clasificado como moroso o no moroso.
# Se recolectaron datos respecto a 11 atributos registrados de un
# cliente al momento que este se afilia a dicha instituci�n 
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

# 1. Realice el pre-procesamiento que considere el m�s adecuado
# 2. Realice la partici�n train-test (80-20) usando una semilla
#    de 123
# 3. Realice entrenamiento usando por los menos 3 algoritmos de
#    clasificaci�n (con tuneo y/o grid de hiperpar�metros) y un
#    ensamble o stacking.
#    El indicador usado para escoger el mejor modelo ser� el AUC
