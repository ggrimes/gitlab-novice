---
title: "Why Version Control?"
teaching: 15
exercises: 3
---

::: questions
-   What problem does version control solve?
-   When should I use Git?
:::

::: objectives
-   Describe what a version control system (VCS) does.
-   List at least three reasons why using Git can improve your workflow.
-   Outline the key components of a Git repository (working directory, staging area, commit history).
:::

Have you ever found yourself with a folder full of files like this?

-   `report.docx`
-   `report_final.docx`
-   `report_final_v2.docx`
-   `report_final_for_real_this_time.docx`
-   `report_final_sent_to_boss.docx`

Or maybe you've been working on a file and thought, "I wish I could go back to the version I had yesterday before I deleted that paragraph."

This is the kind of problem that version control is designed to solve.

## Introduction

Version control is like a digital lab notebook: it keeps a dated, permanent record of every meaningful change you make to your project files. In this episode we introduce Git, the distributed version control system we will use throughout the lesson.

A VCS helps you:

-   keep files synchronised across multiple machines,
-   recover previous states of your project (including deleted files!),
-   discover who changed what, when, and why,
-   collaborate safely with colleagues, and
-   showcase the evolution of your work.

In this workshop we will explore:

-   tracking changes locally,
-   sharing work using **GitLab**, a web-based platform for hosting your Git repositories and collaborating with others,
-   collaborating via pushes, pulls, and merge requests, and
-   branching to develop new ideas without breaking the main line of development.

::: instructor
Learners often try to remember **all** Git commands at once. Reassure them that they only need a handful today: `git config`, `git init`, `git status`, `git add`, and `git commit`. Emphasise the conceptual model (working directory → staging area → repository) before the syntax.
:::

### The Git Workflow

![](https://swcarpentry.github.io/git-novice/fig/git-staging-area.svg){alt="Diagram showing working directory, staging area, and repository."}

The diagram above summarises the flow of information in a Git repository.

Here is what these terms mean:

-   **Working Directory:** The folder on your computer where your project files live. This is where you do all your work: creating, editing, and deleting files.
-   **Staging Area (or Index):** A "waiting room" for your changes. You select which changes from your working directory you want to save, and you add them to the staging area. This allows you to group related changes into a single, meaningful snapshot.
-   **Repository (or Commit History):** The permanent, dated record of all the snapshots you have saved. Once a change is committed from the staging area to the repository, it's saved in your project's history.

::::: challenge
### Challenge

1: Why bother?

Which of the following is **not** a typical reason to use a version control system?

A. Keeping files synchronised between two laptops\
B. Tracking the history of code changes\
C. Encrypting files to keep them secret\
D. Collaborating with colleagues on a shared project

::: solution
C. Encrypting files. While encryption is possible, it is **not** the primary purpose of a version control system.
:::
:::::

::: keypoints
-   Version control records every meaningful change to your project.
-   Git’s three-step workflow is: **edit → stage → commit**.
-   Version control facilitates collaboration, provenance, and backup.
:::
