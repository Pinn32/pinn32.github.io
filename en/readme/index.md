---
title: 'Reproduce This Project'
author: 'Pinn Xu'
date: 2026-06-30
description: 'Instructions for reproducing this Quarto Website, or any specific R/Python projects in this website.'
categories: [Quarto, Web Dev, Knowhow]
sidebar: true
---

This site is built with [Quarto](https://quarto.org). Because the project pages execute both Python and R code, reproducing the build requires restoring both environments.

This guide covers two scenarios:

- **[Reproduce the full website](#reproduce-the-full-website)** — restore every environment and render the complete site.
- **[Reproduce a single project](#reproduce-a-single-project)** — rebuild one project page on its own, without the surrounding site.

## Reproduce the Full Website

### Prerequisites

- [Quarto CLI](https://quarto.org/docs/get-started/) 1.4+
- [Python 3.12](https://www.python.org/downloads/release/python-31213/), via either [conda](https://docs.conda.io/en/latest/miniconda.html) or the built-in `venv`
- [R](https://www.r-project.org/) 4.x with [`renv`](https://rstudio.github.io/renv/) for the R code

### Clone the Repository

```bash
git clone https://github.com/pinn32/pinn32.github.io.git
cd pinn32.github.io
```

### Restore the Environments

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

Confirm that Quarto is using the correct Python interpreter:

```bash
quarto check jupyter
# Path: /path/to/your/envs/dv-env/bin/python
```

### Preview Locally

With both environments restored, start the local development server:

```bash
quarto preview
```

### Deploy to GitHub Pages

To publish your own copy, first point the remote at your repository:

```bash
git remote set-url origin https://github.com/<your-username>/<repo>
```

Update `site-url` in `_quarto.yml` to match your GitHub Pages address:

```yaml
website:
  site-url: https://<your-username>.github.io/<repo>
```

Then publish:

```bash
quarto publish gh-pages
```

## Reproduce a Single Project

The [prerequisites](#prerequisites) above still apply.

Download the files for the project you want to rebuild — for example, `/en/projects/student-media-usage/index.qmd`. Where relevant, also retrieve the source dataset from `/src/data/` and any images from `/src/img/`.

Using `student-media-usage` as an example, you can either keep the `.qmd` extension or convert the file to `.Rmd`.

**To keep the `.qmd` extension**, adjust the YAML options as follows:

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

Then run `quarto render` to build the HTML.

**To convert the file to `.Rmd`**, adjust the YAML options as follows:

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

Then click `Knit` in RStudio, or run `rmarkdown::render("index.Rmd")` in the R console to build the HTML.