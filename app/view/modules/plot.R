box::use(
  shiny[
    NS,
    moduleServer,
    tagList,
    selectInput,
  ],
  dplyr[select],
  rlang[`%||%`],
)

box::use(
  app/view/plotting/scatterplot,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("variable"),
      label = "Select value variable",
      choices = c("y", "z")
    ),
    scatterplot$output(ns("plot"))
  )
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    output$plot <- scatterplot$render({
      data |>
        select(x, value = !!input$variable %||% "y") |>
        scatterplot$plot()
    })
  })
}
