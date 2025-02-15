# User interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) Intro tabPanel ----
  tabPanel(title = "About this App",
           
           "background info will go here"
           
  ), # END (Page 1) Intro tabPanel
  
  # (Page 2) Data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerInput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s)",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxGroupButtons input ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select sampling section(s)",
                                               choices = c("Clear Cut" = "clear cut forest", 
                                                           "Old Growth" = "old growth forest"),
                                               selected = c("clear cut forest", "old growth forest"),
                                               justified = TRUE,   # expand buttons to length of box
                                               checkIcon = list(yes = icon("check", lib = "font-awesome"),
                                                                no = icon("xmark"))
                          )
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output")
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel
             
             # penguin tabPanel
             tabPanel(title = "Penguins",
                      
                      # penguins sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        sidebarPanel(
                          
                          # island pickerInput ----
                          pickerInput(inputId = "penguin_island_input",
                                      label = "Select an island(s)",
                                      choices = unique(penguins$island),
                                      selected = c("Dream", "Torgersen", "Biscoe"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # bin sliderInput ----
                          sliderInput(inputId = "penguin_bin_input",
                                      label = "Select number of bins",
                                      min = 2, max = 60,
                                      value = 25
                          )
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ----
                        mainPanel(
                          
                          # penguin histogram output ----
                          plotOutput(outputId = "penguin_histogram_output")
                          
                        ) # END penguin mainPanel
                        
                      ) # END penguins sidebarLayout
                      
             ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
  ) # END (Page 2) Data viz tabPanel
  
) # END UI