# The "downloader", "dplyr"", "ggplot2"", and "knitr"" libraries are required to carry out this study.
library(downloader)
library(dplyr)
library(ggplot2)
library(knitr)


## Download the educational data 
educURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download(educURL, destfile = "Education.csv")

list.files() # Confirm download to working directory


EducationRaw <- read.csv("Education.csv", stringsAsFactors = FALSE, header = TRUE) # Try reading characters in as strings instead of factors for easier manipulation
str(EducationRaw) # Review raw data internal structure details
head(EducationRaw) # Review beginning rows to look for irrelevant entries
tail(EducationRaw) # Review ending rows to look for irrelevant entries



## Rename CountryCode variable to match GDPdata's Country.ShortCode
Education <- rename(EducationRaw, Country.ShortCode = CountryCode)


## Check NAs or missing values in columns of interest
nrow(Education[Education$Country.ShortCode == "",])
nrow(Education[Education$Income.Group == "",])
nrow(Education[Education$Short.Name == "",])



## Extract Country.Code and Income.Group columns
Income <- Education[,c(1,3,31)]
sum(complete.cases(Income))
head(Income)
Income1 <- Income[complete.cases(Income),]
sum(complete.cases(Income1))
