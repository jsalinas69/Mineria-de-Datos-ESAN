#######################################
#     CUARTA PR�CTICA CALIFICADA      #
# ENSAMBLE Y STACKING DE ALGORITMOS   # 
#       Mg. Jes�s Salinas Flores      # 
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
# 1. Descripci�n de los datos #
###############################

# El archivo Seguros.xlsx contiene informaci�n sobre 
# 2463 personas a las cuales se les aprob� (SI) o se les 
# deneg� (NO) un seguro de vida premium

# Target : Seguro
# Predictoras: Edad, N�mero de hijos, N�mero de tarjetas 
#              de cr�dito, Sexo, Ingresos, Educaci�n, 
#              Autom�vil y Trabajo.

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

# 1. Relice el preprocesamiento que considere adecuado
#    (eliminaci�n de variables con poca variancia, selecci�n 
#     de variables, etc). (4 puntos)
#    Describa el procedimiento que sigui�
# 2. Trabaje con todos las variables que quedaron de la 
#    pregunta 1
#    - Para las variables categ�ricas genere sus correspondientes 
#      variables dummies
#    - Particione la data 80% (train) y 20% (test) usando el 
#      paquete caret() usando 
#      set.seed(2020)
#    - Entrene los modelos con Validaci�n Cruzada y usando el accuracy
#      set.seed(2020)
#      ctrl <- trainControl(method="cv", 
#                           number=10,classProbs =  TRUE)
#    - Para los modelos use la estandarizaci�n range [0,1] para 
#      las variables num�ricas
#     - Encuentre el mejor modelo usando 
#       a. Ensamble con por lo menos cinco algoritmos o modelos 
#          no correlacionados. 
#          Puede usar cualquier algoritmo o modelo.
#       b. Stacking de por lo menos cinco algoritmos o modelos no 
#          correlacionados. 
#       Para a y b puede usar cualquier algoritmo o modelo.
#       Verifique que los algoritmos o modelos del ensamble o 
#       stacking no est�n correlacionados (12 puntos)
# 3.  Compare el mejor modelo (de a y b) en la data de prueba
#     (test) usando sensibilidad, especificidad, accuracy y AROC. (2 puntos)
#     Mejore cada uno de esos modelos encontrando el punto de 
#     corte �ptimo que de mayor sensibilidad + especificidad
#     (4 puntos)

# Cuadro Comparativo 
#                  Sensibilidad  Especificidad  Accuracy AROC
# Ensamble
# Ensamble umbral
# Stacking
# Stacking umbral