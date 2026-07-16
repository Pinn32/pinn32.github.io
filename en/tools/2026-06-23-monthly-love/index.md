---
title: 'Monthly Love'
author: 'Pinn Xu'
date: 2026-06-23
description: 'Write letters in Notion and publish them as password-protected pages, one password per letter.'
categories: [Web App, Next.js, Notion API]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260715184751049.webp"

order: 0
---

# Monthly Love

This is a tiny, private letter site for sending monthly letters to someone special. Letters are written in **Notion** and published to the web as password-protected pages: one password per letter, plus a separate password for the index of all letters. It was developed with **Next.js**, **TypeScript**, and the **Notion API**.


:::{style="text-align:center;"}
[Click Here to Try](https://monthly-loveletter.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

:::{style="text-align:center;"}
(portal passcode: `missu`)
:::

:::{.macbook-frame style="width:15rem;"}
![Monthly Love](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260715183255138.webp)
:::

Think of it as a minimal, personalized blog where every post is sealed in its own envelope: a locked page renders only the password form, and the letter body is never fetched from Notion until the right password is entered, so it never appears in the HTML or any HTTP response.

## Key Features

- **Notion as the CMS** — write a letter in Notion, check the *Published* box, and it goes live at `/p/<slug>` within a minute (ISR revalidates every 60 seconds), without a redeploy.
- **One password per letter** — each letter has its own password, verified with `crypto.timingSafeEqual` to resist enumeration attacks. Locked pages never leak the article body.
- **Stay unlocked** — once a letter is opened, its slug is stored in a signed and encrypted `iron-session` cookie (30-day lifetime), so returning readers aren't asked again.
- **Rich letter content** — Notion blocks are converted to Markdown server-side and rendered with GFM tables, task lists, toggles, images, and code blocks, plus a floating table of contents with scroll-spy.
- **Bilingual interface** — the site chrome switches between English and 中文.
- **Comments back into Notion** — visitor comments are stored as native Notion page comments, so replies land right where the letters are written.
- **Private by design** — every response carries `X-Robots-Tag: noindex, nofollow`, so letters stay out of search engines.

## How It Works

Writing a letter is the whole workflow:

1. Draft the letter as a page in a Notion database with `Title`, `Slug`, `Password`, `Date`, and `Excerpt` properties.
2. Check the **Published** checkbox.
3. Share the short link and the password with your reader — that's it.

On the reader's side, the letter opens with a password prompt. After unlocking, the page remembers them for 30 days.

## Tech Stack

| Layer | Technology |
| --- | --- |
| Framework | Next.js 16 (App Router, Server Components, Server Actions) |
| Language | TypeScript |
| UI | React 19 + Tailwind CSS v4 |
| CMS | Notion API (`@notionhq/client`) |
| Markdown | notion-to-md + react-markdown |
| Sessions | iron-session |

[>> View source on GitHub](https://github.com/Pinn32/monthly-love){target="_blank"}
