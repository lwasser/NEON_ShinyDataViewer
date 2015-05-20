library(dygraphs)

shinyServer(function(input, output) {

  datafiles <- list.files(path = 'data', pattern = 'min.csv')
  
  makeTS <- reactive({
    data <- read.csv(input$datafile[1,4], header = TRUE, stringsAsFactors = FALSE)
    #data <- read.csv(paste("data/", input$datafile, sep = ""), 
    #                 header = TRUE, stringsAsFactors = FALSE)
    data <- data[,-2]
    data[,1] <- as.POSIXct(substr(data[,1], 1, 19), format = "%Y-%m-%dT%H:%M:%S", tz = "GMT")
    tsdata <- xts(x = data[ , 2:ncol(data)], order.by = data[,1], tzone = "GMT")
  })
  
  makeHistogram <- reactive({
    aes_mapping <- aes_string(x=input$windvar)
    g <- ggplot(data, mapping = aes_mapping) + 
      theme_bw() +
      geom_histogram(binwidth = input$binwidth)
    g
  })
 

  makeTimeSeriesChart <- reactive({
    d <- data[,c("DateTime", input$windvar)]
    names(d) <- c("DateTime","var")
    g <- ggplot(d, aes(x=DateTime, y = var)) +
      theme_bw() +
      geom_line()
  })
  
  output$histogram <- renderPlot({
    print(makeHistogram())
  })
  
  output$dygraph <- renderDygraph({
    d <- makeTS()[,1:3]
    minval <- min(d, na.rm = TRUE)
    maxval <- max(d, na.rm = TRUE)
    dygraph(d) %>%
      dyHighlight(highlightCircleSize = 5, 
                  highlightSeriesBackgroundAlpha = 0.2,
                  hideOnMouseOut = FALSE) %>%
      dyAxis("y", label = "Wind Speed (m/s)", valueRange = c(minval, maxval * 1.5)) %>%
      dyRangeSelector()
  })
  
  #,highlightSeriesOpts = list(strokeWidth = 3)
  
})

