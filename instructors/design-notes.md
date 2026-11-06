---
title: 'Lesson Design Notes'
---

This page records the design decisions behind the lesson and the reasons for
them. It follows the backward design process taught in The Carpentries
[Collaborative Lesson Development Training](https://carpentries.github.io/lesson-development-training/):
define the learning outcomes, design exercises that check them, write the
content, then use what happens in workshops to revise the lesson.

## Audience

**Chosen audience:** researchers, analysts and postgraduate students at the
University of Edinburgh and partner NHS organisations who write scripts to
analyse data but have never used version control. They are **novices** with
Git, though some are competent programmers. See the
[learner profiles](../profiles/learner-profiles.md).

**Audience we decided not to design for:** learners with no command-line
experience at all. The lesson is the final workshop of a two-week programme,
so it assumes the shell basics taught earlier. Learners new to the shell
should take a shell lesson first.

## Prerequisites and pre-workshop check

Prerequisites are listed on the [home page](../index.md). To check whether a
registrant fits the audience, ask these two questions when they sign up.
Self-assessment is unreliable, so ask learners to answer rather than rate
themselves.

1. **In a terminal, which command shows the files in the current folder?**
   `cd` / `ls` / `pwd` / I don't know.
   Learners who can't answer `ls` should take a shell lesson first.
2. **Which of these have you done?**
   I have used Git to make a commit / I have cloned a repository but never
   committed / I have never used Git.
   This shows the mix of experience in the group, so the instructor can
   plan extension tasks for learners who already use Git.

## Lesson objectives and how episodes map to them

By the end of the lesson, learners will be able to:

1. Track changes to their own project with Git, and inspect and restore
   earlier versions of their work.
2. Share a project on GitLab and collaborate with others in a shared
   repository, resolving rejected pushes and merge conflicts.
3. Use branches to keep experimental work separate, and tags to mark the
   version of their code used for a result.

| Episode | Lesson objective | Objectives | Challenges |
|---|---|---|---|
| 1. Why Version Control? | 1 | 3 | 1 |
| 2. Configuring Git | 1 | 4 | 3 |
| 3. Recording Changes Locally | 1 | 6 | 4 |
| 4. Working with Remote Repositories | 2 | 4 | 4 |
| 5. Using Git with a GUI (RStudio) | 1, 2 | 5 | 0 |
| 6. Collaborating | 2 | 4 | 3 |
| 7. Exploring History | 1 | 5 | 4 |
| 8. Ignoring Things | 1 | 3 | 1 |
| 9. Branching and Tagging | 3 | 7 | 5 |

## Narrative and example data

Learners build a single project, `MyProject`, through episodes 3 to 6. It
contains a small genomics dataset (`Data/data.csv`, a tidy table of variant
calls from the Data Carpentry genomics workshop data) and a short Python
script (`Src/hello.py`) that reads it. The story is a researcher putting an
existing analysis under version control, then sharing it with a collaborator.

This scenario was chosen because it matches what the learners do: they
already have scripts and data, and the problem is keeping track of versions
and sharing them safely. The dataset is real but small, so it doesn't distract
from Git itself.

## Exercises

Exercises are written to check episode objectives, and every exercise has a
worked solution. They use a mix of formats suited to novices:
predict-the-output questions, multiple-choice questions, and short hands-on
tasks in the learners' own project. In a hybrid workshop the online helper
monitors exercise progress for learners joining remotely.

## Life cycle

| Stage | What changed |
|---|---|
| Pre-alpha | Lesson created from the Carpentries Workbench template (June 2025) |
| Beta | Lesson taught as part of the Introduction to Data Science programme. Learner profiles, prerequisites, lesson objectives, instructor notes and design notes added; collaboration exercises added to episode 6 |

### Changes made after teaching

- Learners asked for more time at the end to practise on a realistic example,
  and a peer observer suggested extension tasks for learners who finish
  quickly. Tiered exercises and a closing worked example are planned.
- The peer observer noticed that the instructor sometimes spoke to the class
  before an exercise timer ended. Instructors should stay quiet while learners
  work on an exercise.

## Known gaps

These are the next steps for the lesson, judged against the Collaborative
Lesson Development Training guidance:

- **Exercises for every objective.** Episode 5 has no challenges, and
  episodes 1 and 8 have one challenge for three objectives.
- **Number of objectives per episode.** The guidance suggests 2–4. Episodes 3,
  5, 7 and 9 have more, so their objectives could be grouped, or episode 9
  split into separate Branching and Tagging episodes.
- **Skill-based objectives.** Some objectives name a command rather than a
  task, for example "Initialise a repository with `git init`".
- **One narrative throughout.** Episodes 8 and 9 use their own example files
  (`secret.txt`, `summary.py`) rather than continuing `MyProject`.
- **Missing images** in episodes 4, 5, 7 and 8.
