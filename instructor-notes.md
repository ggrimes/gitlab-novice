---
title: 'Instructor Notes'
---

This workshop is designed to run at the University of Edinburgh and uses its
services: ECDF GitLab, the Eddie cluster and Noteable. Instructors elsewhere can
use [gitlab.com](https://gitlab.com) and learners' own computers instead. The
GitLab screens look the same, but menu names may differ slightly between
versions.

## Before the workshop

- **Send the setup instructions at least a week ahead** and ask learners to
  confirm that `git --version` works. Installation problems are the most common
  cause of lost time in the first half hour.
- **Ask learners to set up SSH keys in advance**, or plan 15 minutes for it
  at the start. Learners on Eddie should use the key already set up for the
  cluster.
- **Off-campus learners need the University VPN** to reach ECDF GitLab. Remind
  them to connect before the workshop starts.
- **Prepare a pairing plan for episode 6.** Collaborating needs learners in
  pairs, and each person needs their partner's UUN. In a hybrid workshop, pair
  in-room learners together and online learners together.

## Timing

The full lesson takes about 2 hours 50 minutes of teaching and exercises, plus
breaks. If time is short:

- Episodes 1–4 and 6 are the core of the lesson.
- Episode 5 (RStudio) can be skipped if learners are not R users, or used
  instead of the command line for learners who find the terminal difficult.
- Episodes 8 (Ignoring Things) and 9 (Branching and Tagging) can be shortened
  or set as follow-up reading.

## Hybrid delivery

- **Have an online helper.** One person should watch the chat, answer
  questions from online learners, and tell the instructor when someone is stuck.
- **Use a consistent way to ask for help**, such as raising a hand in Teams for
  online learners and coloured sticky notes in the room.
- **Increase the terminal font size** and use a light background so code is
  readable on a shared screen and in a video call.
- **Paste each command into the chat** or a shared notes document after typing
  it, so online learners can catch up if the video lags.

## Common problems

| Problem | What usually helps |
|---|---|
| `Permission denied (publickey)` when pushing or cloning | The SSH key is missing, not added to GitLab, or the wrong key is being used. Check with `ssh -T git@git.ecdf.ed.ac.uk`. |
| Cannot reach GitLab off campus | Connect to the University VPN. |
| Push to `main` rejected in episode 6 | The branch is still protected. Repeat Step 2 (unprotect the branch). |
| `git` opens Vim during a commit or merge | Show learners how to exit (`Esc`, then `:wq`), then set a friendlier editor with `git config --global core.editor nano`. |
| Commits show the wrong name or email | `git config` was not run in episode 2, or was run without `--global`. |
| Learners worry about "breaking" the repository | Emphasise that committed work can almost always be recovered, and show `git log` and `git restore` early. |

## Links

* [Git cheat sheet (GitHub Education)](https://education.github.com/git-cheat-sheet-education.pdf)
* [Top 12 Git commands every developer must know](https://github.blog/developer-skills/github/top-12-git-commands-every-developer-must-know/)
