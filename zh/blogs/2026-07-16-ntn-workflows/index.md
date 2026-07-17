---
title: "Notion 数据库工作流"
author: 'Pinn Xu'
date: 2026-07-16
order: -20260716   # sidebar sort key: negative date => newest first
description: '我基于 Notion 数据库搭建的自动化工作流。'
categories: [Notion, Database, 技巧]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716134621505.png"

aliases:
    - ../ntn-workflows/
---

# 项目进度自动追踪工作流

这套工作流几乎不需要手动维护就能记录项目进度。三类关联数据库分工协作：任务 → 进度 → 项目。我通过 Notion Calendar 记录任务，数据自动填充至三个数据库；同时，外部应用可以通过 Notion API 读取数据库内容。

比如，我用它来记录本站的开发进度。博客 [Notion 数据库自动同步技巧](/zh/blogs/ntn-db-auto-sync/) 介绍了同步的搭建方式。  
本站数据库：[Quarto Website Database](https://app.notion.com/p/394a25f9fecd80b88fadc11537fb59b0)

<!-- flowchart -->
![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260712013355165.svg){.light-content}
![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260712013519774.svg){.dark-content}
<!-- flowchart -->

我在 Notion Calendar 中将每项任务记入任务数据库 ("Quarto Dev Track")。每日进度由 Rollup 与 Formula 属性自动汇总至进度数据库 ("Quarto Change Log")，并可通过 Notion API 同步至外部应用（例如本站）。项目数据库 ("All Projects") 则集中展示所有项目的进度与关键统计。

:::{.macbook-frame style="width:40rem;"}
![All Projects 数据库总览](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191552656.png)
:::


# 用 Notion 数据库做 CMS

Monthly Love 是我的一个 Web 项目，用 Notion 数据库作为内容管理系统 (CMS)。应用基于 Next.js、TypeScript 与 Notion API，借助 Claude Code 搭建。配置仅需一次，之后所有内容都在 Notion 界面中管理。

代码托管在 GitHub：[Pinn32/monthly-love](https://github.com/Pinn32/monthly-love)  
在线演示见 [monthly-loveletter.vercel.app](https://monthly-loveletter.vercel.app/)（门户密码 `missu`；示例页面密码 `123`）。

:::{.macbook-frame style="width:40rem;"}
![Monthly Love 数据库：Notion 作为 CMS](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716192021172.png)
:::


# 课程作业仪表盘

我用 Notion 仪表盘页面管理每学期的课程。每个仪表盘实时追踪作业进度，结合 Notion Calendar，自动计算成绩，期末还会生成带图表的总结与反思。

在线示例：[2025 Fall Course Dashboard](https://app.notion.com/p/2dea25f9fecd800691d6eccfac51b7cd)。

:::{.macbook-frame style="width:40rem;"}
![仪表盘预览：统计与图表](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191715075.png)
:::


# 其他 Notion 数据库

作为 Notion 重度用户，我还搭建了不少数据库来打理日常生活，下面是几个例子。

## 自动扣费数据库

管理我的订阅服务。一次性配置后，数据库会自动更新续费日期并按时提醒我。

:::{.macbook-frame style="width:40rem;"}
![自动扣费提醒数据库](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191645135.png)
:::

## 日志数据库

记录我每天的进步、经验、反思和生活点滴。

:::{.macbook-frame style="width:40rem;"}
![Journal 数据库（标签分组视图）](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191751879.png)
:::

## 学习数据库

这个数据库是我所有页面和数据库的主要入口之一，各具体项目在其子页面中逐步落地。

:::{.macbook-frame style="width:40rem;"}
![Learning 数据库总览](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191821645.png)
:::


# 彩蛋

分享 Notion 页面时链接往往很长，欢迎试用我的 [短链接生成器](/zh/tools/2026-04-06-url-shortener/) ;P
