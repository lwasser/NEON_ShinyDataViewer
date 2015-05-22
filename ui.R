#load required libraries
library(shiny)
library(scales)
library(plyr)
library(ggplot2)
library(reshape2)
library(xts)
library(dygraphs)

shinyUI(navbarPage(
  title = "NEON TIS Data",
  
  tabPanel("Data",
           fileInput('datafile', "Select data file"),
           br(),
           dataTableOutput('datatable')           
           ),

  tabPanel("Time Series Graph",
           uiOutput('tsvariables'),
           br(),
           dygraphOutput("dygraph", height = "600px")
  ),
  
  tabPanel("Histograms", 
           
           sliderInput("binwidth",
                       "Bin Width:",
                        min = 0,
                        max = 1,
                        value = .5),
           br(),
           uiOutput('histvars'),
        
           plotOutput('histogram', height = "200px")

    )
  

  )
)
