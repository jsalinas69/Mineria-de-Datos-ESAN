###################################
#    CUARTA PR�CTICA CALIFICADA   #
#     T�CNICAS NO SUPERVISADAS    # 
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


#######################
# I. An�lisis Cluster #
#######################

# Tasas de Crimenes Violentos por estados en USA
#
# Esta data contiene estad�sticas de arrestos por cada 100,000 
# residentes por asesinato (murder), asalto (assault) y 
# violaci�n (rape) en cada uno de los 50 estados de EEUU en 1973. 
# Adem�s se cuenta con el % de la poblaci�n que est� viviendo en 
# �reas urbanas (UrbanPop)

# Cargando los datos
my_data            <- read.csv("USArrests.csv",sep=";")
row.names(my_data) <- my_data$State
my_data            <- my_data[,-1]
USArrests          <- my_data

# I.1 Trabaje para todo el caso con los datos estandarizados. 
#     Encuentre el n�m�ro �ptimo de clusters. (2 puntos)
# I.2 Aplique por lo menos 2 t�cnicas para encontrar clusters y 
#     de una descripci�n de los mismos. Verifique la estabilidad 
#     de los mismos. (6 puntos)
# I.3 De las dos t�cnicas aplicadas escoja la que considere
#     la mejor soluci�n. Justifique su respuesta
#     Para dicha t�cnica, presente un diagrama de l�neas.
#     Interprete los resultados encontrados (2 puntos)

############################
# II.	Reglas de Asociaci�n #
############################

# El archivo Cosmetic.csv contiene los datos 
# de las compras por cat�logo de una muestra de 1000 clientes 
# durante la campa�a por el d�a de la madre

# Leyendo el archivo de datos
mydata  <-read.csv("Cosmetics.csv",header=T,sep=";")
summary(mydata)
names(mydata)
head(mydata)

# II.1 Aplique el algoritmo a priori y encuentre las
#      principales reglas. Justifique los indicadores usados y
#      elimine las reglas redundantes. (6 puntos)
# II.2 Ordene las reglas seg�n el lift e indique para la primera 
#      regla c�mo se obtiene el soporte, la confianza y el lift
#      (4 puntos)
