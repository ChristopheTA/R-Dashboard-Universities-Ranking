source("imports.R")

# Importation des datasets
times = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-",""))
countrycoord = read.table("country-coordinates-world.csv", sep = ',', header = T, quote = "")

# Fusion des datasets
colnames(countrycoord)[3] = "country"
data = merge(times, countrycoord, by = "country")

### Transformation des données ###

# On met world_rank en nombre
data$world_rank = as.integer(str_replace((str_replace(data$world_rank,"=","")),"-","."))

# On met international_students en nombre 
data$international_students = as.integer(str_replace(data$international_students, "%",""))
colnames(data)[12] = "international_students_ratio"

# On met female_male_ration en nombre
data$female_male_ratio = as.integer(str_replace(data$female_male_ratio, " : ","."))
colnames(data)[13] = "female_ratio"



View(data[order(data$world_rank),])
