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

# La data turkiye-student-evaluation_R_Specific.csv contiene 
# los resultados de la encuesta final de un curso preuniversitario.  Las columnas Q1-Q28 están medidas en una escala de Likert, donde los valores han sido tomados en la escala {1, 2, 3, 4, 5}
#  Q1: The semester course content, teaching method and evaluation system were provided at the start. 
#  Q2: The course aims and objectives were clearly stated at the beginning of the period. 
#  Q3: The course was worth the amount of credit assigned to it. 
#  Q4: The course was taught according to the syllabus announced on the first day of class. 
#  Q5: The class discussions, homework assignments, applications and studies were satisfactory. 
#  Q6: The textbook and other courses resources were sufficient and up to date.	
#  Q7: The course allowed field work, applications, laboratory, discussion and other studies. 
#  Q8: The quizzes, assignments, projects and exams contributed to helping the learning.	
#  Q9: I greatly enjoyed the class and was eager to actively participate during the lectures. 
# Q10: My initial expectations about the course were met at the end of the period or year. 
# Q11: The course was relevant and beneficial to my professional development. 
# Q12: The course helped me look at life and the world with a new perspective. 
# Q13: The Instructor's knowledge was relevant and up to date. 
# Q14: The Instructor came prepared for classes. 
# Q15: The Instructor taught in accordance with the announced lesson plan. 
# Q16: The Instructor was committed to the course and was understandable. 
# Q17: The Instructor arrived on time for classes. 
# Q18: The Instructor has a smooth and easy to follow delivery/speech. 
# Q19: The Instructor made effective use of class hours. 
# Q20: The Instructor explained the course and was eager to be helpful to students. 
# Q21: The Instructor demonstrated a positive approach to students. 
# Q22: The Instructor was open and respectful of the views of students about the course. 
# Q23: The Instructor encouraged participation in the course. 
# Q24: The Instructor gave relevant homework assignments/projects, and helped/guided students. 
# Q25: The Instructor responded to questions about the course inside and outside of the course. 
# Q26: The Instructor's evaluation system (midterm and final questions, projects, assignments, etc.) effectively measured the course objectives. 
# Q27: The Instructor provided solutions to exams and discussed them with students. 
# Q28: The Instructor treated all students in a right and objective manner. 

# Aplique por lo menos 2 técnicas cluster para encontrar clusters y 
# de una descripción. Para encontrar las técnicas use únicamente las
# columnas Q1 hasta la Q28. 
# Verifique la estabilidad de los mismos. 
# Interprete los resultados encontrados.


############################
# II.	Reglas de Asociación #
############################

# El archivo Market_Basket_Optimization.csv contiene los datos 
# de las compras de 7501 clientes de un supermercado durante un 
# fin de semana (sábado y domingo). Aplique el algoritmo a priori
# y encuentre las principales reglas. Justifique los indicadores 
# usados y elimine las reglas redundantes. Presente el o los
# gráfico(s) adecuados. Interprete sus resultados.
