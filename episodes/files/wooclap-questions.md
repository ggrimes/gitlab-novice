# Wooclap questions: Introduction to Git and GitLab

Create one Wooclap event for the day and add these questions **in this order**,
so the numbers match the badges on the slides. Then put the event code in the
`wooclap-code:` line at the top of `git-slides.qmd` and re-render.

Suggested event settings: participants join **without logging in** and answers
are **anonymous**; hide results until you choose to show them (so the quiz
questions aren't answered by copying the bar chart).

| #   | Slide                                | Wooclap type    |
|-----|--------------------------------------|-----------------|
| Q1  | Warm-up                              | Rating          |
| Q2  | Warm-up                              | Word cloud      |
| Q3  | Your turn: why bother?               | Multiple choice |
| Q4  | Your turn: predict the result        | Multiple choice |
| Q5  | Your turn: `git diff HEAD`           | Multiple choice |
| Q6–Q8 | Your turn: branch or tag?          | Multiple choice ×3 |
| Q9  | Before you go                        | Rating          |
| Q10 | Before you go                        | Word cloud      |
| Q11 | Before you go                        | Open question   |

---

## Q1: Warm-up (Rating, 1–5)

How comfortable are you with the command line?

- 1 = never used it
- 5 = live in it

## Q2: Warm-up (Word cloud)

One word that comes to mind when you hear "version control".

## Q3: Why bother? (Multiple choice, one correct)

Which of these is **not** a typical reason to use version control?

- Keeping files synchronised between two laptops
- Tracking the history of code changes
- **Encrypting files to keep them secret** ✅
- Collaborating with colleagues on a shared project

## Q4: Predict the result (Multiple choice, one correct)

System config sets `user.email = root@machine`, global config is not set, and
the project's local config sets `user.email = user@project`.
Which email is recorded when you commit **inside the project**?

- root@machine
- **user@project** ✅
- Nothing: Git refuses to commit
- Whichever was set most recently

*Follow-up to ask out loud:* and in a different repository? (root@machine)

## Q5: `git diff HEAD` (Multiple choice, one correct)

What does `git diff HEAD` show?

- Working directory ↔ staging area
- Staging area ↔ last commit
- **Working directory ↔ last commit** ✅
- Two different commits

## Q6: Branch or tag? (Multiple choice, one correct)

Try a new way of plotting without breaking the working script.

- **Branch** ✅
- Tag

## Q7: Branch or tag? (Multiple choice, one correct)

Record the exact code behind a submitted paper's figures.

- Branch
- **Tag** ✅

## Q8: Branch or tag? (Multiple choice, one correct)

A collaborator's new analysis that will take a few weeks.

- **Branch** ✅
- Tag

## Q9: Before you go (Rating, 1–5)

How comfortable are you with the command line now?

- 1 = never used it
- 5 = live in it

## Q10: Before you go (Word cloud)

Which Git command will you use first on your own project?

## Q11: Before you go (Open question)

What's still confusing? Anything goes, it's anonymous.
