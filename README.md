# Personal Website (built with Quarto)

English | [中文](README.zh.md)

**URL: [pinn32.github.io](https://pinn32.github.io)**

Source for my personal site, built with [Quarto](https://quarto.org). Projects pages involves Python and R, so reproducing the build needs to restore both environments.

- To reproduce the whole Quarto website, see [Reproducing the Website](#reproducing-the-website).  
- To reproduce specific R/Python project, see [Reproducing Specific Project](#reproducing-specific-project)

## Reproducing the Website

### Prerequisites

- [Quarto CLI](https://quarto.org/docs/get-started/) 1.4+
- [Python 3.12](https://www.python.org/downloads/release/python-31213/), via either [conda](https://docs.conda.io/en/latest/miniconda.html) or the built-in `venv`
- [R](https://www.r-project.org/) 4.x with [`renv`](https://rstudio.github.io/renv/) for the R code

### Clone

```bash
git clone https://github.com/pinn32/pinn32.github.io.git
cd pinn32.github.io
```

### Restore Environments

**R:**

```r
install.packages("renv")  # if needed
renv::restore(lockfile = "envs/renv.lock")
```

**Python (pick one).** Both create an environment named `dv-env` and need Python 3.12.

Option A, conda:

```bash
conda env create -f envs/environment.yml
conda activate dv-env
```

Option B, venv + pip:

```bash
python3.12 -m venv dv-env
source dv-env/bin/activate        # Windows: dv-env\Scripts\activate
pip install -r envs/requirements.txt
```

Check that Quarto sees the right Python:

```bash
quarto check jupyter
# Path: /path/to/your/envs/dv-env/bin/python
```

## Local Preview

```bash
quarto preview
```

### Deploy to GitHub Pages

Reset the remote URL to your GitHub repo:
```bash
git remote set-url origin https://github.com/<your-username>/<repo>
```

Reset `site-url` to your GitHub Pages URL in `_quarto.yml`:

```yaml
website:
  site-url: https://<your-username>.github.io/<repo>
```

Deploy to GitHub Pages:
```bash
quarto publish gh-pages
```

## Reproducing Specific Project

Same [prerequisites](#prerequisites) as above.

Download project specific files from GitHub.

e.g. `/en/projects/student-media-usage/index.qmd`

Find source dataset from `/src/data/` folder, and images from `/src/img/` folder, if any.

Taking the `student-media-usage` project as an example, you can choose either maintain the `.qmd` extension or change it to `.Rmd`. 

**If you prefer `.qmd`, modify the YAML options as follows:**

```yml
title: 'Student Social Media Usage and Well-being Analysis'
author: 'Pinn Xu'
date: '2026-02-23'
format:
  html:
    code-fold: true
    highlight-style: pygments
    theme: flatly
    toc: true
    toc-location: right
```

Run `quarto render` to build HTML.

**If you prefer `.Rmd`, modify the YAML options as follows:**

```yml
---
title: 'Student Social Media Usage and Well-being Analysis'
author: 'Pinn Xu'
date: '2026-02-23'
output:
  html_document:
    code_folding: hide
    highlight: "pygments"
    theme: "sandstone"
    toc: true
    toc_float:
      collapsed: true
---
```

Click `Knit` in RStudio or run `rmarkdown::render("index.Rmd")` in R console to build HTML.


## Fetch Change Log from Notion Database

Replace `"database_id"` in `scripts/notion-changelog.json` with your own database ID, then run:

```zsh
python3 scripts/sync-changelog.py --strict
```

Create your own Notion connection token at [Notion Developers](https://app.notion.com/developers/connections), copy the "Secret" value and store it as the environment variable `NOTION_TOKEN=...` (e.g. in `~/.zshrc`).

