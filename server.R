shinyServer(function(input,output) {
   proposalFunction <- function(x.old){
     return(rnorm(1, mean = x.old, sd = input$prop.sd))
   }
   
   targetDensity <- function(x){
     return(dnorm(x, mean = input$target.mean, sd = input$target.sd))
   }
   
  run_metropolis_hatings_MCMC <- function(x.start, N){
     sample = rep(NA, N)
     x.old = x.start
     for(i in 1:N){
       x.new = proposalFunction(x.old)
       p = exp(log(targetDensity(x.new)) - log(targetDensity(x.old)))
       sample[i] = ifelse(runif(1) < p, x.new, x.old) 
       x.old = sample[i]
     }
     #output$sample <- renderPrint(sample)
     return(sample)
  }
  
  data <- reactive({
    chain <- run_metropolis_hatings_MCMC(input$prop.mean, input$sliderN)
    chain = chain[-c(1:input$sliderB)]
  })
  
  output$plot1 <- renderPlot({
    hist(data(),xlab="Value",ylab="N",col="lightgreen",main="")
  })

  output$plot2 <- renderPlot({
    autocorr <- acf(data(),plot=FALSE)
    if (input$show_acf) { plot(autocorr, main = "") }
  })
  
  
  
  
  }
)