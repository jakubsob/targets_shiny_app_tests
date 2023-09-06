box::use(
  testthat[...],
  shiny[testServer],
)

box::use(
  module = app/view/modules/table,
  test_cases = tests/test_cases/table,
)

describe("table", {
  it("should render a table", {
    # Arrange
    args <- list(
      data = data.frame(
        x = 1:10,
        y = 1:10,
        z = 11:20
      )
    )

    # Act, Assert
    test_cases$assert_render_table(args)
  })
})
