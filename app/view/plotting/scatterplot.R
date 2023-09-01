box::use(
  echarts4r[
    e_charts,
    e_scatter
  ]
)

#' @export
scatterplot <- function(data) {
  data |>
    e_charts(x) |>
    e_scatter(y) |>
    e_scatter(z)
}
