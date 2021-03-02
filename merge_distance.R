
distance<-read.csv("lockdowns/distance_matrix.csv")
distance$source_county<-0
distance$dest_county<-0
library(dplyr)
counties<-read.csv("lockdowns/county_centroids_unweighted.csv")
distance<-left_join(distance,counties,by=c("INPUT_FID"="FID"),suffix=c(" " ,"source"))
distance<-left_join(distance,counties,by=c("NEAR_FID"="FID"),suffix=c( " ","dest"))
write.csv(distance,"lockdowns/distance.csv")

