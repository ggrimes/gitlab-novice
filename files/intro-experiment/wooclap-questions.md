# Wooclap questions: experimental opening

Use a **separate Wooclap event** from the main deck so the results of the two
openings can be compared. Add these in order (E1–E8), then put the event code
in `wooclap-code:` at the top of `intro-experiment.qmd` and re-render.

Settings: join without logging in; anonymous; results hidden until you show
them (important for E5/E6, so vote 1 isn't copied from the bar chart).

| #  | Slide                         | Wooclap type                 |
|----|-------------------------------|------------------------------|
| E1 | Where are you starting from?  | Rating 1–5                   |
| E2 | Where are you starting from?  | Multiple choice, multi-select, no correct answer |
| E3 | What made that hard?          | Word cloud                   |
| E4 | Your goal for today           | Open question                |
| E5 | Check your model (vote 1)     | Multiple choice, one correct |
| E6 | Talk to your neighbour (vote 2) | Same question as E5         |
| E7 | Before you go                 | Rating 1–5                   |
| E8 | Before you go                 | Multiple choice, no correct answer |

---

## E1: Rating, 1–5
How comfortable are you with the command line?
(1 = never used it, 5 = live in it)

## E2: Multiple choice, select all that apply
How do you keep track of versions of your work now?
- Renamed copies: _v2, _final…
- Dropbox / OneDrive / SharePoint history
- Emailing files to myself or others
- Git (or another version control system)
- I don't, really

## E3: Word cloud
In one or two words: what made that hard?

## E4: Open question
What's one thing you want to be able to do with Git by 4 pm? A real project of yours is ideal.

## E5: Multiple choice, one correct (vote 1)
You edit two files, a.py and b.py. Then you run `git add a.py` and
`git commit -m "Fix plotting bug"`. What's in the commit?
- Changes to both a.py and b.py
- **Only the changes to a.py** ✅
- Nothing: you have to add both files first
- Only the changes to b.py

## E6: identical to E5 (vote 2, after discussion)
Duplicate E5 in Wooclap so the two votes can be compared side by side.

## E7: Rating, 1–5
How comfortable are you with the command line now?
(1 = never used it, 5 = live in it)

## E8: Multiple choice
Look at your goal from this morning (E4). Can you do it now?
- Yes
- Partly
- Not yet

---

## What to compare against a run with the original opening

- E1 → E7 confidence shift
- E5 → E6: share of correct answers before and after discussion
- red-sticky count per episode (a helper keeps a tally)
- time to first commit (aim: about 10:10)
- 4 weeks later: "Have you committed to a repository since the workshop?"
