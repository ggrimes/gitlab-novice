---
title: "Reference"
---

## Glossary

**Branch**
:   A separate line of development. New branches are often created to work on new features without disturbing the main line of development.

**Clone**
:   To make a local copy of a remote repository. The local copy is connected to the remote, allowing you to pull changes from the remote and push your own changes to it.

**Commit**
:   A snapshot of the state of your files at a particular point in time. Each commit has a unique identifier (a hash) and a message describing the changes.

**Conflict**
:   A situation that occurs when two or more people make changes to the same part of a file. Git is unable to automatically decide which change to keep, so it asks the user to resolve the conflict manually.

**Diff**
:   The difference between two versions of a file or set of files.

**Fork**
:   A copy of a repository that is owned by you. Forks allow you to freely experiment with changes without affecting the original project. It is often used in open-source software to propose changes to a project you don't have write access to.

**Git**
:   A distributed version control system that tracks changes in source code during software development. It is designed for coordinating work among programmers, but it can be used to track changes in any set of files.

**GitLab**
:   A web-based Git repository hosting service. It provides a graphical interface, plus access control and several collaboration features, such as wikis and basic task management tools for every project.

**HEAD**
:   A reference to the most recent commit in the currently checked-out branch.

**Index**
:   Another name for the staging area.

**Log**
:   A record of the sequence of commits that have been made to a repository.

**Main**
:   The default branch in a Git repository. It is conventionally the main line of development.

**Merge**
:   To combine the changes from one branch into another.

**Origin**
:   The default name for the remote repository from which a local repository was cloned.

**Pull**
:   To fetch changes from a remote repository and merge them into the current branch.

**Push**
:   To send your committed changes to a remote repository.

**Rebase**
:   To re-apply a series of commits on top of another base tip. This is an alternative to merging.

**Remote**
:   A version of your repository that is hosted on another computer, usually a server. You can have multiple remotes for a single local repository.

**Repository**
:   A collection of files and the history of their changes. The history is stored in a hidden subdirectory called `.git`.

**Staging Area**
:   A file, also known as the index, that stores information about what will go into your next commit. You can add and remove files from the staging area before you commit them.

**Tag**
:   A reference to a specific commit, often used to mark a release (e.g., v1.0).

**Upstream**
:   A term for the remote repository from which you cloned your local repository. It is the main place where the code is developed.

**Version Control System (VCS)**
:   A system that records changes to a file or set of files over time so that you can recall specific versions later.

**Working Directory**
:   The directory on your computer where you are currently working. It contains the files that you are editing.

---

## Git Cheatsheets for Quick Reference

- Printable Git cheatsheets in several languages are available [here](https://training.github.com/downloads/github-git-cheat-sheet/).
- More material is available from the [GitHub training website](https://training.github.com/).
- An interactive one-page visualisation about the relationships between workspace, staging area, local repository, upstream repository, and the commands associated with each (with explanations) is available [here](http://ndpsoftware.com/git-cheatsheet.html#loc=workspace;).
- Both resources are also available in other languages (e.g. Spanish, French, and more).
- "Happy Git and GitHub for the useR" is an accessible, free online book by Jenny Bryan on how to setup and use Git and GitHub with specific references on the integration of Git with RStudio and working with Git in R.
- Open Scientific Code using Git and GitHub - A collection of explanations and short practical exercises to help researchers learn more about version control and open source software.

---

## Git Command Cheatsheet

| Command | Description |
|---|---|
| `git config --global user.name "Your Name"` | Set your name for Git commits |
| `git config --global user.email "you@example.com"` | Set your email for Git commits |
| `git init` | Create a new local repository |
| `git status` | Check the status of your repository |
| `git add <file>` | Add a file to the staging area |
| `git commit -m "Your message"` | Commit your staged changes with a message |
| `git log` | View the commit history |
| `git log --oneline` | View the commit history in a condensed format |
| `git diff <file>` | View the changes you've made to a file |
| `git diff HEAD~N <file>` | Compare a file with the version from N commits ago |
| `git show <commit>` | Show the changes made in a specific commit |
| `git restore <file>` | Discard changes in the working directory |
| `git remote add origin <url>` | Connect your local repository to a remote one |
| `git push -u origin main` | Push your changes to the remote repository for the first time |
| `git push` | Push your changes to the remote repository |
| `git pull` | Pull changes from the remote repository |
| `git clone <url>` | Clone a remote repository to your local machine |
| `git blame <file>` | Show who last modified each line of a file |
 

