# CLAUDE.md

## Project Overview

Quarto website for data visualization projects and tutorials by Pinn (Aiqi) Xu.
**URL:** https://pinn32.github.io

Content is organized into two language trees (`en/`, `zh/`), each mirroring the same structure:
- **Projects** — analytical write-ups (Catalan referendum sentiment, visa costs, Spotify streams, student media usage)
- **Tutorials** — data visualization guides (data processing, amounts & distribution, multivariate plots, Sankey & network)
- **Hobbies**, **About** pages

## Tech Stack

- **Quarto** — static site generator (`_quarto.yml`)
- **Python kernel** — `dv-env` conda env (`envs/environment.yml`); Python 3.12, pandas, plotly, seaborn, matplotlib, pyvis, networkx
- **Theme** — Minty (Bootswatch)

## File Structure

```
_quarto.yml               # site config, navbar, sidebar, format defaults
_brand.yml                # branding (logo)
en/                       # English content
  _metadata.yml
  index.qmd
  404.qmd
  projects/<name>/index.qmd
  tutorials/<name>/index.qmd
  hobbies/index.qmd
  about/index.qmd
zh/                       # Chinese content (same structure as en/)
src/
  styles/
    portfolio.scss         # self-contained LIGHT theme (tokens, layout, code, listings)
    portfolio-dark.scss    # self-contained DARK theme (same section order as portfolio.css)
  scripts/
    fix-code-fold.html    # JS post-processing
    lang-switch.html      # language switcher logic
  filters/
    reading-stats.lua     # reading time
  img/
  data/                   # shared CSV datasets
  apa.csl                 # APA citation format
```

## Common Commands

```bash
quarto preview                                        # local dev server
quarto render                                         # full build
quarto render en/tutorials/amounts-and-distribution/index.qmd  # single file
conda activate dv-env                                 # needed for Python cells
python3 scripts/sync-changelog.py                     # pull change-log content from Notion
```

## Conventions

- **Code folding** — on by default (`code-fold: true`); tutorials override with `code-fold: false`
- **Sidebar** — manually listed in `_quarto.yml`; add new pages there when creating content
- **Citations** — APA style (`apa.csl`); `.bib` files live alongside each project's `index.qmd`
- Chinese content (`zh/`) is standalone `.qmd`, not converted from `.ipynb`

## Change Log Page (`en/changes/`)

Content lives in the Notion database "Site Change Log" (one row per timeline node;
`Type` = Phase or Entry; entry bullets in the row's page body, day-prefixed like
`Jun 25 · did the thing`). To update the page:

1. Edit rows in Notion
2. `NOTION_TOKEN=... python3 scripts/sync-changelog.py` — regenerates
   `en/changes/_timeline.md` (committed; DB id in `scripts/notion-changelog.json`)
3. `quarto render en/changes/index.md`

`src/filters/changelog-timeline.lua` turns the partial's markdown convention
(`##` phase + `range` attr, `###` entry + `date/iso/commits/hours/days` attrs)
into the timeline HTML styled by `en/changes/changes.css`. The filter also
derives the daily-activity heatmap above the stats line from the same parsed
data (day-prefixed bullets → per-day counts overall and per tag group
feat/content/dev; entry commits/hours split across days by bullet share), so
it stays in sync with Notion automatically. Without a token the
sync script exits 0 and keeps the committed partial, so builds work offline.
`_timeline.md` can also be edited by hand in a pinch (next sync overwrites it).

## After Fixing Bugs
- Run tests after fixing bugs until no more errors
