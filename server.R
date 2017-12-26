#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# This is the server logic for a Shiny web application.

library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
    
    output$distPlot <- renderPlotly({
        
        if (input$chartType == 'point')
        {
            p <- ggplot(data=women , aes(x=height, y=weight, color=factor(height) )) + geom_point() +
                labs( color = "Height" )+
                xlab('Height in Inches') +
                ylab('Weight in Lbs')
            if (input$stat == TRUE)
            {
                p <- p + geom_smooth(method = "lm") 
            }
        }
        
        else if (input$chartType == 'hist')
        {      
            # draw the histogram with the specified number of bins
            p <- ggplot(women, aes(x=height)) + 
                geom_histogram(binwidth=1, colour="black", aes(y=..density.., fill=..count..))+
                xlab('Height in Inches')
            
            if (input$stat == TRUE)
            {
                p <- p + stat_function(fun=dnorm,
                                       color="red",
                                       args=list(mean=mean(women$height), 
                                                 sd=sd(women$height)))
            }
        }
        else
        {
            p <-qplot(factor(weight), height, data = women, geom = "boxplot") +
                ylab('Height in Inches') +
                xlab('Weight in Lbs')
            
        }
        
        # Theme managment
        if (input$theame == 'bw'){
            p <- p  + theme_bw()
        }
        else if (input$theame == 'dark'){
            p <- p  + theme_dark()
        }
        else if (input$theame == 'line'){
            p <- p  + theme_linedraw()
        }
        
        ggplotly(p)
    })
    
    # Generate a summary of the dataset
    output$summary <- renderPrint({
        summary(women)
    })
    
    # Generate table
    
    output$table <- output$view <- renderTable({
        head(women , addrownumsmt = TRUE, n = input$obs )}, include.rownames=TRUE
    )
    
    
    # women dataset info
    output$tableInfo <-  renderText({"A data frame with 15 observations on 2 variables"})
    
})