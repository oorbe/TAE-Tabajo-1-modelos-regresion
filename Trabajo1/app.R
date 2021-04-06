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
                "Graficas" = "chart",
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
                )
            )
        )
    ),
    material_side_nav_tab_content(
        class = "container",
        side_nav_tab_id = "chart",
        tags$h1("Second Side-Nav Tab Content")
    ),
    material_side_nav_tab_content(
        class = "container",
        side_nav_tab_id = "link",
        tags$h1("Second Side-Nav Tab Content")
    )
    
)

server <- function(input, output) {
    
}
shinyApp(ui = ui, server = server)