# Cargar modelo 
library(caret)
library(tidyverse)
library(dplyr)
library(mlbench)
library(tidyr)
library(fastDummies)
library(randomForest)
Datos <- read.csv("datos.csv",header = TRUE)
Datos <- Datos[,-1]
Datos <- dummy_cols(Datos, select_columns = c("vive_con_conyuge","nvl_educacion_papa",
                                              "nvl_educacion_mama","rasgos","campesino",
                                              "actividad_semana_pasada","A_EPS","SEG_SOCIAL_SALUD",
                                              "vivienda_es","REGION","TIPO_VIVIENDA"),remove_selected_columns  = TRUE)
Datos_pred_cent <- scale(Datos,center=TRUE,scale=TRUE)
centro<-attr(Datos_pred_cent,"scaled:center")
escala<-attr(Datos_pred_cent,"scaled:scale")
Datos_pred_cent<-as.data.frame(Datos_pred_cent)
modelofinal <- readRDS("knn.rds")
p <- predict(modelofinal, newdata = Datos_pred_cent[15,])
# Valor real 
p*escala[1]+centro[1]
val <- Datos_pred_cent[15,]

