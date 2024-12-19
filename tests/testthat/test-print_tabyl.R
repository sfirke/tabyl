test_that("print.tabyl", {
  tabyl_example <- tabyl(mtcars, cyl)
  expect_output(
    print(tabyl_example),
    regexp =
      paste0(
        capture.output(
          print.data.frame(tabyl_example, row.names = FALSE)
        ),
        collapse = "\n"
      ),
    fixed = TRUE
  )
})
