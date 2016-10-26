
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

  is.inner.data.frame <- function(argument){
    return(is.data.frame(argument[[1]]))
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


  # listed values
  listed_values <- reactive({
    x <- parse_file()
    x <- x[,which(sapply(x, is.inner.list)), with = FALSE]
    x <- data.table(x)
    x
  })


  # output tables of flattened listed values
  flattened_lists <- reactive({
    x <- listed_values()
      if(input$listed_values == "address"){
        #if(!is.inner.data.frame(x[, input$listed_value])){
        y <- x[, input$listed_value, with = FALSE]
        y <- data.frame(t(unlist(y)))
        #y <- data.frame(t(unlist(x[, input$listed_value])))
        is.data.frame(y)
        #return(input$listed_values)
      } else {
        y <- y[, input$listed_value][[1]]
        y <- data.table(y)
        y
      }
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

  output$unlisted_values_table <- DT::renderDataTable(
    if(!is.null(input$inputfile))
      unlisted_values()
  )

  # output listed values
  output$listed_values = renderUI({
    req(input$inputfile)
    if(nrow(listed_values()) > 0){
      selectizeInput(inputId = 'listed_values',
                     label = 'nested objects',
                     choices = c("", names(listed_values())),
                     options = list(placeholder = 'choose a nested object...')
                     )
    } else
      return("no nested objects")
  })


  output$listed_values_table <- DT::renderDataTable(
      req(input$listed_values),
      flattened_lists()
  )

  output$condition <- renderText({
    req(input$listed_values)
    is.data.frame(flattened_lists())
  })

})
