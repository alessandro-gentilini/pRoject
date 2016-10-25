
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
                                DT::dataTableOutput("unlisted_values"),
                                style= "width: 75%"
                                )
                    )
           ),
           tabPanel("Summary",
                    helpText("A (not so short) help text")
           )
)
