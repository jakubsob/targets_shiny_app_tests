box::use(
  testthat[
    expect_is,
    expect_setequal,
  ],
  shiny[testServer],
  jsonlite[fromJSON],
)

box::use(
  module = app/view/modules/plot,
)

expect_plot <- function(x) {
  x <- fromJSON(x)
  expect_is(x, "list")
  expect_setequal(names(x), c("x", "evals", "jsHooks", "deps"))
}

#' @export
assert_render_plot <- function(args) {
  testServer(module$server, args = args, {
    # Act
    session$setInputs(variable = "y")
    plot <- output$plot

    # Assert
    expect_plot(plot)
  })
}
