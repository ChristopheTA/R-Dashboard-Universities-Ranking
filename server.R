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
      filter(year==input$graph_years) %>%
      ggplot(aes_string(x = input$graph_xtype, y = input$graph_ytype)) +
      geom_point()
    
  })
  output$histogram <- renderPlot({
    data %>%
      filter(year==input$histo_years) %>%
      ggplot(aes_string(x = input$histo_type)) +
      geom_histogram(boundary = 0, binwidth = 5)
    
  })
  output$map <- renderLeaflet({
    
    data %>%
      filter(year==input$map_years) %>%
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
  
  output$top10 <- renderTable({
    
    data[order(data$world_rank),] %>%
      filter(year==input$top10_years) %>%
      subset(select = c(world_rank,university_name,country,total_score)) %>%
      head(10)
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
    