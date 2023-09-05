box::use(
  echarts4r[
    e_charts,
    e_scatter,
    echarts4rOutput,
    renderEcharts4r,
  ],
  checkmate[
    assert_data_frame,
    assert_numeric,
    assert_subset,
  ],
)

#' @export
plot <- function(data) {
  assert_data_frame(data)
  assert_subset(c("x", "value"), colnames(data))
  assert_numeric(data$x)
  assert_numeric(data$value)
  data |>
    e_charts(x) |>
    e_scatter(value)
}

#' @export
output <- echarts4rOutput

#' @export
render <- renderEcharts4r
