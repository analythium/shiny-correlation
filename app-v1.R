library(shiny)
library(MASS)

ui <- fluidPage(
  titlePanel("Correlated variables"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "Sample size",
        min=2, max=10^3, value=200
      ),
      sliderInput("r", "Correlation",
        min = -1, max = 1, value = 0, step=0.05
      )
    ),
    mainPanel(
      plotOutput("plot", width="500px", height="500px")
    )
  )
)

server <- function(input, output) {
  Sigma <- reactive({
    matrix(c(1, input$r, input$r, 1), 2, 2)
  })
  m <- reactive({
    mvrnorm(input$n, c(0, 0), Sigma())
  })
  output$plot <- renderPlot({
    d <- m()
    k <- kde2d(d[,1], d[,2])
    image(k, axes=FALSE, ann=FALSE)
    points(d, col="#0000ff22", pch=19)
    contour(k, add=TRUE)
  })
}

shinyApp(ui, server)
