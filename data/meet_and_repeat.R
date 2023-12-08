#Script for longitudinal data 
library(tidyverse)
library(psych)

#load the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#check the variables
str(BPRS)
describe(BPRS)
str(RATS)
describe(RATS)

#Along with between-subjects treatment variable, and subject identifier (subject)
#BPRS has 40 subjects' repeated scores. Each week is represented by a separate variable.

#Along with between-subjects group variable, and subject identifier (ID)
#RATS has 16 subjects' repeated scores. Each day in unequal intervals is represented by a separate variable.


#Convert categorical variables into factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Convert both data sets into long form

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) 

BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

glimpse(BPRSL)

RATSL <-  pivot_longer(RATS, cols = -c(ID, Group),
                       names_to = "weekdays", values_to = "rats") %>%
  arrange(weekdays) 

RATSL <-  RATSL %>% 
  mutate(time = as.integer(substr(weekdays,3,4)))


#Check that the conversion was succesful. Now that the data has few columns, it can be printed as whole for examination.
#Another bonus that comes with the long form data. 

str(BPRLS)
str(RATSL)

print(BPRSL,n=360)
print(RATSL,n=176)

#Everything looks good. week/Time variable now indicates the longitudinal data point.
#This is the crucial difference between wide and long forms. 
#Between-subjects variables, (ID/subject and treatment/Group) are repeated for the subjects in every time point.
#By looking at total rows, the conversion seems to be correct:
#40 participants x 9 weeks = 360
#16 participants x 11 weeks = 176

#Plot BPRS values per subjects, separate panels according to treatment (1 or 2)
ggplot(BPRSL, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))

#Plot RATS values per subjects, separate panels according to Group (1,2 or 3)
ggplot(RATSL, aes(x = time, y = rats, linetype = ID)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:8, times=2)) +
  facet_grid(. ~ Group, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(RATSL$rats), max(RATSL$rats)))

#Plots look sane. 



