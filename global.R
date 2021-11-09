install.packages("tidyverse")
install.packages("shiny")
install.packages("leaflet")
install.packages("geojsonio")
install.packages("shinythemes")
library(tidyverse)
library(shiny)
library(leaflet)
library(geojsonio)
library(shinythemes)




# Importation des datasets
data <- read.table("Data/timesData.csv", sep = ',', header = T, na.strings = c("NA","-",""))
continents <- read.csv("Data/continent.csv") %>% subset(select = c("ï..name", "region"))
colnames(continents) <- c("country", "continent")

# Importation du fichier GeoJSON
countries = geojson_read("Data/countries.geojson", what = "sp")


### Transformation des données ###

# On change le nom de certains pays
# Pas le bon nom
data$country <- data$country %>% str_replace("Hong Kong","Hong Kong S.A.R.")
continents$country <- continents$country %>% str_replace("Hong Kong","Hong Kong S.A.R.")
data$country <- data$country %>% str_replace("Macau","Macao S.A.R")
continents$country <- continents$country %>% str_replace("Macao","Macao S.A.R")
data$country <- data$country %>% str_replace("Serbia","Republic of Serbia")
continents$country <- continents$country %>% str_replace("Serbia","Republic of Serbia")
data$country <- data$country %>% str_replace("Russian Federation","Russia")
data$country <- data$country %>% str_replace("Republic of Ireland","Ireland")

# Erreur
data$country <- data$country %>% str_replace("Unisted States of America","United States of America")
data$country <- data$country %>% str_replace("Unted Kingdom","United Kingdom")

# Fusion des datasets
data <- merge(data, continents, by = "country")

# On met num_students en nombre
data$num_students <- data$num_students %>% 
  str_replace(",","") %>% 
  as.numeric()

# On met world_rank en entier
data$world_rank <- data$world_rank %>% 
  str_replace("=","") %>% 
  str_replace("-",".") %>% 
  as.integer()

# On met international_students en nombre 
data$international_students <- data$international_students %>%
  str_replace("%","") %>%
  as.numeric()
colnames(data)[12] <- "international_students_ratio"

# On met female_male_ration en entier
data$female_male_ratio <- data$female_male_ratio %>%
  str_replace(" : ",".") %>%
  as.integer()
colnames(data)[13] <- "female_ratio"

source("server.R", local = TRUE)
source("ui.R", local = TRUE)

# Run the application 
shinyApp(ui = ui, server = server)

