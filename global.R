# Importation des datasets
data = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-",""))


# Define server logic required to draw a histogram
countries = geojson_read("countries.geojson", what = "sp")


### Transformation des données ###

# On change le nom de certains pays
# Pas le nom officiel
data$country <- data$country %>% str_replace("Hong Kong","Hong Kong S.A.R.")
data$country <- data$country %>% str_replace("Macau","Macao S.A.R")
data$country <- data$country %>% str_replace("Serbia","Republic of Serbia")
data$country <- data$country %>% str_replace("Russian Federation","Russia")
data$country <- data$country %>% str_replace("Republic of Ireland","Ireland")

# Erreur
data$country <- data$country %>% str_replace("Unisted States of America","United States of America")
data$country <- data$country %>% str_replace("Unted Kingdom","United Kingdom")

# On met num_students en nombre
data$num_students <- data$num_students %>% 
  str_replace(",","") %>% 
  as.numeric()

# On met world_rank en nombre
data$world_rank <- data$world_rank %>% 
  str_replace("=","") %>% 
  str_replace("-",".") %>% 
  as.numeric()

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

data
