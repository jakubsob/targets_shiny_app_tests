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

    testServer(module$server, args = args, {
      # Act
      table <- output$table

      # Assert
      expect_table(table)
    })
  })
})
