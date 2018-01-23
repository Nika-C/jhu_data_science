#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Central limit theorem demonstration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      selectInput("distribution_type",
                  "Select population distribution",
                  choices = list("binomial","uniform","normal")),
      
      br(),
      
      conditionalPanel(condition = "input.distribution_type=='binomial'",
                  
                  sliderInput("bi_prob",
                              "Select probability of success:",
                              min = 0.01,
                              max = 0.99,
                              value = .5) 
        
      ),
      
      conditionalPanel(condition = "input.distribution_type=='uniform'",
                       
                  sliderInput("un_range",
                             "Population range:",
                             min = -10,
                             max = 10,
                             value = c(-5,5)) 
                       
      ),
      
      conditionalPanel(condition = "input.distribution_type=='normal'",
                       
                  sliderInput("norm_mju",
                             "Population mean:",
                             min = -10,
                             max = 10,
                             value = 0),
                  
                  sliderInput("norm_sd",
                              "Population standard deviation:",
                              min = 1,
                              max = 20,
                              value = 5)
                  
      ),
      
      br(),br(),
      
      sliderInput("sample_n",
                   "Number of samples:",
                   min = 100,
                   max = 500,
                   value = 100),
      

      sliderInput("sample_size",
                   "Sample size:",
                   min = 1,
                   max = 1000,
                   value = 100),
      
      br(),br(),
      
      strong("What is this about?"),
      br(),
      a("[WikiLink]", href="https://en.wikipedia.org/wiki/Central_limit_theorem"), 
      br(),
      a("[YoutubeLink]", href="https://www.youtube.com/watch?v=zr-97MVZYb0") 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
       h3("Population distribution"),
       
       textOutput("pop_stats"),
       plotOutput("pop_plot"),

       
       
       h3("Sampling distribution"),
       
       textOutput("samp_stats"),
       plotOutput("samp_plot")
       
    )
  )
))
