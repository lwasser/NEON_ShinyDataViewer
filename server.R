library(dygraphs)

shinyServer(function(input, output) {

  datafiles <- list.files(path = 'data', pattern = 'min.csv')
  
  readTable <- reactive({
    data <- read.csv(input$datafile[1,4], header = TRUE, stringsAsFactors = FALSE)
  })
  
  readVars <- reactive({
    data <- readTable()
    names <- names(data)
  })
  
  makeTS <- reactive({
    data <- readTable()
    data <- data[,-2]
    data[,1] <- as.POSIXct(substr(data[,1], 1, 19), format = "%Y-%m-%dT%H:%M:%S", tz = "GMT")
    tsdata <- xts(x = data[ , 2:ncol(data)], order.by = data[,1], tzone = "GMT")
  })
  
  makeHistogram <- reactive({
    data <- readTable()
    var <- as.character(input$histvar)
    aes_mapping <- aes_string(x = var)
    g <- ggplot(data, mapping = aes_mapping) + 
      theme_bw() +
      geom_histogram(binwidth = input$binwidth)
    g
  })
 

  makeTimeSeriesChart <- reactive({
    d <- data[,c("DateTime", input$variables)]
    names(d) <- c("DateTime","var")
    g <- ggplot(d, aes(x=DateTime, y = var)) +
      theme_bw() +
      geom_line()
  })
  
  output$datatable <- renderDataTable(readTable(),
                                      options = list(pageLength = 10,
                                                     scrollY = "500px",
                                                     scrollX = "700px",
                                                     scrollCollapse = FALSE,
                                                     dom = 'lfrtip'))
  
  output$histogram <- renderPlot({
    print(makeHistogram())
  })

  output$tsvariables = renderUI({
    selectizeInput('tsvars', 'Choose variable', readVars()[3:length(readVars())], 
                   multiple = TRUE, width = "80%")
  })
  
  output$histvars = renderUI({
    selectInput('histvar', 'Choose variable', readVars()[3:length(readVars())])
  })
  
  output$dygraph <- renderDygraph({
    d <- makeTS()[,c(input$tsvars)]
    minval <- min(d, na.rm = TRUE)
    maxval <- max(d, na.rm = TRUE)
    dygraph(d) %>%
      dyHighlight(highlightCircleSize = 5, 
                  highlightSeriesBackgroundAlpha = 0.2,
                  hideOnMouseOut = FALSE) %>%
      dyAxis("y", label = "", valueRange = c(minval, maxval * 1.2)) %>%
      dyRangeSelector()
  })

})

