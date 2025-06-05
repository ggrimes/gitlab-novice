---
title: "Configuring Git"
teaching: 10
exercises: 3
---

::: questions
- How does Git know who I am?
- What is the difference between local, global, and system configuration?
- Which Git settings are helpful to change right away?
:::

::: objectives
- Explain the purpose of the `git config` command.
- Distinguish the three configuration levels used by Git (`--system`, `--global`, `--local`).
- Set a username, email address, colour output, default editor, and pull behaviour.
- View and edit the `~/.gitconfig` file safely.
:::

## Introduction

Before we can record changes, Git needs to know **who** is making them.  It also allows you to tailor its behaviour.  All of this is handled by the `git config` command, which writes preferences to one of three configuration files (listed from lowest to highest priority):

| Level | File | Scope |
|-------|------|-------|
| System | `/etc/gitconfig` | Every user on the machine |
| Global | `~/.gitconfig` | All repositories for *you* |
| Local | `.git/config` | Single repository only |

When Git looks up a setting it starts locally and works upward, so local settings override global, which override system.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Learners may have already used Git on their computers.  Ask them to run `git config --list --show-origin` to display where each value is coming from.  This often reveals surprises (e.g. an IDE has silently set the editor to *vim*).

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

### 1. Identify yourself

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "you@example.com"
```

These two lines create (or update) entries in `~/.gitconfig` so every commit you make will be tagged with the correct author information.

::::::::::::::::::::::::::::::::::::: challenge 

### Challenge 1: Check your work

1. Run `git config --global --list` to confirm that your name and email were saved.
2. Where would the same information be stored if you had used `--local` instead?

:::::::::::::::::::::::: solution 

1. Your terminal should show lines similar to

   ```text
   user.name=Your Name
   user.email=you@example.com
   ```

2. With the `--local` flag the values are written to `.git/config` inside the current repository, leaving other projects unaffected.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::: 

### 2. Make output readable

```bash
$ git config --global color.ui auto
```

With colour enabled, Git highlights additions (*green*), deletions (*red*), and branch names, making the status information easier to parse.

### 3. Choose your editor

```bash
$ git config --global core.editor "nano -w"
```

Git drops you into an editor for multi‑line commit messages, merge conflict resolutions, and interactive rebases.  Pick an editor you are comfortable with (common choices are *nano*, *code --wait*, or *notepad.exe* on Windows).

### 4. Tame autocorrect and pulls

```bash
$ git config --global help.autocorrect 1   # Suggest closest command after 1/10 second
$ git config --global pull.rebase false    # Default to merge when running `git pull`
```

Autocorrect spares you from typos, while the pull setting aligns behaviour with the rest of this workshop (merging instead of rebasing).

::::::::::::::::::::::::::::::::::::: challenge 

### Challenge 2: Inspect your `.gitconfig`

Use `cat ~/.gitconfig` (or open the file in your editor) and locate the lines you just added.  Which section header (`[user]`, `[core]`, etc.) does each belong to?

:::::::::::::::::::::::: solution 

- `[user]` contains `name` and `email`.
- `[core]` contains `editor` and options such as `autocorrect`.
- `[color]` stores `ui = auto`.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::: 

### 5. Override settings per‑project

Occasionally a project needs a different identity (e.g. when contributing to an open‑source repository on behalf of a separate organisation).  Add local overrides inside the project directory:

```bash
$ git config --local user.name "Open Source Bot"
$ git config --local user.email "bot@example.org"
```

These values live in `.git/config` and apply only to that repository.

::::::::::::::::::::::::::::::::::::: challenge 

### Challenge 3: Predict the result

You have the following configuration hierarchy:

- System: `user.email = root@machine`
- Global: *none set*
- Local: `user.email = user@project`

What email address will Git record when you commit inside the project directory?  What happens if you commit in a different repository?

:::::::::::::::::::::::: solution 

- Inside the project directory Git will record **user@project** because local overrides everything else.
- In any other repository Git falls back to the system‑wide value **root@machine**.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::: 

## Key commands reference

```bash
# View all settings (with their files)
$ git config --list --show-origin

# Set values
$ git config --global user.name "Your Name"
$ git config --local  color.ui auto

# Edit configuration interactively (opens editor)
$ git config --global --edit
```

::::::::::::::::::::::::::::::::::::: keypoints 

- `git config` writes and reads Git’s preference files.
- Three levels exist: system, global, local; the closest level wins.
- Setting your name and email **globally** ensures commits are attributed correctly.
- Colour, editor, and autocorrect options improve usability.

::::::::::::::::::::::::::::::::::::::::::::::::
