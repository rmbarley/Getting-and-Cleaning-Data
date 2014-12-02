##Question 1
##How many properties are worth $1,000,000 or more?
q1Subset <- subset(data, data$VAL == 24)
View(`q1Subset`)

##Question 3
##Make sure xlsx package is installed
library(xlsx)
myFile <- "question3.xlsx"
dat <- read.xlsx(myFile, sheetIndex = 1, columnIndex = 7:15, 
                 rowIndex = 18:23)
sum(dat$Zip*dat$Ext,na.rm=T)

##Question 4
library(XML)
