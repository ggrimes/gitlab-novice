#!/usr/bin/env bash
# Pre-course self-check for "Introduction to Git and GitLab" (half-day).
# Run on Eddie, on an interactive node (after qlogin):
#     bash check-setup.sh
# Prints a tick or a cross for each item, with what to do about crosses.

GITLAB=git.ecdf.ed.ac.uk
ok=0; bad=0
pass() { printf '  \033[32m✓\033[0m %s\n' "$1"; ok=$((ok + 1)); }
fail() { printf '  \033[31m✗\033[0m %s\n      → %s\n' "$1" "$2"; bad=$((bad + 1)); }

echo "Checking your setup for the Git course..."
echo

# 1. on a compute node, not a login node
case "$(hostname)" in
  login*) fail "You're on a login node ($(hostname))" "run qlogin first, then run this script again" ;;
  *)      pass "On an interactive node ($(hostname))" ;;
esac

# 2. git installed and new enough for 'git restore' (2.23+)
if command -v git >/dev/null 2>&1; then
  v=$(git --version | awk '{print $3}')
  major=${v%%.*}; rest=${v#*.}; minor=${rest%%.*}
  if [ "$major" -gt 2 ] || { [ "$major" -eq 2 ] && [ "$minor" -ge 23 ]; }; then
    pass "Git $v"
  else
    fail "Git $v is too old (need 2.23 or newer)" "email the course organiser before the day"
  fi
else
  fail "Git not found" "email the course organiser before the day"
fi

# 3. an SSH key exists. Eddie's ~/.ssh/config (Host * / IdentityFile) makes ssh
#    offer only id_alcescluster, so that is the key GitLab needs.
if [ -f "$HOME/.ssh/id_alcescluster.pub" ]; then
  pass "Eddie SSH key found: ~/.ssh/id_alcescluster.pub"
else
  fail "No ~/.ssh/id_alcescluster.pub found" "email the course organiser before the day"
fi

# 4. GitLab accepts the key
echo "  … testing the connection to GitLab"
out=$(ssh -T -o ConnectTimeout=15 -o StrictHostKeyChecking=accept-new "git@$GITLAB" 2>&1 < /dev/null)
if printf '%s' "$out" | grep -qi "welcome to gitlab"; then
  pass "GitLab recognises your SSH key"
elif printf '%s' "$out" | grep -qi "permission denied"; then
  fail "GitLab doesn't recognise your key" \
       "copy the whole line from: cat ~/.ssh/id_alcescluster.pub  into GitLab → user icon → Preferences → Access → SSH Keys (not id_ed25519.pub)"
else
  fail "Couldn't reach $GITLAB" "check you can log in at https://$GITLAB in a browser; message: ${out:0:80}"
fi

echo
if [ "$bad" -eq 0 ]; then
  echo "All $ok checks passed. You're ready. See you on the day!"
else
  echo "$bad check(s) need attention. Fix them using the hints above, or reply to the course email and we'll help."
fi
