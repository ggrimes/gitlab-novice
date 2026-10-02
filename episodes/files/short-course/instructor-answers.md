# Instructor answers: Introduction to Git and GitLab (half-day)

Answers and background for every exercise in `git-short.qmd`, in the order they
appear. For helpers and co-instructors: read before the day; keep open on the day.
Error messages and fixes are in `helper-sheet.md`.

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

## Opening

### W5/W6: what's in the commit? (`git add a.py`, then `git commit`)
**B: only the changes to `a.py`.** A commit contains exactly what's staged;
`b.py` is still modified in the working directory.
What the wrong answers mean: **A** "a commit saves everything" (staging not
understood) · **C** "Git is all or nothing" · **D** confused about what `add` does.

### Your turn: be the detective (`messy_project`)
There is **no provable answer**: that's the lesson.

- **Best guess:** `analysis_final.py` made `figure3.png`. Compared with
  `analysis_v2.py`, the threshold dropped from `QUAL > 30` to `QUAL > 20`, a
  log scale was added, and the results file became `results_jan.csv`.
- **The traps:**
  - `figure3.png` is dated **2 May**, later than every script (it was copied to a
    shared drive), so the dates don't help.
  - `notes_old.txt` says to rerun Figure 3 with the FIXED script before
    submission, but `analysis_final_FIXED.py` has its `savefig` line
    **commented out**. Did anyone rerun it? No way to tell.
  - `diff` shows *what* differs between two files, never *which one made the figure*.
- Most pairs end up torn between `analysis_final.py` and `analysis_final_FIXED.py`.
  Both are reasonable; neither can be proved.

### First commit, step 2: predict `git status`
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md
```
Git sees the file but isn't tracking it yet.

---

## Recording changes

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

## GitLab

### Your turn: keep two copies in sync
1. **laptop:** edit README, `add`, `commit`, `push`. Works.
2. **MyProject:** `git pull` brings the new heading in.
3. **MyProject:** `notes.txt`, `add`, `commit`, `push`. Works.
4. **laptop, without pulling:** edit `Src/hello.py`, `commit`, `push`:
   **rejected** (non-fast-forward), because the laptop copy is behind.
   Fix: `git pull` → Git merges automatically (different files) → nano opens with
   *"Merge branch 'main'…"* → save and exit → `git push`.

Lesson: **always pull before you start work.**
Fast finishers who edit the same line in both copies get a **conflict**: edit
the file, remove the `<<<<<<<` `=======` `>>>>>>>` lines, `add`, `commit`, `push`.

---

## History & undo

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

---

## Ignoring things

### Your turn: ignore a secret
```bash
echo "my password" > secret.txt
echo "secret.txt" >> .gitignore    # >> appends; > would wipe .gitignore
git status                         # secret.txt no longer listed
git add .gitignore
git commit -m "Ignore secret.txt"
git push
```
Point to make: `.gitignore` only affects files Git isn't tracking yet. If
`secret.txt` had already been committed, ignoring it wouldn't remove it from the history.

---

## Tags

### Your turn: tag your project
```bash
git tag -a v1.0 -m "First tagged version"
git push origin v1.0
```
On GitLab, **Code → Tags** shows `v1.0` with downloads (zip, tar.gz) of the
whole project **exactly as it was at that tag**: what you'd give a reviewer.

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

**What to write back to Reviewer 2:** *"Figure 3 was generated by commit
'Make figure 3 for the paper' (tag v1.0-submitted, 14 March 2025), using
QUAL > 20 and a log-scale y-axis; the preprint version used QUAL > 30. The
exact code is available at [GitLab URL], tag v1.0-submitted."*

---

## Bonus round

### ★ Your own project
No single answer. Check **before** they commit or push:
- `git status` shows **no** data files, outputs or secrets
- `du -sh .git` is small (a few MB, not GB)
- `.gitignore` is committed

### Detective, level 2 (`tidy_project`)
```bash
git log -S "DP > 10" --oneline     # → "Add depth filter (DP > 10) for the revision"
git log -S "DP > 10"               # full entry: Alex Researcher, 28 April 2025
git show HEAD~3:analysis.py        # first version: QUAL > 50
```
`git log -S "text"` (the "pickaxe") lists commits that added or removed that text.

### Explore on GitLab
Make a change, commit, `git tag -a v1.1 -m "…"`, `git push origin v1.1`.
GitLab **Code → Compare revisions** (menu names vary by GitLab version), `v1.0`
→ `v1.1` shows the diff in the browser. On a file page, **History** = `git log`
for that file; **Blame** = who last changed each line.

### Time travel
```bash
git restore --source=v1.0 README.md   # README as it was at the tag
git diff                              # shows what came back
git restore README.md                 # undo, or: git add + git commit to keep it
```
Nothing is lost either way: the tag still points at the old version.
