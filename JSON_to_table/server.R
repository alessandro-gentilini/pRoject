
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
    return(is.data.frame(argument[[1]][[1]]))
  }

  # format and parse the JSON file as object
  parse_file <- reactive({
      raw.data <- readLines(input$inputfile$datapath, warn = "F")
      rd <- fromJSON(raw.data)
      rd <- data.table(t(rd))
      rd
  })


  # obtaining the unlisted values (values that are not nested)
  unlisted_values <- reactive({
      x <- parse_file()
      x <- x[,which(!sapply(x, is.inner.list)), with = FALSE]
      x
  })


  # obtaining the listed values (values that are nested)
  listed_values <- reactive({
    x <- parse_file()
    x <- x[,which(sapply(x, is.inner.list)), with = FALSE]
    x
  })


  # output tables of flattened listed values
  flattened_lists <- reactive({
    x <- listed_values()
      if(!is.inner.data.frame(x[, input$listed_values, with = FALSE])){
        y <- data.frame(t(unlist(x[, input$listed_values, with = FALSE])))
        names(y) <- unique(unlist(lapply(strsplit(names(y), '.', fixed = TRUE), '[', 2)))
        y
      } else if(is.inner.data.frame(x[, input$listed_values, with = FALSE])){
        y <- x[, input$listed_values, with = FALSE][[1]][[1]]
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

  # output listed values in a column to choose among
  output$listed_values = renderUI({
    req(input$inputfile)
    if(nrow(listed_values()) > 0){
      selectizeInput(inputId = 'listed_values',
                     label = 'nested objects',
                     choices = c("", names(listed_values())),
                     options = list(
                               placeholder = 'choose a nested object...',
                               onInitialize = I('function() { this.setValue(""); }')
                              )
                     )
    } else
      return("no nested objects")
  })

  
  # output of the flattened listed values as a table
  output$listed_values_table <- DT::renderDataTable(
      if(input$listed_values != "")
        datatable(flattened_lists())
  )

})
