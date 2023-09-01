box::use(
  R6[R6Class],
  stats[
    rnorm,
  ],
)

Database <- R6Class(
  classname = "Database",
  public = list(
    get_data = function() {
      data.frame(x = rnorm(10, 5, 3), y = rnorm(10, 50, 12), z = rnorm(10, 50, 5))
    }
  )
)

#' @export
new <- Database$new
