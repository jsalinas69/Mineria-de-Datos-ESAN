###############################
# SEGUNDA PRÁCTICA CALIFICADA #
#   CLASES DESBALANCEADAS     # 
#  Mg. Jesús Salinas Flores   # 
#   jsalinasf@esan.edu.pe     #
###############################

#--------------------------------------------------------------
# Para limpiar el workspace, por si hubiera algún dataset 
# o información cargada
rm(list = ls())

#--------------------------------------------------------------
# Cambiar el directorio de trabajo
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#--------------------------------------------------------------
library(pacman)
p_load(caret, readxl, DMwR, caTools, ggplot2, MLmetrics, 
       dplyr,pROC,DataExplorer) 

######################
#  Lectura de datos  #
######################

#############################################
# ENCUESTA A VENEZOLANOS RESIDENTES EN PERÚ #
#############################################

# La encuesta estuvo dirigida a la población venezolana que
# reside en Perú, se ejecuto desde el 19 de noviembre al 31 de
# diciembre del 2018. 
# El objetivo es caracterizar a los hogares en función a
# variables demográficas, situación migratoria, salud, 
# educación y empleo.
# La muestra es probabilística, estratificada e independiente
# en cada ciudad/cono de estudio.
# El tamaño de la muestra total es de 3611 viviendas con
# población venezolana.

# Variables Predictoras
# Ocupación: ¿Usted se desempeñó en su ocupación principal o
#            negocio como:
#            1) Empleador o patrono
#            2) Trabajador independiente
#            3) Empleado
#            4) Obrero
#            5) Trabajador familiar no remunerado
#            6) Trabajador del hogar
#            7) Otro
# Horas_principal: Total de horas de trabajo en su ocupación 
#                  principal.
# Horas_secundaria: Total de horas de trabajo en su ocupación
#                   secundaria.
# Horas_semana: Total de horas de trabajo en su ocupación 
#               principal y secundaria.
# Disponibilidad: La semana pasada, cumpliendo con sus 
#                 obligaciones actuales de trabajo, ¿Tuvo la 
#                 voluntad de trabajar más horas y además 
#                 estuvo disponible para hacerlo?
#                 1) No
#                 2) Si
# Nro_trabajadores: En su ocupación principal, negocio o 
#                   empresa incluyéndose usted, laboraron:
#                   1) Menos de 100 personas
#                   2) Más de 100 personas.
# Pago: En su ocupación principal,  ¿La frecuencia con que a 
#       usted le pagan es?
#       1) Diario
#       2) Semanal
#       3) Quincenal
#       4) Mensual
# Ingreso: ¿Cuánto fue su ingreso total sin descuentos en 
#          el/la ... anterior, incluyendo horas extras, 
#          bonificaciones, pago por concepto de refrigerio, 
#          movilidad, comisiones, etc.? dinero
# Actividad_sec: No tiene actividad secundaria
#                1) No
#                2) Si
# Ing_principal: Ingreso principal por trabajo
# Estrato_socieconómico: Estrato final
#                        1) Bajo
#                        2) Medio 
#                        3) Alto

# Variable Target o dependiente
# Interés:  ¿Estuvo usted buscando otro trabajo?

data.v <- read_excel("encuesta-venezolanos-INEI.xlsx")

data.v <- as.data.frame(data.v)

data.v$Horas_semana <- NULL
data.v$Ingreso      <- NULL

data.v <- na.omit(data.v)

dim(data.v)

# [1] 4982    11

str(data.v)

data.v$Ocupacion         <- as.factor(data.v$Ocupacion)
levels(data.v$Ocupacion) <- c("patron","trab_indep","empleado","obrero","no_remunerado","trab_hogar","otro")

data.v$Disponibilidad         <- as.factor(data.v$Disponibilidad)
levels(data.v$Disponibilidad) <- c("No", "Si")

data.v$Nro_trabajadores         <-as.factor(data.v$Nro_trabajadores)
levels(data.v$Nro_trabajadores) <-c("menos_100", "mas_100")

data.v$Pago         <- as.factor(data.v$Pago)
levels(data.v$Pago) <- c("diario", "semanal","quincenal","anual")

data.v$Estrato_socioeconomico         <- as.factor(data.v$Estrato_socioeconomico)
levels(data.v$Estrato_socioeconomico) <- c("bajo", "medio","alto")

data.v$Actividad_Sec         <- as.factor(data.v$Actividad_Sec)
levels(data.v$Actividad_Sec) <- c("No","Si")

data.v$Interes         <- as.factor(data.v$Interes)
levels(data.v$Interes) <- c("No", "Si")

contrasts(data.v$Interes)

data.v$Interes <- relevel(data.v$Interes,ref="Si")

contrasts(data.v$Interes)

table(data.v$Interes)
prop.table(table(data.v$Interes))*100

library(DataExplorer)
plot_missing(data.v)

# Donde corresponda asignar una semilla aleatoria, use:
# set.seed(2020)                                      

# 1.  Particione la data 70% (train) y 30% (test) usando el
#     paquete caret. (2 puntoS)


# 2.	Realice un balanceo de datos con:
#     Undersampling, Oversampling y SMOTE
#     (4 puntos)


# 3.  Entrene los modelos con Validación Cruzada. Use: 
#     ctrl <- trainControl(method="cv", number=10)
#     usando Regresión Logística con train() del paquete caret
#     Para los cuatro modelos (incluya los datos sin balancear)
#     Use como indicador en el train el Accuracy
#     (4 puntos)

# 4. De los cuatro modelos indique cual tiene la menor 
#    variancia en la muestra de entrenamiento. 
#    Comente o justifique su respuesta  (2 puntos)


# 5. Presente un cuadro comparando los siguientes indicadores
#    en el testing: 
#    Puntos de corte, Sensibilidad, Especificidad, Accuracy, Log-Loss y
#    AROC para los siguientes modelos:
#    1. Datos sin balancear con punto de corte 0.5
#    2. Datos sin balancear con punto de corte óptimo
#    3. Datos con undersampling con punto de corte 0.5
#    4. Datos con undersampling con punto de corte óptimo
#    5. Datos con oversampling con punto de corte 0.5
#    6. Datos con oversampling con punto de corte óptimo
#    7. Datos con SMOTE con punto de corte 0.5
#    8. Datos con SMOTE con punto de corte óptimo

# El punto de corte óptimo (umbral) búsquelo según el 
# que de la mayor sensibilidad + especificidad

# Finalmente indique cuál sería el modelo escogido. 
# Justifique su respuesta (8 puntos)