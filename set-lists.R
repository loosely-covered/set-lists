# R script to
# 1) manage Set Lists on Google Sheets,
# 2) write Set Lists as text files to GitHub, and
# 3) allow GitHub Actions to create PDFs from those text files.
library(rmarkdown)
library(tidyverse)
library(googledrive)
library(googlesheets4)
library(credentials)
library(git2r)

# Authenticate using json token to Google Drive, then Google Sheets
# Needs GOOGLE_API_KEY env variable set equal to `client_secret...` file
drive_auth(email = "kylelundstedt@gmail.com",
           path = Sys.getenv("GOOGLE_API_KEY"))
gs4_auth(token = drive_token())

# connect to Set Lists maintained as Google Sheet
set_lists <- drive_get("Loosely-Covered-2021")

# create list of sheet names in R for which to create set lists
# (filters out non-"Set List" sheets from Google Sheets)
set_lists_properties <- set_lists %>% sheet_properties() %>% 
  subset(name != "GH Files" & name != "Lookup" &
           name != "YYYY-MM-DD-Location" )

# function to read a Set List from Google Sheets,
# and create a corresponding text file
#
# creates new test file, if one does not exist
# modifies existing text file, if it has changed
# does NOT delete old text files
get_set_list <- function(name) { 
  set_lists %>%
    read_sheet(sheet = name, range = "A:A") %>%
    mutate( Song = str_c("./lead-sheet/", Song, ".md") ) %>% 
    write.table(file = str_c(name, ".txt"),
                quote = FALSE, sep = " ",
                row.names = FALSE, col.names = FALSE)
}

# loop over list of sheet names to create text files
pwalk( list(set_lists_properties$name), get_set_list)
