#shinyUI(fluidPage())

library(magrittr)
library(dplyr)
library(ggplot2)
library(shiny)

function(input, output, session) {

  enrollment <- read.csv("../Enrollment2003-2016.csv")

  temp <- reactive({  
  enrollment %>%
    filter(County == input$county) %>% 
    group_by(SupervisoryUnion, year) %>% 
    summarise(EnrollmentSum=sum(Enrollment)) %>% 
    mutate(maxEnrollment=max(EnrollmentSum),enrollmentRatio=EnrollmentSum/maxEnrollment)
  })
    
  output$plot1 <- renderPlot({
    ggplot(temp(), aes(x=year, y=enrollmentRatio, color=SupervisoryUnion)) + geom_line()
  })
}

