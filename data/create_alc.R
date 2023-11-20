#Pentti Henttonen 18.11.2023
#IODS Assignment 3 data wrangling script, reading in original data from http://www.archive.ics.uci.edu/dataset/320/student+performance

library(dplyr)
#read both files using ;-separator
mat = read.csv('data/student-mat.csv', sep=";",header = TRUE)
por = read.csv('data/student-por.csv', sep=";", header = TRUE)

#have a look a the structure, they seem to have the same variables
str(mat)
str(por)

#Join datasets using the syntax and instructions from Exercise 3

free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))


alc <- select(math_por, all_of(join_cols))

for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]

  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}


#Calculate a new variable, the average of daily and weekend alcohol use
alc$alc_use <- (alc$Dalc + alc$Walc) / 2

#Calculate binary logical (alc_use>2) variable indicating high alcohol use
alc <- mutate(alc, high_use = alc_use > 2)

str(alc)

#data looks good, 370 observations and 35 variables now. 
#Looks equal also to: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/alc.csv"

#save data is .csv form
write.csv(alc,file="data/alcohol.csv",row.names=FALSE)

#Check that the saved data is ok
check = read.csv('data/alcohol.csv',header = TRUE)
str(check)
