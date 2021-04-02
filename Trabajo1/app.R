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
    primary_theme_color = "#2962ff blue accent-4",
    secondary_theme_color = "#e3f2fd blue lighten-5",
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
    tags$div(class = "container"),
        
        material_side_nav_tab_content(
            side_nav_tab_id = "predChild",
            tags$h1("First Side-Nav Tab Content")
        ),
        material_side_nav_tab_content(
            side_nav_tab_id = "chart",
            tags$h1("Second Side-Nav Tab Content")
        ),
        material_side_nav_tab_content(
            side_nav_tab_id = "link",
            tags$h1("Second Side-Nav Tab Content")
        )
    
)

server <- function(input, output) {
    
}
shinyApp(ui = ui, server = server)