---
title: "Colab 导出 HTML 后无法显示 Plotly 图表问题"
author: 'Pinn Xu'
date: 2025-10-07
order: -20251007   # sidebar sort key: negative date => newest first
description: '对于 Plotly 图表，Google Colab 内部渲染和导出 HTML 后浏览器渲染的差异。'
categories: [Python, Colab, Plotly, 教程]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260712154436828.png"

aliases:
    - ../colab-plotly-export/
---

# 总结
## 问题
使用 Google Colab 编辑 ipynb 文件并导出为 HTML 后，Plotly 图表无法显示。

## 解决
经过测试，ipynb 文件在 Google Colab 中 [^1]：

- `fig.show()` 可以正常显示图表。
- `fig.show(renderer="notebook_connected")` 无法显示图表。

但导出为 HTML 并用浏览器打开后 [^2]：

- `fig.show()` 生成的图表无法显示。
- 只有 `fig.show(renderer="notebook_connected")` 生成的图表可以正常显示。

因此，建议在 Colab 中编辑 Notebook 时使用默认渲染器（ `fig.show()` ），在导出 HTML 前再将 `renderer` 改为 `"notebook_connected"`。


[^1]: **IPYNB 文件：**[在Colab中查看示例文件](https://colab.research.google.com/drive/1BbMO74Hw-yHjvXoj5mbD5DEZsw00RKnp?usp=drive_link) 或 <a href="../../../src/data/colab-plotly-export/renderer-test.ipynb" download>下载示例文件</a>

[^2]: **HTML 文件：**[在浏览器中查看演示文件](../../../src/data/colab-plotly-export/renderer-test.html) 或 <a href="../../../src/data/colab-plotly-export/renderer-test.html" download>下载示例文件</a> 


## 注意事项
使用 Colab 编辑 ipynb 文件后，如果要导出为 HTML，务必先按 **Ctrl+S**（保存到 Google Drive），确保导出的是最新保存的版本。如果没有先保存就执行导出命令，导出的 HTML 可能不是最新版本，甚至会出现内容缺失等问题。

**推荐流程：**

1. 完成整个 `ipynb` 的编辑。
2. 选择 **Runtime → Restart and run all**（或重新启动运行时并运行全部）。
3. 按 **Ctrl+S** 保存 Notebook。
4. 运行下面的代码导出 HTML。
5. 导出完成后，如 Notebook 有新的修改，再按一次 **Ctrl+S** 保存。

```bash
%%shell
jupyter nbconvert --to html /content/drive/MyDrive/路径/文件名.ipynb
```

:::{callout-tip}
`%%shell` 是 Jupyter Notebook 的 特殊语法 (cell magic)，用于执行一个代码单元中的 shell 命令；对于单行 shell 命令，也可以使用 `!`，如 `!pip install pyvis`。
:::
