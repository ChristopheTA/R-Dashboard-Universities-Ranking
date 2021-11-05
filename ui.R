# Define UI for application that draws a histogram
ui <- fluidPage(
  

  # Application title
  titlePanel("World University Rankings (from 2011 to 2016)"),
  
  # Theme
  theme = shinytheme("cosmo"),
  
  actionButton(inputId = 'button',
               label = "View on GitLab",
               icon = icon("gitlab"),
               onclick ="window.open('https://git.esiee.fr/tac/r-and-data-visualisation')"
               ),
  
  img(src = "ESIEE.png", height = 50, width = 150),
  h4(HTML("Hoang-Duc DUONG<br/>Christophe TA")),

  # Sidebar with a slider input for number of bins
  navbarPage("Navigation", 
             tabPanel("Graph", fluid = T, icon = icon("chart-line"),
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput(inputId = "graph_ytype",
                                         label = "Select Category for Y",
                                         choices = colnames(data[4:13])
                          ),    
                          selectizeInput(inputId = "graph_xtype",
                                         label = "Select Category  for X",
                                         choices = colnames(data[4:13])
                          ),
                          
                          sliderInput(inputId = "graph_years",
                                      label = "Select Year",
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
                                         label = "Select Category Type",
                                         choices = colnames(data[4:13])
                          ),
                          
                          sliderInput(inputId = "histo_years",
                                      label = "Select Year",
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
                                      label = "Select Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016
                                      ),
                          radioButtons(inputId = "map_type",
                                       label = "Select Category:",
                                       choices = c("Number of Universities", "Number of Students"),
                                       selected = "Number of Universities")
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
                                      label = "Select Year",
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

