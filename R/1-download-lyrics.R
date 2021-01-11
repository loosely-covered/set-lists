library(googlesheets)
library(httr)
library(rvest)
library(stringr)
library(tidyverse)

# connect to Google Sheets
(my_sheets <- gs_ls())
# connect to Loosely Covered Set Lists workbook
set_lists <- gs_title("LC Gigs Set Lists")

# connect to Master tab in that workbook
master_list <- set_lists %>% gs_read(ws = "Master") %>%
  mutate( Artist = str_replace_all(Artist, "/", "-") ) %>%
  mutate( Artist = str_replace_all(Artist, "’" , "") ) %>%
  mutate( Artist = str_replace_all(Artist, "'", "") ) %>%
  mutate( Artist = str_replace_all(Artist, "&", "n") ) %>%
  mutate( Artist = str_replace_all(Artist, "\\.", "") ) %>%
  mutate( Title = str_replace_all(Title, "/", "-") ) %>%
  mutate( Title = str_replace_all(Title, "’" , "-") ) %>%
  mutate( Title = str_replace_all(Title, "'", "-") ) %>%
  mutate( Title = str_replace_all(Title, "--", "-") ) %>%
  mutate( Title = str_replace_all(Title, "&", "n") ) %>%
  mutate( Title = str_replace_all(Title, "\\.", "") ) %>%
  mutate( Artist_Title =
           str_c("https://www.songlyrics.com/", Artist, "/", Title, "-lyrics/") ) %>% 
  mutate( Artist_Title = str_to_lower(Artist_Title) ) %>% 
  mutate( Artist_Title = str_replace_all(Artist_Title, "\\s+", "-") ) %>% 
  mutate( Title_dash = str_replace_all(Title, " ", "-"))

# function to download lyrics from Songlyrics.com
# save individual song in Songs folder in Markdown format
get_one_song <- function(song_url, song_title) {
  if ( !file.exists( paste0(song_title, ".md") ) ) {
    html <- read_html(song_url)
    lyrics <- html %>%
      html_nodes("#songLyricsDiv") %>%
      html_text() %>%
      str_replace_all("\n", "  \n") %>% 
      str_replace_all("[\r]", "") %>% 
      str_replace_all(c("€" = "", "â" = "", "½" = "", "" = ""))
    section <- paste0("# ", song_title, "\n")
    write(section, file = paste0("./", song_title, ".md"))
    write(lyrics, file = paste0("./", song_title, ".md"),
          append = TRUE)
    Sys.sleep(5)
  }
}

# download all songs from Master tab
# call get_one_song once per song
pwalk( list(master_list$Artist_Title, master_list$Title_dash),
       possibly(get_one_song, NA_character_) )


# html <- read_html("http://www.songlyrics.com/r-e-m/don-t-go-back-to-rockville-lyrics/")
# lyrics <- html %>%
#   html_nodes("#songLyricsDiv") %>%
#   html_text() %>%
#   str_replace_all("\n", "  \n") %>% 
#   str_replace_all("[\r]", "") %>% 
#   str_replace_all(c("€" = "", "â" = "", "½" = "", "" = ""))
