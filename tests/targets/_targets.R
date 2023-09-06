box::use(
  targets[
    tar_cue,
    tar_target,
  ],
  tarchetypes[
    tar_combine,
    tar_map,
  ],
  purrr[
    safely,
  ],
  dplyr[
    bind_rows,
    tibble,
  ],
  rlang[`%||%`]
)

box::use(
  app/view/modules,
)

datasets <- list(
  "1" = data.frame(x = as.character(1:10), y = as.character(1:10)),
  "2" = data.frame(x = 1:10, y = 1:10)
)

grid <- tibble(
  dataset_name = c("1", "2", "1", "2"),
  module = c("plot", "plot", "table", "table"),
  test_case = c("assert_render_plot", "assert_render_plot", "assert_render_table", "assert_render_table")
)[1:2, ]

safe_test <- function(module, test_case, dataset_name) {
  box::use(
    tests/test_cases,
  )
  modules[[module]]
  data <- datasets[[dataset_name]]
  test_function <- test_cases[[module]][[test_case]]
  result <- safely(test_function)(list(data = data))
  tibble(
    module = module,
    test_case = test_case,
    dataset_name = dataset_name,
    error = as.character(result$error %||% NA)
  )
}

test_grid <- list(
  tar_map(
    values = grid,
    tar_target(
      name = test,
      command = safe_test(module, test_case, dataset_name)
    )
  )
)

test_results <- tar_combine(
  name = results,
  test_grid,
  command = dplyr::bind_rows(!!!.x)
)

list(
  test_grid,
  test_results
)
