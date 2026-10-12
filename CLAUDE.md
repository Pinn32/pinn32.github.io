# CLAUDE.md

Agent guide for the Quarto website of Pinn (Aiqi) Xu — data visualization projects,
tutorials, tools, blogs and media. **URL:** https://pinn32.github.io
**Repo:** https://github.com/Pinn32/pinn32.github.io (source on `main`, built site on `gh-pages`)

Canonical agent documentation for the Notion side (Dev Track, Change Log) lives in
Notion: **Documentation** page `3e1a25f9fecd8073b6e1de55015a989f` (under the
"Quarto Website" project page). This file summarizes it; when they disagree, see
[Source authority](#source-authority).

---

## 1. Tech stack

- **Quarto** static site (`_quarto.yml`), Minty (Bootswatch) + custom light/dark themes
- **Python** — `dv-env` (Python 3.12; pandas, plotly, seaborn, matplotlib, pyvis, networkx).
  Spec: `envs/environment.yml` (conda) or `envs/requirements.txt` (venv). Projects/tutorials set `jupyter: dv-env`.
- **R** — some projects use knitr chunks (e.g. `ai-discourse`); packages pinned in `envs/renv.lock`
- **Lua filters**, inline **JS** (`src/scripts/*.html`), **SCSS/CSS**
- **Notion** — CMS for the Change Log (synced by `scripts/sync-changelog.py`, stdlib only)
- **Cloudflare R2 CDN** (`https://cdn.mcp32.com`) — videos, gallery media, large images
- **Giscus** comments; **Git LFS** for csv/images/video (see `.gitattributes`)

## 2. File structure

```
_quarto.yml            # site config: navbar, sidebars (en/zh), format, filters, freeze
_brand.yml             # logo/branding
index.qmd, 404.qmd     # root pages
en/  zh/               # two language trees, same structure
  _metadata.yml        # lang, giscus language, crossref labels
  index.qmd
  projects/  tutorials/  tools/  blogs/  media/{video,art,music}/
    _metadata.yml      # per-section defaults (code-fold, jupyter, post-type, reading-meta…)
    index.qmd          # listing page
    YYYY-MM-DD-slug/index.qmd|md   (+ references.bib, data, caches)
  about/  all-posts/  readme/  changes/{index.md,_timeline.md}
en/a-playground/       # scratch page (shared by both sidebars; en only)
src/
  styles/
    portfolio.scss       # LIGHT theme: Sass defaults + :root --pf-* tokens + light-only rules
    portfolio-dark.scss  # DARK theme: same structure as portfolio.scss
    style.css            # shared, theme-agnostic rules (consume var(--pf-*)/var(--st-*))
    changes.css          # change-log timeline + heatmap (tokens only, no theme overrides)
    about-jolla.css      # about page (jolla template)
  scripts/
    site-fixes.html      # all global JS: link cleanup, navbar active state, lang switch,
                         #   code-fold buttons, sidebar search/toggle, tag redirect,
                         #   copyright year, early Mermaid render
    *-filter.html, responsive-tag-bar.html   # listing/category UI
  filters/
    subtitle-typing.lua      # subtitle string = static; list = rotating typewriter
    reading-stats.lua        # reading time (needs reading-meta-enabled: true)
    changelog-timeline.lua   # change-log timeline + heatmap (needs changelog-timeline: true)
    lazy-images.lua          # loading="lazy" decoding="async" on body images
  img/ data/             # local images, shared CSV datasets
  apa.csl                # APA citation style
scripts/
  sync-changelog.py      # Notion → en/zh changes/_timeline.md
  notion-changelog.json  # Change Log database id
  clean-site-output.sh / check-site-output.sh   # publish-time pre/post render hooks
envs/                    # environment.yml, requirements.txt, renv.lock
_freeze/                 # committed frozen execution results (execute: freeze: true)
archive/                 # git-ignored; not rendered (README.dev.md = old dev notes)
```

Generated / do not edit by hand: `_site/`, `_freeze/` (re-render instead), `*_files/`,
`*/changes/_timeline.md` (regenerated from Notion; hand edits only in a pinch, next sync overwrites).

## 3. Commands

```bash
conda activate dv-env                                  # required for Python cells
quarto preview                                         # dev server, port 4200
quarto render                                          # full build (uses frozen results)
quarto render en/projects/<dir>/index.qmd              # re-execute one page (refreshes _freeze)
quarto check jupyter                                   # confirm dv-env kernel
python3 scripts/sync-changelog.py [--strict]           # pull Change Log from Notion
quarto render en/changes/index.md zh/changes/index.md  # rebuild change-log pages
quarto publish gh-pages                                # deploy — run by the user only, never by agents
```

`NOTION_TOKEN` (and optional `NOTION_CHANGELOG_DB`) are read from the environment, then
from repo-root `.env` (git-ignored — never print, commit or echo it). Without a token or
network the sync script warns and exits 0, keeping committed partials; `--strict` makes that exit 1.

## 4. Content conventions

- **Bilingual parity.** Every content page exists in `en/` and `zh/` at the same path.
  `zh/` pages are standalone `.qmd`/`.md`, written in natural Chinese (not converted from
  `.ipynb`). When adding or changing content in one language, update the other or tell the user.
- **Page directories** are `YYYY-MM-DD-slug/index.qmd` (or `index.md` for code-free posts).
  When renaming/moving a page, add the old path to `aliases:` (e.g. `- ../old-slug/`).
- **Front matter** commonly uses `title`, `subtitle`, `description`, `author: 'Pinn Xu'`,
  `date`, `categories`, `image`, `order` (listing sort; blogs use `order: -YYYYMMDD`),
  `aliases`, `bibliography: references.bib`, `csl: ../../../src/apa.csl`.
- **Sidebars** are glob-based (`en/<section>/*/index.*md`) — new posts appear automatically.
  Only edit `_quarto.yml` sidebars/navbar for new sections or Media/fixed links, and mirror
  the change in both `en-sidebar` and `zh-sidebar`.
- **Section defaults** come from each `_metadata.yml`: projects `code-fold: true`;
  tutorials/blogs/tools/media `code-fold: false`; projects & tutorials `jupyter: dv-env`;
  `post-type` drives tag redirects and listing filters. Override per page only when needed.
- **Citations:** APA via `src/apa.csl`; `.bib` beside each `index.qmd`.
- **Crossrefs:** no spaces inside `tbl-colwidths` values; verify crossrefs after editing executable cells.
- **Language code** is `zh` (not `zh-CN`) for Quarto `lang`; Giscus uses `zh-CN`.
- **Media:** large images/videos go to the R2 CDN (`https://cdn.mcp32.com/...`), not the repo.
  `project.resources` only ships `src/img/**` and two data folders — don't add media globs to it.
  The publish check fails on any file > 95 MiB or `_site` > 500 MiB.
- **Execution is frozen** (`execute: freeze: true`). Full renders and `quarto publish` reuse
  `_freeze/`; to refresh a page's output, render that page/directory explicitly; the resulting `_freeze/` changes must be committed (by the user).
- **Prose:** invoke `/humanizer` (en) or `/humanizer-zh` (zh) before writing public site copy;
  invoke `/frontend-design` before designing new pages or layouts.

## 5. Styling & scripts rules

- Shared rules go in `src/styles/style.css` and consume `var(--pf-*)` tokens. Theme files
  hold only Sass defaults, the `:root` token map, and theme-specific residue.
- Any token or structural change to `portfolio.scss` must be mirrored in `portfolio-dark.scss`
  (same section order). Check both light and dark mode.
- `changes.css` uses tokens only — no theme-specific overrides.
- New global JS goes into `src/scripts/site-fixes.html` as its own commented `<script>` block;
  JS must work under both `/en/` and `/zh/` paths.
- Filters are opt-in by metadata flag; keep them no-ops when their flag is absent.
- Global config/SCSS/filter/script changes require a **full** `quarto render`, not just a page preview.

## 6. Git & publishing

- **Never commit, push, or publish on the user's behalf**, and don't offer to. Leave changes
  uncommitted; read-only git commands (`status`, `diff`, `log`) are fine. The user does all
  commits, pushes and `quarto publish` runs themselves.
- For reference when describing changes, the user's commit subjects use a lowercase prefix: `dev:`, `feat:`, `fix:`, `style:`, `proj:`, `ttl:`,
  `blg:`, `tool:`, `contnt:`, `media:` (formerly `hobb:`). Multiple parts: `blg: x; style: y`.
  Change-log syncs are committed as `dev: sync cl`.
- Publishing: `pre-render`/`post-render` hooks in `_quarto.yml` (`clean-site-output.sh`,
  `check-site-output.sh`) are commented out and are uncommented **only for publishing**
  (they wipe `_site/` on full renders). Restore the comments afterwards.

## 7. Validation (do this after every change / bug fix)

There is no test suite; "tests" means these three layers, repeated until clean:
1. **Source** — YAML/QMD/Python/Lua/JS/CSS syntax and relative paths (`../../../src/...`).
2. **Render** — `quarto render` the affected pages in **both** `en/` and `zh/`; full render after
   global changes. No render errors or new warnings.
3. **Output** — inspect generated HTML in `_site/` (or preview): links, crossrefs, listings,
   light/dark theme, responsive layout; for the change log: card order, timeline, heatmap,
   en/zh text.

Never fix generated output (`_site/`, `_timeline.md`) when a source file or script produces it.

---

## 8. Change Log system (Notion ↔ repo)

### Data flow
**Quarto Dev Track** (raw work-session rows) → curated into **Quarto Change Log**
(publishable milestones) → `sync-changelog.py` → `en|zh/changes/_timeline.md` →
`changelog-timeline.lua` + `changes.css` → timeline + heatmap pages.

Stable identifiers:
- Quarto Website project page: `394a25f9-fecd-80b8-8fad-c11537fb59b0`
- Dev Track data source: `collection://338a25f9-fecd-805c-98b6-000b7b761bba`
- Change Log data source: `collection://2d395573-f298-4306-84a6-58e960f44918`
  (database id used by the script: `scripts/notion-changelog.json`)

Project timezone: **America/New_York** (Notion's and the user's). If you notice Notion's or
Notion Calendar's timezone has changed, remind the user to update the Notion documentation.
Notion UI/API timezone mismatch caused past sync bugs — handle dates as logical NY work days.

### Source authority
Live Notion schema → live rows / established entries → current repo code → rendered site →
the Notion Documentation → this file. If they disagree, inspect rather than guess. The live
schema and current rules outrank legacy entries' formatting.

### Hard rules (every mission)
- **Never edit any `_BU` property** (`Start_BU`, `Date label_BU`, `Days_BU`, `Hours_BU`) — top
  priority. Sole exception: setting `Start_BU` on a new Phase row (see Create a Phase).
- **Never write computed/formula/rollup properties:** Change Log `Hours`, `Start`, `_end`,
  `_days`, `Days`, `Date label`, `_phase`; Dev Track `_start`, `用时(h)`, `_phase`. Empty
  computed fields are reported, never patched. Formula code can't be edited via the API.
- **Bilingual always:** every Entry has `Name zh`, `Summary zh`, and a Chinese child per bullet.
- **Phases are user-triggered only** — never created by automation.
- Never fabricate facts, dates or commit counts; existing relations always win over new ones.

### Dev Track schema (writable)
`Name` (short raw description with a prefix: `dev: feat: fix: style: proj: blg: contnt: tool: hobb:`),
`Type` (`daily progress` | `record` | `phase`), `Timeline` (date-times start/end for sessions;
date only for phases), `Note` (raw details: commit refs, filenames, implementation facts, lessons),
`Quarto Change Log` (relation, max 1; empty = awaiting curation), `All Projects` (→ Quarto Website).
`_start` counts non-phase activity 00:00–17:00 as the previous day (live formula is authoritative).

### Change Log schema (writable)
`Name` (concise Title Case milestone), `Name zh`, `Type` (`Entry` | `Phase`), `Summary` /
`Summary zh` (Entry only, 1–2 sentences, outcome-focused), `Quarto Dev Track` (all source rows),
`All Projects` (→ Quarto Website), `Commits` (number of **grouped** commits — never the raw
relation count). Mandatory on every Entry: `Name`, `Name zh`, `Type`, `Summary`, `Summary zh`, `Commits`.

### Mission: Add a Dev Track row (on request only)
Before creating, **ask the user** for (1) the corresponding commit and (2) anything special to note.
Then fill Name/Type/Timeline/Note (preserve commit, notes, filenames, lessons), relate to Quarto
Website; leave the Change Log relation empty unless it belongs to an existing entry.
Exception: the nightly calendar import creates rows directly.

### Mission: Sync Change Log ("sync change log", or nightly)
1. Fetch both live schemas; query Dev Track rows with empty Change Log relation, oldest first;
   read their Name, Note, Timeline and the most recent Change Log entries.
2. None unlinked → change nothing, report "nothing to sync". Be idempotent: never recreate
   existing entries/relations.
3. **Group rows into Entries**, in priority order (day = `_start` date; "Dev Track day" = a day with ≥1 row):
   1. **Chronological continuity is mandatory.** All rows on one day go in one entry. Never group
      two Dev Track days while skipping a Dev Track day between them — counting already-linked rows too.
      Never relate separated sequences to one entry.
   2. Then: similar topics (soft preference — **propose the grouping and ask the user** first);
      join a 1–2 commit day to its next Dev Track day; group neighboring similar days.
   3. **Cap: ≤ 7 commits per entry.** If joining next would exceed 7 but previous wouldn't, join
      previous. A 1-commit day where both sides exceed 7 → join the side with fewer days. A 2-commit
      day where both exceed 7 → its own entry.
   If unlinked rows continue the latest existing entry under these rules, relate them to it and update
   its properties, Commits and body instead of creating a new one.
4. **Group commits within an entry** (read every row's Name *and* Note; check git history if ambiguous):
   merge tiny same-theme refinements into one bullet joined with `; `; merge stages of one task into
   one bullet worded around the finished outcome; keep distinct deliverables separate. One English
   top-level bullet per grouped commit; `Commits` = bullet count. Keep source prefixes; never pull
   rows from another entry.
5. **Write the entry** (format below), re-fetch it and its rows, run the format test + verification
   pass, fix and repeat until everything passes, then re-query for unexpectedly unlinked rows.
6. Report a short outcome summary (created / related / nothing to do). The verification pass reports
   **only exceptions**: missing Timeline dates (skip that entry), undecidable Commits (report; if
   proceeding, mark provisional), unfilled mandatory/empty computed fields, relation clashes or
   out-of-order timelines (skip those rows, never change existing relations). Distinguish
   expected-unlinked rows from bugs.
7. Repo side (when asked): `python3 scripts/sync-changelog.py --strict`, act on its untranslated
   report, `quarto render en/changes/index.md zh/changes/index.md`, verify output; leave the changes uncommitted (the user commits them as `dev: sync cl`).

### Entry editorial format
- Title: result-oriented Title Case (e.g. `Cross-Reference System`, `Full Style Revamp & en/zh Switch`).
  Repeated category → `xN` (`Blog x3` / `博客 x3`); never use `*` in names.
- Body = only two-level bullet pairs: English level-1, immediately followed by exactly one Chinese
  level-2 child. No third level, prose, headings, callouts, code blocks, images, or blank lines.
  Phase bodies stay blank.
- **Date prefix by unique logical work dates** across related rows: exactly one date → no prefixes;
  more than one → every English bullet starts `MMM D · ` (e.g. `Apr 7 · feat: add cross-refs`), never on
  the Chinese child; a merged bullet takes its earliest date; no bullets for unrepresented days.
- Chinese child: repeat the prefix (`- feat: 新增更新日志页面`), keep code/identifiers in backticks
  and names like Quarto, Notion, Giscus, GitHub, Cloudflare R2, PicGo, Plotly, Mermaid, SCSS, Python, R.
  Translate naturally; never add facts; check Notes/code when wording is ambiguous.
- The sync script inherits a missing day prefix/tag on zh children from the English parent and falls
  back to English where zh is absent; translate only what is missing.

```
- Apr 7 · feat: add cross-refs
	- feat: 添加交叉引用
- Apr 9 · blg: finish zh/en xxx blog; generate figs
	- blg: 完成 xxx 博客的中英版本；生成配图
```

### Mission: Create a Phase (user request only)
1. Start date = `Start` of the phase's first Change Log entry.
2. Dev Track row `Phase X · Topic` (X = new phase number), `Type: phase`, Timeline = start date (date only), related to the project.
3. Change Log row with the same Name, `Name zh` = `阶段 X · 中文标题`, `Type: Phase`, empty summaries,
   `Start_BU` = start date, blank body, related to the Dev Track phase row and project.
4. Tell the user to append `parseDate("YYYY-MM-DD")` (ascending) to `phaseStarts` in the `_phase`
   formula of **both** databases — agents can't edit formulas.
5. Audit all phase rows: strict 1:1 Dev Track ↔ Change Log pairs with identical Names; report
   mismatches and ask which Name is correct — never rename silently.
Breakpoints over existing entries: group neighboring entries (by `Start`) with similar topics, 4–7 entries per phase.

### Scheduled jobs (standing authorization from 2026-09-24; report exceptions only)
- **`sync-dev-track`** (~11:00 PM NY): import Google Calendar events from today + previous 3 days with
  dev prefixes (`💻dv-proj:`, `🖥️dv-proj:`, `💻dv`, `🖥️dv`, `💻qt:`, `🖥️qt`) plus conservatively judged
  Quarto dev events; dedupe by overlapping Timeline; create `daily progress` rows (Timeline = event
  times, Note = description, related to Quarto Website); then run the Change Log sync.
- **`nightly-change-log-drafts`** (~11:37 PM NY): first check for unlinked Dev Track rows; none → end
  silently; else draft entries per all sync rules. Never create phases.
Document any new scheduled job in the Notion Documentation page.

### Repo-side change-log mechanics
- `_timeline.md` convention parsed by `changelog-timeline.lua`: `## Phase {range="..."}`,
  `### Entry {date iso commits hours days}`, first paragraph = card summary, first bullet list = details,
  `Mon D · ` bullets grouped by date.
- UI strings are localized via the filter's `STRINGS` table keyed on page `lang`; day prefixes, tag
  prefixes, date labels and heatmap tabs stay English (parsing depends on them).
- Heatmap is derived from day-prefixed bullets (overall + feat/content/dev groups; entry
  commits/hours split across days by bullet share) — it updates automatically with Notion.
- Before changing sync behavior, read the current `sync-changelog.py`, the Lua filter, `.env`
  handling and generated partials; old notes don't replace current code.
