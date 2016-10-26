
library(shiny)


navbarPage("JSON to table", theme = shinytheme("united"),
           tabPanel("Upload",
                    fluidRow(align = "center",
                             fileInput(inputId = 'inputfile',
                                       label = 'Choose file to upload',
                                       accept = c(
                                         '.csv',
                                         '.json'
                                       ),
                                       width = '30%'
                             ),
                             div(textOutput("instructions"),
                                 style= "width: 60%;
                                        text-align:justify;
                                        font-size:17px"
                                 )
                    ),
                    br(),
                    fluidRow(align = "center",
                            div(hr(),
                                DT::dataTableOutput("unlisted_values_table"),
                                style= "width: 75%"
                                )
                    )
           ),
           tabPanel("Summary",
                    uiOutput('listed_values'),
                    br(),
                    fluidRow(align = "center",
                             div(hr(),
                                 DT::dataTableOutput("listed_values_table"),
                                 style= "width: 75%"
                             )
                    ),
                    textOutput("condition")
          )

)
