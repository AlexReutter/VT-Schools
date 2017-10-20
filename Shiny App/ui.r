library(dplyr)
enrollment <- read.csv("../Enrollment2003-2016.csv")


shinyUI(fluidPage(
  titlePanel("VT School Enrollment for selected county"),
  sidebarLayout(
    sidebarPanel(
      selectInput('county', 'County', distinct(enrollment,County))
    ),
    mainPanel(
      h1("Ratio of yearly enrollment to maximum enrollment"),
      plotOutput('plot1')
    )
  )
))