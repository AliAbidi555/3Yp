library(dplyr)
library(fuzzyjoin)
library(stringr)
library(tidyr)
county_baseline <- read.csv("nhgis0009_ds240_20185_2018_county.csv")
counties<-read.csv("county_id.csv")


county_baseline <- county_baseline %>% select(
  "STATE", "STATEA", "COUNTY", "COUNTYA", "AKJ0E001", "AKJ0E002", "AKJ0E003", "AKJ0E004", "AKJ0E005", "AKJ0E006",
  "AKJ0E007", "AKJ0E008", "AKJ0E009", "AKJ0E010", "AKJ0E011", "AKJ0E012", "AKJ0E013",
  "AKJ0E014"
)

county_baseline<-county_baseline %>% rename(total=AKJ0E001,"11/21"=AKJ0E002,"23"=AKJ0E003,"31/32/33"=AKJ0E004,"41"=AKJ0E005,"44/45"=AKJ0E006,"22/48/49"=AKJ0E007,"51"=AKJ0E008,"52/53"=AKJ0E009,"54/55/56"=AKJ0E010,"61/62"=AKJ0E011,"71/72"=AKJ0E012,"81"=AKJ0E013,"91"=AKJ0E014,countyname=COUNTY,statename=STATE)


names(county_baseline)
#Fix the county names

county_baseline$countyname<-str_to_lower(county_baseline$countyname)
counties$countyname<-str_to_lower(counties$countyname)
county_baseline$countyname<-str_replace(county_baseline$countyname," county","")

county_baseline<-merge(counties,county_baseline,by=c("countyname","statename"))

county_baseline<-gather(data = county_baseline,key = NAICS,value = emp,"11/21" ,    
                        "23"      ,   "31/32/33"  , "41"    ,     "44/45"   ,   "22/48/49" ,  "51" ,       
                        "52/53"   ,   "54/55/56" ,  "61/62"    ,  "71/72"   ,   "81"  ,       "91")

write.csv(county_baseline,"base_emp.csv")