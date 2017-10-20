
enrollment <- read.csv("Enrollment2003-2016.csv")

library(magrittr)
library(dplyr)
library(ggplot2)
library(shiny)

enrollment %>%
  filter(Grade != 'PKEEE') %>%
  group_by(County, year) %>% 
  summarise(EnrollmentSum=sum(Enrollment)) %>% 
  mutate(maxEnrollment=max(EnrollmentSum),enrollmentRatio=EnrollmentSum/maxEnrollment) -> temp

sp<-ggplot(temp, aes(x=year, y=enrollmentRatio, color=County)) + geom_line()
sp

enrollment %>%
  filter(County == "Chittenden County") %>% 
  filter(Grade != 'PKEEE') %>%
  group_by(SupervisoryUnion, year) %>% 
  summarise(EnrollmentSum=sum(Enrollment)) %>% 
  mutate(maxEnrollment=max(EnrollmentSum),enrollmentRatio=EnrollmentSum/maxEnrollment) -> temp

sp<-ggplot(temp, aes(x=year, y=enrollmentRatio, color=SupervisoryUnion)) + geom_line()
sp

temp

runApp("Shiny App")
