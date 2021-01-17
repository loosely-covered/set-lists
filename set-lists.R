# R script to
# 1) read Set Lists from Google Sheets,
# 2) write Set Lists as text files, and
# 3) commit Set List text files to GitHub.
library(rmarkdown)
library(tidyverse)
library(googlesheets4)
library(googledrive)
library(credentials)
library(git2r)

# connect to Set List maintained as Google Sheet
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


if (is.null(unlist(status()))) {
  return (writeLines(paste0("There is nothing to do.")))
}

# add, commit. and push new text files to GitHub
set_list_repo <- repository()
pull(set_list_repo)
add(set_list_repo, "*.txt")
try(commit(set_list_repo,
           message = paste0("GH Actions update",
                            Sys.time(), "%Y-%m-%d %H:%M:%S") ))
push(set_list_repo,
     credentials = cred_token(token = "GITHUB_PAT") )
