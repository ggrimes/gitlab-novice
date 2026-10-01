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

### 3. Create an SSH key on Eddie and add it to GitLab

On Eddie:

```
ssh-keygen -t ed25519
```

Press **Enter** to accept the file location, then choose a **passphrase** (nothing appears as you type; that's normal). Then show your public key:

```
cat ~/.ssh/id_ed25519.pub
```

Copy the **whole** line it prints (it starts with `ssh-ed25519`). In GitLab: your avatar → **Edit profile** → **SSH Keys** → **Add new key** → paste → **Add key**.

### 4. Run the setup check

Still on Eddie:

```
bash [WORKSHOP-DATA-DIR]/check-setup.sh
```

You should see four green ticks. Any red crosses come with a hint on what to do. If you're stuck, reply to this email with a copy of what it printed.

### On the day, please bring

- a laptop that can connect to the University Wi-Fi (or VPN) and log in to Eddie
- a phone, for some quick anonymous polls (no account needed)
- a real project of yours, if you have one: there's time at the end to put it under Git

No prior Git experience needed. The course website: <https://ggrimes.github.io/gitlab-novice/>

See you there,
Graeme
