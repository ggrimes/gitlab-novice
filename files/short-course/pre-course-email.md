**Subject:** Introduction to Git and GitLab, [DATE]: 15 minutes of setup before the day

Hi everyone,

Looking forward to seeing you on **[DATE], 09:00–14:00** in **[ROOM]**. (Break 10:30, lunch 12:00.)

To make sure we spend the morning on Git rather than on logins, please do the four steps below **before [DATE − 2 days]**. They take about 15 minutes. If anything goes wrong, just reply to this email; that's exactly what it's for.

### 1. Log in to Eddie and get an interactive node

```
ssh <UUN>@eddie.ecdf.ed.ac.uk
qlogin
```

### 2. Log in to the University GitLab once

Go to <https://git.ecdf.ed.ac.uk> and sign in with your University login. (This creates your account.)

### 3. Add your Eddie SSH key to GitLab

Eddie has already made an SSH key for you, so you don't need to create one. On Eddie, show its public half:

```
cat ~/.ssh/id_alcescluster.pub
```

Copy the **whole** line it prints (it starts with `ssh-`). In GitLab: click your **user icon** → **Preferences** → **Access** → **SSH Keys** → **Add new key** → paste → **Add key**.

Please use this key rather than making a new one with `ssh-keygen`: Eddie is set up to use `id_alcescluster` for every connection, so a new key would be ignored and GitLab would refuse you.

### 4. Run the setup check

Still on Eddie:

```
curl -fLO https://ggrimes.github.io/gitlab-novice/files/short-course/check-setup.sh
bash check-setup.sh
```

You should see four green ticks. Any red crosses come with a hint on what to do. If you're stuck, reply to this email with a copy of what it printed.

### On the day, please bring

- a laptop that can connect to the University Wi-Fi (or VPN) and log in to Eddie
- your laptop is also used for a shared Etherpad page during the day (no account needed)
- a real project of yours, if you have one: there's time at the end to put it under Git

No prior Git experience needed. The course website: <https://ggrimes.github.io/gitlab-novice/>

See you there,
Graeme
