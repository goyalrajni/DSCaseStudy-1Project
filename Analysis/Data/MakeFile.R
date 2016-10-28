#Makefile is used when the code includes several R files containing code that fit the models and generate tables and graphs. 
# It is used to re-create all the results by simply running the R files.

#SessionInfo() is provided for the environment where the code was run.
sessionInfo()

#Sourcing the GDPData.R file
source('C:/DSCaseStudy-1Project/Analysis/Data/GDPData.R', echo = TRUE)
#Sourcing the IncomeData.R file
source('C:/DSCaseStudy-1Project/Analysis/Data/IncomeData.R', echo = TRUE)
#Sourcing the MergeData.R file
source('C:/DSCaseStudy-1Project/Analysis/Data/MergeData.R', echo = TRUE)