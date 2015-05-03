#load required libraries
library(shiny)
library(scales)
library(plyr)
library(ggplot2)
data <- read.csv('NEON.D10.CPER.DP1.00001.001.000.010.002.2DWSD_2min.csv')

shinyUI(navbarPage(
  title = "NEON TIS Data",
  tabPanel("Wind Speed Histograms", 
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      plotOutput("minWSHist", height = "200px"),
      plotOutput("meanWSHist", height = "200px"),
      plotOutput("maxWSHist", height = "200px")
    )
  )
)
