# Define UI for application that draws a histogram
ui <- fluidPage(
  

  # Application title
  titlePanel("J'adore duc"),
  
  # Sidebar with a slider input for number of bins
  navbarPage("duc", 
             tabPanel("Graph", fluid = T, icon = icon("chart-line"),
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput(inputId = "graph_ytype",
                                         label = "Y Type",
                                         choices = colnames(data[4:13])
                          ),    
                          selectizeInput(inputId = "graph_xtype",
                                         label = "X Type",
                                         choices = colnames(data[4:13])
                          ),
                          
                          sliderInput(inputId = "graph_years",
                                      label = "Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T)
                        ),
                        mainPanel(
                          plotOutput(outputId = "graph")
                        )
                      )

              ),
             tabPanel("Histogram", icon = icon("chart-bar"),
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput(inputId = "histo_type",
                                         label = "Score Type",
                                         choices = colnames(data[4:13])
                          ),
                          
                          sliderInput(inputId = "histo_years",
                                      label = "Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          plotOutput(outputId = "histogram")
                          
                        )
                      )
              ),
             tabPanel("Map", icon = icon("globe-americas"),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput(inputId = "map_years",
                                      label = "Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016
                                      )
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          leafletOutput(outputId = "map")
                          
                        )
                      )
             ),
             tabPanel("Top 10", icon = icon("university"),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput(inputId = "top10_years",
                                      label = "Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T)
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          tableOutput(outputId = "top10")
                          
                        )
                      )
            )
    )
)

