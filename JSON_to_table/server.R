
library(DT)
library(data.table)
library(jsonlite)
library(shiny)
library(shinythemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  #---------------------------------------------
  # -------------- Functions -------------------
  #---------------------------------------------

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


  #---------------------------------------------
  # -------------- Outputs ---------------------
  #---------------------------------------------

  # general introduction text
  output$instructions <- renderText({
    if(is.null(input$inputfile)){
      paste("Choose a file to import: once so, a first table",
            "with the general un-nested object will be populated.",
            "In correspondence of each of those, the top menu",
            "allows to choose the corresponding nested sub-lists.", sep="\n")
    } else {
      paste("The top menu allows to choose the",
            "corresponding nested sub-lists.", sep="\n")
    }
  })


  # general output
  output$generalTable <- DT::renderDataTable(
    if(!is.null(input$inputfile))
      datatable(parse_file())
  )

  output$unlisted_values <- DT::renderDataTable(
    if(!is.null(input$inputfile))
      unlisted_values()
  )


})
