#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

shinyUI(fluidPage(
    
    # css
    tags$head(
        tags$style(HTML("
                        @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                        
                        h4, li a {
                        font-family: 'Optima', 'sans-serif';
                        font-weight: 500;
                        line-height: 1.3;
                        color:#428bca;
                        }
                        h1 {
                        font-family: 'Apple Chancery', 'cursive';
                        font-weight: 900; line-height: 1.1; 
                        color: #4d3a7d;
                        }
                        
                        body {
                        background-color: #fff;
                        }
                        
                        "))
        ),
    
    # Application title
    
    headerPanel("Average Heights And Weights For American Women"),
    
    # Sidebar with a slider input for number of bins
    
    sidebarLayout(
        sidebarPanel(
            
            h4("Graph Settings"),      
            
            selectInput("chartType", "Chart Type:",
                        c("Scattered" = "point",
                          "Histograph" = "hist",
                          "Box Plot" = "box")),
            checkboxInput("stat", "Show Linear Regression / Normal Distribution", TRUE),
            
            # Input: Select the Theame type ----
            radioButtons("theame", "Theme type:",
                         c("Normal" = "norm",
                           "Black & White" = "bw",
                           "Dark" = "dark",
                           "Linedraw" = "line")),
            
            
            hr(),
            h4("Table Settings"),
            sliderInput("obs",
                        "Number of observations shown in Table:",
                        min = 1,
                        max = 15,
                        value = 15)
            
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Plot",
                         br(),
                         plotlyOutput("distPlot" , height = "100%")
                ),
                tabPanel("Table", tableOutput("table")),
                tabPanel("Summary", 
                         h2("Dataset: women"),
                         verbatimTextOutput("summary"),
                         verbatimTextOutput("tableInfo"),
                         
                         div(class="header", checked=NA,
                             p("More information on dataset ", 
                               a(href="https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/women.html", " is here.")
                             )
                             
                         )
                ),
                tabPanel("About",
                         div(class="header", checked=NA,
                             br(),
                             p( "Coursera Assignment: Shiny Application and Reproducible Pitch" ),
                             p( " Developed By : Madhavi Reddy"),
                             p( " ")
                         )
                )
                
            )
        )
    )
        ))