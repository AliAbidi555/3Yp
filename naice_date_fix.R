library(dplyr)
library(tidyr)
library(readr)
library(tidyverse)

data_long<-read.csv("reopening_dataset.csv")
data_long$initial_date<- recode(data_long$initial_date,"04apr2020"="2020-04-04","28mar2020"="2020-03-28","16mar2020"="2020-03-16","22mar2020"="2020-03-22","23mar2020"="2020-03-22","06apr2020"="2020-04-06","19mar2020"="2020-03-19","17mar2020"="2020-03-17","24mar2020"="2020-03-24","03apr2020"="2020-04-03","20mar2020"="2020-03-20","27mar2020"="2020-03-27","26mar2020"="2020-03-26","25mar2020"="2020-03-25","21mar2020"="2020-03-21","30mar2020"="2020-03-30","09apr2020"="2020-04-09","18mar2020"="2020-03-18","31mar2020"="2020-03-31")

data_long$initial_date<-parse_date(data_long$initial_date)

data_long<-gather(data_long,date,open,open_may_1:open_aug_7,factor_key=TRUE)
data_long$date<-as.character(data_long$date)

#Convert the initial dates to year-month-day


data_long$date[data_long$date=="open_may_1"]<-"May-01-2020"

data_long$date[data_long$date=="open_may_8"]<-"May-08-2020"

data_long$date[data_long$date=="open_may_15"]<-"May-15-2020"

data_long$date[data_long$date=="open_may_22"]<-"May-22-2020"

data_long$date[data_long$date=="open_may_29"]<-"May-29-2020"

data_long$date[data_long$date=="open_june_5"]<-"June-05-2020"


data_long$date[data_long$date=="open_june_12"]<-"June-12-2020"


data_long$date[data_long$date=="open_june_19"]<-"June-19-2020"


data_long$date[data_long$date=="open_june_26"]<-"June-26-2020"


data_long$date[data_long$date=="open_july_3"]<-"July-03-2020"


data_long$date[data_long$date=="open_july_10"]<-"July-10-2020"


data_long$date[data_long$date=="open_july_17"]<-"July-17-2020"

data_long$date[data_long$date=="open_july_24"]<-"July-24-2020"


data_long$date[data_long$date=="open_july_31"]<-"July-31-2020"


data_long$date[data_long$date=="open_aug_7"]<-"August-07-2020"

data_long$date<-parse_date(data_long$date,format = "%B%.%d%.%Y")

data_long$date<-as.Date(data_long$date,format="%Y-%m-%d")
data_long$initial_date<-as.Date(data_long$initial_date,format="%Y-%m-%d")

write_csv(data_long,"industry_lockdowns_naics.csv")