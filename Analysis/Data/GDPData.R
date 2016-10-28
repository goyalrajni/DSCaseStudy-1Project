# The "downloader", "dplyr"", "ggplot2"", and "knitr"" libraries are required to carry out this study.
library(downloader)
library(dplyr)
library(ggplot2)
library(knitr)


### GDP Data: Download and tidy up the data


## Download the Gross Domestic Product data for the 190 ranked countries
GDPURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download(GDPURL, destfile = "GrossDomesticProduct.csv")
list.files() # Confirm download to working directory

## Import Gross Domestic Product data and review raw data
GDPRaw <- read.csv("GrossDomesticProduct.csv", stringsAsFactors = FALSE, header = FALSE) 
str(GDPRaw)  # Review raw data internal structure details
head(GDPRaw) # Review beginning rows to look for irrelevant entries
kable(tail(GDPRaw, 100))  # Review last 100 rows to look for irrelevant entries

GDP <- GDPRaw[6:236,] # Remove empty rows at beginning and end of productRaw data.frame
str(GDP) # Review data internal structure details once more
head(GDP) # Review beginning rows once more
tail(GDP) # Review ending rows once more

sum(!is.na(GDP[,c(3,7:10)])) # Identify total number of valid entries

sum(GDP$V2 != "") # Check character type column for valid entries in Column V2
sum(GDP$V2 == "") # Output empty entry counts in Column V2

sum(GDP$V6 != "") # Check character type column for valid entries in Column V6
sum(GDP$V6 == "") # Output empty entry counts in Column V6

GDP <- GDP[,c(1,2,4:6)] ## Extract only valid columns from GDP
str(GDP) # Review data internal structure details
head(GDP) # Review beginning rows
tail(GDP) # Review ending rows

## Provide names for each column
names(GDP) <- c("Country.ShortCode","Country.Rank", "Economy", "GDP.Millions.of.US.Dollars", "Comments")
names(GDP) # Making sure names are added correctly

## Replace comment reference with comment from original data's legend
GDP[GDP$Comments != "",] # View valid comment column entries before edits
GDP$Comments[GDP$Comments == 'a'] <- "Includes Former Spanish Sahara"
GDP$Comments[GDP$Comments == 'b'] <- "Excludes South Sudan"
GDP$Comments[GDP$Comments == 'c'] <- "Covers mainland Tanzania only"
GDP$Comments[GDP$Comments == 'd'] <- "Data are for the area controlled by the government of the Republic of Cyprus"
GDP$Comments[GDP$Comments == 'e'] <- "Excludes Abkhazia and South Ossetia"
GDP$Comments[GDP$Comments == 'f'] <- "Excludes Transnistria"
GDP[GDP$Comments != "",] # View valid comment column entries after editing the data

## Prepare GDP column for type conversion
GDP$GDP.Millions.of.US.Dollars <- gsub(",","", GDP$GDP.Millions.of.US.Dollars, fixed = TRUE) # Remove commas (fixed = TRUE to remove "," as is)
GDP$GDP.Millions.of.US.Dollars <- gsub(".","", GDP$GDP.Millions.of.US.Dollars, fixed = TRUE) # Remove periods (fixed = TRUE to remove "." as is)
head(GDP$GDP.Millions.of.US.Dollars) # Review beginning rows after the conversion process

## Convert column classes as necessary
GDP$GDP.Millions.of.US.Dollars <- as.numeric(GDP$GDP.Millions.of.US.Dollars) # Convert GDP type to numeric
GDP$Country.Rank <- as.integer(GDP$Country.Rank)  # Convert Country.Rank type to integer
str(GDP$GDP.Millions.of.US.Dollars) # Review data internal structure details after the conversion of data types
str(GDP$Country.Rank) # Review data internal structure details after the conversion of data types

GDP[!complete.cases(GDP),] # View all rows for which not all variable data is available

GDP1 <- subset(GDP, GDP$Country.ShortCode != "") # Remove missing Country.Code values from the data frame
GDP1[!complete.cases(GDP1$Country.ShortCode),] # Confirm there are no missing Country.Code values in the data

GDPdata <- GDP1[,c(1,2,4)] # Extract only Country.Code, Country.Rank and GDP column data to be merged
str(GDPdata) # Review extracted data internal structure details
GDPdata[!complete.cases(GDPdata),]  # Confirm there are no missing values in the data
GDPdata <- GDPdata[order(GDPdata$Country.ShortCode),] # Order the data by Country.Code instead of GDP
