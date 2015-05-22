# NEON_ShinyDataViewer

This is a sample R `shiny` app for visualization of NEON TIS data, including wind speed, air temperature, etc.

In particular, this app illustrates several concepts:
* The use of a JavaScript library, <a href = "http://rstudio.github.io/dygraphs/index.html"> `dygraphs` </a> in a shiny app. `dygraphs` requires a time series, which is made using the `xts` package within a reactive function.
* The use of `fileInput()` to allow a user to select a data file in their own directory
* The use of two other kinds of input UIs, `selectInput` and `selectizeInput`. The first shows a drop-down list, the second shows a box with multiple selections added to it.
* Organization of functions within `server.R` - I like to put items in this order:
  * static statements 
  * reactive functions that manipulate data
  * reactive functions that build tables or charts
  * outputs from a render function
* Organization of objects within `ui.R`
  * Tabs (using `tabPanel()`) help separate different kinds of outputs
  * Inputs at top or left side, output below or right side.
  * In `ui.R`, all functions are separated by commas
  * Shiny provides some functions that generate HTML, like `br()`, which is the same as HTML tag `<br>` (which you could use instead of `br()`).
