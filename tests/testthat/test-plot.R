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
  test_cases = tests/test_cases/plot,
)

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

    # Act & Assert
    test_cases$assert_render_plot(args)
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
