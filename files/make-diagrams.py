#!/usr/bin/env python3
"""Generate the commit-graph SVGs used in git-slides.qmd.

Run from this directory:  python3 make-diagrams.py
Writes to ../fig/. Colours match git-theme.scss.
"""
from pathlib import Path

NAVY, TEAL, CORAL, SAND, INK, MUTED = "#13294b", "#0f8b8d", "#ec6b56", "#f6f3ee", "#1f2933", "#5b6770"
AMBER, AMBER_BG, AMBER_INK = "#e0a800", "#fff4e5", "#b27d00"
FONT = "Inter, 'Helvetica Neue', Arial, sans-serif"
MONO = "'JetBrains Mono', Menlo, monospace"
OUT = Path(__file__).resolve().parent.parent / "fig"


def svg(w, h, body):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}" '
            f'font-family="{FONT}">\n{body}\n</svg>\n')


def text(x, y, s, size=20, colour=INK, weight=400, anchor="middle", font=None):
    f = f' font-family="{font}"' if font else ""
    return (f'<text x="{x}" y="{y}" text-anchor="{anchor}" font-size="{size}" font-weight="{weight}" '
            f'fill="{colour}"{f}>{s}</text>')


def commit(x, y, colour, label=None, below=True, r=17):
    out = f'<circle cx="{x}" cy="{y}" r="{r}" fill="{colour}" stroke="{colour}" stroke-width="5"/>'
    if label:
        out += text(x, y + r + 32 if below else y - r - 16, label, size=24)
    return out


def line(x1, y1, x2, y2, colour):
    return f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{colour}" stroke-width="7" stroke-linecap="round"/>'


def curve(x1, y1, x2, y2, colour):
    mx = (x1 + x2) / 2
    return (f'<path d="M{x1},{y1} C{mx},{y1} {mx},{y2} {x2},{y2}" fill="none" stroke="{colour}" '
            f'stroke-width="7" stroke-linecap="round"/>')


def tag(x, y, label, colour, head=False):
    """Branch label pill above the commit at x,y."""
    s = label + ("  ← HEAD" if head else "")
    w = 24 + 14 * len(s)
    top = y - 82
    return (f'<line x1="{x}" y1="{top + 40}" x2="{x}" y2="{y - 20}" stroke="{colour}" stroke-width="3"/>'
            f'<rect x="{x - w / 2}" y="{top}" width="{w}" height="40" rx="20" fill="{colour}"/>'
            + text(x, top + 28, s, size=22, colour="#fff", weight=700, font=MONO))


def side_tag(x, y, label, colour, head=False):
    """Branch label pill to the right of the commit at x,y."""
    s = label + ("  ← HEAD" if head else "")
    w = 24 + 14 * len(s)
    left = x + 34
    return (f'<line x1="{x + 20}" y1="{y}" x2="{left}" y2="{y}" stroke="{colour}" stroke-width="3"/>'
            f'<rect x="{left}" y="{y - 20}" width="{w}" height="40" rx="20" fill="{colour}"/>'
            + text(left + w / 2, y + 8, s, size=22, colour="#fff", weight=700, font=MONO))


def arrowhead(id_, colour):
    return (f'<marker id="{id_}" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto">'
            f'<path d="M0,0 L10,5 L0,10 z" fill="{colour}"/></marker>')


def write(name, content):
    (OUT / name).write_text(content)
    print("wrote", OUT / name)


# 1. commit on a branch -------------------------------------------------------
write("branch-dev.svg", svg(640, 340, "\n".join([
    line(90, 90, 300, 90, NAVY),
    curve(300, 90, 420, 250, CORAL),
    commit(90, 90, NAVY, "initial commit", below=False),
    commit(300, 90, NAVY, "Add example dataset", below=False),
    commit(420, 250, CORAL, "Add summary.py"),
    side_tag(300, 90, "main", NAVY, head=True),
    side_tag(420, 250, "dev", CORAL),
])))

# 2. fast-forward vs merge commit --------------------------------------------
write("ff-vs-merge.svg", svg(1000, 350, "\n".join([
    f"<defs>{arrowhead('ah', TEAL)}</defs>",
    '<line x1="500" y1="20" x2="500" y2="330" stroke="#d9dee3" stroke-width="2"/>',
    # left: fast-forward
    text(20, 36, "Fast-forward", size=28, colour=NAVY, weight=800, anchor="start"),
    text(20, 68, "main has no new commits → just move the label", size=19, colour=MUTED, anchor="start"),
    line(60, 200, 420, 200, NAVY),
    commit(60, 200, NAVY), commit(180, 200, NAVY),
    commit(300, 200, CORAL), commit(420, 200, CORAL),
    text(180, 252, "old main", size=19, colour=MUTED),
    f'<path d="M180,125 Q300,85 400,125" fill="none" stroke="{TEAL}" stroke-width="3" stroke-dasharray="6 6" marker-end="url(#ah)"/>',
    tag(420, 200, "main", NAVY),
    # right: merge commit
    text(540, 36, "Merge commit", size=28, colour=NAVY, weight=800, anchor="start"),
    text(540, 68, "both branches moved → Git joins them", size=19, colour=MUTED, anchor="start"),
    line(580, 200, 940, 200, NAVY),
    curve(700, 200, 790, 290, CORAL), line(790, 290, 850, 290, CORAL), curve(850, 290, 940, 200, CORAL),
    commit(580, 200, NAVY), commit(700, 200, NAVY), commit(820, 200, NAVY),
    commit(820, 290, CORAL),
    commit(940, 200, TEAL, r=22),
    text(820, 338, "dev", size=19, colour=CORAL, weight=700),
    text(985, 338, "merge commit", size=20, colour=TEAL, weight=700, anchor="end"),
    tag(940, 200, "main", NAVY),
])))

# 3. how a conflict happens ---------------------------------------------------
write("conflict.svg", svg(1000, 400, "\n".join([
    line(80, 200, 260, 200, NAVY),
    curve(260, 200, 450, 100, TEAL), curve(260, 200, 450, 300, CORAL),
    curve(450, 100, 660, 200, TEAL), curve(450, 300, 660, 200, CORAL),
    commit(80, 200, NAVY), commit(260, 200, NAVY, "both start here"),
    commit(450, 100, TEAL, "Person 1 edits line 3", below=False),
    commit(450, 300, CORAL, "Person 2 edits line 3"),
    text(450, 36, "pushed first ✓", size=19, colour=TEAL, weight=700),
    text(450, 380, "push rejected → git pull", size=19, colour=CORAL, weight=700),
    f'<circle cx="684" cy="200" r="28" fill="{AMBER_BG}" stroke="{AMBER}" stroke-width="5"/>',
    text(684, 211, "!", size=30, colour=AMBER_INK, weight=800),
    text(736, 194, "CONFLICT", size=26, weight=800, anchor="start"),
    text(736, 224, "same line, two versions:", size=19, colour=MUTED, anchor="start"),
    text(736, 250, "you choose, then commit", size=19, colour=MUTED, anchor="start"),
])))


# 4. Eddie <-> GitLab <-> Noteable round trip ---------------------------------
def box(x, y, w, h, title, sub, colour):
    return (f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="{SAND}" stroke="{colour}" stroke-width="4"/>'
            + text(x + w / 2, y + h / 2, title, size=32, colour=NAVY, weight=800)
            + text(x + w / 2, y + h / 2 + 30, sub, size=20, colour=MUTED))


def arrow(x1, y1, x2, y2, label, colour, lx, ly):
    return (f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="{colour}" stroke-width="5" marker-end="url(#a{colour[1:]})"/>'
            + text(lx, ly, label, size=24, colour=colour, weight=700, font=MONO))


write("round-trip.svg", svg(920, 350, "\n".join([
    f"<defs>{arrowhead('a' + TEAL[1:], TEAL)}{arrowhead('a' + CORAL[1:], CORAL)}</defs>",
    box(320, 15, 280, 100, "GitLab", "git.ecdf.ed.ac.uk", TEAL),
    box(15, 235, 270, 100, "Eddie", "terminal", NAVY),
    box(635, 235, 270, 100, "Noteable", "RStudio Git pane", CORAL),
    arrow(160, 230, 335, 122, "push", CORAL, 190, 160),
    arrow(365, 122, 195, 230, "pull", TEAL, 335, 212),
    arrow(760, 230, 585, 122, "push", CORAL, 730, 160),
    arrow(555, 122, 725, 230, "pull", TEAL, 585, 212),
])))


# ---------- History & Undo (short course) -------------------------------------
LIGHT = "#d9dee3"


def mono(x, y, s, size=22, colour=TEAL, weight=700, anchor="middle"):
    return text(x, y, s, size=size, colour=colour, weight=weight, anchor=anchor, font=MONO)


def chip(cx, y, w, s, colour):
    """A filled file/edit chip centred on cx, top at y."""
    return (f'<rect x="{cx - w / 2}" y="{y}" width="{w}" height="32" rx="6" fill="{colour}"/>'
            + mono(cx, y + 23, s, size=18, colour="#fff"))


def ghost(x, y, r=17):
    return (f'<circle cx="{x}" cy="{y}" r="{r}" fill="#fff" stroke="{MUTED}" stroke-width="3" '
            f'stroke-dasharray="5 4"/>')


def dashed(d, colour, marker=None, width=3):
    m = f' marker-end="url(#{marker})"' if marker else ""
    return f'<path d="{d}" fill="none" stroke="{colour}" stroke-width="{width}" stroke-dasharray="7 6"{m}/>'


def solid(d, colour, marker=None, width=4):
    m = f' marker-end="url(#{marker})"' if marker else ""
    return f'<path d="{d}" fill="none" stroke="{colour}" stroke-width="{width}"{m}/>'


def markers():
    return (f"<defs>{arrowhead('at', TEAL)}{arrowhead('ac', CORAL)}{arrowhead('an', NAVY)}"
            f"{arrowhead('am', MUTED)}</defs>")


# 5. history as a chain: HEAD, HEAD~1, HEAD~2 ---------------------------------
xs = [90, 290, 490, 690]
write("history-chain.svg", svg(1000, 290, "\n".join([
    markers(),
    line(90, 110, 690, 110, NAVY),
    *[commit(x, 110, NAVY) for x in xs],
    *[mono(x, 72, h, size=21, colour=MUTED, weight=400) for x, h in zip(xs, ["72041c0", "3b9e1f2", "a41c7d0", "9f2e6b1"])],
    *[mono(x, 168, s, size=24) for x, s in zip(xs, ["HEAD~3", "HEAD~2", "HEAD~1", "HEAD"])],
    side_tag(690, 110, "main", NAVY, head=True),
    dashed("M690,188 Q490,250 300,190", CORAL, "ac"),
    text(490, 270, "HEAD~2 = start at HEAD, count two commits back", size=21, colour=CORAL, weight=700),
])))

# 6. look at an old version without changing anything --------------------------
write("show-old.svg", svg(1000, 345, "\n".join([
    markers(),
    mono(400, 36, "git diff HEAD~2 HEAD", size=22, colour=CORAL),
    text(400, 62, "what changed between these two commits", size=19, colour=MUTED),
    f'<path d="M150,100 L150,80 L650,80 L650,100" fill="none" stroke="{CORAL}" stroke-width="3"/>',
    line(150, 150, 650, 150, NAVY),
    commit(150, 150, NAVY), commit(400, 150, NAVY), commit(650, 150, NAVY),
    side_tag(650, 150, "main", NAVY, head=True),
    mono(150, 205, "HEAD~2"), mono(400, 205, "HEAD~1"), mono(650, 205, "HEAD"),
    dashed("M150,218 L150,258", TEAL, "at"),
    f'<rect x="20" y="264" width="440" height="72" rx="10" fill="{NAVY}"/>',
    mono(40, 293, "$ git show HEAD~2:README.md", size=19, colour="#fff", weight=700, anchor="start"),
    text(40, 321, "prints README.md as it was back then", size=18, colour="#bfe6e6", anchor="start"),
    f'<rect x="540" y="264" width="440" height="72" rx="10" fill="{SAND}" stroke="{TEAL}" stroke-width="3"/>',
    text(760, 293, "Your files: unchanged ✓", size=22, colour=NAVY, weight=800),
    text(760, 321, "show and diff only look, they never edit", size=18, colour=MUTED),
])))

# 7. which undo do I need? -------------------------------------------------------
def stage(x, title, sub, colour, fix, d1, d2):
    cx = x + 130
    return "\n".join([
        box(x, 20, 260, 90, title, sub, colour),
        solid(f"M{cx},116 L{cx},150", CORAL, "ac"),
        f'<rect x="{x}" y="156" width="260" height="48" rx="24" fill="#fff" stroke="{CORAL}" stroke-width="3"/>',
        mono(cx, 188, fix, size=20, colour=CORAL),
        text(cx, 238, d1, size=19, colour=INK, weight=600),
        text(cx, 264, d2, size=18, colour=MUTED),
    ])


write("which-undo.svg", svg(1000, 330, "\n".join([
    markers(),
    stage(20, "Edited", "not committed yet", NAVY, "git restore &lt;file&gt;",
          "back to the last commit", "uncommitted edits are lost"),
    stage(370, "Committed", "on Eddie, not pushed", CORAL, "git commit --amend",
          "redo the last commit", "rewrites it: fine, nobody has it"),
    stage(720, "Pushed", "on GitLab", TEAL, "git revert &lt;hash&gt;",
          "new commit that undoes it", "adds history: always safe"),
    solid("M286,65 L362,65", TEAL, "at"), mono(325, 52, "commit", size=18),
    solid("M636,65 L712,65", TEAL, "at"), mono(675, 52, "push", size=18),
    f'<line x1="20" y1="290" x2="980" y2="290" stroke="{LIGHT}" stroke-width="2"/>',
    text(500, 320, "Not a mistake, just in the way of a git pull?  →  git stash", size=19, colour=MUTED),
])))

# 8. git restore: from the last commit, or an older one -------------------------
write("restore.svg", svg(1000, 365, "\n".join([
    markers(),
    line(120, 80, 600, 80, NAVY),
    commit(120, 80, NAVY), commit(360, 80, NAVY), commit(600, 80, NAVY),
    mono(360, 46, "HEAD~1"), mono(600, 46, "HEAD"),
    side_tag(600, 80, "main", NAVY, head=True),
    f'<rect x="200" y="232" width="780" height="88" rx="12" fill="{SAND}" stroke="{NAVY}" stroke-width="3"/>',
    text(225, 284, "Working directory", size=24, colour=NAVY, weight=800, anchor="start"),
    chip(600, 260, 170, "README.md", CORAL),
    solid("M600,102 L600,252", TEAL, "at"),
    mono(620, 160, "git restore README.md", size=20, anchor="start"),
    text(620, 186, "the version in the last commit", size=18, colour=MUTED, anchor="start"),
    dashed("M360,102 C360,180 540,190 585,252", CORAL, "ac"),
    mono(345, 150, "git restore --source=HEAD~1", size=19, colour=CORAL, anchor="end"),
    mono(345, 174, "README.md", size=19, colour=CORAL, anchor="end"),
    text(345, 200, "an older version", size=18, colour=MUTED, anchor="end"),
    text(500, 352, "Either way the file is overwritten: edits you never committed are gone.", size=19, colour=MUTED),
])))

# 9. --amend replaces the last commit --------------------------------------------
write("amend.svg", svg(1000, 345, "\n".join([
    markers(),
    text(20, 78, "Before", size=26, colour=NAVY, weight=800, anchor="start"),
    line(280, 70, 620, 70, NAVY),
    commit(280, 70, NAVY), commit(450, 70, NAVY), commit(620, 70, CORAL),
    mono(620, 122, '"oops"  4e1a2b3', size=20, colour=CORAL, weight=400),
    side_tag(620, 70, "main", NAVY, head=True),
    f'<line x1="20" y1="150" x2="980" y2="150" stroke="{LIGHT}" stroke-width="2"/>',
    text(20, 268, "After", size=26, colour=NAVY, weight=800, anchor="start"),
    mono(20, 296, "--amend", size=20, colour=TEAL, anchor="start"),
    dashed("M450,270 C535,270 535,200 603,200", MUTED),
    ghost(620, 200),
    text(650, 207, '"oops" is replaced: gone from history', size=19, colour=MUTED, anchor="start"),
    line(280, 270, 620, 270, NAVY),
    commit(280, 270, NAVY), commit(450, 270, NAVY), commit(620, 270, TEAL, r=22),
    mono(620, 326, '"Add silly line"  8c0d5f9', size=20, colour=TEAL, weight=400),
    side_tag(620, 270, "main", NAVY, head=True),
])))

# 10. revert adds a commit that undoes an old one ------------------------------
write("revert.svg", svg(1000, 270, "\n".join([
    markers(),
    line(80, 100, 740, 100, NAVY),
    commit(80, 100, NAVY), commit(260, 100, NAVY), commit(470, 100, CORAL),
    commit(740, 100, TEAL, r=22),
    text(470, 60, "Add silly line", size=22, colour=CORAL, weight=700),
    text(740, 60, 'Revert "Add silly line"', size=22, colour=TEAL, weight=700),
    side_tag(740, 100, "main", NAVY, head=True),
    dashed("M735,132 Q605,200 482,130", TEAL, "at"),
    text(605, 204, "undoes its changes", size=20, colour=TEAL, weight=700),
    text(500, 252, "Nothing is deleted: both commits stay in the history, and GitLab is happy.", size=19, colour=MUTED),
])))

# 11. the golden rule: amend vs revert after pushing ---------------------------
write("golden-rule.svg", svg(1000, 350, "\n".join([
    markers(),
    f'<line x1="500" y1="20" x2="500" y2="330" stroke="{LIGHT}" stroke-width="2"/>',
    # left: amend after pushing
    text(20, 36, "✗ Amend after pushing", size=28, colour=CORAL, weight=800, anchor="start"),
    text(20, 68, "your copy and GitLab now disagree", size=19, colour=MUTED, anchor="start"),
    line(50, 200, 170, 200, NAVY),
    curve(170, 200, 310, 125, TEAL), curve(170, 200, 310, 275, CORAL),
    commit(50, 200, NAVY), commit(170, 200, NAVY),
    commit(310, 125, TEAL), commit(310, 275, CORAL),
    text(310, 98, "on GitLab", size=20, colour=TEAL, weight=700),
    text(310, 322, "your amended copy", size=20, colour=CORAL, weight=700),
    text(350, 196, "push", size=22, colour=CORAL, weight=800, anchor="start"),
    text(350, 222, "rejected", size=22, colour=CORAL, weight=800, anchor="start"),
    # right: revert after pushing
    text(530, 36, "✓ Revert after pushing", size=28, colour=TEAL, weight=800, anchor="start"),
    text(530, 68, "one history, one extra commit", size=19, colour=MUTED, anchor="start"),
    line(560, 200, 920, 200, NAVY),
    commit(560, 200, NAVY), commit(680, 200, NAVY), commit(800, 200, CORAL),
    commit(920, 200, TEAL, r=22),
    text(800, 252, "on GitLab", size=20, colour=TEAL, weight=700),
    text(920, 252, "your copy", size=20, colour=NAVY, weight=700),
    text(740, 310, "push just adds the new commit ✓", size=21, colour=TEAL, weight=700),
])))

# 12. git stash: shelf, pull, pop ------------------------------------------------
def panel(x, title, wd, shelf, arrow):
    cx = x + 155
    out = [mono(x + 10, 36, title, size=22, colour=NAVY, anchor="start"),
           f'<rect x="{x + 10}" y="58" width="290" height="118" rx="10" fill="{SAND}" stroke="{NAVY}" stroke-width="3"/>',
           text(cx, 82, "Working directory", size=17, colour=MUTED),
           f'<rect x="{x + 10}" y="226" width="290" height="80" rx="10" fill="#fff" stroke="{TEAL}" stroke-width="3" stroke-dasharray="8 6"/>',
           text(cx, 250, "the stash (a shelf)", size=17, colour=MUTED)]
    out += wd(cx) + shelf(cx)
    if arrow == "down":
        out.append(solid(f"M{cx},182 L{cx},218", CORAL, "ac"))
    elif arrow == "up":
        out.append(solid(f"M{cx},220 L{cx},184", TEAL, "at"))
    return "\n".join(out)


write("stash.svg", svg(1000, 345, "\n".join([
    markers(),
    f'<line x1="335" y1="20" x2="335" y2="310" stroke="{LIGHT}" stroke-width="2"/>',
    f'<line x1="670" y1="20" x2="670" y2="310" stroke="{LIGHT}" stroke-width="2"/>',
    panel(10, "1 git stash",
          lambda cx: [text(cx, 135, "clean ✓", size=22, colour=TEAL, weight=700)],
          lambda cx: [chip(cx, 262, 160, "your edits", CORAL)], "down"),
    panel(345, "2 git pull",
          lambda cx: [chip(cx, 102, 250, "new from GitLab", NAVY)],
          lambda cx: [chip(cx, 262, 160, "your edits", CORAL)], None),
    panel(680, "3 git stash pop",
          lambda cx: [chip(cx, 96, 250, "new from GitLab", NAVY), chip(cx, 136, 160, "your edits", CORAL)],
          lambda cx: [text(cx, 285, "empty", size=19, colour=MUTED)], "up"),
    text(500, 336, "git pull can refuse while you have uncommitted edits: the stash keeps them safe meanwhile.", size=18, colour=MUTED),
])))

# 13. what each git diff compares ----------------------------------------------
write("diff-head.svg", svg(1000, 270, "\n".join([
    box(20, 90, 260, 90, "Working dir", "what you edit", NAVY),
    box(370, 90, 260, 90, "Staging area", "after git add", TEAL),
    box(720, 90, 260, 90, "Last commit", "HEAD", CORAL),
    f'<path d="M150,82 L150,64 L500,64 L500,82" fill="none" stroke="{MUTED}" stroke-width="3"/>',
    mono(325, 50, "git diff", size=19, colour=MUTED),
    f'<path d="M500,82 L500,64 L850,64 L850,82" fill="none" stroke="{MUTED}" stroke-width="3"/>',
    mono(675, 50, "git diff --staged", size=19, colour=MUTED),
    f'<path d="M150,188 L150,210 L850,210 L850,188" fill="none" stroke="{CORAL}" stroke-width="4"/>',
    mono(500, 244, "git diff HEAD", size=24, colour=CORAL),
    text(500, 266, "everything since the last commit, staged or not", size=18, colour=MUTED),
])))
