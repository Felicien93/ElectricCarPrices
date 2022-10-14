#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Price of electric cars"),

    
    sidebarLayout(
        sidebarPanel(
            sliderInput("angle",
                        "Angle of the graphic:",
                        min = 1,
                        max = 180,
                        value = 55),
            sliderInput("topSpeed",
                        "What is the top speed of the car?",
                        min = 100,
                        max = 450,
                        value = 200),
            sliderInput("range",
                        "What is the range of the car?",
                        min = 0,
                        max = 1000,
                        value = 500)
        ),

        
        mainPanel(
            plotOutput("topSpeedPlot"),
            h3("Predicted price from data in left panel:"),
            textOutput("pred")
        )
    )
))
