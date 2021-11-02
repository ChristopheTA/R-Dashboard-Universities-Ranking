source("global.R")
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("duc"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "ytype",
                     label = "Y Type",
                     choices = colnames(data[4:13])
      ),    
      selectizeInput(inputId = "xtype",
                     label = "X Type",
                     choices = colnames(data[4:13])
      ),
      selectizeInput(inputId = "type",
                     label = "Score Type",
                     choices = colnames(data[4:13])
      ),
      
      sliderInput(inputId = "years",
                  label = "Year",
                  min = 2011,
                  max = 2016,
                  step = 1,
                  value = 2016,
                  animate = T)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput(outputId = "graph"),
      plotOutput(outputId = "histogram"),
      leafletOutput(outputId = "map")
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  output$graph <- renderPlot({
    data %>%
      filter(year==input$years) %>%
      ggplot(aes_string(x = input$xtype, y = input$ytype)) +
      geom_point()
    
  })
  output$histogram <- renderPlot({
    data %>%
      filter(year==input$years) %>%
      ggplot(aes_string(x = input$type)) +
      geom_histogram(boundary = 0, binwidth = 5)
    
  })
  output$map <- renderLeaflet({
    
    leaflet(g) %>% addTiles() %>%
      addCircles(lng = ~longitude, lat = ~latitude, weight = 1,
                 radius = ~n * 6500, popup =  paste0( "Country:"
                                                      , g$country 
                                                      , "<br>"
                                                      ,"Number of universities:"
                                                      , g$n
                                                      , "<br>"
                                                      ,"Total Score:"
                                                      , g$total_score
                 )
      )
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
