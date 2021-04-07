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
library(data.table)

model <- readRDS("C:/Users/Usuario/Documents/knn.rds")

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
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "age",
                            "Edad del jefe",
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
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "viv_cony",
                            "Vive con el conyuge",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No responde" = 3
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Educacion",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "ed_papa",
                            "Nivel de educacion del papa",
                            choices = c(
                                "Bachillerato" = 0,
                                "Estudios superiores" = 1
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Educacion",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "ed_mama",
                            "Nivel de educacion de la mama",
                            choices = c(
                                "Bachillerato" = 0,
                                "Estudios superiores" = 1
                            )
                        ) 
                    )
                    
                )
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Raza",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "raza",
                            "Considera que pertenece a una raza",
                            choices = c(
                                "Si" = 1,
                                "No" = 0
                            )
                        ) 
                    )
                    
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Campesino",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "camp",
                            "Se considera campesino",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No responde" = 3
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Actividad",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "act_sem_pas",
                            "Actividad que ocupo la semana pasada",
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
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "horas",
                            "Horas laboradas la semana anterior",
                            0,
                            120,
                            initial_value = 31
                        )
                    )
                ),
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "EPS",
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "eps",
                            "Esta afiliado a seguridad social",
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
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "ss",
                            "Seguridad social salud",
                            choices = c(
                                "Si" = 1,
                                "No" = 2,
                                "No sabe, no informa" = 3
                            )
                        )
                    )
                ),
                material_column(
                    width = 3,
                    material_card(
                        title = "Edad hijo",
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "edHijo",
                            "A que edad tuvo su primer hijo",
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
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "disp",
                            "Total de dispositivos en la casa",
                            0,
                            7,
                            initial_value = 1
                        )
                    )
                ),
            ),
            material_row(
                material_column(
                    width = 3,
                    material_card(
                        title = "Ingresos",
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "ing",
                            "Ingresos del hogar",
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
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "ener",
                            "Consumo de energia (pesos)",
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
                        divider = TRUE,
                        depth = 3,
                        material_number_box(
                            "gas",
                            "Consumo de gas (pesos)",
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
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "vivienda",
                            "Que tipo de vivienda tiene",
                            choices = c(
                                "Propia" = 1,
                                "Arrendada" = 2,
                                "No sabe, no informa" = 3
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
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "reg",
                            "En que region vive",
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
                        divider = TRUE,
                        depth = 3,
                        material_dropdown(
                            "t_vivienda",
                            "Tipo de vivienda",
                            choices = c(
                                "0" = 0,
                                "1" = 1
                            )
                        )
                    )
                ),
                material_column(
                    width = 6,
                    material_card(
                        title = "Enviar",
                        divider = TRUE,
                        depth = 3,
                        tags$div(
                            align = "Center",
                            material_button(
                                "submit",
                                "Enviar"
                            )
                        )
                    )
                ),mainPanel(
                    tags$label(h3('Status/Output')), # Status/Output Text Box
                    verbatimTextOutput('contents'),
                    tableOutput('tabledata')) # Prediction results table
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
server<- function(input, output, session) {
    
    # Input Data
    datasetInput <- reactive({  
        
        df <- data.frame(
            Name = c("age",
                     "viv_cony",
                     "ed_papa",
                     "ed_mama",
                     "raza",
                     "camp",
                     "act_sem_pas",
                     "horas",
                     "eps",
                     "ss",
                     "edHijo",
                     "disp",
                     "ing",
                     "ener",
                     "gas",
                     "vivienda",
                     "reg",
                     "t_vivienda"
            ),
            Value = as.character(c(input$age,
                                   input$viv_cony,
                                   input$ed_papa,
                                   input$ed_mama,
                                   input$raza,
                                   input$camp,
                                   input$act_sem_pas,
                                   input$horas,
                                   input$eps,
                                   input$ss,
                                   input$edHijo,
                                   input$disp,
                                   input$ing,
                                   input$ener,
                                   input$gas,
                                   input$vivienda,
                                   input$reg,
                                   input$t_vivienda)),
            stringsAsFactors = FALSE)
        
        #Species <- 0
        #df <- rbind(df, Species)
        #input <- transpose(df)
        
        write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
        
        test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
        
        Output <- data.frame(Prediction=predict(model,test))
        print(Output)
    })
    
    # Status/Output Text Box
    output$contents <- renderPrint({
        if (input$submit>0) { 
            isolate("Calculation complete.") 
        } else {
            return("Server is ready for calculation.")
        }
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$submit>0) { 
            isolate(datasetInput()) 
        } 
    })
}
###################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
