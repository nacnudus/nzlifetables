#' New Zealand Cohort Life Tables
#'
#' A dataset containing New Zealand Cohort Life Tables from Statistics New
#' Zealand
#'
#' @format A data frame with 13,464 rows and 12 variables:
#'
#' * `sex`
#' * `cohort`
#' * `age` Exact age (years)
#' * `lx` Number alive at exact age, out of 100,000 born
#' * `Lx` Average number alive in the age interval, out of 100,000 born
#' * `dx` Number dying in the age interval, out of 100,000 born
#' * `px` Probability that a person who reaches this age lives another year
#' * `qx` Probability that a person who reaches this age dies within a year
#' * `mx` Central death rate for the age interval
#' * `sx` Proportion of age group surviving another year
#' * `ex` Expected number of years of life remaining at age x
#' * `ex` Expected number of years of life remaining at age x
#' * `projected` Whether or not the statistic is a projection
#'
#' @source
#' http://www.stats.govt.nz/Census/2013-census/data-tables/electorate-tables.aspx
#' released under the CC BY 4.0 licence
#' https://creativecommons.org/licenses/by/4.0/
"nzlifetables"

