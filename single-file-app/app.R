# Load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)


# User interface ----
ui <- fluidPage(
  
  # App title ----
  tags$h1("My App Title"),
  
  # App subtitle ----
  # nested tags allow me to have a level 4 header that's bolded
  #tags$h4(tags$strong("Exploring Antarctic Penguin Data"))
  # for the most common tags, don't need to include tags$
  h4(strong("Exploring Antarctic Penguin Data")),
  
  # Body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # Body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # Year check box input
  checkboxGroupInput(inputId = "year_input",
                     label = "Select year(s):",
                     choices = unique(penguins$year),
                     selected = c(2007, 2008)),
  
  # Data table output
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
  
)

# Server ----
server <- function(input, output){
  
  # Render penguin scatter plot ----
  output$body_mass_scatterplot_output <- renderPlot({
    
    
    # Filter body masses ----
    body_mass_df <- reactive({
      
      penguins |>
        filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
      
    })
    
    # Code to generate our plot
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", 
                                    "Chinstrap" = "purple", 
                                    "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
    
  })
  
  # Filter years
  years_filtered <- reactive({
    penguins |>
    filter(year %in% c(input$year_input))
    })
  
  # Code to generate table
  output$penguin_DT_output <- DT::renderDataTable({
    DT::datatable(years_filtered())
    }) 
  
}

# Combine UI and server into an app ----
shinyApp(ui = ui, server = server)