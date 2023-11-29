#Script for human data, new version

#libraries
library(tidyverse)
library(psych)

#read the data was saved correctly 
human = read.csv('data/human.csv',header = TRUE)
str(human)
describe(human)

#Data consists of demographical data from 195 countries, including various indices of human development

#select the wanted columns
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

#remove all observations (rows) with missing values on any variable (column) using the simple na.omit function
human2 <- na.omit(human)

#look manually at the country list
human2$Country

#regions seem to be at end, starting on row 156. Save only rows 1-155.
human3 <- human2[1:155,]

#overwrite human.csv
write.csv(human3,file="data/human.csv",row.names=FALSE)

#check results
check = read.csv('data/human.csv',header = TRUE)
str(check)


