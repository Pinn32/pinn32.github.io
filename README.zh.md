# 个人网站（基于 Quarto 构建）

**网址：[pinn32.github.io](https://pinn32.github.io)**

我的个人网站源码，使用 [Quarto](https://quarto.org) 构建。项目页面涉及 Python 和 R，因此复现构建需要同时还原这两套环境。

- 若要复现整个 Quarto 网站，请参阅 [复现网站](#复现网站)。
- 若要复现特定的 R/Python 项目，请参阅 [复现特定项目](#复现特定项目)。

## 复现网站

### 前置要求

- [Quarto CLI](https://quarto.org/docs/get-started/) 1.4 及以上版本
- [Python 3.12](https://www.python.org/downloads/release/python-31213/)，可通过 [conda](https://docs.conda.io/en/latest/miniconda.html) 或内置的 `venv` 安装
- [R](https://www.r-project.org/) 4.x，并搭配 [`renv`](https://rstudio.github.io/renv/) 用于运行 R 代码

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

检查 Quarto 是否识别到正确的 Python：

```bash
quarto check jupyter
# Path: /path/to/your/envs/dv-env/bin/python
```

## 本地预览

```bash
quarto preview
```

### 部署到 GitHub Pages

将远程仓库 URL 重置为你自己的 GitHub 仓库：

```bash
git remote set-url origin https://github.com/<your-username>/<repo>
```

在 `_quarto.yml` 中将 `site-url` 重置为你的 GitHub Pages 网址：

```yaml
website:
  site-url: https://<your-username>.github.io/<repo>
```

部署到 GitHub Pages：

```bash
quarto publish gh-pages
```

## 复现特定项目

前置要求与上文 [前置要求](#前置要求) 相同。

从 GitHub 下载特定项目的相关文件。

例如：`/en/projects/student-media-usage/index.qmd`

如有需要，从 `/src/data/` 文件夹中找到源数据集，从 `/src/img/` 文件夹中找到图片。

以 `student-media-usage` 项目为例，你可以选择保留 `.qmd` 扩展名，或将其改为 `.Rmd`。

**如果你更倾向使用 `.qmd`，请按如下方式修改 YAML 选项：**

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

运行 `quarto render` 构建 HTML。

**如果你更倾向使用 `.Rmd`，请按如下方式修改 YAML 选项：**

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

在 RStudio 中点击 `Knit`，或在 R 控制台运行 `rmarkdown::render("index.Rmd")` 构建 HTML。
