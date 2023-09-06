box::use(
  testthat[...],
  shiny[testServer],
)

box::use(
  module = app/view/modules/table,
)

expect_table <- function(x) {
  expect_is(x, "character")
}

#' @export
assert_render_table <- function(args) {
  testServer(module$server, args = args, {
    # Act
    table <- output$table

    # Assert
    expect_table(table)
  })
}
