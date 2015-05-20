#load required libraries
library(shiny)
library(scales)
library(plyr)
library(ggplot2)
library(reshape2)
library(dygraphs)
library(xts)

shinyUI(navbarPage(
  title = "NEON TIS Data",

    tabPanel("Wind Speed Time Series",
           fileInput('datafile', "Select data file"),
             
           #selectInput('datafile',
            #           'Select data file',
             #          choices = datafiles,
              #         width = '60%'),
           br(),           
           dygraphOutput("dygraph")
  ),
  
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
