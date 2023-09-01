box::use(
  shiny[
    bootstrapPage,
    moduleServer,
    NS,
  ],
)

box::use(
  app/logic/database,
  app/view/modules/plot,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  bootstrapPage(
    plot$ui(ns("plot"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    db <- database$new()
    plot$server("plot", db$get_data())
  })
}
