# R script to write Set Lists to Google Sheets
# R script to
# 1) read Set List text files from GitHub, and
# 2) write Set Lists to Google Sheets.
library(rmarkdown)
library(tidyverse)
library(googlesheets4)
library(googledrive)

# function to write a set list to Google Sheets
write_set_list ???
  
get_set_list <- function(name) {
  drive_get("Loosely-Covered-2021") %>%
    read_sheet(sheet = name, range = "A:A") %>%
    mutate( Song = str_c("./lead-sheet/", Song, ".md") ) %>% 
    write.table(file = str_c(name, ".txt"),
                quote = FALSE, sep = " ",
                row.names = FALSE, col.names = FALSE)
}

# list of files from which to write set lists
set_lists_properties <- drive_get("Loosely-Covered-2021") %>%
  sheet_properties() %>% 
  subset(name != "GH Files" & name != "Lookup" &
           name != "YYYY-MM-DD-Location" )

# loop over list of sheets to create corresponding text files
pwalk( list(set_lists_properties$name), get_set_list)
