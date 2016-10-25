
library(shiny)

shinyUI(
fluidPage(

  # Application title
  titlePanel("JSON to table"),

  # file upload
  column(12, align = "center",
         fileInput(inputId = 'inputfile',
                   label = 'Choose file to upload',
                   accept = c(
                     '.csv',
                     '.json'
                   ),
                   width = '30%'
         )
  ),
  fluidRow(align = "center",
           width = '70%',
           DT::dataTableOutput("general")
  ),
  fluidRow(align = "center",
           width = '70%',
           DT::dataTableOutput("unlisted_values")
  )

)
)
