#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(scatterplot3d)
library(wesanderson)
df<-read.csv("ElectricCarData_Clean.csv")
df$BodyStyle<-as.factor(df$BodyStyle)

shinyServer(function(input, output) {
  form<-df$PriceEuro~df$TopSpeed_KmH+df$Range_Km
  mylinearmodel<-lm(PriceEuro~TopSpeed_KmH+Range_Km,data=df)
    output$topSpeedPlot <- renderPlot({
      col=wes_palette(n=9, name="Zissou1",type="continuous")
      colors <- col[as.numeric(df$BodyStyle)]
        
      scat3D<-scatterplot3d(form,color=colors,xlab = "Top Speed [km/h]",
                            zlab="Price [€]",
                            ylab = "Range [km]", pch=16,angle=input$angle,
                            type="h")
      scat3D$plane3d(mylinearmodel)
      legend("topright", legend = levels(df$BodyStyle),
             col =  colors, pch = 16,bty="o")
      topSpeedInput <- input$topSpeed
      rangeInput <- input$range
      temppred<-predict(mylinearmodel, newdata = data.frame(TopSpeed_KmH = topSpeedInput,Range_Km=rangeInput))
      scat3D$points3d(x=topSpeedInput,y=rangeInput,z=temppred,pch=17)
      scat3D

    })
    modelpred <- reactive({
      topSpeedInput <- input$topSpeed
      rangeInput <- input$range
      predict(mylinearmodel, newdata = data.frame(TopSpeed_KmH = topSpeedInput,Range_Km=rangeInput))
    })
    output$pred <- renderText({
      modelpred()
    })

})
