library(shiny)
library(tippy)

shinyUI(fluidPage(
  headerPanel("Week 4 Assignment - Xiaoran Guo"),
  titlePanel("Plotting a Markov Chain Monte-Carlo Simulation"),
    sidebarLayout(
      sidebarPanel(
        h3('Parameters'),
        tippy("N of Data Generated", tooltip = "Choose the number of data points to be generated."),
        sliderInput("sliderN","",100,1000,value=500),
        tippy("Burn-in Period", tooltip = "Choose the number of data points from the beginning to be discarded."),
        sliderInput("sliderB","",0,50,value=50),
        checkboxInput("show_acf", "Show ACF",value=TRUE),
        tippy("Proposal function mean", tooltip = "Choose the number of data points from the beginning to be discarded."),
        numericInput("prop.mean","",
                     value=-10,min=-10,max=10,step=1),
        tippy("Proposal function SD", tooltip = "Choose the proposal function SD, i.e. what the initial function's spread is."),
        numericInput("prop.sd","",
                     value=1,min=1,max=10,step=0.5),
        tippy("Target density mean", tooltip = "Target density mean, i.e. where you want your function to end up."),
        numericInput("target.mean","",
                     value=0,min=-10,max=10,step=1),
        tippy("Target density SD", tooltip = "Target density SD, i.e. what the spread of the target density is."),
        numericInput("target.sd","",
                     value=4,min=1,max=10,step=0.5),
        tippy_this(element = "prop.mean", tooltip =  "Choose the proposal function mean, i.e. where your function starts from."),
        tippy_this(element = "prop.sd", tooltip =  "Choose the proposal function SD, i.e. what the initial function's spread is."),
        tippy_this(element = "target.mean", tooltip =  "Target density mean, i.e. where you want your function to end up."),
        tippy_this(element = "target.sd", tooltip =  "Target density SD, i.e. what the spread of the target density is."),
        submitButton('Submit', icon("refresh"))
        ),
      mainPanel(
        h3("Results"),
        p("Hover over the titles for a brief explanation!"),
        column(3,align="center"),
        tippy("Histogram of the Metropolis-Hastings MCMC Run", tooltip = "This plot shows the cumulative run of a Markov chain Monte Carlo run using the Metropolis-Hastings algorithm. Adjust the parameters to the left and click submit for a different run!"),
        plotOutput("plot1"),
        column(4,align="center"),
        tippy("Autocorrelation Function", tooltip = "This is the autocorrelation function of the run. In generating a Markov chain with sufficient information, you would typically expect this to fall as more steps are taken."),
        plotOutput("plot2")
      )
    )
  )
)