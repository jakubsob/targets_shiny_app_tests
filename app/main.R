box::use(
  shiny[
    bootstrapPage,
    moduleServer,
    NS,
    fluidRow,
    column,
  ],
)

box::use(
  app/logic/database,
  app/view/modules/plot,
  app/view/modules/table,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    fluidRow(
      column(6, table$ui(ns("table"))),
      column(6, plot$ui(ns("plot")))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    db <- database$new()
    data <- db$get_data()
    table$server("table", data)
    plot$server("plot", data)
  })
}
