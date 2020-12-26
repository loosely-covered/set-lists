# Loosely Covered - Set Lists

## Overview

This repository contains the Set Lists for our gigs.

This `set-lists` repo contains text files (e.g., `2020-01-08-Murphys.txt`) that define the songs from our repertoire to be performed at that gig.  Once a new Set List text file is created for a gig, a Set List PDF file automatically gets created a few minutes later.

A Set List contains:

- a title and date for the gig;
- a table of contents that lists all the songs for that gig; and
- for each of those songs, a page containing the lead sheet for that song.

The `lead-sheet` folder contains all of the "lead sheets" (lyrics, plus structure) for the songs in our repertoire.  If new songs need to be added, before creating the new Set List, go to the `lead-sheets` folder, and follow the README instructions therein to add the new song(s).

## Create a Set List

For a new Set List, you should create a **new file** specific to that gig using the following instructions:

1. Click the "Add file" dropdown button, followed by the "Create new file" button.
2. In the "Name Your File ..." field, name the new Set List for that gig as "set-list-location-date.txt" (e.g., "set-list-nicholson-2021-02-08.txt").
3. Add each song on a new line, using the format "./lead-sheet/Amber.md".
6. Click the green "Commit new file" button at the bottom of the page to save.
7. Wait a few minutes, then the PDF file for the new Set List will appear in the repo.
8. Double-click to download and open the PDF file.

## How Each Set List Gets Built

All content is written in Markdown for ease-of-use.

This repo uses the command-line tool [`pandoc`](https://pandoc.org) to combine all of the lead sheets for the gig, and output a PDF-based Set List for the gig.  Each `.txt` file defines the Set List.  The `_defaults.yml` and `_header.sty` files define the `pandoc` options used across all Set Lists.

Once you commit your changes to any edited file(s), this repo uses GitHub Actions to produce the PDF file behind the scenes using `pandoc`.  In effect, GitHub Actions runs the following command:

`pandoc -d _defaults.yml -M title='Murphys 2020-01-08' $(cat 2020-01-08-Murphys.txt) -o 2020-01-08-Murphys.pdf`

for each Set List.  **Please be patient**; it may take a few minutes for the PDF to get generated.

If using VSCode locally, the `tasks.json` file enables building an open Set list with Cmd-Shift-B.
