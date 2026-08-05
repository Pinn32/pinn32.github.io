---
title: '短链接生成器'
author: 'Pinn Xu'
date: 2026-04-06
description: '无需登录即可创建自定义短链接；登录后还能保存、编辑、导出和管理链接。'
categories: [Web App, Next.js, MongoDB, OAuth]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png"
order: 2
aliases:
    - ../url-shortener/
---

# 短链接生成器 (URL Shortener)

URL Shortener 可以把长网址转换成带有自定义后缀的短链接。无需注册即可直接使用；通过 Google 登录后，新建的链接会保存到个人账户中，之后可以集中管理。

:::{style="text-align:center;"}
[点击此处在线体验](https://url-to.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

<!-- :::{.macbook-frame style="width:35rem;"}
![URL Shortener](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png)
::: -->

:::{style="max-width:40rem; margin:0 auto;"}
{{<video /src/video/tools/2026-07-22-url-shortener-demo.mov title="URL Shortener Demo">}}
:::

短链接是长网址的精简版本，分享时占用的篇幅更少，也更容易记住。自定义后缀（slug）还能让链接的含义一目了然，例如 `url-to.vercel.app/my-portfolio`，不必使用随机生成的字符串。

## 功能介绍

- **自定义短链接**：为目标网址设置一个自己容易记住的后缀。
- **免登录使用**：不注册账户也能创建可正常访问的短链接。
- **直接跳转**：打开短链接后，浏览器会直接前往原始网址。
- **Google 登录**：通过 Auth.js 和 Google OAuth 完成身份验证。
- **按账户保存**：登录状态下创建的链接会自动加入「我的短链接」（**Your shortened URLs**）列表。
- **编辑链接**：修改已保存链接的后缀，并添加不超过 10 个单词的说明。
- **查看时间**：编辑链接时可查看创建日期和最后修改日期。
- **删除链接**：确认后可删除账户中的链接。
- **导出 JSON**：将账户中的全部链接下载为 JSON 文件，也可以直接复制 JSON 到剪贴板。
- **修改显示名称**：系统会根据 Gmail 地址生成初始用户名，你也可以改成希望显示在页面顶部的名称。
- **持久化跳转**：链接映射保存在 MongoDB 中，创建后的短链接可以持续使用。

## 创建短链接

1. 输入完整的目标网址，包括 `https://`：

   ```text
   https://example.com/your/very/long/url/
   ```

2. 设置短链接后缀。生成后的链接格式如下：

   ```text
   https://url-to.vercel.app/your-slug
   ```

3. 点击 **Click to Compact**。生成的短链接可以直接复制和分享，访问者打开后会跳转到目标网址。

## 游客模式与登录模式

短链接生成功能无需登录。游客创建的链接仍会正常跳转，但不会关联到任何账户，因此不会出现在链接管理列表中。

如果需要保存和管理新链接，请先通过 Google 登录。登录后创建的链接都会加入「我的短链接」（**Your shortened URLs**）。

## 管理已保存的链接

在「我的短链接」中选择一条记录，可以进行以下操作：

- 修改链接后缀；
- 添加或修改说明，最多 10 个单词；
- 查看创建日期和最后修改日期；
- 确认后删除链接。

如需备份或另作处理，可以把账户中的全部链接下载为 JSON 文件，也可以将 JSON 直接复制到剪贴板。

在「我的账户」（**Your account**）中点击 **Edit username**，可以修改页面顶部显示的名称。初始用户名来自登录时使用的 Gmail 地址。

## 技术栈

| 部分 | 技术 |
| --- | --- |
| 框架 | Next.js 16（App Router） |
| 前端界面 | React 19 + styled-components |
| 身份验证 | Auth.js + Google OAuth |
| 账户数据 | Auth.js MongoDB adapter |
| 数据库 | MongoDB |
| 字体 | 通过 `next/font` 加载 Quantico |

[>> 查看 GitHub 源码](https://github.com/Pinn32/url-shortener){target="_blank"}
