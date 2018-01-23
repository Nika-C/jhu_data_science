#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
library(e1071) 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # data collection and transformation
  
  population_object <- reactive({
    
    obj <- list()
    
    if (input$distribution_type=="binomial"){
      p <- input$bi_prob

      obj$pop_data <-  rbinom(10000, size = 1, prob = input$bi_prob)

    } 
    
    if (input$distribution_type=="uniform"){
      
      xlim <- input$un_range
      obj$pop_data <- runif(10000, min = xlim[1], max = xlim[2])
    }
    
    if (input$distribution_type=="normal"){
      
      mju <- input$norm_mju
      sd <- input$norm_sd
      obj$pop_data <- rnorm(10000, mean = mju, sd = sd)
    }
    
    obj$pop_mju <- mean(obj$pop_data)
    obj$pop_sd <- sd(obj$pop_data)
    obj$density <- density(obj$pop_data)
    obj
    
  })
  
  
  sampling_object <- reactive ({
    
    pop_data <- population_object()$pop_data
      
    obj <- list()
    
    set.seed(2017-11-27)
    obj$samp_data <- replicate(input$sample_n,
                               
                               sample(pop_data,
                                      size = input$sample_size,
                                      replace = T),
                               
                                      simplify = F) %>% sapply(mean)
    
    obj$samp_mju <- mean(obj$samp_data)
    obj$samp_sd <- sd(obj$samp_data)
    obj$density <- density(obj$samp_data)
    obj$samp_skew <- skewness(obj$samp_data)
    obj$samp_kurt <- kurtosis(obj$samp_data)
    
    obj
    
  })
  
  # rendering population outputs
  
  output$pop_stats <- renderText({
    
    population_object <- population_object()
    
    pop_mju <- population_object$pop_mju
    pop_sd <- population_object$pop_sd
    
    paste("Mean:", round(pop_mju,2),"; SD:", round(pop_sd,2))
  })
  
  output$pop_plot <- renderPlot({
    
    population_object <- population_object()
    
    par(mar= c(2.1,4.1,4.1,7.1))
    
    h<-hist(population_object$pop_data,
         breaks = "Sturges",
         col = "#f5f5f5",
         border = "#e3e3e3",
         freq=T,
         main = "",
         xlab = "Population value")
    
    abline(v = population_object$pop_mju, lwd = 2, lty = 2)
    
    density_est <- population_object$density
    
    lines(density_est$x,density_est$y*diff(h$mids[1:2])*length(population_object$pop_data),
          col = "#3b7db5", lwd = 2, lty = 3)
    
    legend(
      "topright", legend = c(expression(paste(mu," estimate")), "PDF"),
      col = c("black","#3b7db5"),
      lty = c(2,3),
      lwd = c(2,2),
      box.col = "white"
    )
    
  })
  
  # rendering samling outputs
  
  output$samp_stats <- renderText({
    
    sampling_object <- sampling_object()
    
    samp_mju <- sampling_object$samp_mju
    samp_sd <- sampling_object$samp_sd
    samp_skew <- sampling_object$samp_skew
    samp_kurt <- sampling_object$samp_kurt

    paste("Mean:", round(samp_mju,2),"; SD:", round(samp_sd,2),
          " Skewness:", round(samp_skew,2), " Kurtosis:", round(samp_kurt,2))
  })
  
  output$samp_plot <- renderPlot({
    
    sampling_object <- sampling_object()
    
    par(mar= c(2.1,4.1,4.1,7.1))
    
    h<-hist(sampling_object$samp_data,
         breaks = "Sturges",
         col = "#f5f5f5",
         border = "#e3e3e3",
         freq=T,
         main = "",
         xlab = "Sampling value")
    
    abline(v = sampling_object$samp_mju, lwd = 2, lty = 2)
    
    density_est <- sampling_object$density
    
    lines(density_est$x,density_est$y*diff(h$mids[1:2])*length(sampling_object$samp_data),
          col = "#3b7db5", lwd = 2, lty = 3)
    
    legend(
      "topright", legend = c(expression(paste(mu," estimate")), "PDF"),
      col = c("black","#3b7db5"),
      lty = c(2,3),
      lwd = c(2,2),
      box.col = "white"
      )
    
  })
  

  

})
 