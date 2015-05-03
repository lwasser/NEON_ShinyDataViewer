
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {


  
  output$minWSHist <- renderPlot({
    # generate bins based on input$bins from ui.R
    bins <- seq(min(data[,4]), max(data[,5]), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    #hist(data[,4], breaks = bins, col = 'darkgray', border = 'white', xlab = "Wind Speed (m/s)", 
    #     ylab = "Number of Values", main = "Minimum")
    g <- ggplot(data, aes(data[,4])) + 
      theme_bw() +
      geom_histogram(binwidth = (1/(input$bins - 1))*2)
    print(g)
  })

  output$meanWSHist <- renderPlot({
    # generate bins based on input$bins from ui.R
    bins <- seq(min(data[,4]), max(data[,5]), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    g <- ggplot(data, aes(data[,3])) + 
      theme_bw() +
      geom_histogram(binwidth = (1/(input$bins - 1))*2)
    print(g)
  })
  
  output$maxWSHist <- renderPlot({
    # generate bins based on input$bins from ui.R
    bins <- seq(min(data[,4]), max(data[,5]), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    g <- ggplot(data, aes(data[,5])) + 
      theme_bw() +
      geom_histogram(binwidth = (1/(input$bins - 1))*2)
    print(g)
  })
  
})

