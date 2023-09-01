box::use(
  shiny[
    NS,
    moduleServer,
    plotOutput,
    renderPlot,
  ]
)

box::use(
  app/view/plotting/scatterplot[scatterplot],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  plotOutput(ns("plot"))
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlot({
      scatterplot(data)
    })
  })
}
