source("imports.R")
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
      
      selectizeInput(inputId = "type",
                  label = "Score Type",
                  choices = c("teaching", "international", "research", "citations", "income")
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
      plotOutput(outputId = "plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    data %>%
      filter(year==input$years) %>%
        ggplot(aes(x = input$type)) +
        geom_histogram(boundary = 0, binwidth = 5)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

