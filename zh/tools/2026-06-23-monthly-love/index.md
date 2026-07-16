---
title: '每月情书'
author: 'Pinn Xu'
date: 2026-06-23
description: '在 Notion 中写信，发布为受密码保护的网页，一信一密。'
categories: [Web App, Next.js, Notion API]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260715184751049.webp"

order: 0
---

# 每月情书 (Monthly Love)

这是一个小巧私密的信件网站，用来给特别的人每月写一封信。信件在 **Notion** 中撰写，发布到网页后受密码保护：每封信有自己的密码，信件目录页则另有一个单独的密码。网站基于 **Next.js**、**TypeScript** 和 **Notion API** 构建。


:::{style="text-align:center;"}
[点击此处在线体验](https://monthly-loveletter.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

:::{style="text-align:center;"}
（入口密码：`missu`）
:::

:::{.macbook-frame style="width:15rem;"}
![Monthly Love](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260715183255138.webp)
:::

可以把它想象成一个极简的私人博客，每篇文章都封在自己的信封里：未解锁的页面只渲染密码输入框，在输入正确密码之前，信件正文不会从 Notion 获取，因此也不会出现在 HTML 或任何 HTTP 响应中。

## 核心功能

- **以 Notion 作为 CMS** —— 在 Notion 中写好信、勾选 *Published*，一分钟内即可在 `/p/<slug>` 上线（ISR 每 60 秒重新验证），无需重新部署。
- **一信一密** —— 每封信有独立密码，使用 `crypto.timingSafeEqual` 校验以抵御枚举攻击，未解锁的页面绝不泄露正文。
- **保持解锁** —— 信件解锁后，其 slug 会存入经签名加密的 `iron-session` cookie（有效期 30 天），再次访问无需重复输入密码。
- **丰富的信件排版** —— Notion 区块在服务端转换为 Markdown，支持 GFM 表格、任务列表、折叠块、图片和代码块，并配有带滚动定位的悬浮目录。
- **双语界面** —— 站点界面可在中英文之间切换。
- **评论回流 Notion** —— 访客评论以 Notion 原生页面评论的形式保存，回复就在写信的地方进行。
- **隐私优先** —— 所有响应均携带 `X-Robots-Tag: noindex, nofollow`，信件不会被搜索引擎收录。

## 使用方法

写一封信只需三步：

1. 在 Notion 数据库中新建页面撰写信件，填写 `Title`、`Slug`、`Password`、`Date` 和 `Excerpt` 属性。
2. 勾选 **Published** 复选框。
3. 把短链接和密码发给收信人，就这么简单。

在读者一侧，打开信件时会先看到密码输入框；解锁之后，页面会在 30 天内记住这位读者。

## 技术栈

| 层级 | 技术 |
| --- | --- |
| 框架 | Next.js 16 (App Router, Server Components, Server Actions) |
| 语言 | TypeScript |
| UI | React 19 + Tailwind CSS v4 |
| CMS | Notion API (`@notionhq/client`) |
| Markdown | notion-to-md + react-markdown |
| 会话 | iron-session |

[>> 查看 GitHub 源码](https://github.com/Pinn32/monthly-love){target="_blank"}
