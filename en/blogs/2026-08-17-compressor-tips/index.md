---
title: "Convert and Compress Video with Apple Compressor"
author: 'Pinn Xu'
date: 2026-08-17
order: -20260817   # sidebar sort key: negative date => newest first
description: 'Use Apple Compressor to convert video to MP4, reduce file size, and adjust audio volume.'
categories: [Mac, Software, Tips]
image: "https://cdn.mcp32.com/img/2026/09/1790014258.png"

aliases:
    - ../compressor-tips/
---

# Convert a video to MP4

1. Open the panel on the left.
2. Click the `+` button at the bottom to create a custom preset.
3. Select `MPEG-4` as the format.
4. To reuse the preset, select `Custom > MPEG-4` from the Presets menu.

![Add New Custom Preset (MPEG-4)](https://cdn.mcp32.com/img/2026/09/1790011046.png){style="width:20rem;"}


# Reduce file size while preserving quality

1. Select the video job that you want to compress.
2. Open the panel on the right and select `Video`.
3. Under `Avg. Bit Rate`, select `Custom`.
4. Lower the bit rate while monitoring `Estimated File Size`. Adjust it until the file size and visual quality meet your requirements.

:::{.macbook-frame style="width:40rem;"}
![Compress File Size with High Quality](https://cdn.mcp32.com/img/2026/09/1790011356.png)
:::


# Adjust the audio volume

1. Select the video job whose volume you want to change.
2. Open the panel on the right and select `Audio`.
3. Select `Add Audio Effect > Dynamic Range`.
4. Adjust `Overall Gain`. A value of `0` preserves the original volume; positive values increase it, and negative values decrease it.

:::{.macbook-frame style="width:35rem;"}
![Adjust Video Volume](https://cdn.mcp32.com/img/2026/09/1790011543.png)
:::
