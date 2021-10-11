source("imports.R")

times = read.table("timesData.csv", sep = ',', header = T, na.strings = c("NA","-"))
countrycoord = read.table("country-coordinates-world.csv", sep = ',', header = T, quote = "")
colnames(countrycoord)[3] = "country"
data = merge(times, countrycoord, by = "country")

data2016 = filter(data, year == "2016")

g = group_by(data2016, country)
g = unique(summarize(g, n=n(), longitude, latitude, teaching = mean(teaching)))

p = ggplot(g, aes(longitude, latitude))
p = p + geom_point(aes(size = n, color = teaching ))
p
  
p2 = ggplot(data2016, aes(x = international))
p2 = p2 + geom_histogram(boundary = 0, binwidth = 5)
p2
