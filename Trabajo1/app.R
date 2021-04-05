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
                            title = "Campesino",
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