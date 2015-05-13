library(shiny)

shinyServer(function(input, output) {

  makeHistogram <- reactive({
    aes_mapping <- aes_string(x=input$windvar)
    g <- ggplot(data, mapping = aes_mapping) + 
      theme_bw() +
      geom_histogram(binwidth = input$binwidth)
    g
  })
  
  output$histogram <- renderPlot({
    print(makeHistogram())
  })
  
  
})

