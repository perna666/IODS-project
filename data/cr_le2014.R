#Pentti Henttonen 13.11.2023
#IODS Assignment 2 data wrangling script

#Read data and have a look
d0 = read.table('http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep="\t", header = TRUE)
str(d0)
dim(d0)
head(d0)

#Conclusions: Data consists of 60 variables from 183 participants. 
#Likely includes four scales: Aa-Af, ST01-SU32, Ca-Ch, Da-D
#Also has two sum variables (Attitude and Points) and two demographic variables (Age and gender)

#Calculating the sum scores
d0$Attitude<-(d0$Da+d0$Db+d0$Dc+d0$Dd+d0$De+d0$Df+d0$Dg+d0$Dh+d0$Di+d0$Dj)/10
d0$Deep<-(d0$D03+d0$D11+d0$D19+d0$D27+d0$D07+d0$D14+d0$D22+d0$D30+d0$D06+d0$D15+d0$D23+d0$D31)/12
d0$Stra<-(d0$ST01+d0$ST09+d0$ST17+d0$ST25+d0$ST04+d0$ST12+d0$ST20+d0$ST28)/8
d0$Surf<-(d0$SU02+d0$SU10+d0$SU18+d0$SU26+d0$SU05+d0$SU13+d0$SU21+d0$SU29+d0$SU08+d0$SU16+d0$SU24+d0$SU32)/12
d0$Points<-d0$Points

#Prune the data to include only values with Points>0 and the desired variabels
d1 <- d0[which(!d0$Points==0),c('gender','Age','Attitude','Deep','Stra','Surf','Points')]

#Save the new data
setwd("C:/Users/phentton/OneDrive - University of Helsinki/Documents/2023/OPENDATASCIENCE/IODS-project")
write.csv(d1,file="data/learning2014.csv",row.names=FALSE)

#Load and check the new data, looks good
d2 <-read.csv('data/learning2014.csv')
str(d2)
dim(d2)
head(d2)
