#source("imports.R")

# Importation des datasets
data = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-",""))

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


# On met world_rank en nombre
data$world_rank = as.integer(str_replace((str_replace(data$world_rank,"=","")),"-","."))

# On met international_students en nombre 
data$international_students = as.integer(str_replace(data$international_students, "%",""))
colnames(data)[12] = "international_students_ratio"

# On met female_male_ration en nombre
data$female_male_ratio = as.integer(str_replace(data$female_male_ratio, " : ","."))
colnames(data)[13] = "female_ratio"


