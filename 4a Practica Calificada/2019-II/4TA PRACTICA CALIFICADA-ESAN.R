###################################
#    CUARTA PRÁCTICA CALIFICADA   #
#     TÉCNICAS NO SUPERVISADAS    # 
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


#######################
# I. Análisis Cluster #
#######################

# Tasas de Crimenes Violentos por estados en USA
#
# Esta data contiene estadísticas de arrestos por cada 100,000 
# residentes por asesinato (murder), asalto (assault) y 
# violación (rape) en cada uno de los 50 estados de EEUU en 1973. 
# Además se cuenta con el % de la población que está viviendo en 
# áreas urbanas (UrbanPop)

# Cargando los datos
my_data            <- read.csv("USArrests.csv",sep=";")
row.names(my_data) <- my_data$State
my_data            <- my_data[,-1]
USArrests          <- my_data

# I.1 Trabaje para todo el caso con los datos estandarizados. 
#     Encuentre el núméro óptimo de clusters. (2 puntos)
# I.2 Aplique por lo menos 2 técnicas para encontrar clusters y 
#     de una descripción de los mismos. Verifique la estabilidad 
#     de los mismos. (6 puntos)
# I.3 De las dos técnicas aplicadas escoja la que considere
#     la mejor solución. Justifique su respuesta
#     Para dicha técnica, presente un diagrama de líneas.
#     Interprete los resultados encontrados (2 puntos)

############################
# II.	Reglas de Asociación #
############################

# El archivo Cosmetic.csv contiene los datos 
# de las compras por catálogo de una muestra de 1000 clientes 
# durante la campaña por el día de la madre

# Leyendo el archivo de datos
mydata  <-read.csv("Cosmetics.csv",header=T,sep=";")
summary(mydata)
names(mydata)
head(mydata)

# II.1 Aplique el algoritmo a priori y encuentre las
#      principales reglas. Justifique los indicadores usados y
#      elimine las reglas redundantes. (6 puntos)
# II.2 Ordene las reglas según el lift e indique para la primera 
#      regla cómo se obtiene el soporte, la confianza y el lift
#      (4 puntos)
