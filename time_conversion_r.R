data<-read.csv("lockdowns/interventions.csv")


for (i in 5:ncol(data))
{
  data[,i]<-format(as.Date(data[,i]),"%d/%m/%Y")
}

write.csv(data,"outputs/interventions.csv")