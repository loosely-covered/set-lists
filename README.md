# Loosely Covered - Set Lists

## Overview

This repository contains the Set Lists for our gigs.

This `set-lists` repo contains YAML files (e.g., `test-set-list.yml`) that each define:

- a title and date for the gig;
- a table of contents that lists all the songs for that gig; and
- for each of those songs, a page containing the lead sheet for that song.

The `lead-sheet` folder contains all of the "lead sheets" (lyrics, plus structure) for the songs in the Loosely Covered repertoire.  If new songs need to be added to our repertoire, before creating the new Set List, go to the `lead-sheets` folder, and follow the instructions below to add the new song(s).

## Create a Set List

For a new Set List, you should create a **new file** specific to that gig using the following instructions:

1. Click on a `.yml` Set List file from a recent gig (e.g., "set-list-nicholson-2021-02-08.yml").
2. Copy the contents of that file (the lines looking like this):

        ```yaml
        # ONLY EDIT LINE 12, and LINES 14 AND BEYOND
        from: markdown
        to: pdf
        standalone: true
        self-contained: true
        pdf-engine: xelatex
        include-in-header: [_header.sty]
        table-of-contents: true
        toc-depth: 1
        metadata:
          title:
            - Test Set List # change to name of the gig
        input-files: # add a lead sheet for each song in the gig
          - ./lead-sheet/Across-The-Universe.md
          - ./lead-sheet/All-About-That-Bass.md
          - ./lead-sheet/Amber.md
          - ./lead-sheet/Angel-From-Montgomery.md
        ```

3. Click the "Add file" dropdown button, followed by the "Create new file" button.
4. In the "Name Your File ..." field, name the new Set List for that gig as "set-list-location-date.yml" (e.g., "set-list-nicholson-2021-02-08.yml").
5. Paste the contents from the recent Set List that you just copied.
6. Edit line 12 to reflect the name of the gig.
7. Edit lines 14 and beyond, and include the file name for each song in the gig.
8. Click the green "Commit new file" button at the bottom of the page to save.
9. Wait a few minutes, then a PDF file with the same name as the `*.yml` file will appear in the repo.
10. Double-click to download and open the PDF file.

## How Each Set List Gets Built

All content is written in Markdown for ease-of-use.

This repo uses the command-line tool [`pandoc`](https://pandoc.org) to combine all of the lead sheets for the gig, and output a PDF-based Set List for the gig.  Each `.yml` file defines the Set List.  The `_header.sty` file defines the `pandoc` options used across all Set Lists.

Once you commit your changes to any edited file(s), this repo uses GitHub Actions to produce the PDF file behind the scenes using `pandoc`.  In effect, GitHub Actions runs the following command:

`pandoc -d test-set-list.yml -o test-set-list.pdf`

for each Set List.  **Please be patient**; it may take a few minutes for the PDF to get generated.
