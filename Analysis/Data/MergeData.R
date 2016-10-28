# The "downloader", "dplyr"", "ggplot2"", and "knitr"" libraries are required to carry out this study.
library(downloader)
library(dplyr)
library(ggplot2)
library(knitr)

### Merging of the GDP and the Income Data sets for the analysis of each country's income group classification and GDP ranking

MergeData <- merge(Income1, GDPdata, by = "Country.ShortCode", all = TRUE)
str(MergeData) # Review raw data internal structure details
head(MergeData) # Review beginning rows to ensure no blank observations


