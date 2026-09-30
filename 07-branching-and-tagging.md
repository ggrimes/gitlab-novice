---
title: "Branching and Tagging"
teaching: 25
exercises: 8
---

::: questions
-   What is a branch in Git?
-   How do I create a branch and move between branches?
-   How do I bring the changes from one branch into another?
-   How do I share a branch on GitLab?
-   How do I mark an important version of my project, such as the one used for a paper?
:::

::: objectives
-   Explain why branches are useful for parallel development.
-   List, create and switch between branches with `git branch` and `git switch`.
-   Compare two branches with `git diff`.
-   Merge a branch into `main` with `git merge` and explain what a *fast-forward* merge is.
-   Push a branch to GitLab with `git push origin <branch>`.
-   Explain the difference between a branch and a tag.
-   Create, inspect and push an annotated tag with `git tag -a`.
:::

## Introduction

So far every commit we have made has gone onto a single line of history called `main`. A **branch** lets you start a separate line of development, so you can work on something new without disturbing the version of your code that already works.

Branches are useful when:

-   you want to **test out a change** to a script without breaking the working version,
-   you are **collaborating** and do not want to be modifying the same code at the same time, or
-   you want to keep an **experimental idea** separate until you know it is worth keeping.

A branch is just a movable label that points to a commit. When you make a new commit on a branch, the label moves forward to the new commit. `HEAD` tells Git which branch you are currently on.

::: instructor
Learners often think a branch is a copy of all the files. Emphasise that a branch is only a *pointer* to a commit, which is why creating one is instant. Drawing the commits as circles and the branches as sticky labels on the whiteboard works well here.
:::

## 1. Listing branches

In your `MyProject` repository, list the branches:

``` bash
$ git branch
```

``` output
* main
```

There is only one branch, `main`. The `*` shows the branch you are currently on.

## 2. Creating a branch

Create a new branch called `dev`:

``` bash
$ git branch dev
$ git branch
```

``` output
  dev
* main
```

The `dev` branch now exists and points to the same commit as `main`, but we are still on `main`.

## 3. Switching branches

Move to the `dev` branch:

``` bash
$ git switch dev      # newer Git (>=2.23)
# or
$ git checkout dev    # older Git versions
$ git branch
```

``` output
* dev
  main
```

::: callout
### Create and switch in one step

You can create a branch and switch to it in a single command:

``` bash
$ git switch -c dev     # newer Git
$ git checkout -b dev   # older Git versions
```
:::

## 4. Committing on a branch

While on `dev`, add a new script that summarises the data:

``` bash
$ nano Src/summary.py
```

``` python
#!/usr/bin/env python

import pandas as pd

variants = pd.read_csv("Data/data.csv")

# Print the column names in the dataset
print(variants.columns)
```

Add and commit it:

``` bash
$ git add Src/summary.py
$ git commit -m "Add script to summarise the dataset"
```

Now switch back to `main` and list the `Src` directory:

``` bash
$ git switch main
$ ls Src
```

`summary.py` is not there. The commit only exists on the `dev` branch, so when we switched to `main` Git updated our working directory to match `main`.

To see how the branches have diverged, view the history of all branches as a graph:

``` bash
$ git log --oneline --graph --all
```

## 5. Comparing branches

Before merging, it is good practice to check what the other branch would bring in:

``` bash
$ git diff main..dev
```

This shows the changes that are on `dev` but not on `main`: here, the new file `Src/summary.py`.

## 6. Merging a branch

We are happy with the change, so we bring it into `main`. First make sure you are on the branch you want to merge **into**, then merge the other branch:

``` bash
$ git switch main
$ git merge dev
```

``` output
Updating 370eb9d..83e878e
Fast-forward
 Src/summary.py | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 Src/summary.py
```

::: callout
### Fast-forward merges

Because nobody had committed to `main` since `dev` was created, there is a straight line from `main` to the tip of `dev`. Instead of creating a new "merge commit", Git simply moves the `main` label forward to the same commit as `dev`. This is called a **fast-forward** merge.

If both branches have new commits, Git creates a *merge commit* that joins the two lines of history. If both branches changed the same lines of the same file, you get a **merge conflict**, which you resolve in the same way as in the Collaborating episode.
:::

## 7. Sharing a branch on GitLab

Branches you create are local until you push them. To publish `dev` to GitLab:

``` bash
$ git push origin dev
```

On GitLab you can now choose the `dev` branch from the branch drop-down on your project page.

::: callout
### Merge requests

On GitLab you can also merge a branch through the web interface by opening a **merge request** (called a *pull request* on GitHub). A merge request lets collaborators review and discuss the changes before they are merged into `main`, and is the usual way teams work with branches.
:::

## 8. Deleting a branch

Once a branch has been merged you can delete it:

``` bash
$ git branch -d dev              # delete the local branch
$ git push origin --delete dev   # delete the branch on GitLab
```

Git will refuse to delete a local branch with `-d` if it contains commits that have not been merged, so you cannot lose work by accident.

::: callout
### Detached HEAD

If you check out a specific commit rather than a branch (for example `git checkout 72041c0`), Git warns that you are in a **"detached HEAD"** state. This means you are no longer on any branch. To get back, switch to the branch you were on:

``` bash
$ git switch main
```
:::

## 9. Tagging a version

A branch is a label that **moves forward** every time you commit. Sometimes you want a label that **never moves**: a permanent name for one particular commit, such as

-   the version of your code used to produce the results in a paper or report,
-   a release you have shared with collaborators (`v1.0`, `v1.1`, ...), or
-   the state of the project at the end of a milestone.

This is what a **tag** is for. Tagging the exact version you published means you, or a reviewer, can always get back to it, even after the code has moved on.

### Creating a tag

Make sure you are on `main`, then create an *annotated* tag with a message describing it:

``` bash
$ git switch main
$ git tag -a v1.0 -m "Version used for the workshop report"
```

The tag is attached to the commit `HEAD` currently points to. To tag an older commit, add its ID at the end, e.g. `git tag -a v0.9 -m "First draft" 72041c0`.

::: callout
### Annotated and lightweight tags

`git tag -a` creates an **annotated** tag, which records who made the tag, when, and a message. Running `git tag v1.0` without `-a` creates a **lightweight** tag, which is only a name for a commit. Use annotated tags for anything you will share or cite.
:::

### Listing and inspecting tags

``` bash
$ git tag
```

``` output
v1.0
```

`git show` displays the tag's message followed by the commit it points to:

``` bash
$ git show v1.0
```

``` output
tag v1.0
Tagger: firstname surname <emailaddress@ed.ac.uk>
Date:   Tue Sep 24 11:15:02 2024 +0100

Version used for the workshop report

commit 83e878e...
```

You can also see tags alongside branch names in the history:

``` bash
$ git log --oneline --decorate
```

### Using a tag

Anywhere Git expects a commit ID, you can use a tag name instead. For example, to see everything that has changed since the tagged version:

``` bash
$ git diff v1.0 main
```

To look at the project exactly as it was when you tagged it:

``` bash
$ git switch --detach v1.0
```

This puts you in a *detached HEAD* state (see the callout above), which is fine for looking around. Switch back with `git switch main` when you are done.

### Sharing tags on GitLab

Like branches, tags are **not** pushed automatically. Push a tag by name:

``` bash
$ git push origin v1.0
```

or push all your tags at once with `git push origin --tags`.

On GitLab, go to **Code → Tags** in the project sidebar to see your tags. From there you can download the code at that version as an archive, or create a **Release** with notes about what changed.

::: instructor
Link tags back to the introduction's reason for using version control: "the state of the system when you published a paper". Many journals ask for the exact version of code used; a tag (and a GitLab release) gives learners a stable reference they can cite.
:::

::::: challenge
#### Challenge 1: Which branch am I on?

Name two commands that tell you which branch you are currently on.

::: solution
`git branch` marks the current branch with `*`, and `git status` starts with `On branch <name>`.
:::
:::::

::::: challenge
#### Challenge 2: Work on a feature branch

1.  Create and switch to a new branch called `readme-update`.
2.  Add a `## Branching` section to `README.md` and commit it.
3.  Switch back to `main` and check that `README.md` does not contain your new section.
4.  Merge `readme-update` into `main`, then delete the branch.

::: solution
``` bash
$ git switch -c readme-update
$ nano README.md                  # add a "## Branching" section
$ git add README.md
$ git commit -m "Add branching section to README"
$ git switch main
$ cat README.md                   # the new section is not here
$ git merge readme-update
$ git branch -d readme-update
```
:::
:::::

::::: challenge
#### Challenge 3: Fast-forward or not?

You create a branch `test` from `main` and make two commits on `test`. Meanwhile a collaborator's commit is pulled into `main`. When you run `git merge test` on `main`, will it be a fast-forward merge? Why or why not?

::: solution
No. `main` has a commit that is not on `test`, so the histories have diverged and there is no straight line from `main` to `test`. Git will create a **merge commit** that combines both lines of history (and you may need to resolve conflicts if the same lines were changed).
:::
:::::

::::: challenge
#### Challenge 4: Tag a version

1.  Tag the current state of `MyProject` on `main` as `v0.1`, with the message "End of Git workshop".
2.  Make a small change to `README.md` and commit it.
3.  Use the tag to show what has changed since `v0.1`.
4.  Push the tag to GitLab and find it on your project page.

::: solution
``` bash
$ git switch main
$ git tag -a v0.1 -m "End of Git workshop"
$ nano README.md                  # make a small change
$ git add README.md
$ git commit -m "Update README after workshop"
$ git diff v0.1 main              # shows your README change
$ git push origin v0.1
```

On GitLab, the tag is listed under **Code → Tags**. Note that the tag still points to the commit you tagged, not the new one: tags do not move.
:::
:::::

::::: challenge
#### Challenge 5: Branch or tag?

For each situation, would you use a branch or a tag?

1.  You want to try a new way of plotting the data without breaking the working script.
2.  You have just submitted a paper and want to record the exact code used for its figures.
3.  A collaborator is adding a new analysis that will take a few weeks.

::: solution
1.  **Branch**: you will keep committing to it, and may merge it or throw it away.
2.  **Tag**: it marks one fixed version that should never change.
3.  **Branch**: ongoing work that will be merged into `main` later.
:::
:::::

::: keypoints
-   A branch is a movable pointer to a commit that lets you develop in parallel without disturbing `main`.
-   `git branch` lists and creates branches; `git switch` (or `git checkout`) moves between them.
-   `git diff main..dev` shows what a branch would bring in before you merge.
-   `git merge <branch>` brings another branch's commits into the current branch; if there is a straight line of history this is a fast-forward.
-   Push a branch with `git push origin <branch>`, and use GitLab merge requests to review changes before merging.
-   A tag is a fixed label for one commit; use `git tag -a` to mark versions such as the code used for a paper.
-   Tags are not pushed automatically; share them with `git push origin <tag>`.
:::
