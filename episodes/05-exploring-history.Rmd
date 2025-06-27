---
title: "Exploring History"
teaching: 10
exercises: 4
---

::: questions
-   How can I view the history of changes in a Git repository?
-   How can I find out what was changed, when, and by whom?
-   How do I explore history using the command line and RStudio?
:::

::: objectives
-   Use `git log` to inspect the commit history of a project.
-   Use `git show` to examine specific changes within a commit.
-   Use `git diff` to compare different versions of files or commits.
-   View history using RStudio’s Git interface.
-   Use `git restore` to revert changes to a file.
:::

## Introduction

Git tracks everything. This means you can always go back and see who changed what, when, and why. This history is extremely useful for debugging, collaboration, and documentation.

Let’s look at some tools for exploring that history.

## 1. Viewing the Commit History (`git log`)

The most basic command to view history is:

```bash
git log
```

This shows:

-   The commit hash (a long ID)
-   Author
-   Date
-   Commit message

This gives you a full history of commits, starting from the most recent.

### Useful `git log` Options

-   **Shorter Log View:** Use `--oneline` for a more concise view. This is helpful when scanning many commits quickly.

    ```bash
git log --oneline
    ```

    ![Terminal showing git log --oneline output](git-log-oneline.png)

-   **Graphical History:** To see a visual representation of branches and merges:

    ```bash
git log --graph --oneline --decorate
    ```

-   **History of a Specific File:** To see only the commits that affected a particular file, along with the changes made in each commit:

    ```bash
git log -p README.md
    ```

-   **Filter by Author:** To see commits made by a specific person:

    ```bash
git log --author="Your Name"
    ```

## 2. Inspecting a Specific Commit (`git show`)

To see exactly what was changed in a particular commit, use `git show` followed by the commit ID:

```bash
git show <commit-id>
```

For example:

```bash
git show a3f2d4e
```

This command shows the commit message, author, date, and the full diff (changes) introduced in that commit.

If you want to see the content of a specific file at a given revision, you can do:

```bash
git show <commit-id>:<file-path>
# Example: git show HEAD~2:README.md
```

## 3. Comparing Changes (`git diff`)

`git diff` is a powerful command for comparing different versions of your files. It shows you the differences between two points in your repository.

-   **Compare Working Directory vs. Staging Area:** Shows changes you've made but haven't yet added to the staging area.

    ```bash
git diff
    ```

-   **Compare Staging Area vs. Last Commit (HEAD):** Shows changes that are staged and ready to be committed.

    ```bash
git diff --staged
    ```

-   **Compare Working Directory vs. Last Commit (HEAD):** Shows all changes since your last commit, whether staged or not.

    ```bash
git diff HEAD
    ```

-   **Compare Between Two Commits:** Shows the differences between any two specific commits.

    ```bash
git diff <commit1-id> <commit2-id>
# Example: git diff abc123 def456
    ```

-   **Compare a File Between Two Commits:** To see changes to a specific file between two commits:

    ```bash
git diff <commit1-id> <commit2-id> <file-path>
# Example: git diff HEAD~1 HEAD README.md
    ```

## 4. Undoing Changes and Restoring Files (`git restore`)

`git restore` is used to discard changes in your working directory or to unstage changes. It can also be used to restore a file to a previous state from a commit.

-   **Discard unstaged changes in working directory:**

    ```bash
git restore <file-path>
# Example: git restore README.md
    ```
    Be cautious: this removes changes **permanently** unless they were staged or committed.

-   **Unstage changes (move from staging area back to working directory):**

    ```bash
git restore --staged <file-path>
    ```

-   **Restore a file to a version from a specific commit:**

    ```bash
git restore --source=<commit-id> <file-path>
# Example: git restore --source=HEAD~1 README.md
    ```

## 5. Using RStudio to Explore History (GUI)

RStudio has a Git pane that allows you to explore commit history graphically:

1.  Click on the **History** button in the Git pane.

2.  Select a commit to see:

    -   Author and date
    -   Commit message
    -   File changes

3.  You can **diff** individual files by selecting them.

![Screenshot of RStudio Git History pane](rstudio-history-pane.png)

This is a good way to review changes if you prefer a GUI over the command line.

## 6. Bonus: Who Wrote This Line? (`git blame`)

Git has a powerful blame tool:

```bash
git blame <file-path>
# Example: git blame README.md
```

This shows you, line by line, who last modified each part of the file, along with the commit ID and timestamp. Very useful for identifying the history of a specific part of the code.

## Challenges

::::: challenge
#### Challenge 1: What Changed?

Open a repository (your project or a partner’s). Then:

1.  Run `git log --oneline` and pick an older commit.

2.  Use `git show` to see what was changed in that commit.

3.  Identify:

    -   Who made the change?
    -   What file(s) were edited?
    -   What was added or removed?

::: solution
1.  ```bash
git log --oneline
    ```
2.  ```bash
git show <commit-id>
    ```
3.  Look for:
    -   Author and date near the top
    -   File names and the actual line changes below
:::
:::::

::::: challenge
#### Challenge 2: The Archaeologist

Your project's `README.md` has changed many times. Your task is to find the very first version of it.

1.  Use `git log` to find the commit hash for the *initial commit* of the repository.
2.  Use `git show` to display the contents of `README.md` as it existed in that first commit.

**Hint:** You can combine the commit hash and the filename in the `git show` command.

::: solution
1.  First, find the last commit in the log:
    ```bash
git log --oneline
    ```
    Scroll to the bottom of the output to find the very first commit and copy its hash (e.g., `72041c0`).

2.  Then, show the file from that commit:
    ```bash
git show 72041c0:README.md
    ```
:::
:::::

::::: challenge
#### Challenge 3: Who Did What?

You're curious about the changes your collaborator made.

1.  Use `git log` to find all the commits made by your collaborator in the project.
2.  Pick one of their commits and use `git show` to see exactly what they changed.

::: solution
1.  Filter the log by author:
    ```bash
git log --author="Collaborator's Name"
    ```
2.  Copy a commit hash from the output and inspect it:
    ```bash
git show <hash>
    ```
:::
:::::

::::: challenge
#### Challenge 4: Revert a Single Mistake (Safely)

Imagine you accidentally deleted a section from `README.md` in your last commit. You want to get it back without undoing all the other good changes in that commit.

1.  Use `git diff` to compare your current `README.md` with the version from the commit *before* (`HEAD~1`). This will show you the lines that were deleted.
2.  Manually copy the deleted lines from the `diff` output and paste them back into your `README.md` file.
3.  Stage and commit this fix.

This is a common and safe way to selectively recover code without using more complex Git commands.

::: solution
1.  See what was changed in the last commit:
    ```bash
git diff HEAD~1 HEAD README.md
    ```
2.  Open `README.md` in your editor, and re-insert the lines that are marked with `-` in the diff output.
3.  Commit the fix:
    ```bash
git add README.md
git commit -m "Fix: Restore deleted section in README"
    ```
:::
:::::

::: keypoints
-   `git log` is used to inspect the commit history, with options for concise, graphical, or filtered views.
-   `git show` displays the details and changes of a specific commit or the content of a file at a past revision.
-   `git diff` compares changes between the working directory, staging area, and different commits.
-   `git restore` can discard unstaged changes, unstage changes, or restore files from previous commits.
-   RStudio provides a graphical interface for exploring Git history.
-   `git blame` helps identify who last modified each line of a file.
:::
