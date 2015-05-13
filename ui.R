#load required libraries
library(shiny)
library(scales)
library(plyr)
library(ggplot2)

shinyUI(navbarPage(
  title = "NEON TIS Data",

  tabPanel("Wind Speed Histograms", 
           
      sliderInput("binwidth",
                  "Bin Width:",
                  min = 0,
                  max = 1,
                  value = .5),
      
      selectInput('windvar',
                  "Choose Variable",
                  choices = names(data)[3:5]),
  
      plotOutput('histogram', height = "200px")
    )
  )
)
