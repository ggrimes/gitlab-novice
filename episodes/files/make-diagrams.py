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
