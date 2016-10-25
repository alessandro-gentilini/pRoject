
library(DT)
library(data.table)
library(jsonlite)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  is.inner.list <- function(argument){
    return(is.list(argument[[1]]))
  }

  # format and parse the JSON object
  parse_file <- reactive({
      raw.data <- readLines(input$inputfile$datapath, warn = "F")
      rd <- fromJSON(raw.data)
      rd <- data.table(t(rd))
      rd
  })

  # unlisted values
  unlisted_values <- reactive({
      x <- parse_file()
      x <- x[,which(!sapply(x, is.inner.list)), with = FALSE]
      x <- data.table(x)
      x
  })

  # general output
  output$general <- DT::renderDataTable(
    if(!is.null(input$inputfile))
      datatable(parse_file())
  )

  output$unlisted_values <- DT::renderDataTable(
    if(!is.null(input$inputfile))
      unlisted_values()
  )


})
