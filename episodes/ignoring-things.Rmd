---
title: "Ignoring Things"
teaching: 10
exercises: 2
---

::: questions
-   What is a `.gitignore` file?
-   Why should we use it?
-   How do we create and manage it?
:::

::: objectives
-   Explain the purpose of a `.gitignore` file in Git repositories
-   Create and edit a `.gitignore` file to exclude unnecessary files
-   Understand common patterns and pitfalls when using `.gitignore`
:::

## What is `.gitignore`?

When using Git, you often have files that you **don’t want to track**. These could be:

-   Temporary files created by your text editor or IDE
-   Output files from running your code
-   Large data files or binary files
-   Configuration files specific to your machine

Git provides a file named `.gitignore` where you can list patterns that match files or directories Git should ignore.

## Why Use `.gitignore`?

If you don’t ignore unnecessary files:

-   Your repository becomes cluttered
-   You may accidentally share sensitive or large files
-   Your collaborators may run into issues syncing or running code

### Common Examples

Here are some typical entries in an R project’s `.gitignore` file:

``` gitignore
.Rhistory
.RData
.Rproj.user/
*.csv
*.xlsx
data/
```

-   `.Rhistory`, `.RData`: Temporary R session files
-   `*.csv`, `*.xlsx`: Data files you don’t want versioned
-   `data/`: An entire directory

![A sample .gitignore file](TODO-fig/gitignore-example.png)

## How to Create and Use `.gitignore`

You can create the file manually:

``` bash
touch .gitignore
```

And then edit it:

``` bash
nano .gitignore
```

Or use RStudio’s **Git pane**: It often shows ignored files in grey.

## Does It Remove Already-Tracked Files?

No. `.gitignore` only affects **new** files. If you've already added a file to Git, `.gitignore` won’t stop it from being tracked. To remove a file already tracked:

``` bash
git rm --cached filename
```

Then add it to `.gitignore`.

## Challenge: Ignore and Track

:::: challenge
1.  Create a file called `secret.txt` and add some text to it.
2.  Add it to your `.gitignore`.
3.  Try running `git status` — is it listed?
4.  Add and commit your `.gitignore` file. :::

::: solution
``` bash
echo "my password" > secret.txt
echo "secret.txt" >> .gitignore
git status   # secret.txt should not appear under "Untracked files"
git add .gitignore
git commit -m "Add gitignore to exclude secret.txt"
```
:::
::::

## Advanced Tip: Ignore Locally Only

If you want to ignore files only on your machine (not share with others), you can use:

``` bash
.git/info/exclude
```

This works like `.gitignore`, but it’s **not committed** to the repository.

::: keypoints
-   Use `.gitignore` to prevent tracking of unnecessary or sensitive files
-   Edit `.gitignore` early in your project to keep your history clean
-   Use `.git/info/exclude` for machine-specific ignores
-   Files already tracked by Git won’t be ignored retroactively
:::
