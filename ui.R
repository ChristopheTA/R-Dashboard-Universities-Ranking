source("global.R")

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
