library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

ui <- fluidPage(
  
  titlePanel("Relation between Sepal and Petal Parameters in Iris Data Set"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x", "X-Axis", c("Sepal.Length", "Sepal.Width",
                                   "Petal.Width", "Petal.Length"), selected = "Petal.Length"),
      selectInput("y", "Y-Axis", c("Sepal.Length", "Sepal.Width",
                                 "Petal.Width", "Petal.Length"), selected = "Sepal.Length"),
      checkboxGroupInput("species", "Species to Include:", c("setosa", "versicolor", "virginica"),
                         selected = c("setosa", "versicolor", "virginica")),
      
      #"This is a sample R Shiny Application of IRIS Dataset. There are five variables in the dataset, four of which provides sepal and petal parameters while the last one indicates species. This application produces a scatter plot based on input parameters provided by the user."
    ),
    
    mainPanel(
      plotlyOutput("plot")
    )
  )
  
)

server <- function(input, output) {
  
  data(iris)
  
  output$plot <- renderPlotly({
    
    data <- subset(iris, Species %in% input$species)
    
    ggplotly(ggplot(data, aes(color = Species)) +
               geom_point(mapping = aes_string(x = input$x, y = input$y)) +
               labs(title = "Scatter Plot from Iris Dataset"))
      
    
  })
  
  
  
  }

# Run the application 
shinyApp(ui = ui, server = server)
