library(dplyr)
data2 <- read.csv("y/open_businesses.csv")

county <- read.csv("y/county_id.csv")

covid <- read.csv("y/covid_cases.csv")
distance <- read.csv("outputs/distance.csv")


covid$date <- as.Date(covid$date)
data2$date <- as.Date(data2$date)

# merge the y cariable and LD status
# d2<-merge(data2,d1,by=c("date","FIPS"))
d2 <- merge(data2, county, by = "FIPS")
d2 <- merge(d2, covid, by = c("date", "FIPS"))


d2 <-
  d2 %>% select(
    date,
    FIPS,
    merchants_all,
    statename,
    county_pop2019,
    case_rate,
    new_case_rate,
    cz,
    czname,
    statefips
  )


write.csv(d2, "y/y.csv")
