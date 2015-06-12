
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  reac_data = reactive({
    # settings and user input
    n = 10000 #the sample size
    reliability = input$reliability
    
    #generate numbers
    true.score = rnorm(n)
    measure.1 = true.score * sqrt(reliability) + rnorm(n) * sqrt(1 - reliability)
    measure.2 = true.score * sqrt(reliability) + rnorm(n) * sqrt(1 - reliability)
    change = measure.2 - measure.1
    
    #into a dataframe
    d = data.frame(true.score,
                   measure.1,
                   measure.2,
                   change)
  })

  output$plot <- renderPlot({
    
    #get data
    d = reac_data()
    c = round(cor(d), 3)
    
    ## PLOT
    #text grob
    text = str_c("Regression effect slope = ", round(lm(change ~ measure.1, d)$coef[2],3))
    grob = grobTree(textGrob(text, x = .95,  y = 0.95, hjust = 1,
                             gp=gpar(col="red", fontsize=13)))
    #ggplot2
    ggplot(d, aes(measure.1, change)) +
      geom_point(alpha = .7) +
      geom_smooth(method = lm, se = F) +
      annotation_custom(grob) +
      scale_x_continuous(breaks = seq(-10, 10, by = .5)) +
      scale_y_continuous(breaks = seq(-10, 10, by = .5)) +
      xlab("First measurement") +
      ylab("Change between first and second measurement")
  })
  
  output$plot2 = renderPlot({
    #Reactive data
    d = reac_data()
    
    #plot
    ggplot(d, aes(measure.1, measure.2)) +
      geom_point(alpha = .7) +
      geom_smooth(method = lm, se = F) +
      scale_x_continuous(breaks = seq(-10, 10, by = .5)) +
      scale_y_continuous(breaks = seq(-10, 10, by = .5)) +
      xlab("First measurement") +
      ylab("Second measurement")
  })
  
  output$table <- DT::renderDataTable({
    #reactive data
    d = reac_data()
    colnames(d) = c("True score", "First measurement", "Second measurement", "Change")
    
    #calculate correlations
    c = round(cor(d), 3)
    
    #settings for table
  }, options = list(searching = F,
                    ordering = F,
                    paging = F,
                    info = F))

})
