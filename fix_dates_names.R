data<-read.csv("y/county_id.csv")

data2<-read.csv("y/open_businesses.csv")

county<-read.csv("y/county_id.csv")

covid<-read.csv("y/covid_cases.csv")

#Convert the three columns into one date
data2$date<-as.Date(with(data2,paste(year,month,day,sep="-")),"%Y-%m-%d")

#convert the dates of the covid file as well
covid$date<-as.Date(with(covid,paste(year,month,day,sep="-")),"%Y-%m-%d")



#rename to make matching easier
names(data2)[names(data2)=="countyfips"]<-"FIPS"

#rename the column in the covid dataset to FIPS
names(county)[names(county)=="countyfips"]<-"FIPS"

#rrename the fips column in the covid dataset
names(covid)[names(covid)=="countyfips"]<-"FIPS"

write.csv(data2,"y/open_businesses.csv")
write.csv(covid,"y/covid_cases.csv")
write.csv(county,"y/county_id.csv")