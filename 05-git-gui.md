---
title: "Using Git with a Graphical User Interface RStudio"
teaching: 15
exercises: 2
---

::: questions
-   What is a Git GUI and how does it relate to the command line?
-   How can I use Git in RStudio on the University of Edinburgh’s Noteable service?
:::

::: objectives
-   Define what a Git GUI is and why you might use one.
-   Use RStudio to clone a repository via its Git integration.
-   Configure Git with your name and email address.
-   Stage, commit, and push changes using RStudio’s GUI.
-   Verify that your changes appear on the remote repository.
:::

## 1. What is a Git GUI?

A Git GUI (Graphical User Interface) provides a visual alternative to the command-line interface. Instead of typing commands like `git commit`, users can interact with buttons, menus, and panels. GUIs are helpful for:

-   Beginners who aren’t yet comfortable with terminal commands
-   Visualising the commit history and file changes
-   Handling merge conflicts more easily

RStudio includes built-in Git support, making it easy to integrate version control into your analysis projects.

::: instructor
Reassure learners that the GUI is not a “less powerful” version of Git—it’s just another interface to the same tool. Some users will transition back and forth between the GUI and command line.
:::

## 2. RStudio and the Noteable Environment

We will be using RStudio Server via the University of Edinburgh’s [Noteable](https://noteable.edina.ac.uk/) platform. This cloud-based RStudio environment supports Git integration and is ideal for version-controlled reproducible research.

## 3. Configure Git in Noteable

The first time you use Git in a new environment (like Noteable), you need to tell Git who you are:

``` bash
$ git config --global user.name "Your Name"
$ git config --global user.email "you@example.com"
```

You can run this in the Terminal pane in RStudio.

## 4. Clone a Repository with RStudio

Now let’s bring your project into RStudio: This can be found on the GitLab repository page.

1.  First copy the **Clone with HTTPS** text from GitLab

![](fig/gitlab-clone-button.png)

2.  In RStudio, go to the top menu: **File → New Project → Version Control → Git**


  ![](fig/git-gui-01.png)

3. Enter the Repository URL:

    ```         
    https://git.ecdf.ed.ac.uk/<username>/myproject.git
    ```

4.  Choose a directory to clone into (e.g. your home folder or `~/projects`)

    ![](fig/git-gui-02.png)

5.  Click **Create Project**

RStudio will open the project and show the Git pane in the top-right.

![Add screenshot of cloning Git project via RStudio.](TODO-fig/rstudio-clone.png)

## 5. Make a Change to README.md

1.  In the **Files** pane, click on `README.md` to open it.
2.  Add a sentence like: `This change was made from RStudio on Noteable.`
3.  Save the file (`Ctrl + S` or **File → Save**)

## 6. Commit and Push from RStudio

1.  In the **Git** pane, you should see `README.md` listed as modified.
2.  Tick the checkbox next to it to stage the file.
3.  Click **Commit**. A window appears.
4.  Write a short commit message, e.g. `Edit README from Noteable`
5.  Click **Commit** in the dialog box.
6.  Now click **Push** (also in the Git pane) to upload your changes.

![Add screenshot of RStudio commit dialog.](TODO-fig/rstudio-commit.png)

## 7. Check the Remote Repository

1.  Visit your project page on <https://git.ecdf.ed.ac.uk>.
2.  Look at the **Repository → Files** tab to confirm that your changes have appeared.
3.  You can also check the **Repository → Commits** tab to see your message.

::: keypoints
-   Git GUIs offer a visual way to use Git—perfect for beginners and for visualising changes.
-   RStudio’s Git integration supports cloning, staging, committing, and pushing.
-   Always configure your name/email before making your first commit.
-   You can verify success by checking your changes online.
:::
