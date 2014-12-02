## Quiz 4

## Question 1
## The American Community Survey distributes downloadable data about 
## United States communities. Download the 2006 microdata survey about housing 
## for the state of Idaho using download.file() from here:   
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
##
## and load the data into R. The code book, describing the variable names is here:     
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
##
## Apply strsplit() to split all the names of the data frame on the 
## characters "wgtp". What is the value of the 123 element of the resulting list?

## Download and read in file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./data/q1data.csv")
q1data <- read.csv("./data/q1data.csv")

## Split the column names along "wgtp"
split <- strsplit(names(q1data), "wgtp")
## Find the 123rd element of the resulting vector
split[123] 

## [[1]]
## [1] ""   "15"

## Question 2
## Load the Gross Domestic Product data for the 190 ranked countries in this 
## data set: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
##
## Remove the commas from the GDP numbers in millions of dollars and average them. 
## What is the average? 
##
## Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

## Download data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile = "./data/q2data.csv")

## Read in 190 ranked countries and tidy up data enough to work with
q2data <- read.csv("./data/q2data.csv", skip=4, nrows = 190)
names(q2data) <- c("countrycode", "rank", "NA", "country", "millions")

## Use gsub() to repmove commas in GDP, then make the column numeric 
q2data$millions <- gsub(",", "", q2data$millions)
q2data$millions <- as.numeric(q2data$millions)

## Take the mean, ignoring NA values
mean(q2data$millions, na.rm=T) ## [1] 377652.4

## Question 3
## In the data set from Question 2 what is a regular expression that would 
## allow you to count the number of countries whose name begins with "United"?
## Assume that the variable with the country names in it is named countryNames. 
## How many countries begin with United?

## Extract column we are interested in
countryNames <- q2data$country
## Use regular expressions to find countries beginning with "United"
grep("^United", countryNames) ## [1]  1  6 32

## Question 4
## Load the Gross Domestic Product data for the 190 ranked countries in this 
## data set: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
##
## Load the educational data from this data set: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
##
## Match the data based on the country shortcode. Of the countries for which the
## end of the fiscal year is available, how many end in June? 

## Original data sources: 
## http://data.worldbank.org/data-catalog/GDP-ranking-table 
## http://data.worldbank.org/data-catalog/ed-stats

## Download files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url, destfile = "./data/q4gdpdata.csv")
download.file(url2, destfile = "./data/q4edudata.csv")

## Read in data
q4gpddata <- read.csv("./data/q4gdpdata.csv", skip=4, nrows = 190)
names(q4gpddata) <- "CountryCode"
q4edudata <- read.csv("./data/q4edudata.csv")

## Merge data tables by CountryCode
q4data <- merge(q4gpddata, q4edudata, by=c("CountryCode"))

## Look for term "fiscal year end: june"
fiscalYear <- grepl("fiscal year end: june", tolower(q4data$Special.Notes))
length(which(fiscalYear)) ## [1] 13

## Question 5
## You can use the quantmod (http://www.quantmod.com/) package to get historical 
## stock prices for publicly traded companies on the NASDAQ and NYSE. 
## Use the following code to download data on Amazon's stock price and get the 
## times the data was sampled.
##
##          >library(quantmod)
##          >amzn = getSymbols("AMZN",auto.assign=FALSE)
##          >sampleTimes = index(amzn)
##
## How many values were collected in 2012? How many values were collected
## on Mondays in 2012?
library(lubridate)
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

## How many values were collected in 2012?
amzn <- amzn['2012']
nrow(amzn)  
## [1] 250

## On Monday in 2012?
nrow(amzn[.indexwday(amzn)==0])
## [1] 47