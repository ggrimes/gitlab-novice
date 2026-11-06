# Helper sheet: Introduction to Git and GitLab (half-day)

Thank you for helping! One page: how the day runs, how to help, and the fixes you'll need most.

## How to help

- **Pink sticky = go over. Yellow = done.** Scan the room every few minutes; don't wait to be asked.
- **Hands off the keyboard.** Point and explain; let the learner type. They learn it; you'd just fix it.
- **First question: "What does `pwd` say?"** Most problems are being in the wrong folder.
- **Read the error message together.** Git's messages usually say what to do next.
- If it'll take more than 2 minutes, help them catch up afterwards: they can copy commands from the website.
- Never say "just" or "simply".

## The day and the hot spots

| Time | Section | Where people get stuck |
|---|---|---|
| 09:00 | Opening, detective task | long `cp -rp` path (copy it from the website); if Eddie's shared folder fails, the zip on the website |
| 09:38 | Config + first commit | `git init` in the home folder; forgetting `git add` |
| 09:50 | Recording changes | saving in nano (`Ctrl+O`, `Enter`, `Ctrl+X`); `q` to leave `git log` |
| 10:30 | **Break** | |
| 10:45 | GitLab | SSH key not working; wrong address in `git remote add` |
| 11:13 | **Sync exercise** (busiest 14 min) | working in the wrong copy; forgetting to push; merge message in nano |
| 11:30 | History & undo | `--amend` after pushing; revert opening nano |
| 12:00 | **Lunch** | |
| 12:30 | Ignoring | `>` instead of `>>` wipes `.gitignore` |
| 12:52 | Tags | forgetting `git push origin v1.0`; "tag already exists" if they typed along with the demo (`git tag -d v1.0`, then retag) |
| 13:03 | Answer Reviewer 2 | `git clone` of `tidy_project` fails with "Permission denied (publickey)": use `git clone https://git.ecdf.ed.ac.uk/igmmbioinformatics/tidy_project.git`; cloning inside `MyProject`: `cd ~` first |
| 13:20 | **Bonus round** (or the branching bonus if the room is ahead) | own projects: check `.gitignore` and `git status` **before** they commit: no data, no secrets |
| 13:45 | Etherpad questions, wrap-up | |

## Fixes

| What you see | Fix |
|---|---|
| Screen full of `~` (vim) | `Esc`, `:wq`, `Enter` (or `:q!`), then `git config --global core.editor "nano -w"` |
| "Please tell me who you are" | `git config --global user.name "…"` and `user.email "…"` |
| "not a git repository" | wrong folder: `pwd`, `cd ~/MyProject` |
| `git status` lists the whole home folder | `rm -rf ~/.git`, then `cd ~/MyProject` |
| "nothing added to commit" | they skipped `git add` |
| "Permission denied (publickey)" | add the **whole** `cat ~/.ssh/id_alcescluster.pub` line to GitLab (**not** `id_ed25519.pub`: Eddie's `~/.ssh/config` makes SSH use only `id_alcescluster`); test `ssh -T git@git.ecdf.ed.ac.uk` |
| "remote origin already exists" or a typo in the address | `git remote set-url origin <address>` |
| "src refspec main does not match any" | no commits yet, or the branch is `master`: `git branch -m master main` |
| First push rejected (README box ticked) | `git pull --allow-unrelated-histories`, save, `git push` |
| "[rejected] … non-fast-forward" | `git pull`, then `git push` |
| "Need to specify how to reconcile divergent branches" | `git config --global pull.rebase false`, pull again |
| "CONFLICT" | edit the file, remove the three marker lines, `add`, `commit`, `push` |
| Committed a big file / secret in the **last** commit, not pushed | `git rm --cached <file>`, add it to `.gitignore`, `git commit --amend`. **If it's in an older commit, or already pushed: get the instructor; don't push** |

The same tables are at the end of the slide deck (press M for the menu).
