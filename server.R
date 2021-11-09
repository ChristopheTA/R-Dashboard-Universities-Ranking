server <- function(input, output) {
  
  # Output du graphique
  output$graph <- renderPlot({
    data %>%
      filter(year==input$graph_years) %>%
      ggplot(aes_string(x = input$graph_xtype, y = input$graph_ytype, color = "continent")) +
      geom_point()
    
  })
  
  # Output de l'histogramme
  output$histogram <- renderPlot({
    data %>%
      filter(year==input$histo_years) %>%
      ggplot(aes_string(x = input$histo_type)) +
      geom_histogram(boundary = 0, binwidth = 5)
    
  })
  
  # Output de la map
  output$map <- renderLeaflet({
    # Groupement des données
    grouped_data <- data %>%
      filter(year==input$map_years) %>%
      group_by(country) %>%
      summarize(
        n=n(), 
        num_students = sum(num_students, na.rm = TRUE), 
        international_ratio = mean(international_students_ratio, na.rm = TRUE), 
        female_ratio = mean(female_ratio, na.rm = TRUE)) %>%
      unique() 
    
    # Changement de valeurs en fonction de l'input
    if(input$map_type=="Number of Universities"){
      value <- grouped_data$n
      bins <- c(1, 5, 10, 20, 35, 50, 80, Inf)
      labels <- sprintf(
        "<strong>%s</strong><br/>%g universities <sup></sup>",
        grouped_data$country, value) %>% lapply(htmltools::HTML)
    }
    else if (input$map_type=="Number of Students"){
      value <- grouped_data$num_students
      bins <- c(1, 100000, 250000, 500000, 800000, 1200000, 1500000, Inf)
      labels <- sprintf(
        "<strong>%s</strong><br/>%g students <sup></sup>",
        grouped_data$country, value) %>% lapply(htmltools::HTML)
    }
    else if(input$map_type=="Ratio of International Students"){
      value <- grouped_data$international_ratio
      bins <- c(0, 5, 10, 15, 20, 25, Inf)
      labels <- sprintf(
        "<strong>%s</strong><br/>%g %% of international students <sup></sup>",
        grouped_data$country, value) %>% lapply(htmltools::HTML)
    }
    else{
      value <- grouped_data$female_ratio
      bins <- c(15, 30, 40, 50, 60, 75)
      labels <- sprintf(
        "<strong>%s</strong><br/>%g %% female students <sup></sup>",
        grouped_data$country, value) %>% lapply(htmltools::HTML)
    }
    
    # Création de la palette
    pal <- colorBin("YlOrRd", domain = value, bins = bins)

    
    # Rangement des pays par ordre alphabétique
    countries_data <- countries[countries$ADMIN %in% grouped_data$country,]
    countries_data <- countries_data[order(countries_data$ADMIN),]
    
    # Création de la map
    countries_data %>% leaflet() %>% addTiles %>%
      addPolygons(
        fillColor = ~pal(value),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        label = labels
      )  %>%
      addLegend(pal = pal, values = value, opacity = 0.7, position = "bottomright")
  })
  
  # Output du Top 10 des universités
  output$top10 <- renderTable({
    top10data = data
    if(input$top10_country=="World"){
      top10data <- data
    }
    else{
      top10data <- data %>% filter(country==input$top10_country)
    }
    top10data[order(top10data$world_rank),] %>%
      filter(year==input$top10_years) %>%
      subset(select = c(world_rank,university_name,country,total_score)) %>%
      head(10)
    
  })
  
}

    