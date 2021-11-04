source("global.R", local = TRUE)
source("server.R", local = TRUE)
source("ui.R", local = TRUE)

# Run the application 
shinyApp(ui = ui, server = server)
