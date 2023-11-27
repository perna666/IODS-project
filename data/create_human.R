#Script for next week's data 


library(tidyverse)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(gii)
str(hd)

dim(gii)
dim(hd)

ls(gii)
ls(hd)


#Rename the requested variables

#Health and knowledge

hd <- rename(hd,  "GNI"= "Gross National Income (GNI) per Capita")
hd <- rename(hd,  "Life.Exp"= "Life Expectancy at Birth")
hd <- rename(hd,  "Edu.Exp"= "Expected Years of Education")
gii <- rename(gii,  "Mat.Mor"= "Maternal Mortality Ratio")
gii <- rename(gii,  "Ado.Birth"= "Adolescent Birth Rate")

# Empowerment

gii <- rename(gii,  "Parli.F"= "Percent Representation in Parliament")
gii <- rename(gii,  "Edu2.F"= "Population with Secondary Education (Female)")
gii <- rename(gii,  "Edu2.M"= "Population with Secondary Education (Male)")
gii <- rename(gii,  "Labo.F"= "Labour Force Participation Rate (Female)")
gii <- rename(gii,  "Labo.M"= "Labour Force Participation Rate (Male)")

#Calculate new variables

gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M

#Join the datasets using Country as the identifier
hdgii <- inner_join(hd, gii, by = "Country")

#New data has 195 obs and 19 variables, as instructed
dim(hdgii)

#save the new dataset as human.csv
write.csv(hdgii,file="data/human.csv",row.names=FALSE)

#check that the data was saved correctly 
check = read.csv('data/human.csv',header = TRUE)
str(check)
