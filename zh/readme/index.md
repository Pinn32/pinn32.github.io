---
title: '项目复现说明'
author: 'Pinn Xu'
date: 2026-06-30
description: '复现本 Quarto 网站，或复现网站中任意特定 R/Python 项目的说明。'
categories: [Quarto, Web Dev, 教程]
sidebar: true
---

本站基于 [Quarto](https://quarto.org) 构建。由于项目页面会同时执行 Python 和 R 代码，复现构建需要还原这两套环境。

本说明涵盖两种场景：

- **[复现完整网站](#复现完整网站)** —— 还原全部环境并渲染整个站点。
- **[复现单个项目](#复现单个项目)** —— 单独重建某一个项目页面，无需构建其余站点。

## 复现完整网站

### 前置要求

- [Quarto CLI](https://quarto.org/docs/get-started/) 1.4 及以上版本
- [Python 3.12](https://www.python.org/downloads/release/python-31213/)，通过 [conda](https://docs.conda.io/en/latest/miniconda.html) 或内置的 `venv` 安装
- [R](https://www.r-project.org/) 4.x，并搭配 [`renv`](https://rstudio.github.io/renv/) 运行 R 代码

### 克隆仓库

```bash
git clone https://github.com/pinn32/pinn32.github.io.git
cd pinn32.github.io
```

### 还原环境

**R：**

```r
install.packages("renv")  # 如有需要
renv::restore(lockfile = "envs/renv.lock")
```

**Python（二选一）。** 两种方式都会创建名为 `dv-env` 的环境，并需要 Python 3.12。

方式 A，conda：

```bash
conda env create -f envs/environment.yml
conda activate dv-env
```

方式 B，venv + pip：

```bash
python3.12 -m venv dv-env
source dv-env/bin/activate        # Windows：dv-env\Scripts\activate
pip install -r envs/requirements.txt
```

确认 Quarto 使用的是正确的 Python 解释器：

```bash
quarto check jupyter
# Path: /path/to/your/envs/dv-env/bin/python
```

### 本地预览

两套环境还原完成后，启动本地开发服务器：

```bash
quarto preview
```

### 部署到 GitHub Pages

若要发布你自己的副本，先将远程仓库指向你的仓库：

```bash
git remote set-url origin https://github.com/<your-username>/<repo>
```

在 `_quarto.yml` 中将 `site-url` 更新为你的 GitHub Pages 地址：

```yaml
website:
  site-url: https://<your-username>.github.io/<repo>
```

然后发布：

```bash
quarto publish gh-pages
```

## 复现单个项目

上文的[前置要求](#前置要求)同样适用。

下载你想重建的项目所需的文件 —— 例如 `/en/projects/student-media-usage/index.qmd`。如有需要，同时从 `/src/data/` 获取源数据集，从 `/src/img/` 获取相关图片。

以 `student-media-usage` 为例，你可以保留 `.qmd` 扩展名，或将文件转换为 `.Rmd`。

**若保留 `.qmd` 扩展名**，按如下方式调整 YAML 选项：

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

然后运行 `quarto render` 构建 HTML。

**若将文件转换为 `.Rmd`**，按如下方式调整 YAML 选项：

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

然后在 RStudio 中点击 `Knit`，或在 R 控制台运行 `rmarkdown::render("index.Rmd")` 构建 HTML。

## 从 Notion 数据库获取更新日志

将 `scripts/notion-changelog.json` 中的 `"database_id"` 替换为你自己的数据库 ID，然后运行：

```zsh
python3 scripts/sync-changelog.py --strict
```

前往 [Notion 开发者平台](https://app.notion.com/developers/connections) 创建你自己的 Notion connection token，复制其中的 “Secret” 值，并将其保存为环境变量 `NOTION_TOKEN=...`（例如写入 `~/.zshrc`）。

