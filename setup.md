---
title: Setup
---

This lesson requires a few software packages to be installed on your computer. This page provides instructions on how to set them up.

## Software Setup

This lesson uses Git, a text editor, R, and RStudio. Below are instructions for installing this software on different operating systems.

::: discussion
### University of Edinburgh Resources

This lesson is designed to be used with resources provided by the University of Edinburgh. While the core concepts are general, some of the setup and examples are specific to the University's IT environment.

-   **ECDF Gitlab:** We will be using the University of Edinburgh's GitLab service at <https://git.ecdf.ed.ac.uk>. You will need your University login to access this.
-   **VPN:** To access the ECDF GitLab from off-campus, you will need to be connected to the University VPN.
-   **SSH Keys:** You will need to set up SSH keys to securely connect to GitLab. Instructions are provided below.

If you are not a member of the University of Edinburgh, you can still follow this lesson by using the public GitLab service at <https://gitlab.com> and adapting the instructions accordingly.
:::

### Required Software

You will need to install the following software:

1.  **A shell:** A command-line interface to your computer.
2.  **Git:** The version control software.
3.  **A text editor:** For editing plain text files.
4.  **R and RStudio:** For running R code and as an interface to Git.

------------------------------------------------------------------------

### Installation Instructions


### Windows

1.  **Shell:**
    -   Download and install Git for Windows from [git-scm.com](https://git-scm.com/download/win).
    -   This will also install Git Bash, which provides a Unix-like shell.
2.  **Git:**
    -   Git is included in the Git for Windows installation.
3.  **Text Editor:**
    -   We recommend using a modern text editor like [Visual Studio Code](https://code.visualstudio.com/) or [Sublime Text](https://www.sublimetext.com/).
    -   Notepad++ is also a good option.
4.  **R and RStudio:**
    -   Install R from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/bin/windows/base/).
    -   Install RStudio Desktop (the free version) from the [RStudio website](https://www.rstudio.com/products/rstudio/download/).
5.  **SSH Keys:**
    -   Open Git Bash and follow the instructions on the [GitLab documentation](https://docs.gitlab.com/ee/ssh/#generate-an-ssh-key-pair) to generate an SSH key.
    -   Add your public key to your [ECDF GitLab account](https://git.ecdf.ed.ac.uk/-/profile/keys).

### MacOS

1.  **Shell:**
    -   The `Terminal.app` is included with macOS and is located in the `Utilities` folder within your `Applications` folder.
2.  **Git:**
    -   Git is pre-installed on most recent versions of macOS. You can check by opening the Terminal and typing `git --version`.
    -   If it's not installed, it will prompt you to install the Xcode Command Line Tools. Follow the prompts to do so.
3.  **Text Editor:**
    -   We recommend using a modern text editor like [Visual Studio Code](https://code.visualstudio.com/) or [Sublime Text](https://www.sublimetext.com/).
4.  **R and RStudio:**
    -   Install R from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/bin/macosx/).
    -   Install RStudio Desktop (the free version) from the [RStudio website](https://www.rstudio.com/products/rstudio/download/).
5.  **SSH Keys:**
    -   Open the Terminal and follow the instructions on the [GitLab documentation](https://docs.gitlab.com/ee/ssh/#generate-an-ssh-key-pair) to generate an SSH key.
    -   Add your public key to your [ECDF GitLab account](https://git.ecdf.ed.ac.uk/-/profile/keys).

### Linux

1.  **Shell:**
    -   The shell is pre-installed on all major Linux distributions (e.g., Bash, Zsh).
2.  **Git:**
    -   You can install Git using your distribution's package manager. For example, on Debian/Ubuntu:

        ``` bash
        sudo apt-get update
        sudo apt-get install git
        ```
3.  **Text Editor:**
    -   We recommend using a modern text editor like [Visual Studio Code](https://code.visualstudio.com/) or [Sublime Text](https://www.sublimetext.com/).
    -   Your distribution will also come with a default text editor (e.g., Gedit, Kate).
4.  **R and RStudio:**
    -   Install R from the [Comprehensive R Archive Network (CRAN)](https://cran.r-project.org/). Follow the instructions for your specific distribution.
    -   Install RStudio Desktop (the free version) from the [RStudio website](https://www.rstudio.com/products/rstudio/download/).
5.  **SSH Keys:**
    -   Open a terminal and follow the instructions on the [GitLab documentation](https://docs.gitlab.com/ee/ssh/#generate-an-ssh-key-pair) to generate an SSH key.
    -   Add your public key to your [ECDF GitLab account](https://git.ecdf.ed.ac.uk/-/profile/keys).


------------------------------------------------------------------------
