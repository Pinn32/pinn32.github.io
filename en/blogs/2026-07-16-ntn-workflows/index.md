---
title: "Notion Database Workflows"
author: 'Pinn Xu'
date: 2026-07-16
order: -20260716   # sidebar sort key: negative date => newest first
description: 'My automatic workflows with Notion databases.'
categories: [Notion, Database, Tips]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716134621505.png"

aliases:
    - ../ntn-workflows/
---

# Project Progress Auto-Tracking Workflow

This workflow records project progress with minimal effort. Three types of linked databases do the work: Tasks → Progress → Projects. I log tasks through Notion Calendar, the data populate automatically, and external applications can read the results through the Notion API.

For example, I use this workflow to track the development of this website. [Notion Database Auto-Sync Tips](/en/blogs/ntn-db-auto-sync/) explains how the sync is built, and the [Quarto Website page on Notion](https://app.notion.com/p/394a25f9fecd80b88fadc11537fb59b0) shows the live databases.

<!-- flowchart -->
![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260712014431241.svg){.light-content}
![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260712014457180.svg){.dark-content}
<!-- flowchart -->

I log individual tasks in the Task database ("Quarto Dev Track") through Notion Calendar. Daily progress is aggregated into the Progress database ("Quarto Change Log") by Rollup and Formula properties, and synced to external applications (this website as an example) via the Notion API. The Project database ("All Projects") shows every project's progress and key statistics in one place.

:::{.macbook-frame style="width:40rem;"}
![All Projects Database Overview](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191552656.png)
:::


# Notion Database as CMS

Monthly Love is a web project of mine that uses a Notion database as its Content Management System (CMS). The app is built with Next.js, TypeScript, and the Notion API, with the help of Claude Code. The setup happens once; after that, all content management happens in the Notion UI.

The code is on GitHub at [Pinn32/monthly-love](https://github.com/Pinn32/monthly-love), and a live demo runs at [monthly-loveletter.vercel.app](https://monthly-loveletter.vercel.app/) (portal passcode `missu`; sample pages passcode `123`).

:::{.macbook-frame style="width:40rem;"}
![Monthly Love Database: Notion as CMS](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716192021172.png)
:::


# Course Assignment Dashboards

I manage each term's courses with a dashboard page in Notion. Each dashboard tracks progress in real time, integrates with Notion Calendar, calculates grades automatically, and ends the term with reflections, charts, and insights.

View live dashboard at: [2026 Spring Course Dashboard](https://app.notion.com/p/3232/2026-Spring-Course-Dashboard-2e8a25f9fecd8075a3d1d5e4dc0df493)

:::{.macbook-frame style="width:40rem;"}
![Dashboard Preview: Statistics & Charts](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191715075.png)
:::


# Other Notion Databases

As an active Notion user, I have built several databases to organize different parts of my daily life. Here are some examples.

## Auto-Pay Database

This database manages my recurring subscriptions. After a one-time setup, automations track renewals and send timely reminders.

:::{.macbook-frame style="width:40rem;"}
![Auto-Pay Tracking Database with Automations](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191645135.png)
:::

## Journal Database

This database captures my daily progress, key lessons learned, self-reflections, and personal experiences.

:::{.macbook-frame style="width:40rem;"}
![Journal Database (Tag Groups View)](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191751879.png)
:::

## Learning Database

This database is one of the main portals to all my pages and databases. I expand and put ideas into practice in its sub-pages.

:::{.macbook-frame style="width:40rem;"}
![Learning Database Overview](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716191821645.png)
:::


# Bonus

When sharing Notion pages, the URL may be too long. Try my [URL Shortener](/en/tools/2026-04-06-url-shortener/) ;P.

