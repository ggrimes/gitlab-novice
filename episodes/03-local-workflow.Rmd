---
title: "Recording Changes Locally"
teaching: 20
exercises: 5
---

::: questions
-   How do I create a new Git repository for my project?
-   How do I check which files have been modified?
-   How do I record a snapshot of my work?
-   How can I review what has changed between versions?
:::

::: objectives
-   Initialise a repository with `git init`.
-   Explain the roles of the **working directory**, **staging area**, and **repository**.
-   Track new or modified files with `git add` and record them with `git commit`.
-   Use `git status` to see the state of the working directory and staging area.
-   Compare changes with `git diff` and inspect history with `git log`.
-   Restore a file to an earlier state with `git restore` (or `git checkout --` for older Git versions).
:::

## Introduction

With Git configured, we can start **tracking changes**. Think of Git as a camera: every time you take a *commit* you capture a snapshot of the files that are *staged*. Much like arranging subjects before pressing the shutter, you choose *what* to record with `git add`.

Three locations matter (see diagram below):

1.  **Working directory** – files you edit in your editor/IDE.
2.  **Staging area** – a holding zone for the next snapshot.
3.  **Repository** – the permanent, time‑stamped history.

![](https://swcarpentry.github.io/git-novice/fig/git-staging-area.svg){alt="Flow diagram from working directory to staging area to repository."}

::: instructor
Some learners struggle with the staging area at first. Compare it to packing items into a box (staging) before placing the box in long‑term storage (repository). Running `git status` after every major step reinforces the mental model.
:::

### 1. Create a repository


A repository, or repo, is a fundamental element of GitHub and Git. It’s a space where project files live, allowing for version control and collaboration.

You can think of a repository as a project folder that tracks changes, stores history, and lets multiple people work together seamlessly.



```bash
mkdir MyProject 
```

You can go into `MyProject` by running 

```bash
$ mkdir MyProject
$ cd `MyProject` 
```

In its current state the directory, `MyProject` is not a Git repository.

If you want this folder to be a Git repository so that you can track all changes you make, type `git init` command. 

``` bash
$ git init            # creates .git directory
```

When you run the `git init` command in an ordinary folder, it allows you to transform that folder into a trackable git repository where you can use Git commands.

`git init` creates a hidden `.git` folder that stores all future history.

:::: challenge
#### Challenge 1: First contact

Run `git status` immediately after `git init`. What output do you see and why?

::: solution
Git reports

``` text
On branch main (or master)

No commits yet
nothing to commit (create/copy files and use "git add" to track)
```

because we have not created any files or commits; the repository is empty.
:::
::::

### 2. Add a README file

::: callout
What’s a README?

A README file in a Git repository provides essential information about the project, including its purpose, usage instructions, how to get started, where to find help, and details on contributors. It serves as an introductory guide for visitors, helping them understand and utilize the project effectively

::: 

Let’s create a new file by running touch README.md then run git status again. Now you should see that you have an untracked file “README.md”.

``` bash
$ echo "# My eddie Python project" > README.md
$ git status          # untracked file appears in red
```

``` output
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
    README.md

nothing added to commit but untracked files present (use "git add" to track)
```

An untracked file is one that has not been added to the staging area. To add files to the staging area, you can use the `git add` command.

### Git add

There are quite a few ways to use this command. For example, you can use `git add .` to add all files to the staging area from the working directory or use `git add filename` to add a specific file to the staging area.

``` bash
$ git add README.md   # stage the file
```

If you run `git status` again, this will show you that README.md is in the staging area 

```bash
$ git status          # file appears in green (staged)
```

``` output
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
    new file:   README.md
```

When files are added to the staging area, that means they are in safe keeping before you commit them. Think of using the Git add command as telling Git, “Please keep track of this file in its current state.”

Staging tells Git *which* changes, Changes to be committed, belong to the next snapshot.


If you make additional changes to the tracked files, you’ll need to use the `git add` command again for Git to keep track of them. 


### 3. Commit the snapshot

To add snapshot to repository use the `git commit` command. For each commit you will need to add a message using the `-m` option.

::: callout
## Git messages

1.  Limit the Subject Line: Keep the subject or summary line to 50 characters or fewer. This ensures it's easily readable in various Git tools.​
2.  Use the Imperative Mood: Frame your commit message as a command or action, e.g., **"Fix"** rather than "**Fixed"** or **"Fixes."​**
3.  Avoid Vague Messages: Instead of writing **"Update code"** or **"Fix bug"**, specify what you did, such as **"Add error handling for login process."**
:::

Let’s run git commit -m "initial commit" to see what happens.

``` bash
$ git commit -m "initial commit"
```

``` output
[main (root-commit) 72041c0] Add README with project title
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

Every commit receives a unique 40‑character *hash* (displayed here as **72041c0** for brevity).

If you run `git status`, you’ll see that you have “1 file changed, 1 insertion(+)” because you just added one new files, and the files has one line of code. 

```bash
git status
```

That’s how you use the git add and git commit commands together! Well done tracking changes and storing your new work.

### Git Log

Show the sequence of commits starting from the current one, in reverse chronological order of the Git repository in the current working directory:

``` bash
git log
```

``` output
git log​

commit f00b5b49b39884a9bf978bc272c82d862976abcb (HEAD -> main)​

Author: Graeme Grimes <Graeme.Grimes@ed.ac.uk>​

Date:   Tue Sep 24 10:06:58 2024 +0100​

​

    Add Readme.md
```

:::: challenge
#### Challenge 2: Where is my commit?

Use `git log --oneline` to view the history. How many commits appear and what information is shown?

::: solution
One commit appears:

``` text
72041c0 (HEAD -> main) Add README with project title
```

We see the abbreviated hash, the branch name, and the commit message.
:::
::::

### 4. Modifying a file

Edit *README.md*

``` bash
nano README.md
```

add a *Run Script* section

```         
# My eddie Python project​

To run Python on eddie need to run:​
    module load igmm/apps/python/3.7
```

git status

``` bash
$ git status          # modified file in red
```

``` output
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   README.md
```

## Viewing changes

We can you the command `git diff` to view our change.

``` bash
$ git diff README.md  # view changes
```

``` output
diff --git a/README.md b/README.md
index a4c6c69..603f621 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,4 @@
 # My eddie Python project
+
+To run Python on eddie need to run:
+    module load igmm/apps/python/3.7
```

------------------------------------------------------------------------

### What Each Part Means

------------------------------------------------------------------------

#### `diff --git a/README.md b/README.md`

-   **This is the file being changed**: `README.md`
-   `a/README.md` = the old version
-   `b/README.md` = the new version
-   This line starts the diff block for that file.

------------------------------------------------------------------------

####  `index a4c6c69..603f621 100644`

-   **`a4c6c69`** = commit hash of the file *before* the change
-   **`603f621`** = commit hash of the file *after* the change
-   **`100644`** = file mode (normal non-executable file)

------------------------------------------------------------------------

#### ➖ `--- a/README.md`

#### ➕ `+++ b/README.md`

-   Shows **what version** is being removed (`---`) and added (`+++`)
-   Still refers to the same file (`README.md`), before and after

------------------------------------------------------------------------

####  `@@ -1 +1,4 @@`

-   This is a **"hunk header"** showing line number context
-   `-1` = from line 1 of the **old file**
-   `+1,4` = starting at line 1 of the **new file**, and it now spans **4 lines**

------------------------------------------------------------------------

###  Content Change Section

``` diff
 # My eddie Python project
+
+To run Python on eddie need to run:
+    module load igmm/apps/python/3.7
```

| Symbol | Meaning | Explanation |
|--------------|--------------|---------------------------------------------|
|  | (no symbol) | This line was **already there** |
| `+` | Line was **added** | These 3 new lines were inserted below the original first line |

------------------------------------------------------------------------

## 

### Stage and commit the update:

Once we are happy with the changes we can stage the changes and then commit into the git repository.

``` bash
$ git add README.md
$ git commit -m "Describe how to run analysis script"
```

``` output
[main 370eb9d] Describe how to run analysis script
  1 file changed, 3 insertions(+)
```

### 5. Inspecting differences between commits

``` bash
$ git diff HEAD~1 README.md   # compare current commit to one before
```

`HEAD` is a symbolic name for *the current commit*; `HEAD~1` means *one commit ago*.

``` output
diff --git a/README.md b/README.md
index a4c6c69..603f621 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,4 @@
 # My eddie Python project
+
+To run Python on eddie need to run:
+    module load igmm/apps/python/3.7
```

:::: challenge
#### Challenge 3: Predict the diff

Suppose the original README contained only a title. After adding a section called **Data**, what colour will the new lines appear in the diff output and why?

::: solution
They will be **green with a + prefix** because new lines are *additions* relative to the previous snapshot.
:::
::::

### 6. Undoing a change in the working directory

If you accidently stage a file you can discard **unstaged** edits using `git restore`:

``` bash
$ git restore README.md   # newer Git (>=2.23)
# or
$ git checkout -- README.md  # older Git versions
```

Be cautious: this removes changes **permanently** unless they were staged or committed.

### 7. Adding directories and data

Git tracks **files**, not empty directories. To include a folder you must add at least one file inside it (often an empty `.gitkeep`):

``` bash
$ mkdir Src
$ touch Src/.gitkeep
$ git add Src/.gitkeep
```

Let download a file into a Data directory

``` bash
$ mkdir Data
$ curl -L -o Data/data.csv https://figshare.com/ndownloader/files/14632895
```

We can now add ito staging area and commit to repository.

```bash
$ git add Data/data.csv # Comment on when to commit data​
$ git commit -m "Add example dataset"
```

:::: challenge
#### Challenge 4: Multiple file workflow

Create a simple Python script *Src/hello.py* that prints *"Hello World!"*. Add and commit it. Then modify the script to read the CSV file added above and print the number of rows. Use `git diff` before committing to verify the change.

```python
        #!/usr/bin/env python
        print("Hello World!")
```


::: solution
1.  Create the file:

    ``` python
        #!/usr/bin/env python
        print("Hello World!")
    ```

    ``` bash
    $ git add Src/hello.py
    $ git commit -m "Add hello world script"
    ```
:::

2.  Edit the script, stage, inspect, commit:

    ``` python
    #!/usr/bin/env python​
    ​
    # load pandas library​
    import pandas as pd​
    ​
    # Read the data​
    variants =  pd.read_csv("Data/data.csv")​
    ​
    # Check we have the data​
    print(variants)
    ```

::: solution
    ``` python
    #!/usr/bin/env python​
    ​
    # load pandas library​
    import pandas as pd​
    ​
    # Read the data​
    variants =  pd.read_csv("Data/data.csv")​
    ​
    # Check we have the data​
    print(variants)
    ```

    ``` bash
    $ git diff Src/hello.py   # shows additions
    $ git add Src/hello.py
    $ git commit -m "Read CSV and report row count"
    ```
:::
::::

### 8. Viewing the complete history

``` bash
$ git log
```


::: keypoints
-   `git init` turns a directory into a repository by creating `.git`.
-   `git status` gives you a report on your git repository.
-   Stage files with `git add`; record them permanently with `git commit -m`.
-   Use `git diff` to inspect unstaged or staged changes.
-   `git log` reveals the history; hashes uniquely identify commits.
-   Empty directories are **not tracked**—add a file such as `.gitkeep`.
-   `git restore` returns a file to a known state.
:::
