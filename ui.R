
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),

  # Application title
  titlePanel("Regression towards the mean"),
  
  HTML("<p><a href='http://en.wikipedia.org/wiki/Regression_toward_the_mean'>Regression towards the mean</a> is a statistical effect that happens when we use an imperfect measurement of something which is nearly always. When this is the case, cases tend to <em>regress towards the mean</em> which is to say that if we measure the same thing twice, the second measurement will be less extreme than the first. The amount of regression is equal to 1 - the test-retest reliability of the measurement.</p>
        <p>The two scatter plots below illustrate the effect by generating 10,000 datapoints. The first plot shows the relationship between the change in scores between measurements and the first measurement. If there is measurement error, the slope will be negative. The second plot shows the relationship between the first and second measurements. You can use the slider to the left to change the reliability of the measurement and observe the effects.</p>
        <p>Understanding the concept is important when designing and interpreting experiments. For instance, if one selects a group of children who perform very poorly in school measured by some achievement test, gives them some kind of special treatment, and then measures their academic ability again, one will probably find that they have improved. However, this effect cannot be attributed to the intervention because improvement was expected for solely statistical reasons due to regression towards the mean. The children's low score on the first testing was not just due to low academic ability but also a host of random factors such as temporary illness, lack of sleep, and hunger that were not present in the second measurement and thus their scores improved. (Note that here we are ignoring <a href='http://emilkirkegaard.dk/en/wp-content/uploads/Retaking-ability-tests-in-a-selection-setting-implications-for-practice-effects-training-performance-and-turnover.pdf'>practice effects which also improve scores on mental tests</a>.)</p>"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("reliability",
                  "Test-retest reliability of the test:",
                  min = 0,
                  max = 1,
                  value = .8,
                  step = .01)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot", width = "50%"),
      plotOutput("plot2", width = "50%"),
      dataTableOutput("table"),
      HTML("Made by <a href='http://emilkirkegaard.dk'>Emil O. W. Kirkegaard</a> using <a href='http://shiny.rstudio.com/'/>Shiny</a> for <a href='http://en.wikipedia.org/wiki/R_%28programming_language%29'>R</a>. Source code available <a href='https://github.com/Deleetdk/regression_towards_the_mean'>on Github</a>.")
    )
  )
))
