# R script to
# 1) read Set Lists from Google Sheets,
# 2) write Set Lists as text files, and
# 3) commit Set List text files to GitHub.
library(rmarkdown)
library(tidyverse)
library(googlesheets4)
library(googledrive)
library(git2r)

# function to read Set List(s) from Google Sheets,
# and create a corresponding set of text files
get_set_list <- function(name) {
  drive_get("Loosely-Covered-2021") %>%
    read_sheet(sheet = name, range = "A:A") %>%
    mutate( Song = str_c("./lead-sheet/", Song, ".md") ) %>% 
    write.table(file = str_c(name, ".txt"),
                quote = FALSE, sep = " ",
                row.names = FALSE, col.names = FALSE)
}

# create list of sheet names in R for which to create set lists
# (filters out non-"Set List" sheets from Google Sheets)
set_lists_properties <- drive_get("Loosely-Covered-2021") %>%
  sheet_properties() %>% 
  subset(name != "GH Files" & name != "Lookup" &
           name != "YYYY-MM-DD-Location" )

# loop over list of sheet names to create text files
pwalk( list(set_lists_properties$name), get_set_list)

# commit and push text files to GitHub
