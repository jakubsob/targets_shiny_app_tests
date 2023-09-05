box::use(
  shiny[
    renderTable,
    tableOutput,
  ],
  checkmate[
    assert_data_frame,
    assert_subset,
  ],
)

#' @export
table <- function(data) {
  assert_data_frame(data)
  assert_subset(c("x", "y", "z"), colnames(data))
  data
}

#' @export
output <- tableOutput

#' @export
render <- renderTable
