#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinymaterial)

library(caret)
library(tidyverse)
library(dplyr)
library(mlbench)
library(tidyr)
library(fastDummies)
library(randomForest)

# Wrap shinymaterial apps in material_page
ui <- material_page(
    title = "Prediccion de cantidad de hijos por hogar en Colombia",
    nav_bar_fixed = TRUE,
    # Place side-nav in the beginning of the UI
    material_side_nav(
        fixed = TRUE,
        h1("Trabajo 1", align = "center"),
        # Place side-nav tabs within side-nav
        material_side_nav_tabs(
            side_nav_tabs = c(
                "Prediccion de hijos" = "predChild",
                "Variables" = "variables",
                "Enlaces" = "link"
            ),
            icons = c("online_prediction", "insert_chart_outlined", "link")
        )
    ),
    # Define side-nav tab content
    
    material_side_nav_tab_content(
        class = "container",
        side_nav_tab_id = "predChild",
        tags$div(
            class = "",
            style = "margin-top: 25px;",
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Edad",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Edad del jefe del hogar"),
                        material_number_box(
                            "edad",
                            "",
                            0,
                            106,
                            initial_value = 48
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Conyuge",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Vive con el conyuge"),
                        material_dropdown(
                            "vive_con_conyuge",
                            "",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No tiene" = 3
                            )
                        )
                    )
                    
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Educacion",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Nivel de educacion del papa"),
                        material_dropdown(
                            "nvl_educacion_papa",
                            "",
                            choices = c(
                                "Secundaria o menos" = 0,
                                "Educacion superior" = 1
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Educacion",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Nivel de educacion de la mama"),
                        material_dropdown(
                            "nvl_educacion_mama",
                            "",
                            choices = c(
                                "Secundaria o menos" = 0,
                                "Educacion superior" = 1
                            )
                        ) 
                    )
                    
                )
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Rasgos",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Segun sus razgos o pensamiento se considera"),
                        material_dropdown(
                            "rasgos",
                            "",
                            choices = c(
                                "Indigena" = 1,
                                "Gitano (a) (Rom)" = 1,
                                "Raizal del archipielago de San Andres, Providencia y Santa Catalina" = 1,
                                "Palenquero (a) de San Basilio" = 1,
                                "Negro (a), mulato (a) (afrodescendiente), afrocolombiano(a)" = 1,
                                "Ninguno de los anteriores" = 0
                            )
                        ) 
                    )
                    
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Campesino",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Se considera campesino"),
                        material_dropdown(
                            "campesino",
                            "",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No informa" = 9
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Actividad",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Actividad que ocupo mas tiempo la semana pasada"),
                        material_dropdown(
                            "actividad_semana_pasada",
                            "",
                            choices = c(
                                "Trabajando" = 1,
                                "Buscando trabajo" = 2,
                                "Estudiando" = 3,
                                "Oficios del hogar" = 4,
                                "Incapacitado permanente para trabajar" = 5,
                                "Otra actividad" = 6
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Horas",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Horas laboradas la semana anterior"),
                        material_number_box(
                            "horas",
                            "",
                            0,
                            120,
                            initial_value = 31
                        )
                    )
                )
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "EPS",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Esta afiliado a alguna eps"),
                        material_dropdown(
                            "A_EPS",
                            "",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No sabe, no informa" = 9
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "S. social",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("A cual de los siguientes regimenes de seguridad social en salud esta afiliado"),
                        material_dropdown(
                            "SEG_SOCIAL_SALUD",
                            "",
                            choices = c(
                                "Contributivo (eps)" = 1,
                                "Especial (fuerzas armadas, ecopetrol, universidades publicas, magisterio)" = 1,
                                "Subsidiado (eps-s)" = 2,
                                "No sabe, no informa" = 3
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Edad hijo",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("A que edad tuvo su primer hijo (0 si no ha tenido hijos)"),
                        material_number_box(
                            "X1ER_HIJO_EDAD",
                            "",
                            0,
                            47,
                            initial_value = 10
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Dispositivos",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Total de dispositivos con conexion a internet en la casa"),
                        material_number_box(
                            "TOT_DISPOSITIVOS",
                            "",
                            0,
                            7,
                            initial_value = 1
                        )
                    )
                )
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Ingresos",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Ingresos totales del hogar en el mes"),
                        material_number_box(
                            "I_HOGAR",
                            "",
                            0,
                            300000000,
                            initial_value = 1727919
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Energia",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Consumo de energia (pesos)"),
                        material_number_box(
                            "ener_consumo",
                            "",
                            0,
                            1000000,
                            initial_value = 44317
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Gas",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Consumo de gas (Pesos)"),
                        material_number_box(
                            "gas_consumo",
                            "",
                            0,
                            300000,
                            initial_value = 8727
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Vivienda",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Que tipo de vivienda tiene"),
                        material_dropdown(
                            "vivienda_es",
                            "",
                            choices = c(
                                "Propia" = 1,
                                "Arriendo" = 2,
                                "otros: permiso o posesion sin titulo o posesion colectiva" = 3
                            )
                        )
                    )
                )
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Region",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("En que region vive"),
                        material_dropdown(
                            "REGION",
                            "",
                            choices = c(
                                "Caribe" = 1,
                                "Oriental" = 2,
                                "Central" = 3,
                                "Pacifica(sin valle)" = 4,
                                "Bogota" = 5,
                                "Antioquia" = 6,
                                "Valle del cauca" = 7,
                                "San andres" = 8,
                                "Orinoquia - amazonia" = 9
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Vivienda",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$h6("Tipo de vivienda en que vive"),
                        material_dropdown(
                            "TIPO_VIVIENDA",
                            "",
                            choices = c(
                                "Casa" = 1,
                                "Apartamento" = 1,
                                "Cuarto(s)" = 0,
                                "Vivienda tradicional indigena" = 0,
                                "Otro (carpa, contenedor, vagon, embarcacion, cueva, refugio natural, etc)" = 0
                            )
                        )
                    )
                ),
                material_column(
                    width = 6,
                    material_card(
                        title = "Enviar",
                        style = "height: 250px;",
                        divider = TRUE,
                        depth = 3,
                        tags$div(
                            align = "Center",
                            material_modal(
                                modal_id = "modal_result",
                                button_text = "Resultado",
                                button_icon = "open_in_browser",
                                title = "Cantidad de hijos",
                                textOutput("textoresultado")
                            )
                        )
                    )
                )
            )
        )
    ),
    material_side_nav_tab_content(
        class = "container",
        side_nav_tab_id = "variables",
        tags$div(
            class = "",
            style = "margin-top: 25px;
                     margin-left: -125px;",
            material_row(
                material_column(
                    width = 18,
                    material_card(
                        title = "Edad del jefe",
                        depth = 5,
                        ("Corresponde a la edad del jefe del hogar del individuo, es decir aquel que lo sostiene economicamente."),
                        divider=TRUE
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Conyuge",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si el (la) conyugue del individuo vive en el hogar.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Nivel de educacion del papa",
                        divider = TRUE,
                        depth = 5,
                        ("Nivel de educacion maximo alcanzado por del papa del individuo, si es de secundaria o inferior debe seleccionarse la opcion bachillerato, si es cualquier tipo de estudio superior debe seleccionarse esta opcion.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Nivel de educacion de la mama",
                        divider = TRUE,
                        depth = 5,
                        ("Nivel de educacion maximo alcanzado por de la mama del individuo, si es de secundaria o inferior debe seleccionarse la opcion bachillerato, si es cualquier tipo de estudio superior debe seleccionarse esta opcion.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Raza",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si de acuerdo con la cultura, pueblo o rasgos fisicos del individuo este se reconoce como: indigena, gitano (a) (Rom), raizal del archipielago de San Andres, Providencia y Santa Catalina, palenquero (a) de San Basilio o negro (a), mulato (a) (afrodescendiente) o afrocolombiano(a).")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Campesino",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si el individuo se considera campesino o si prefiere no informarlo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Actividad",
                        divider = TRUE,
                        depth = 5,
                        ("Actividad que en la que el individuo ocupo la mayor parte del tiempo la semana pasada.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Horas",
                        divider = TRUE,
                        depth = 5,
                        ("Cantidad de horas durante las cuales el individuo laboro la semana pasada.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "EPS",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si el individuo esta afiliado (a), es cotizante o es beneficiario (a) de alguna entidad de seguridad social en salud (Entidad promotora de salud [EPS] o entidad promotora de salud subsidiada EPS-S).")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "S. Social",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si el regimen de seguridad social en salud al que esta afiliado el individuo es contribuitivo o especial (Seleccionar si), si es subsidiado (seleccionar no) o si prefiere no informarlo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Edad hijo",
                        divider = TRUE,
                        depth = 5,
                        ("Indica la edad a la cual el individuo tuvo su primer hijo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Dispositivos",
                        divider = TRUE,
                        depth = 5,
                        ("Indica la cantidad de dispositivos con acceso a internet en el hogar del individuo, entre estos se incluyen computadores, tabletas, celulares, consolas, televisores y reproductores de sonido.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Ingresos",
                        divider = TRUE,
                        depth = 5,
                        ("Indica los ingresos totales de los miembros del hogar del individuo durante el mes pasado.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Energia",
                        divider = TRUE,
                        depth = 5,
                        ("Cantidad en pesos pagada el mes pasado o la ultima vez por electricidad consumida en el hogar del individuo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Gas",
                        divider = TRUE,
                        depth = 5,
                        ("Cantidad en pesos pagada el mes pasado o la ultima vez por el servicio de gas natural en el hogar del individuo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Vivienda",
                        divider = TRUE,
                        depth = 5,
                        ("Indica si la vivienda del hogar es propia del jefe de hogar del individuo o si es arrendada.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Region",
                        divider = TRUE,
                        depth = 5,
                        ("Indica la region en la que se encuentra la vivienda del individuo.")
                    )
                ),
                material_column(
                    width = 18,
                    material_card(
                        title = "Vivienda (ultima fila)",
                        divider = TRUE,
                        depth = 5,
                        ("Indica el tipo de la vivienda, en caso de que sea una casa o un apartamento se selecciona 1, si se trata de cuarto(s), vivienda tradicional indigena u otros se selecciona 0.")
                    )
                )
            )
        )
    ),
    material_side_nav_tab_content(
        class = "container",
        side_nav_tab_id = "link",
        tags$div(
            class = "",
            style = "margin-top: 25px;
                    margin-left: -125px;",
            material_row(
                material_column(
                    width = 5,
                    material_card(
                        title = (tags$a(href="https://github.com/oorbe/TAE-Tabajo-1-modelos-regresion", "Repositorio github")),
                        depth = 5,
                        divider=TRUE
                    )
                )
            ),
            material_row(
                material_column(
                    width = 5,
                    material_card(
                        title = (tags$a(href="www.rstudio.com", "Video e informe")),
                        divider = TRUE,
                        depth = 5,
                    )
                )
            ),
            material_row(
                material_column(
                    width = 5,
                    material_card(
                        title = (tags$a(href="www.rstudio.com", "Rpubs")),
                        divider = TRUE,
                        depth = 5,
                    )
                )
            )
            
        )
    )
    
)

server <- function(input, output) {
    modelofinal <- readRDS("knn.rds")
    escala <- read.csv("escala.csv",header = TRUE,sep=",",dec=".")
    centro <- read.csv("centro.csv",header = TRUE,sep=",",dec=".")
    output$textoresultado <- renderText({
        # columnas <- c("edad", "vive_con_conyuge", "nvl_educacion_papa", "nvl_educacion_mama", "rasgos", "campesino", "actividad_semana_pasada", "horas", "A_EPS", "SEG_SOCIAL_SALUD", "X1ER_HIJO_EDAD", "TOT_DISPOSITIVOS", "I_HOGAR", "ener_consumo", "gas_consumo", "vivienda_es", "REGION", "TIPO_VIVIENDA")
        resultado <- c(input$edad, input$vive_con_conyuge, input$nvl_educacion_papa, input$nvl_educacion_mama, input$rasgos, input$campesino, input$actividad_semana_pasada, input$horas, input$A_EPS, input$SEG_SOCIAL_SALUD, input$X1ER_HIJO_EDAD, input$TOT_DISPOSITIVOS,input$I_HOGAR, input$ener_consumo, input$gas_consumo, input$vivienda_es, input$REGION, input$TIPO_VIVIENDA)
        datos <- data.frame("edad" = c(as.numeric(resultado[1]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "vive_con_conyuge" = c(as.numeric(resultado[2]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "nvl_educacion_papa" = c(as.numeric(resultado[3]), 0, 1, 0, 0, 0, 0, 0, 0, 0), 
                            "nvl_educacion_mama" = c(as.numeric(resultado[4]), 0, 1, 0, 0, 0, 0, 0, 0, 0), 
                            "rasgos" = c(as.numeric(resultado[5]), 0, 1, 0, 0, 0, 0, 0, 0, 0), 
                            "campesino" = c(as.numeric(resultado[6]), 1, 2, 9, 1, 1, 1, 1, 1, 1), 
                            "actividad_semana_pasada" = c(as.numeric(resultado[7]), 1, 2, 3, 4, 5, 6, 1, 1, 1), 
                            "horas" = c(as.numeric(resultado[8]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "A_EPS" = c(as.numeric(resultado[9]), 1, 2, 9, 1, 1, 1, 1, 1, 1), 
                            "SEG_SOCIAL_SALUD" = c(as.numeric(resultado[10]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "X1ER_HIJO_EDAD" = c(as.numeric(resultado[11]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "TOT_DISPOSITIVOS" = c(as.numeric(resultado[12]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "I_HOGAR" = c(as.numeric(resultado[13]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "ener_consumo" = c(as.numeric(resultado[14]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "gas_consumo" = c(as.numeric(resultado[15]), 1, 2, 3, 1, 1, 1, 1, 1, 1), 
                            "vivienda_es" = c(as.numeric(resultado[16]), 1, 2,3, 1, 1, 1, 1, 1, 1), 
                            "REGION" = c(as.numeric(resultado[17]), 1, 2, 3, 4, 5 ,6, 7, 8, 9), 
                            "TIPO_VIVIENDA" = c(as.numeric(resultado[18]), 1, 0, 1, 1, 1, 1, 1, 1, 1))
        datos <- dummy_cols(datos, select_columns = c("vive_con_conyuge","nvl_educacion_papa",
                                                      "nvl_educacion_mama","rasgos","campesino",
                                                      "actividad_semana_pasada","A_EPS","SEG_SOCIAL_SALUD",
                                                      "vivienda_es","REGION","TIPO_VIVIENDA"),remove_selected_columns  = TRUE)
        
        # Valor real 
        fin_escala <- t(escala)[1, -1]
        fin_centro <- t(centro)[1, -1]
        c(length(fin_centro), length(fin_escala), length(as.numeric(datos[1,])))
    
        datos_norm <- (datos[1, ] - fin_centro) / fin_escala
        names(datos_norm) <- names(datos)
        datos_norm[1]
        names(datos_norm)
        p <- predict(modelofinal, newdata = data.frame(datos_norm))
        p*t(escala)[1]+t(centro)[1]
    })
 }
shinyApp(ui = ui, server = server)