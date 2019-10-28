#READYING THE ENVIRONMENT AND UPLOADING THE MAIN FILE
#Install Tidyverse to ease removing duplicates and other features
install.packages("tidyverse")
#Add Library that enable removing duplicates
library(tidyverse)
#Add Library "dplyr" but I'm confused because it says dplyr is a part of tidyverse, whatevs.
library(dplyr)

#Store current timestamp as 'now' to use in file name
now <- format(Sys.time(), format = "%m.%d.%Y.%Hh %Mm %Ss")
#print(now)

#view all column names in the data set
names(The311Data_df)

#Create a shorter name to reference the data set
SA311<- The311Data_df

#View structure and class of the data set
str(SA311)

class(SA311)

#Convert all of the dates that came over as 'factors' to 'dates'
SA311$OPENEDDATETIME <- as.Date(SA311$OPENEDDATETIME, "%d/%m/%Y")
SA311$INTERACTIONDATE <- as.Date(SA311$INTERACTIONDATE, "%d/%m/%Y")
SA311$CLOSEDDATETIME <- as.Date(SA311$CLOSEDDATETIME, "%d/%m/%Y")
SA311$CASEID <- as.integer(SA311$CASEID)
SA311$Council.District <- as.factor(SA311$Council.District)
SA311$Council.DistrictNum <- as.numeric(SA311$Council.District)
#confirm conversion
class(SA311$OPENEDDATETIME)
class(SA311$INTERACTIONDATE)
class(SA311$CLOSEDDATETIME)
class(SA311$CASEID)
class(SA311$Council.District)
class(SA311$Council.DistrictNum)

#Take a peak at the data types and first/last several values for each field
head(SA311, n = 30)

tail(SA311)

glimpse(SA311)

#Calculate various numerical summaries related to distrubition and center for each field in the data set.
summary(SA311)

# Most of the data seems ot be from 2018-2019 even though the full set 
# spans back to 2011.

#DaysFrmOpem2Interact has both negative values and positive values (large ones).

#Check for correlation in various numeric fields
cor(SA311$Council.District, SA311$DAYSTOCLOSE, use = "complete.obs")

cor(SA311$DaysFrmOpen2Interact, SA311$DAYSTOCLOSE, use = "complete.obs")

cor(SA311$CASEID, SA311$Council.DistrictNum, use = "complete.obs")

#Check for correlation on ALL numeric field combinations
SA311_num <- data.frame(SA311$CASEID, SA311$DaysFrmOpen2Interact, SA311$DAYSTOCLOSE, SA311$Council.DistrictNum, SA311$XCOORD, SA311$YCOORD)
str(SA311_num)
numnames <- c('CaseID', 'DaystoInteract', 'DaystoClose', 'CouncilDistrict', 'X-Coor', 'Y-Coor')
matrix(cor(SA311_num), 6, 6, dimnames = list(numnames, numnames))

#There do not appear to be any meaningful correlations

#Make a dot chart that shows the number of days it took to close cases by district.
plot(SA311$Council.District, SA311$DAYSTOCLOSE)

#Calculate metrics for center and distribution values for each of the numerical fields.
summary(SA311_num)


#Create a bar chart of total cases per district.
plot(SA311$Council.District)

#names(SA311)

#summary(SA311$Council.DistrictNum)

#summary(SA311$Council.District)

#Store district case totals in a vector
district_volume <- as.numeric(c(summary(SA311$Council.District)))

#Analyze the list of district case totals
summary(district_volume)

#Save list of 11 district names and verify structure.
Council.DistrictNumNames <- as.numeric(c(0:10))

str(Council.DistrictNumNames)

#Verifey district_volume structure
str(district_volume)

district_volume

#Calculate the correlation between district number and quantity of cases
cor(Council.DistrictNumNames, district_volume)

#I did a lot of other calculations but just realizing I only did them in the console
#so they didn't save between sessions );

#ASSUMPTIONS: 
