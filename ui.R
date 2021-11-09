# Création de l'interface utilisateur
ui <- fluidPage(
  

  # Titre de l'application
  titlePanel("World University Rankings (from 2011 to 2016)"),
  
  # Thème
  theme = shinytheme("cosmo"),
  
  # Bouton GitLab
  actionButton(inputId = 'button',
               label = "View on GitLab",
               icon = icon("gitlab"),
               onclick ="window.open('https://git.esiee.fr/tac/r-and-data-visualisation')"
               ),
  
  # Image ESIEE
  img(src = "ESIEE.png", height = 50, width = 150),
  
  # Noms
  h4(HTML("Hoang-Duc DUONG<br/>Christophe TA")),

  # Création de la page de navigation
  navbarPage("Navigation", 
             
             # Création de l'onglet du graphique
             tabPanel("Graph", fluid = T, icon = icon("chart-line"),
                      sidebarLayout(
                        sidebarPanel(
                          # Sélection de la variable à utiliser sur l'axe des ordonnées
                          selectizeInput(inputId = "graph_ytype",
                                         label = "Select Category for Y",
                                         choices = colnames(data[4:13])[-7]
                          ),    
                          # Sélection de la variable à utiliser sur l'axe des abscisses
                          selectizeInput(inputId = "graph_xtype",
                                         label = "Select Category  for X",
                                         choices = colnames(data[4:13])[-7]
                          ),
                          
                          # Slider des années
                          sliderInput(inputId = "graph_years",
                                      label = "Select Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T)
                        ),
                        # Affichage du graphique
                        mainPanel(
                          plotOutput(outputId = "graph")
                        )
                      )

              ),
             
             # Création de l'onglet de l'histogramme
             tabPanel("Histogram", icon = icon("chart-bar"),
                      sidebarLayout(
                        sidebarPanel(
                          # Sélection de la catégorie
                          selectizeInput(inputId = "histo_type",
                                         label = "Select Category Type",
                                         choices = colnames(data[4:13])[-7]
                          ),
                          
                          # Slider des années
                          sliderInput(inputId = "histo_years",
                                      label = "Select Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T)
                        ),
                        
                        # Affichage de l'histogramme
                        mainPanel(
                          plotOutput(outputId = "histogram")
                          
                        )
                      )
              ),
             
             # Création de l'onglet de la map
             tabPanel("Map", icon = icon("globe-americas"),
                      sidebarLayout(
                        sidebarPanel(
                          # Slider des années
                          sliderInput(inputId = "map_years",
                                      label = "Select Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016
                                      ),
                          
                          # Sélection de la catégorie
                          radioButtons(inputId = "map_type",
                                       label = "Select Category:",
                                       choices = c("Number of Universities", 
                                                   "Number of Students", 
                                                   "Ratio of Students-Staff",
                                                   "Ratio of International Students", 
                                                   "Ratio of Female-Male"),
                                       selected = "Number of Universities")
                        ),
                        
                        # Affichage de la map
                        mainPanel(
                          textOutput(outputId = "maptitle"),
                          leafletOutput(outputId = "map")
                          
                        )
                      )
             ),
             
             # Création de l'onglet du top 10 des universités
             tabPanel("Ranking", icon = icon("university"),
                      sidebarLayout(
                        sidebarPanel(
                          # Slider des années
                          sliderInput(inputId = "top10_years",
                                      label = "Select Year",
                                      min = 2011,
                                      max = 2016,
                                      step = 1,
                                      value = 2016,
                                      animate = T),
                          
                          # Sélection du pays
                          selectizeInput(inputId = "top10_country",
                                         label = "Select Country",
                                         choices = data$country %>% append("World", 0)
                                         )
                        ),
                        
                        # Affichage du tableau
                        mainPanel(
                          textOutput(outputId = "top10title"),
                          tableOutput(outputId = "top10")
                        )
                      )
            )
    )
)

