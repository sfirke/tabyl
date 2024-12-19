# tabyl

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/tabyl)](https://CRAN.R-project.org/package=tabyl)
[![Codecov test coverage](https://codecov.io/gh/sfirke/tabyl/graph/badge.svg)](https://app.codecov.io/gh/sfirke/tabyl)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/sfirke/tabyl/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/sfirke/tabyl/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

tidyverse-friendly functions for counting things in R. Formerly part of the janitor package.

## Installation

You can install the development version of tabyl from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("sfirke/tabyl")
```

## Exploring

### Tabulating tools

A variable (or combinations of two or three variables) can be tabulated with `tabyl()`.  The resulting data.frame can be tweaked and formatted
with the suite of `adorn_` functions for quick analysis and printing of pretty results in a report.  `adorn_` functions can be helpful with non-tabyls, too.

#### `tabyl()`

Like `table()`, but pipe-able, data.frame-based, and fully featured.

`tabyl()` can be called two ways:

* On a vector, when tabulating a single variable: `tabyl(roster$subject)`
* On a data.frame, specifying 1, 2, or 3 variable names to tabulate: `roster %>% tabyl(subject, employee_status)`.
    * Here the data.frame is passed in with the `%>%` pipe; this allows `tabyl` to be used in an analysis pipeline

One variable:
```{r}
roster %>%
  tabyl(subject)
```

Two variables:
```{r}
roster %>%
  filter(hire_date > as.Date("1950-01-01")) %>%
  tabyl(employee_status, full_time)
```

Three variables:
```{r}
roster %>%
  tabyl(full_time, subject, employee_status, show_missing_levels = FALSE)
```

#### Adorning tabyls

The `adorn_` functions dress up the results of these tabulation calls for fast,
basic reporting.  Here are some of the functions that augment a summary table
for reporting:

```{r}
roster %>%
  tabyl(employee_status, full_time) %>%
  adorn_totals("row") %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  adorn_ns() %>%
  adorn_title("combined")
```

Pipe that right into `knitr::kable()` in your RMarkdown report.

These modular adornments can be layered to reduce R's deficit against Excel and
SPSS when it comes to quick, informative counts.  Learn more about `tabyl()` and
the `adorn_` functions from the
[tabyls vignette](https://sfirke.github.io/janitor/articles/tabyls.html).

### Count factor levels in groups of high, medium, and low with `top_levels()`

Originally designed for use with Likert survey data stored as factors.  Returns a `tbl_df` frequency table with appropriately-named rows, grouped into head/middle/tail groups.

+ Takes a user-specified size for the head/tail groups
+ Automatically calculates a percent column
+ Supports sorting
+ Can show or hide `NA` values.

```{r}
f <- factor(c("strongly agree", "agree", "neutral", "neutral", "disagree", "strongly agree"),
  levels = c("strongly agree", "agree", "neutral", "disagree", "strongly disagree")
)
top_levels(f)
top_levels(f, n = 1)
```
