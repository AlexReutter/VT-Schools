# Load the packages we plan to use
library(magrittr)
library(dplyr)
library(tidyr)
library(reshape2)

# Create an empty dataframe
# For each year, read the data
# Remove the empty columns and filter out bad rows
# Add the year
# Append the newly read data to the enrollment dataframe
enrollment <- data.frame(County=character(), SupervisoryUnion=character(), OperatingDistrict=character(), 
                 School=character(), year=integer(), Grade=character(), Enrollment=integer(),
                 stringsAsFactors=FALSE)
for (i in 2004:2006) {
  read.csv(paste("CSV data/Enrollment Report ",i-1,"-",i,".csv",sep=""), 
           header=FALSE, skip=23, strip.white = TRUE, colClasses = "character") %>% 
    select(County=V2,SupervisoryUnion=V7,OperatingDistrict=V8,School=V12,
           PKEEE=V13,KPart=V14,KFull=V17,Grade01=V18,Grade02=V19,Grade03=V20,Grade04=V21,Grade05=V25,
           Grade06=V26,ElementaryUngraded=V27,Grade07=V28,Grade08=V31,
           Grade09=V33,Grade10=V34,Grade11=V36,Grade12=V37,SecondaryUngraded=V38) %>%
    filter(School != "", School != "County Total") %>%
    mutate(year = i) -> raw.data
  # Fill in the rows with empty County, SU, OD, and School names
  # Convert blank/NA values for enrollment to 0's
  for (i in 1:21) {
    raw.data[,i][raw.data[,i] == ""] <- NA
  }
  raw.data <- fill(raw.data,County)
  raw.data <- fill(raw.data,SupervisoryUnion)
  raw.data <- fill(raw.data,OperatingDistrict)
  raw.data <- filter(raw.data,School != SupervisoryUnion)
  for (i in 5:21) {
    raw.data[,i] <- as.numeric(raw.data[,i])
    raw.data[,i][is.na(raw.data[,i])] <- 0
  }
  raw.data <- melt(raw.data, id=c("County","SupervisoryUnion","OperatingDistrict","School","year"), variable.name = "Grade", value.name = "Enrollment")
  enrollment <- bind_rows(enrollment,raw.data)
}
for (i in 2007:2016) {
  read.csv(paste("CSV data/Enrollment Report ",i-1,"-",i,".csv",sep=""), 
           header=FALSE, skip=23, strip.white = TRUE, colClasses = "character") %>% 
    select(County=V2,SupervisoryUnion=V7,OperatingDistrict=V8,School=V12,
           PKEEE=V13,KPart=V14,KFull=V17,Grade01=V18,Grade02=V19,Grade03=V20,Grade04=V21,Grade05=V25,
           Grade06=V26,Grade07=V27,Grade08=V28,Grade09=V31,Grade10=V33,Grade11=V34,Grade12=V36) %>%
    filter(School != "", School != "County Total") %>%
    mutate(year = i) -> raw.data
  # Fill in the rows with empty County, SU, OD, and School names
  # Convert blank/NA values for enrollment to 0's
  for (i in 1:19) {
    raw.data[,i][raw.data[,i] == ""] <- NA
  }
  raw.data <- fill(raw.data,County)
  raw.data <- fill(raw.data,SupervisoryUnion)
  raw.data <- fill(raw.data,OperatingDistrict)
  raw.data <- filter(raw.data,School != SupervisoryUnion)
  for (i in 5:19) {
    raw.data[,i] <- as.numeric(raw.data[,i])
    raw.data[,i][is.na(raw.data[,i])] <- 0
  }
  raw.data <- melt(raw.data, id=c("County","SupervisoryUnion","OperatingDistrict","School","year"), variable.name = "Grade", value.name = "Enrollment")
  enrollment <- bind_rows(enrollment,raw.data)
}
for (i in 2017:2017) {
  read.csv(paste("CSV data/Enrollment Report ",i-1,"-",i,".csv",sep=""), 
           header=FALSE, skip=23, strip.white = TRUE, colClasses = "character") %>% 
    select(County=V2,SupervisoryUnion=V7,OperatingDistrict=V8,School=V12,
           PKEEE=V13,KPart=V14,KFull=V17,Grade01=V18,Grade02=V19,Grade03=V20,Grade04=V21,Grade05=V25,
           Grade06=V26,Grade07=V27,Grade08=V28,Grade09=V31,Grade10=V33,Grade11=V34,Grade12=V36) %>%
    filter(School != "", School != "County Total") %>%
    mutate(year = i) -> raw.data
  # Fill in the rows with empty County, SU, OD, and School names
  # Convert blank/NA values for enrollment to 0's
  for (i in 1:19) {
    raw.data[,i][raw.data[,i] == ""] <- NA
  }
  raw.data <- fill(raw.data,County)
  raw.data <- fill(raw.data,SupervisoryUnion)
  raw.data <- fill(raw.data,OperatingDistrict)
  raw.data <- filter(raw.data,School != SupervisoryUnion)
  for (i in 5:19) {
    raw.data[,i] <- as.numeric(raw.data[,i])
    raw.data[,i][is.na(raw.data[,i])] <- 0
  }
  raw.data <- melt(raw.data, id=c("County","SupervisoryUnion","OperatingDistrict","School","year"), variable.name = "Grade", value.name = "Enrollment")
  enrollment <- bind_rows(enrollment,raw.data)
}
rm(raw.data)

enrollment %>% filter(SupervisoryUnion == 'Burlington SD') -> enrollment.BSD
enrollment.BSD %>% group_by(year) %>% summarize(enroll = sum(Enrollment))
enrollment.BSD %>% filter(Grade != 'PKEEE') %>% group_by(year) %>% summarize(enroll = sum(Enrollment))
enrollment.BSD %>% filter(Grade == 'Grade01') %>% group_by(year) %>% summarize(enroll = sum(Enrollment))

