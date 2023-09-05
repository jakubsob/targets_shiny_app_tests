box::use(
  testthat[...],
  shiny[testServer],
  jsonlite[fromJSON],
  mockery[
    expect_args,
    mock,
    stub,
  ],
)

box::use(
  module = app/view/modules/plot,
)

expect_plot <- function(x) {
  x <- fromJSON(x)
  expect_is(x, "list")
  expect_setequal(names(x), c("x", "evals", "jsHooks", "deps"))
}

describe("plot", {
  it("should render a plot", {
    # Arrange
    args <- list(
      data = data.frame(
        x = 1:10,
        y = 1:10,
        z = 11:20
      )
    )

    testServer(module$server, args = args, {
      # Act
      session$setInputs(variable = "y")
      plot <- output$plot

      # Assert
      expect_plot(plot)
    })
  })

  it("should pass data to plotting function", {
    # Arrange
    args <- list(
      data = data.frame(
        x = 1:10,
        y = 1:10,
        z = 11:20
      )
    )
    mock_plot <- mock()
    stub(module$server, "scatterplot$plot", mock_plot)

    testServer(module$server, args = args, {
      # Act
      session$setInputs(variable = "y")
      plot <- output$plot

      # Assert
      expect_args(
        mock_plot,
        n = 1,
        data = data.frame(
          x = 1:10,
          value = 1:10
        )
      )
    })
  })
})
