# Instructor answers: Introduction to Git and GitLab (half-day)

Answers and background for **every question** in `git-short.qmd`: the
exercises, the Wooclap polls, the questions on section slides, and the recall
questions in the speaker notes, in the order they appear. For helpers and
co-instructors: read before the day; keep open on the day.
Error messages and fixes are in `helper-sheet.md`.

**Contents**

1. The two practice folders
2. Opening (09:00–09:50): hook, polls W1–W6, detective task, first commit
3. Recording changes (09:50–10:30)
4. GitLab (10:45–11:30): SSH prompt, sync exercise
5. History & undo (11:30–12:00): undo exercise, W7
6. Ignoring things (12:30–12:51)
7. Tags (12:52–13:13): tag your project, Answer Reviewer 2
8. Wrap-up and bonus (13:13–14:00): the whole picture, bonus round, W8–W10, follow-up
9. Questions learners often ask (for W10 and during the day)

---

## The two practice folders: `messy_project` and `tidy_project`

Both are built by `../intro-experiment/make-messy-project.sh` and describe the
**same fictional research project**: "Alex Researcher" analysing variant quality
over a few months to make **Figure 3** for a paper. Same scripts and data,
organised two ways:

| | `messy_project` (detective task, ~09:14) | `tidy_project` (Answer Reviewer 2, ~13:03) |
|---|---|---|
| Scripts | four copies: `analysis.py`, `analysis_v2.py`, `analysis_final.py`, `analysis_final_FIXED.py` | **one** `analysis.py`, every version in the history |
| Dates | misleading: `figure3.png` was copied later, so its date matches no script | exact date and author on every commit |
| What changed | compare files by eye, or with `diff` | `git diff` shows the exact lines |
| Which version was submitted | a confusing note in `notes_old.txt` | a tag: `v1.0-submitted` |
| Can you **prove** which script made Figure 3? | **No** | **Yes, in about 30 seconds** |

The contrast is the point of the day: same project, with and without Git.

### Inside `tidy_project`

A Git repository with 4 commits and 1 tag (the commits are backdated so the
history looks real):

```
4204ec8 (HEAD -> main) Add depth filter (DP > 10) for the revision
cc86a42 (tag: v1.0-submitted) Make figure 3 for the paper: QUAL > 20, log scale
6af5dac Lower QUAL threshold to 30 after QC meeting
f8cafbd Add first variant-quality analysis
```

Files: `analysis.py`, `data.csv`, `figure3.png`, `results_jan.csv`,
`results_jan_new.csv`. The scripts don't need to run: the exercises are about
tracing versions, not plotting. Hashes depend on the machine's timezone, so
they may differ on another system; the tag and messages don't.

How the threshold changed over time:

| Commit | `QUAL` threshold | Other changes |
|---|---|---|
| Add first variant-quality analysis | > 50 | |
| Lower QUAL threshold to 30 after QC meeting | > 30 | |
| Make figure 3 for the paper (**v1.0-submitted**) | > 20 | log scale; saves `figure3.png` and `results_jan.csv` |
| Add depth filter for the revision | > 20 | adds `DP > 10`; writes `results_jan_new.csv`; no longer saves the figure |

---

## Opening (09:00–09:50)

### Hook: "Could you answer this email today?"
**Don't answer it yet.** It's rhetorical. Expect nervous laughs and a few "no"s.
The honest answer for most people is *"not with certainty"*, which is what the
detective task makes them feel. Say: *"Hold that thought. By 2 o'clock you'll
answer it in about 30 seconds."* It's answered at the "Answer Reviewer 2" slide.

### W1: How comfortable are you with the command line? (rating 1–5)
No right answer. **What to expect:** a spread, often centred on 2–3.
**How to respond:** lots of 1s and 2s means slowing down on the terminal
toolkit slide, demoing every command, and sending helpers to anyone who looks
unsure. Note the average: it's compared with W8 at the end.

### W2: How do you keep track of versions of your work now? (multi-select)
No right answer. **What to expect:** "renamed copies" is usually the biggest
bar, then Dropbox/OneDrive history; few pick Git.
**How to respond:** without judgement. *"That's what I did for years. Let's
see how well it works."* Note: Dropbox/OneDrive history *does* keep old
versions, but without messages, without exact differences, and without a
permanent label for "the submitted version".

### Your turn: be the detective (`messy_project`)
There is **no provable answer**: that's the lesson.

1. **Which script made `figure3.png`?** Best guess: `analysis_final.py`.
2. **What changed?** Compared with `analysis_v2.py`, the threshold dropped from
   `QUAL > 30` to `QUAL > 20`, a log scale was added, and the results file
   became `results_jan.csv`.
3. **How sure are you? Could you prove it?** No. The honest answer is
   "fairly sure, but I can't prove it", and that's the answer you want.

**The traps:**

- `figure3.png` is dated **2 May**, later than every script (it was copied to a
  shared drive), so the dates don't help.
- `notes_old.txt` says to rerun Figure 3 with the FIXED script before
  submission, but `analysis_final_FIXED.py` has its `savefig` line
  **commented out**. Did anyone rerun it? No way to tell.
- `diff` shows *what* differs between two files, never *which one made the figure*.

Most pairs end up torn between `analysis_final.py` and `analysis_final_FIXED.py`.
Both are reasonable; neither can be proved.

### W3: What made that hard? (word cloud)
No right answer. **What to expect:** *dates, names, notes, final, guessing,
versions, no history, which one?, confusing, can't prove.*
**How to respond:** read 4–5 words out, then map them onto the next slide
("So we need a tool that…"): each problem has a Git answer: commits, `git log`,
`git diff`, commit messages, tags. Use the room's own words where they differ.

### W4: What's one thing you want to be able to do with Git by 2 pm? (open)
No right answer. **What to expect:** *"back up my thesis code"*, *"share code
with my supervisor"*, *"stop having _final_v2 files"*, *"use GitLab for my
pipeline"*, *"collaborate with my lab"*.
**How to respond:** skim at the 10:30 break and reuse their examples all day.
Goals about collaborating or branches aren't covered today: point those people
to the lesson website and the bonus round. W9 asks whether they got there.

### "Any questions about the three boxes?"
The questions people actually ask, with short answers:

- **"Why have a staging area at all?"** So one commit can hold one logical
  change, even if you've edited five files. You choose what goes on the page.
- **"Is the staging area a folder?"** No. It's a list Git keeps inside the
  hidden `.git` folder. Your files don't move anywhere.
- **"Do I have to `git add` every time?"** Yes: every change you want in the
  next commit, every time. `git add` records the file's state *now*.
- **"Where is the repository?"** In the hidden `.git` folder inside your project.
  Delete `.git` and you delete the history (but not your files).

### W5 and W6: what's in the commit? (`git add a.py`, then `git commit`)
**B: only the changes to `a.py`.** A commit contains exactly what's staged;
`b.py` is still modified in the working directory.
What the wrong answers mean: **A** "a commit saves everything" (staging not
understood) · **C** "Git is all or nothing" · **D** confused about what `add` does.
**What to expect:** vote 2 (after discussion) usually has more correct answers
than vote 1. Point out the shift.

### First commit, step 2: what will `git status` say now?
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md
```
Git sees the file but isn't tracking it yet.

---

## Recording changes (09:50–10:30)

### Section question: "How do I record what changed, and see the difference?"
Edit → **`git diff`** to see exactly what changed → **`git add`** to stage it →
**`git commit -m "…"`** to save the snapshot. **`git log`** shows the history:
who, when and why. Before committing, `git restore <file>` throws away unwanted edits.

### Your turn: a Python script
```python
#!/usr/bin/env python
import pandas as pd

variants = pd.read_csv("Data/data.csv")
print(len(variants))
```
```bash
git diff Src/hello.py
git add Src/hello.py
git commit -m "Read CSV and report row count"
```
`git log --oneline` should then show **5 commits**: initial commit, Describe how
to run Python, Add Src folder and example dataset, (add hello.py), Read CSV and
report row count. Running the script isn't required.

---

## GitLab (10:45–11:30)

### Section question: "How do I back up my repository and keep two copies in sync?"
Create an empty project on GitLab → `git remote add origin <address>` →
`git push -u origin main` (back-up done). On another machine: `git clone`.
Then the rule: **`git pull` before you start, `git push` when you finish.**

### Recall (start of section): "Tell your neighbour the three steps to save a snapshot."
Edit the file → **`git add`** → **`git commit -m "…"`**. (Bonus: check with
`git status` along the way.)

### SSH: "Are you sure you want to continue connecting (yes/no)?"
Type **yes**. It appears the first time you connect to any server: SSH doesn't
yet know GitLab's identity, so it asks you to trust it once and remembers it
(in `~/.ssh/known_hosts`). It's a check against impostor servers; it won't
appear again for GitLab.

### Your turn: keep two copies in sync
1. **laptop:** edit README, `add`, `commit`, `push`. Works.
2. **MyProject:** `git pull`. **Is the heading there?** Yes: the pull brought the
   laptop's commit across.
3. **MyProject:** `notes.txt`, `add`, `commit`, `push`. Works.
4. **laptop, without pulling:** edit `Src/hello.py`, `commit`, `push`.
   **What happens?** The push is **rejected** (non-fast-forward), because the
   laptop copy is behind. **Fix:** `git pull` → Git merges automatically
   (different files) → nano opens with *"Merge branch 'main'…"* → save and exit →
   `git push`.

Lesson: **always pull before you start work.**
Fast finishers who edit the same line in both copies get a **conflict**: edit
the file, remove the `<<<<<<<` `=======` `>>>>>>>` lines, `add`, `commit`, `push`.

---

## History & undo (11:30–12:00)

### Section question: "How do I find old versions, and undo mistakes?"
**Find:** `git log` (add `-p` for the changes), `git show HEAD~2:<file>` for an
old version of a file, `git diff HEAD~2 HEAD` to compare.
**Undo:** `git restore` (uncommitted edits) · `git commit --amend` (last commit,
**not yet pushed**) · `git revert <hash>` (anything already pushed) ·
`git stash` (put edits aside to pull).

### Recall (start of section): "Why was your push rejected, and how did you fix it?"
The other copy had pushed first, so mine was **behind** GitLab and Git refused
to overwrite those commits. Fix: **`git pull`** (merges them in), then **`git push`**.

### Your turn: undo it
```bash
# 1. silly line + commit "oops"
git commit --amend -m "Add silly line"   # 2. fix the message: not pushed yet, so rewriting is fine
git push
git revert HEAD --no-edit                # 3. pushed, so undo with a NEW commit
git push
```
Check: `git log --oneline` shows both *Add silly line* and *Revert "Add silly line"*.
Amending **after** pushing leads to a rejected push: the golden rule in action.

### W7: what does `git diff HEAD` show?
**c) working directory ↔ last commit**: everything changed since the last
commit, staged or not.
(a = plain `git diff` · b = `git diff --staged` · d = `git diff <A> <B>`)

---

## Ignoring things (12:30–12:51)

### Section question: "How do I keep big data and secrets out of my repository?"
List them in **`.gitignore`**, ideally **before** the first commit, and commit
`.gitignore` itself. Commit scripts and a README that says where the data
lives. Check with `git status` before every commit and `du -sh .git` now and then.

### Recall (start of section): "Tell your neighbour the difference between amend and revert."
**`--amend`** *replaces* the last commit: only for commits you haven't pushed.
**`revert`** adds a *new* commit that undoes an old one: safe after pushing,
because it adds history instead of rewriting it.

### Large data: "Already committed a big file?"
`git rm --cached big.bam` stops tracking it (the file stays on disk), but it's
**still in the history**. If it hasn't been pushed and it's in the **last**
commit, `git commit --amend` after `rm --cached` removes it. Otherwise, or if
it's been pushed: get help **before** pushing anything else. Removing it fully
needs tools like `git filter-repo`.

### Your turn: ignore a secret
```bash
echo "my password" > secret.txt
echo "secret.txt" >> .gitignore    # >> appends; > would wipe .gitignore
git status                         # secret.txt no longer listed
git add .gitignore
git commit -m "Ignore secret.txt"
git push
```
**Is it listed?** No: once it's in `.gitignore`, `git status` stops showing it.
Point to make: `.gitignore` only affects files Git isn't tracking yet. If
`secret.txt` had already been committed, ignoring it wouldn't remove it from the history.

---

## Tags (12:52–13:13)

### Section question: "How do I mark the exact version behind a paper?"
`git tag -a v1.0 -m "Version submitted to <journal>"` on the right commit, then
`git push origin v1.0`. Cite the tag name and the GitLab URL in the paper's
code availability statement.

### Your turn: tag your project
```bash
git tag -a v1.0 -m "First tagged version"
git push origin v1.0
```
**What can you download there?** On GitLab, **Code → Tags** shows `v1.0` with
downloads (zip, tar.gz) of the whole project **exactly as it was at that tag**:
what you'd give a reviewer.

### Answer Reviewer 2 (`tidy_project`)
```bash
git log --oneline -- figure3.png                          # 1. which commit made it
git show v1.0-submitted --stat                            # 3. the submitted version
git diff v1.0-submitted~1 v1.0-submitted -- analysis.py   # 2. what changed
```
1. **"Make figure 3 for the paper: QUAL > 20, log scale"** (14 March 2025)
2. `QUAL > 30` → `QUAL > 20`, `ax.set_yscale("log")` added,
   `plt.savefig("figure3.png")` added, results file renamed to `results_jan.csv`
3. The tag **`v1.0-submitted`** points at that same commit

**"So what would you write back to Reviewer 2?"** *"Figure 3 was generated by commit
'Make figure 3 for the paper' (tag v1.0-submitted, 14 March 2025), using
QUAL > 20 and a log-scale y-axis; the preprint version used QUAL > 30. The
exact code is available at [GitLab URL], tag v1.0-submitted."*

---

## Wrap-up and bonus (13:13–14:00)

### Section question: "What should I remember, and where do I go next?"
The core loop: **pull → edit → add → commit → push**, with `status`, `diff` and
`log` to check, `.gitignore` to keep things out, and a **tag** for anything you
publish. Next: collaborating in one repository, branches, and Git in RStudio,
all on the lesson website.

### The whole picture: name the command for each arrow
| Arrow | Command |
|---|---|
| Working directory → staging area | `git add` |
| Staging area → repository | `git commit` |
| Repository → GitLab | `git push` |
| GitLab → repository (and your files) | `git pull` (= `git fetch` + merge) |
| Repository → working directory (put a file back) | `git restore` |
| Look at any of it | `git status` · `git diff` · `git log` · `git show` |

### "Which one will you use this week?"
No right answer. Good answers to encourage: *"`git init` + `.gitignore` on my
analysis folder"*, *"push my thesis code to GitLab as a backup"*, *"tag the code
for my next paper"*. Push for a specific plan: *"When I next ___, I will commit."*

### Bonus round

#### ★ Your own project
No single answer. Check **before** they commit or push:
- `git status` shows **no** data files, outputs or secrets
- `du -sh .git` is small (a few MB, not GB)
- `.gitignore` is committed

#### Detective, level 2 (`tidy_project`)
**When did the depth filter appear, and who added it?**
**What threshold did the very first version use?**
```bash
git log -S "DP > 10" --oneline     # → "Add depth filter (DP > 10) for the revision"
git log -S "DP > 10"               # full entry: Alex Researcher, 28 April 2025
git show HEAD~3:analysis.py        # first version: QUAL > 50
```
`git log -S "text"` (the "pickaxe") lists commits that added or removed that text.

#### Explore on GitLab
Make a change, commit, `git tag -a v1.1 -m "…"`, `git push origin v1.1`.
GitLab **Code → Compare revisions** (menu names vary by GitLab version), `v1.0`
→ `v1.1` shows the diff in the browser. On a file page, **History** = `git log`
for that file; **Blame** = who last changed each line.

#### Time travel
```bash
git restore --source=v1.0 README.md   # README as it was at the tag
git diff                              # what came back? any lines added since v1.0 show as removed (empty if README hasn't changed since the tag)
git restore README.md                 # undo, or: git add + git commit to keep it
```
Nothing is lost either way: the tag still points at the old version.

### W8: How comfortable are you with the command line now? (rating 1–5)
No right answer. **What to expect:** a shift up of about one point compared
with W1. Show the two side by side. If it hasn't moved, ask (kindly) what made
it hard, and note it for next time.

### W9: Your goal from this morning (W4): can you do it now? (Yes / Partly / Not yet)
No right answer. **How to respond:** to "Partly" and "Not yet": *"Come and talk
to me after, or email me: let's get you there."* Collaboration and branching
goals are expected to be "Not yet": point to the lesson website.

### W10: What's still confusing? (open, anonymous)
Answer one or two quick ones live; the rest go in the follow-up email. The most
likely ones are in "Questions learners often ask" at the end of this file.

### Follow-up, 4 weeks later: "Have you committed to a repository since the workshop?"
Send as a one-question survey (Yes / No / Tried but got stuck). It's the real
measure of whether the course worked. "Tried but got stuck" replies are worth a
personal reply.

---

## Questions learners often ask

Short answers for W10 and for questions during the day.

**What's the difference between Git, GitLab and GitHub?**
Git is the tool on your computer that records versions. GitLab and GitHub are
websites that host Git repositories, for backup and sharing. The University runs
its own GitLab at git.ecdf.ed.ac.uk.

**`git pull` vs `git fetch`?**
`fetch` downloads new commits but doesn't touch your files. `pull` = `fetch` +
merge them into your files. Day to day, use `pull`.

**What does `pull.rebase false` mean?**
When pulling, combine the two histories with a merge (the simplest behaviour).
The alternative, rebase, rewrites your local commits on top; it's for later.

**What is `HEAD`? And `HEAD~2`?**
`HEAD` is "where you are now": usually your latest commit. `HEAD~1` is one
commit before it, `HEAD~2` two before.

**`restore` vs `revert` vs `amend`?**
`restore`: throw away edits you haven't committed. `amend`: replace your last
commit (only if not pushed). `revert`: add a new commit that undoes an old one
(safe after pushing).

**How often should I commit?**
Whenever you've made one logical change that works: a fixed bug, a new
section, a changed parameter. Small and often beats big and rarely. The message
says *why*.

**Should I commit my data?**
Small, stable files that you can't regenerate (a few MB): fine. Large, raw,
regenerable or sensitive data: no. Put it in `.gitignore` and say in the README
where it lives.

**Is Git a backup?**
Only once you `git push` to GitLab. The history on Eddie alone is lost if the
folder is.

**Can I use Git for Word or Excel files?**
Git stores them, but can't show what changed inside them. It works best with
text: scripts, Markdown, CSV, config files.

**I added a file to `.gitignore` but `git status` still shows it.**
It was already being tracked. `git rm --cached <file>`, then commit.

**What if I make a mistake and commit something wrong?**
Not pushed: `git commit --amend`. Pushed: `git revert <hash>`. Secret or big
file already pushed: get help before doing anything else.

**What are branches?** (not covered today)
A way to work on an experiment in parallel without touching the main version,
then merge it in if it works. See the lesson website.

**How do I use this with colleagues?** (not covered today)
Add them as members of the GitLab project; everyone clones, pulls before
working and pushes after. Conflicts work exactly like the sync exercise. See
"Collaborating" on the lesson website.

**Can I do this from RStudio or VS Code?**
Yes: both have Git built in, with buttons for add, commit, push and pull. It's the
same Git underneath. See "Git in RStudio" on the lesson website.

**SSH or HTTPS for GitLab?**
SSH (today's way): set up a key once, no passwords after. HTTPS works too, but
asks for a username and access token.
