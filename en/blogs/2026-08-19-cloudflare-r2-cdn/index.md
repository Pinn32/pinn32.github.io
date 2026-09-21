---
title: "Don't Assume It's Hard: From Git LFS to Cloudflare R2"
author: 'Pinn Xu'
date: 2026-08-19
order: -20260819
description: 'Lessons from moving a website media library to Cloudflare R2: identifying the wrong abstraction, testing alternatives, and building a separate media workflow.'
categories: [Web, Reflection]
image: "https://cdn.mcp32.com/img/2026/09/1790016460.png"

aliases:
    - ../cloudflare-r2-cdn/
---

# Introduction

I used to keep all the images and videos for my personal website in the repository's `src` directory. That was convenient when there were only a few files. Once the media library grew to one or two gigabytes, however, the repository became unwieldy. Pushes slowed down, builds and deployments took longer, and `quarto publish gh-pages` repeatedly stalled near the end.

The problem was clear: large media files should not ship with the source code. What slowed me down was my assumption that setting up object storage and a CDN would be difficult. Instead of testing that assumption, I tried several alternatives that appeared easier.

# The detour: using Git for media hosting

I first considered Git LFS and GitHub Releases. Both keep large files out of regular Git history, but they solve large-file management for code repositories, not static asset delivery for websites.

To avoid cloning an already large media repository, I used GitHub Codespaces to organize the files in the cloud and enabled LFS tracking for the entire `video/` directory. Codespaces worked well, and the upload succeeded. But LFS object URLs are a poor fit for stable, public web media: their access patterns and bandwidth model differ from those of a CDN.

I also tried GitHub's web uploader and unlisted YouTube videos. The web uploader imposed file-size and batch-operation limits. YouTube added a heavier upload and embedding workflow, provided little control over the player, and was not reliably accessible in every region I wanted to support.

These experiments made the architectural problem obvious. Tweaking the Git workflow would not turn a source repository into a media delivery system.

# The right fit: R2 object storage and a custom domain

Once I opened Cloudflare R2 and tried it, the setup was simpler than I had expected. I created a `media` bucket, organized the files under `img/` and `video/`, and connected the bucket to `cdn.sample.com`, a subdomain of an existing domain. The website could then reference each asset through an independent URL:

```txt
https://cdn.sample.com/img/example.webp
https://cdn.sample.com/video/example.mp4
```

The resulting separation is straightforward:

```txt
Source repository: Markdown, Quarto configuration, CSS, JavaScript
R2 bucket: images, audio, video
Custom domain: stable media URLs for the website
```

With the large files removed, the repository stayed lightweight and deployments no longer copied the entire media library. The assets also gained an upload and delivery path independent of Git history. I later connected R2 to PicGo through its API, bringing upload and URL generation into my regular writing workflow.

# Completing the media-processing workflow

Moving the files solved the storage problem, but oversized source files still made uploads and page loads slower. Online compressors are convenient for the occasional file, yet their file-size limits and weak batch support make them unreliable for a recurring workflow. They also offer little control over bit rate, image quality, and audio levels.

I returned to Apple Compressor and learned the few settings I actually needed: output format, bit rate, and audio gain. That was enough to convert files in batches, estimate output sizes, and normalize volume. The interface has a higher initial learning cost, but its control and consistency make repeated work cheaper. I documented the settings separately in [Convert and Compress Video with Apple Compressor](../2026-08-17-compressor-tips/).

The complete workflow now looks like this:

```txt
Source media → batch processing in Compressor → upload to R2 with PicGo → add the CDN URL to the article
```

# Retrospective: solve the problem, not the workaround

The detour happened because I investigated the options in the wrong order. I assumed that a CDN would be hard to configure, then used Git LFS, Releases, and a video platform to avoid it. Each choice made sense in isolation, but together they drifted away from the original need. The website required media storage and delivery, not another large-file version-control workflow.

Next time, I will first separate source management, file storage, and content delivery. Then I will run a small experiment with the tool designed for the job. If a workaround starts to require another workaround, that is a good time to revisit the problem definition instead of refining the temporary solution.

That is what “don't assume it's hard” means to me. A technology may genuinely be difficult, but I should open the tool, read the documentation, and run a low-cost test before deciding. Fear based on an untested assumption can add more complexity than the technology itself.

# Afterword: rediscovering the joy of tinkering

After configuring R2, I kept exploring its API. I connected the media library to PicGo and linked compression, upload, and URL generation into one workflow. Working in the terminal, reading documentation, calling an API, configuring a domain, and finally watching several independent tools work together brought back a feeling I had missed: the excitement of investigating computers simply because I was curious.

When technical learning becomes tied to courses, projects, and job hunting, it is easy to expect every hour of study to produce a measurable outcome. The way I enjoy learning is more direct. I start with something I want to make, then learn each piece of technology as the problem demands it.

This project followed that pattern. It began with “my website's media files are too large” and naturally led to Git LFS, Codespaces, object storage, CDNs, custom domains, media encoding, and APIs. None of these formed a planned curriculum. They were connected parts of one real problem. Curiosity did not make the work unfocused; a clear problem gave the exploration its boundaries.

The lesson I am keeping is simple: do not invent difficulty before testing it, and do not spend more effort maintaining a workaround than solving the original problem. Define the need first, then try the solution that fits it most directly.
