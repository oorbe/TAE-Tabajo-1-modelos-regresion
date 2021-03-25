mu <- c(0.3,0.7)
m <- matrix(c(0.5,0.5,0.25,0.75),2,2,T)
mu %*% (m%*%m)
mu %*% m
       
m <- matrix(c(0,1,1,0),2,2,T)
m
m%*%m
m %*% (m%*%m)


# AQUI LE DOY UN VISTAZO A LA BASE DE DATOS  'CARACTERISTICA Y COMPOSICION DEL HOGAR':
library(tidyverse)

#TABLAS PERSONAS
getwd()
setwd('C:/Users/Oliver/Documents/9/TAE/Trabajo1 regresion/tablas de personas')
d_f <- read.csv('Caracteristicas y composicion del hogar.csv', header = T, sep = ';')
unique(d_f$SECUENCIA_P)
summary(df)

no_hijos <-   d_f %>% 
  group_by(ï..DIRECTORIO, SECUENCIA_P) %>% # agrupo por vivienda y hogar
  dplyr::filter(P6051 == 3) %>% # Selecciono el parentesco con jefe de hogar 3= hij@ o hijastr@
  count(P6051) # Cuento esas frecuencias


which(table(no_hijos$ï..DIRECTORIO)==2) # encontrar los que aparecen dos veces, lo verifique con 2 y 3
table(no_hijos$ï..DIRECTORIO)[209] # verifico 
d_f %>% filter(ï..DIRECTORIO == 7122042 | ï..DIRECTORIO==7126603) # consulto y observo que esta contando bien
no_hijos %>% filter(ï..DIRECTORIO == 7122042 | ï..DIRECTORIO==7126603) # Finalmente verifico que si esta haciendo lo debido
no_hijos %>% filter(ï..DIRECTORIO == 7120005) # este es alguien sin hijos, no está en no_hijos

# Las variables que me interesan son :
# vivienda, seq_hogar, seq_encuesta,edad, vive_con_conyuge, nvl_educacion_p, nvl_educacion_m, razgos, campesino, s_vida, s_ingreso s_salud, s_seguridad, s_actividad_actual, escalon
df1 <- d_f %>% select(ï..DIRECTORIO,SECUENCIA_ENCUESTA,SECUENCIA_P,P6040,P6071,P6087,
                       P6088,P6080, P2057,P1895,P1896,P1897,P1898,P1899,P1927)
# defino los nombres de las columnas
colnames(df1) <- c('ï..DIRECTORIO','SECUENCIA_ENCUESTA','SECUENCIA_P','edad', 'vive_con_conyuge', 'nvl_educacion_papa', 'nvl_educacion_mama', 'razgos', 'campesino', 's_vida', 's_ingreso', 's_salud', 's_seguridad', 's_actividad_actual', 'escalon')
df_2 <- no_hijos %>%  # volvemos a el estado normal mostrando el numero de hijo por hogar
  full_join(df1,by = c('ï..DIRECTORIO' = 'ï..DIRECTORIO', 'SECUENCIA_P'='SECUENCIA_P'))

df_2 <- df_2 %>% replace_na(list(n=0)) # Reemplazo los NA's los cuales serán aqullos que no tiene hijos.


d_f %>% filter(ï..DIRECTORIO==7120005) # al usar la union no recupera ningun P6051
df_2 %>% filter(ï..DIRECTORIO==7120005)
df_2$P6051 <- d_f$P6051 # la bse vuvlve a su normalidad con P6051

any(is.na(df4)) # ayudan a veifia NA´s
colSums(is.na(df4))


df3 <- df_2 %>% unite("id", ï..DIRECTORIO:SECUENCIA_P, remove = FALSE) # uno estas V. para identificar
df4 <- df3 %>% distinct(id,.keep_all = T) # Selecciono los únicos valores. Ahora tengo los hogares un sus hijo identificado de manera única.

# verifico otra base para comapra rsultados
dff <- read.csv('Agrupacion1.csv', header = T, sep=',')

# Para los NA´s: vive conyuge 2 = no, nvl de educa = 0, campesino = no informa =3, s = satisfaccio... = 0 
df4<- df4 %>% replace_na(list(vive_con_conyuge=2)) 
df4[is.na(df4)] <- 0
summary(df4)
# Reemplzo nvl educa 9 y 10 por o los cuales son sin estudio
df4$nvl_educacion_mama[which(df4$nvl_educacion_mama == 10 | df4$nvl_educacion_mama==9)] <- 0
df4$nvl_educacion_papa[which(df4$nvl_educacion_papa == 10 | df4$nvl_educacion_papa==9)] <- 0
filter(df4, ï..DIRECTORIO==7120005)


# TABLAS DE HOGAR:
# Uso de energéticos del hogar
setwd('C:/Users/Oliver/Documents/9/TAE/Trabajo1 regresion/tablas hogares')
ener_hogar <- read.csv('Uso de energéticos del hogar.csv', sep=';')
ener_hogar <- ener_hogar %>% select(ï..DIRECTORIO,SECUENCIA_ENCUESTA,SECUENCIA_P,P5018,P8524)
# Les pongo nombres entendibles:
colnames(ener_hogar) <- c("ï..DIRECTORIO","SECUENCIA_ENCUESTA" ,"SECUENCIA_P",'ener_consumo','gas_consumo')
names(ener_hogar)

summary(ener_hogar)# muchos NA's, se pondrán en 0
ener_hogar <- ener_hogar %>% replace_na(list(ener_consumo=0,gas_consumo=0)) # Reemplazo los NA's los cuales serán aqullos que no tiene hijos.
# asi es smás facil reeplazar NA : datos[is.na(datos)] <- 0
summary(ener_hogar)
apply(ener_hogar, 2, max)
colSums(is.na(ener_hogar))
