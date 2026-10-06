#!/usr/bin/env bash
# Build the two practice folders for the experimental Git intro.
#
#   messy_project/  the "before Git" folder: renamed copies, misleading
#                   notes, and timestamps that no longer line up
#   tidy_project/   the same history as a Git repository, used at the end
#                   of the day to answer the same question in seconds
#
# Usage:  bash make-messy-project.sh [target-dir]     (default: current dir)
# Put the result somewhere learners can copy from, e.g. the workshop_data
# directory on Eddie. figure3.png is made by running the analysis scripts,
# so Python with pandas and matplotlib is needed (loaded below on Eddie).
set -euo pipefail

# On Eddie, load Python through environment modules first
PY_MODULE="${PY_MODULE:-igmm/apps/python/3.12.3}"
if ! command -v module >/dev/null 2>&1 && [ -f /etc/profile.d/modules.sh ]; then
  source /etc/profile.d/modules.sh
fi
if command -v module >/dev/null 2>&1; then
  module load "$PY_MODULE"
fi
# prefer the module's own Python over any conda/mamba python3 on PATH
if [ -n "${PYTHONBIN:-}" ] && [ -x "$PYTHONBIN/python3" ]; then
  PYTHON="$PYTHONBIN/python3"
else
  PYTHON="$(command -v python3 || command -v python)"
fi
"$PYTHON" -c 'import pandas, matplotlib' || {
  echo "Error: $PYTHON needs pandas and matplotlib (module load $PY_MODULE)" >&2
  exit 1
}
export MPLBACKEND=Agg   # no display needed to save figures

TARGET="${1:-.}"
mkdir -p "$TARGET"
cd "$TARGET"
rm -rf messy_project tidy_project

# --------------------------------------------------------------------------
# shared content
# --------------------------------------------------------------------------
write_data() {
  cat > "$1" <<'EOF'
CHROM,POS,QUAL,DP
chr1,10583,18.2,7
chr1,13302,35.0,22
chr1,14907,61.3,40
chr2,22051,24.8,12
chr2,30117,9.6,4
chr3,40213,52.1,31
chr3,41877,27.4,9
chr4,50222,44.9,18
chr5,61004,21.3,15
chr5,62555,73.8,55
EOF
}

# analysis script, parameterised by version
# $1 = file, $2 = QUAL threshold, $3 = extra filter line (or ""),
# $4 = log scale (yes/no), $5 = figure line (or ""), $6 = results file
write_script() {
  local file=$1 qual=$2 extra=$3 logscale=$4 fig=$5 results=$6
  {
    echo '#!/usr/bin/env python'
    echo '"""Filter variants by quality and summarise them."""'
    echo 'import pandas as pd'
    echo 'import matplotlib.pyplot as plt'
    echo ''
    echo 'variants = pd.read_csv("data.csv")'
    echo "variants = variants[variants.QUAL > $qual]"
    if [ -n "$extra" ]; then echo "$extra"; fi
    echo ''
    echo "variants.to_csv(\"$results\", index=False)"
    echo ''
    echo 'fig, ax = plt.subplots()'
    echo 'ax.hist(variants.QUAL, bins=10)'
    if [ "$logscale" = yes ]; then echo 'ax.set_yscale("log")'; fi
    echo 'ax.set_xlabel("Variant quality (QUAL)")'
    if [ -n "$fig" ]; then echo "$fig"; fi
  } > "$file"
}

# run an analysis script so its outputs (results CSV, figure3.png) are real
run_script() {
  "$PYTHON" "$1"
}

# --------------------------------------------------------------------------
# messy_project: what most people's folders look like
# --------------------------------------------------------------------------
mkdir messy_project
(
  cd messy_project
  write_data data.csv

  write_script analysis.py 50 "" no 'plt.savefig("figure3.png")' results.csv
  write_script analysis_v2.py 30 "" no 'plt.savefig("figure3.png")' results.csv
  write_script analysis_final.py 20 "" yes 'plt.savefig("figure3.png")' results_jan.csv
  write_script analysis_final_FIXED.py 20 'variants = variants[variants.DP > 10]' yes \
    '# plt.savefig("figure3.png")   # TODO regenerate fig 3?' results_jan_new.csv

  run_script analysis_final.py         # figure3.png + results_jan.csv
  run_script analysis_final_FIXED.py   # results_jan_new.csv only

  cat > notes_old.txt <<'EOF'
- fig 3 for paper: use the final script
- Sam says lower the threshold?? check with PI
- FIXED version filters depth too - rerun fig 3 with it before submission!
EOF

  # timestamps: figure3.png was copied to the shared drive later, so its
  # date no longer matches the script that made it
  touch -t 202501101015 analysis.py
  touch -t 202502021432 analysis_v2.py
  touch -t 202503141002 analysis_final.py results_jan.csv
  touch -t 202504281120 analysis_final_FIXED.py results_jan_new.csv
  touch -t 202504020900 notes_old.txt
  touch -t 202505021647 figure3.png
  touch -t 202501091200 data.csv
)

# --------------------------------------------------------------------------
# tidy_project: the same story, tracked with Git
# --------------------------------------------------------------------------
mkdir tidy_project
(
  cd tidy_project
  git init -q
  git symbolic-ref HEAD refs/heads/main     # works on old and new Git
  commit() {   # commit <date> <message>
    GIT_AUTHOR_DATE="$1" GIT_COMMITTER_DATE="$1" \
      git -c user.name="Alex Researcher" -c user.email="alex@example.org" \
      commit -q -m "$2"
  }

  write_data data.csv
  write_script analysis.py 50 "" no "" results.csv
  git add data.csv analysis.py
  commit "2025-01-10T10:15:00" "Add first variant-quality analysis"

  write_script analysis.py 30 "" no "" results.csv
  git add analysis.py
  commit "2025-02-02T14:32:00" "Lower QUAL threshold to 30 after QC meeting"

  write_script analysis.py 20 "" yes 'plt.savefig("figure3.png")' results_jan.csv
  run_script analysis.py
  git add analysis.py figure3.png results_jan.csv
  commit "2025-03-14T10:02:00" "Make figure 3 for the paper: QUAL > 20, log scale"
  GIT_COMMITTER_DATE="2025-03-14T10:05:00" \
    git -c user.name="Alex Researcher" -c user.email="alex@example.org" \
    tag -a v1.0-submitted -m "Code behind the submitted manuscript"

  write_script analysis.py 20 'variants = variants[variants.DP > 10]' yes "" results_jan_new.csv
  run_script analysis.py
  git add analysis.py results_jan_new.csv
  commit "2025-04-28T11:20:00" "Add depth filter (DP > 10) for the revision"
)

echo "Created:"
echo "  $(pwd)/messy_project"
echo "  $(pwd)/tidy_project  ($(git -C tidy_project rev-list --count HEAD) commits, tag v1.0-submitted)"
