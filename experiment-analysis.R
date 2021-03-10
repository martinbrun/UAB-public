#PUBLIC SECTOR ECONOMICS - EXPERIMENT ANALYSIS
#UNIVERSITAT AUTONOMA DE BARCELONA
#MARCH 2021
#MARTÍN BRUN

rm(list = ls()) #Clear environment

#Loading libraries
library(tidyverse)
library(readxl)
library(dplyr)

#Set Working Directory
setwd("C:/Users/1514133/Google Drive/Martin/Trabajo/UAB/Public Economics")

#########################################
#WITHOUT PUNISHMENT######################
#########################################

#Import Datasets (without punishment)
without_raw <- read_excel("data_without-punishment.xlsx",sheet="decision (subjects table)") #Without punishment data

#Clean No group observations
without_raw <- without_raw[!without_raw$group==0,]

#Split datasets
without_con <- subset(without_raw, subset=variable=="contribution") #data frame with contributions
  names(without_con)[names(without_con)=="decision"] <- "Contribution" #replacing column "decision" for Contribution
without_pay <- subset(without_raw, subset=variable=="totalpayoff_without") #data frame with payoffs 
  names(without_pay)[names(without_pay)=="decision"] <- "Payoff" #replacing column "decision" for Payoff

without_all <- merge(without_con[,c("player ID","group","round","Contribution")],without_pay[,c("player ID","round","Payoff")],by=c("player ID","round")) #Merging necesary information 

without_gro <-without_all %>% 
              group_by(group, round) %>%
              summarise_each(funs(mean))  #Creates means by Group/Round
without_gro <- without_gro[,c(1,2,4,5)] #Cleans Number ID variable  

without_plo <- aggregate(without_gro[,3:4],list(without_gro$round),mean) #Creates means by round
names(without_plo)[1] <- "round" #replacing column 1 for round

#Plot Average contributions
plot(without_plo$round, without_plo$Contribution, type = "l",
     col = "blue", lwd = 2, xlab = "Round",
     ylim = c(0, 20), ylab = "Average contribution")

title("Average contribution to public goods game - 20210304")

legend("bottomleft", lty = 1, cex = 1.2, lwd = 2,
       legend = "Without punishment",
       col = "blue")

#########################################
#WITH PUNISHMENT#########################
#########################################

#Import Datasets (without punishment)
with_raw <- read_excel("data_with-punishment.xlsx",sheet="decision (subjects table)") #With punishment data

#Clean No group observations
with_raw <- with_raw[!with_raw$group==0,]

#Split datasets
with_con <- subset(with_raw, subset=variable=="contribution") #data frame with contributions
names(with_con)[names(with_con)=="decision"] <- "Contribution" #replacing column "decision" for Contribution
with_pay <- subset(with_raw, subset=variable=="totalpayoff_without") #data frame with payoffs 
names(with_pay)[names(with_pay)=="decision"] <- "Payoff" #replacing column "decision" for Payoff

with_all <- merge(with_con[,c("player ID","round","group","Contribution")],with_pay[,c("player ID","round","Payoff")],by=c("player ID","round")) 

with_gro <- with_all %>% 
            group_by(group, round) %>%
            summarise_each(funs(mean))  #Creates means by Group/Round
with_gro <- with_gro[,c(1,2,4,5)] #Cleans Number ID variable  

with_plo <- aggregate(with_gro[,3:4],list(with_gro$round),mean) #Creates means by round
names(with_plo)[1] <- "round" #replacing column 1 for round

#Plot Average contributions, with and without punishment
plot(with_plo$round, with_plo$Contribution, type = "l",
     col = "red", lwd = 2, xlab = "Round",
     ylim = c(0, 20), ylab = "Average contribution")

lines(without_plo$Contribution, col = "blue", lwd = 2)

title("Average contribution to public goods game - 202103")

legend("bottomleft", lty = 1, cex = 1.2, lwd = 2,
       legend = c("Without punishment", "With punishment"),
       col = c("blue", "red"))

#########################################
#ADDING STANDARD DEVIATIONS##############
#########################################

without_plo$sdC <- 0
with_plo$sdC <- 0

for (row in 1:10) {
  sd_aux <- subset(without_gro, round==row,select=Contribution)
  without_plo$sdC[row] <- sd(sd_aux$Contribution)
  
  sd_aux <- subset(with_gro, round==row,select=Contribution)
  with_plo$sdC[row] <- sd(sd_aux$Contribution)
} #Loop that assigns to each round the SD of Contrbituions within groups means

#WITHOUT PUNISHMENT

#Plot Average contributions, without punishment
plot(without_plo$round, without_plo$Contribution, type = "l",
     col = "blue", lwd = 2, xlab = "Round",
     ylim = c(0, 20), ylab = "Average contribution")

title("Contribution to public goods game without punishment")

#Plotting All groups
points(without_gro[[2]], without_gro[[3]])

#Mean + 2 sd
lines(without_plo$Contribution + 2 * without_plo$sdC, col = "red", lwd = 2)

#Mean - 2 sd
lines(without_plo$Contribution - 2 * without_plo$sdC, col = "red", lwd = 2)

legend("bottomleft", legend = c("Mean", "+/- 2 sd"),
       col = c("blue", "red"), lwd = 2, lty = 1, cex = 1.2)

#WITH PUNISHMENT

#Plot Average contributions, with punishment
plot(with_plo$round, with_plo$Contribution, type = "l",
     col = "blue", lwd = 2, xlab = "Round",
     ylim = c(0, 20), ylab = "Average contribution")

title("Contribution to public goods game without punishment")

#Plotting All groups
points(with_gro[[2]], with_gro[[3]])

#Mean + 2 sd
lines(with_plo$Contribution + 2 * with_plo$sdC, col = "red", lwd = 2)

#Mean - 2 sd
lines(with_plo$Contribution - 2 * with_plo$sdC, col = "red", lwd = 2)

legend("bottomleft", legend = c("Mean", "+/- 2 sd"),
       col = c("blue", "red"), lwd = 2, lty = 1, cex = 1.2)

#########################################
#BAR PLOTS###############################
#########################################

temp_d <- c(without_plo$Contribution[1], without_plo$Contribution[10],
            with_plo$Contribution[1], with_plo$Contribution[10]) #Creates data for mean Contribution in 1 and 10 round with and without punishment 
temp <- matrix(temp_d, nrow = 2, ncol = 2, byrow = TRUE) #Compiles in matrix
temp

barplot(temp, 
        main = "Mean contributions in a public goods game",
        ylab = "Contribution",
        beside = TRUE, col = c("Blue", "Red"), 
        names.arg = c("Round 1", "Round 10"))
legend("bottom", pch = 1, col = c("Blue", "Red"),
       c("Without punishment", "With punishment"))

#########################################
#STATISTICAL TEST########################
#########################################

#Is last round different than first round?
##Without punishment
without_first <- subset(without_all, round==1)  #Creates data for Round 1 without punishment            
without_last <- subset(without_all, round==10)  #Creates data for Round 10 without punishment

t.test(x = t(without_first[,4]), y = t(without_last[,4]), paired=TRUE)

##With punishment
with_first <- subset(with_all, round==1)        #Creates data for Round 1 with punishment      
with_last <- subset(with_all, round==10)        #Creates data for Round 10 with punishment

t.test(x = t(with_first[,4]), y = t(with_last[,4]), paired=TRUE)

#Is contribution different without/with punishment?
t.test(x = t(with_all[,4]), y = t(without_all[,4]), paired=TRUE)