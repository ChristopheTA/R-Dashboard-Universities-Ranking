source("imports.R")

times = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-",""))
countrycoord = read.table("country-coordinates-world.csv", sep = ',', header = T, quote = "")
colnames(countrycoord)[3] = "country"
data = merge(times, countrycoord, by = "country")

data$international_students = as.integer(str_replace(data$international_students, "%",""))
colnames(data)[12] = "international_students_ratio"

data$female_male_ratio = as.integer(str_replace(data$female_male_ratio, " : ","."))
colnames(data)[13] = "female_ratio"

g = group_by(data2016, country)
g = unique(summarize(g, n=n(), longitude, latitude, total_score = mean(total_score)))

pal <- colorNumeric(
  palette = "Blues",
  domain = g$teaching)

p = ggplot(data2016, aes(x = total_score, y = teaching))
p = p + geom_point()
p


View(data)
str(data)
