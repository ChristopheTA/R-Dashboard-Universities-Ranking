# Define server logic required to draw a histogram
countries = geojson_read("countries.geojson", what = "sp")

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
    # group data
    grouped_data <- data %>%
      filter(year==input$map_years) %>%
      group_by(country) %>%
      summarize(n=n()) %>%
      unique() 
    # create palette
    bins <- c(1, 5, 10, 20, 35, 50, 80, Inf)
    pal <- colorBin("YlOrRd", domain = grouped_data$n, bins = bins)
    # set labels
    labels <- sprintf(
      "<strong>%s</strong><br/>%g universities <sup></sup>",
      grouped_data$country, grouped_data$n) %>% lapply(htmltools::HTML)
    #order countries
    countries_data <- countries[countries$ADMIN %in% grouped_data$country,]
    countries_data <- countries_data[order(countries_data$ADMIN),]
    countries_data %>% leaflet() %>% addTiles %>%
      addPolygons(
        fillColor = ~pal(grouped_data$n),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        label = labels
      )  %>%
      addLegend(pal = pal, values = grouped_data$n, opacity = 0.7, position = "bottomright")
  })
  
  output$top10 <- renderTable({
    
    data[order(data$world_rank),] %>%
      filter(year==input$top10_years) %>%
      subset(select = c(world_rank,university_name,country,total_score)) %>%
      head(10)
    
    
  })
  
}

    