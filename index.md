---
site: sandpaper::sandpaper_site
---

# Introduction to Git and GitLab

This lesson is a hands-on introduction to version control with Git and GitLab.
Learners start by tracking changes to files on their own computer, then share
their work on GitLab and collaborate with others in a shared repository.

## Who this lesson is for

The lesson is for researchers, analysts and postgraduate students who work with
data and code but have not used version control before. It is usually taught as
the final workshop of a two-week Introduction to Data Science programme at the
University of Edinburgh, with some learners in the room and some online. The
[learner profiles](profiles/learner-profiles.md) describe the learners we have
in mind.

:::::::::::::::::::::::::::::::::::::::::: prereq

## Prerequisites

- Basic use of the command line: moving between directories, listing files and
  running commands. The Software Carpentry
  [Unix Shell](https://swcarpentry.github.io/shell-novice/) lesson covers this.
- Ability to edit a text file with an editor such as nano, VS Code or RStudio.
- For episode 5, some familiarity with RStudio.
- A University of Edinburgh login, or a free [gitlab.com](https://gitlab.com)
  account.

No previous experience of Git is needed.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Lesson objectives

By the end of this lesson, learners will be able to:

1. Track changes to their own project with Git, and inspect and restore
   earlier versions of their work.
2. Share a project on GitLab and collaborate with others in a shared
   repository, resolving rejected pushes and merge conflicts.
3. Use branches to keep experimental work separate, and tags to mark the
   version of their code used for a result.

Each episode's objectives build towards one or more of these. The
[lesson design notes](instructors/design-notes.md) show how they map.

## What the lesson covers

- Why version control is useful
- Configuring Git
- The local workflow: staging, committing and checking status
- Working with remote repositories on GitLab
- Using Git from RStudio
- Collaborating in a shared repository, including resolving merge conflicts
- Exploring the history of a project and restoring earlier versions
- Ignoring files
- Branching and tagging

## Setup

The setup instructions are specific to resources available at the University
of Edinburgh, with notes for learners using gitlab.com. They can be found in
the [setup guide](learners/setup.md).

This lesson is built with [The Carpentries Workbench][workbench].

[workbench]: https://carpentries.github.io/sandpaper-docs
