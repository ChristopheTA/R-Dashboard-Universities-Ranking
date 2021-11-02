source("ui.R")
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


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
    
    data %>%
      filter(year==input$years) %>%
      group_by(country) %>%
      summarize(n=n(), longitude, latitude) %>%
      unique() %>%
      leaflet() %>% addTiles() %>%
      addCircles(lng = ~longitude, lat = ~latitude, weight = 1,
                 radius = ~n * 6500, popup =  ~paste0( "Country:"
                                                      , country 
                                                      , "<br>"
                                                      ,"Number of universities:"
                                                      , n
                 )
    
    
      )
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
    