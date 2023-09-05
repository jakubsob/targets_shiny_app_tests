box::use(
  shiny[
    NS,
    moduleServer,
  ]
)

box::use(
  app/view/plotting/table,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  table$output(ns("table"))
}

#' @export
server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    output$table <- table$render({
      table$table(data)
    })
  })
}
