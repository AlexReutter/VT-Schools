# Load the packages we plan to use
library(magrittr)
library(dplyr)
library(tidyr)
library(reshape2)
library(ggplot2)
library(shiny)

# Read the data
read.csv("CSV data/K12headcount_salary.csv", header=TRUE, strip.white = TRUE) -> staffing

# Checking the numbers in K12headcount_salary.csv vs. K12headcount_school.csv
# They are *close*, but not exactly the same
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  group_by(SY) %>%
  summarise(FTESum=sum(TOTFTE),SALSum=sum(SAL),BenSum=sum(BEN),SubClass="Total") %>%
  mutate(maxFTE=max(FTESum),FTERatio=FTESum/maxFTE)  -> TotStaff
print(TotStaff)
read.csv("CSV data/K12headcount_school.csv", header=TRUE, strip.white = TRUE) %>%
  filter(SUName == "Burlington SD") %>% 
  group_by(Fiscal.Year) %>% 
  summarise(EnrollmentSum=sum(Enrollment),
            K12FTESum=sum(K12FTE),
            TotStaffFTESum=sum(TotStaffFTE))

# Total staff
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SY,SubClass) %>%
  summarise(FTESum=sum(TOTFTE),SALSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(maxFTE=max(FTESum),FTERatio=FTESum/maxFTE) %>% 
  ggplot(aes(x=SY, y=FTESum, color=SubClass)) + geom_line() +
  labs(x="School Year",y="FTE Staff") + scale_x_continuous(breaks = seq(2008,2017,2))

# Staff ratio to maximum year
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SubClass,SY) %>%
  summarise(FTESum=sum(TOTFTE),SALSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(maxFTE=max(FTESum),FTERatio=FTESum/maxFTE)%>% 
  bind_rows(TotStaff) %>%
  ggplot(aes(x=SY, y=FTERatio, color=SubClass)) + geom_line() +
  labs(x="School Year",y="FTE Staff") + scale_x_continuous(breaks = seq(2008,2017,2))

# Salary 
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SubClass,SY) %>%
  summarise(FTESum=sum(TOTFTE),SalSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(maxFTE=max(FTESum),FTERatio=FTESum/maxFTE,SalRatio=SalSum/FTESum)%>% 
  ggplot(aes(x=SY, y=SalSum, color=SubClass)) + geom_line() +
  labs(x="School Year",y="Salary") + scale_x_continuous(breaks = seq(2008,2017,2))

# Salary per FTE
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SubClass,SY) %>%
  summarise(FTESum=sum(TOTFTE),SalSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(maxFTE=max(FTESum),FTERatio=FTESum/maxFTE,SalRatio=SalSum/FTESum)%>% 
  ggplot(aes(x=SY, y=SalRatio, color=SubClass)) + geom_line() +
  labs(x="School Year",y="Salary per FTE") + scale_x_continuous(breaks = seq(2008,2017,2))

# Benefits 
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SubClass,SY) %>%
  summarise(FTESum=sum(TOTFTE),SalSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(FTERatio=FTESum/max(FTESum),SalRatio=SalSum/FTESum,BenRatio=BenSum/FTESum)%>% 
  ggplot(aes(x=SY, y=BenSum, color=SubClass)) + geom_line() +
  labs(x="School Year",y="Benefits") + scale_x_continuous(breaks = seq(2008,2017,2))

# Benefits per FTE
staffing %>%
  filter(SUName == "Burlington SD") %>% 
  filter(SubClass!="#N/A") %>%
  filter(SubClass!="Other") %>%
  group_by(SubClass,SY) %>%
  summarise(FTESum=sum(TOTFTE),SalSum=sum(SAL),BenSum=sum(BEN))%>%
  mutate(FTERatio=FTESum/max(FTESum),SalRatio=SalSum/FTESum,BenRatio=BenSum/FTESum)%>% 
  ggplot(aes(x=SY, y=BenRatio, color=SubClass)) + geom_line() +
  labs(x="School Year",y="Benefits per FTE") + scale_x_continuous(breaks = seq(2008,2017,2))

