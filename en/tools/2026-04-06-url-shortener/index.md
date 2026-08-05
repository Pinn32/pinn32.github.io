---
title: 'URL Shortener'
author: 'Pinn Xu'
date: 2026-04-06
description: 'Create custom short links as a guest, or sign in to save, edit, export, and manage them.'
categories: [Web App, Next.js, MongoDB, OAuth]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png"
order: 2
aliases:
    - ../url-shortener/
---

# URL Shortener

URL Shortener turns long web addresses into compact, shareable links with custom slugs. You can create a link immediately as a guest, or sign in with Google to save and manage links under your account.

:::{style="text-align:center;"}
[Click Here to Try](https://url-to.vercel.app/){.btn .btn-outline-primary target="_blank"}
:::

<!-- :::{.macbook-frame style="width:35rem;"}
![URL Shortener](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260623194155759.png)
::: -->

:::{style="max-width:40rem; margin:0 auto;"}
{{<video /src/video/tools/2026-07-22-url-shortener-demo.mov title="URL Shortener Demo">}}
:::

A short link is a compact version of a long web address. It saves space, looks cleaner when shared, and is easier to remember. A custom slug also gives the link a meaningful ending, such as `url-to.vercel.app/my-portfolio`, instead of an arbitrary sequence of characters.

## Key Features

- **Custom short links** — pair a long destination URL with a memorable slug that you choose.
- **Guest access** — create a working short link without registering or signing in.
- **Instant redirects** — send anyone who opens the short link directly to its original destination.
- **Google sign-in** — authenticate securely through Google OAuth with Auth.js.
- **Account-based storage** — automatically save links created while signed in and view them together in **Your shortened URLs**.
- **Link editing** — change the slug of a saved link and add an optional description of up to 10 words.
- **Link details** — see when a saved link was created and when it was last edited.
- **Link deletion** — remove an account-owned link after confirming the action.
- **JSON export** — download all links saved to your account as JSON or copy the JSON directly to the clipboard.
- **Editable profile name** — use the username initially derived from your Gmail address, or replace it with the name you want displayed in the app header.
- **Persistent redirects** — short-link mappings are stored in MongoDB so created links continue to resolve.

## Create a Short Link

1. Enter the complete destination URL, including `https://`:

   ```text
   https://example.com/your/very/long/url/
   ```

2. Choose the custom slug that will appear after the app's domain:

   ```text
   https://url-to.vercel.app/your-slug
   ```

3. Select **Click to Compact**. The generated short link is ready to share and redirects visitors to the destination URL.

## Guest and Account Modes

You can use the core shortening feature as a guest. Guest-created links continue to redirect normally, but they are not associated with an account and therefore do not appear in the saved-link manager.

To keep and manage new links, sign in with Google before creating them. Every link you create while signed in is added to **Your shortened URLs**.

## Manage Saved Links

From **Your shortened URLs**, select a saved item to:

- change its slug;
- add or revise an optional description of up to 10 words;
- review its creation and last-edited dates; or
- delete it after a confirmation prompt.

To back up or reuse your link data, download all account-specific saved URLs as a JSON file or copy the JSON to your clipboard.

Under **Your account**, select **Edit username** to change the name displayed in the app header. The initial username is derived from the Gmail address connected to your Google login.

<!-- :::{.macbook-frame style="width:40rem;"}
![Manage Saved Links](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260722124055952.png)
::: -->

## Technology

| Area | Technology |
| --- | --- |
| Framework | Next.js 16 with the App Router |
| UI | React 19 + styled-components |
| Authentication | Auth.js with Google OAuth |
| Account persistence | Auth.js MongoDB adapter |
| Database | MongoDB |
| Typography | Quantico through `next/font` |

[>> View source on GitHub](https://github.com/Pinn32/url-shortener){target="_blank"}
