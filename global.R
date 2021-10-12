source("imports.R")

times = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-"))
countrycoord = read.table("country-coordinates-world.csv", sep = ',', header = T, quote = "")
colnames(countrycoord)[3] = "country"
data = merge(times, countrycoord, by = "country")

data2016 = filter(data, year == "2016")

g = group_by(data2016, country)
g = unique(summarize(g, n=n(), longitude, latitude, teaching = mean(teaching)))

pal <- colorNumeric(
  palette = "Blues",
  domain = g$teaching)
