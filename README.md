# Loosely Covered - Set Lists

TODO automatically build new/changed Set Lists

## Overview

This repository contains the Set Lists for our gigs.

This `set-lists` repo contains text files (e.g., `2020-01-08-Murphys.txt`) that define the songs from our repertoire to be performed at that gig.  Once a new Set List text file is created for a gig, a Set List PDF file automatically gets created a few minutes later.

A Set List contains:

- a title and date for the gig;
- a table of contents that lists all the songs for that gig; and
- for each of those songs, a page containing the lead sheet for that song.

The `lead-sheet` folder contains all of the "lead sheets" (lyrics, plus structure) for the songs in our repertoire.  If new songs need to be added, before creating the new Set List, go to the `lead-sheet` folder, and follow the README instructions therein to add the new song(s).  **Don't forget** to leave a blank line at the end of every lead sheet!

## Create a Set List

For a new Set List, you should create a **new file** specific to that gig using the following instructions:

1. Click the "Add file" dropdown button, followed by the "Create new file" button.
2. In the "Name Your File ..." field, name the new Set List for that gig as "set-list-location-date.md" (e.g., "set-list-nicholson-2021-02-08.md").
3. Add each song on a new line, using the format "./lead-sheet/Amber.md".
4. Click the green "Commit new file" button at the bottom of the page to save.
5. Wait a few minutes, then the PDF file for the new Set List will appear in the repo.
6. Double-click to download and open the PDF file.

## How Each Set List Gets Built

All content is written in Markdown for ease-of-use.

This repo uses the command-line tool [`pandoc`](https://pandoc.org) to combine all of the lead sheets for the gig, and output a PDF-based Set List for the gig.  Each `.txt` file defines the Set List.  The `_defaults.yml` and `_header.sty` files define the `pandoc` options used across all Set Lists.

Once you commit your changes to any edited file(s), this repo uses GitHub Actions to produce the PDF file behind the scenes using `pandoc`.  In effect, GitHub Actions runs the following command:

`pandoc -d _defaults.yml -M title='Murphys 2020-01-08' $(cat 2020-01-08-Murphys.txt) -o 2020-01-08-Murphys.pdf`

for each Set List.  **Please be patient**; it may take a few minutes for the Set List PDF to get generated.

The Master Set List automatically gets updated each time there's a change ???
by running the following command:

`pandoc -d _defaults.yml -M title="Master Set List $(date +%F)" ./lead-sheet/*.md  -o "Master-Set-List.pdf"`

## Create a New Lead Sheet  

The `lead-sheet` folder contains all of the "lead sheets" (lyrics, plus structure) for the songs in our repertoire.  **Don't forget** to leave a blank line at the end of every lead sheet!

For a new Lead Sheet, you should create a **new file** specific to that song using the following instructions:

1. Open a browser tab to your favorite lyrics site (e.g., azlyrics.com, songlyrics.com); search for the lyrics to the new song; and copy the song lyrics.
2. In a separate browser tab, open this `set-lists` repo and click on the `lead-sheet` folder.
3. Then, click the "Add file" dropdown button, followed by the "Create new file" button.
4. In the "Name Your File ..." field, name the new Lead Sheet for that song as "Song-Name.md" (e.g., "Back-In-Black.md").  Each word should start with a capital letter, and replace all special characters (e.g. "-", "'", "&") with a dash.
5. At a minimum, on the first line of the "Edit new file" section, type the pound sign, a space, the Song Name, then a new line.
6. Then, paste the lyrics into the "Edit new file" section, and add song structure, if desired.
7. **Don't forget** to leave two spaces at the end of each line, and a blank line at the end of every lead sheet.
8. Click the green "Commit new file" button at the bottom of the page to save.
9. The new lead sheet now will appear in the `lead-sheet` folder of the repo.

## Editing and Improving Lead Sheets

All lead sheets are basically plain text.  The only requirements are having:

- the "#" symbol, followed by a space and the Song Name, on the first line;
- then a blank line;
- then the lyrics;
- then a blank line at the end.

However, a Lead Sheet is more useful with a little structure.  Take a look at the top of the Lead Sheet for [Rebel Yell](./Rebel-Yell.md).

```markdown
# Rebel Yell

https://www.youtube.com/watch?v=m0JImKXjtaA  

### Intro  _B-D-C_

### Verse  16x  _B-G-A_
Last night a little dancer
came dancing to my door
Last night a little angel
came pumping on the floor

She said, come on baby
You got a license for love
And if it expires
pray help from above, because
```

The following structure has been added to the plain-text lyrics:

- Shorten long song names like so: `# All These Things That I ve Done {short="All These Things"}`.
- Bonus points!  Add a web link to an online version close to how we do it.
- Section headings, like "Intro" and "Verse", have been added using the "### " symbols.  These break the song up into its major parts.
- You  can add the number of bars in each section (e.g., "16x").
- You can add blank lines to separate the different parts of each section.
- You also can add the chords for that section in italics; just put an underscore on either side of the chord progression.
- You can separate out the harmony lyrics by putting them in parentheses.

To add this kind of structure to a Lead Sheet, do the following:

1. Click on the name of the Lead Sheet in the `lead-sheet` folder of the repo.
2. Find the "pencil" icon ("Edit this file") on the right side of the page above the lyrics.
3. Make the desired changes to the structure of the song.
4. Click the green "Commit changes" button at the bottom of the page to save.
5. The edited lead sheet now will appear in the `lead-sheet` folder of the repo.

If using VSCode locally, run `lyrics-finder "Sublime" "What I Got" | awk '{print $0 "  ";next}1' > ./lead-sheet/What-I-Got.md`
