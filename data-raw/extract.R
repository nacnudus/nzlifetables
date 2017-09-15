library(tidyverse)
library(tidyr)
library(readxl)

download.file("http://www.stats.govt.nz/~/media/Statistics/Browse%20for%20stats/NZCohortLifeTables/HOTPMar16/male-complete-cohort-life-tables-1876-1941.xls",
               destfile = "cohorts_male.xls", mode = "wb")
download.file("http://www.stats.govt.nz/~/media/Statistics/Browse%20for%20stats/NZCohortLifeTables/HOTPMar16/female-complete-cohort-life-tables-1876-1941.xls",
               destfile = "cohorts_female.xls", mode = "wb")

# At the command line, you could convert to xlsx using gnumeric e.g.  ssconvert
# cohorts_male.xls cohorts_male.xlsx But there's something funny with the files
# and it makes them very slow to import.  Instead, try to open them with Excel
# (my copy of 2010 makes a fuss about corrupt files) and save them as xlsx.

male_file <- "cohorts_male.xlsx"
female_file <- "cohorts_female.xlsx"
col_names <- c("cohort", "age", "lx", "Lx", "dx", "px", "qx", "mx", "sx", "ex")

sheets_to_load <- excel_sheets(male_file)[-1]

import_lifetable <- function(workbook) {
  raw_data <- map_df(sheets_to_load,
                     ~ read_excel(workbook,
                                  .x,
                                  skip = 10,
                                  col_types = rep("numeric", 19)) %>%
                     slice(1:51) %>%
                     select(-10) %>%
                     mutate(cohort = as.integer(.x)) %>%
                     select(cohort, everything()))
  age_50 <- select(raw_data, 1:10)
  age_100 <- select(raw_data, c(1, 11:19))
  colnames(age_50) <- col_names
  colnames(age_100) <- col_names
  bind_rows(age_50, age_100) %>%
    map_at(c("age", "lx", "llx", "dx"), as.integer)
}

male <- import_lifetable(male_file)
female <- import_lifetable(female_file)

nzlifetables <-
  bind_rows(male = male, female = female, .id = "sex") %>%
  mutate(projected = (cohort + age) > 2015)

devtools::use_data(nzlifetables, overwrite = TRUE)
