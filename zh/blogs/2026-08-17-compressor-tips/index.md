---
title: "Mac Compressor 视频压缩与格式转换"
author: 'Pinn Xu'
date: 2026-08-17
order: -20260817   # sidebar sort key: negative date => newest first
description: '快速掌握 Apple Compressor 的格式转换、视频压缩与音量调节。'
categories: [Mac, 软件, 教程]
image: ""

aliases:
    - ../compressor-tips/
---

# 更改视频格式为 MP4

1. 打开左侧 panel
2. 点击底部 “+” 号, 增加新 “Preset”
3. 选择 MPEG-4 格式
4. 后续使用时, 在 Preset 菜单中选择 Custom > MPEG-4 即可

![添加新自定义预设 (MPEG-4)](https://cdn.mcp32.com/img/2026/09/1790011046.png){style="width:20rem;"}


# 压缩视频大小, 但保证质量

1. 选中要压缩的视频任务
2. 打开右侧 Panel, 选择 Video
3. 找到 Avg. Bit Rate 选择 Custom
4. 降低比特率数值, 同时查看 Estimated File Size, 直到文件大小和画质都符合期望

:::{.macbook-frame style="width:40rem;"}
![压缩文件大小同时保证视频质量](https://cdn.mcp32.com/img/2026/09/1790011356.png)
:::


# 调节视频音量

1. 选中要调整音量的视频任务
2. 打开右侧 Panel, 选择 Audio
3. 选择 Add Audio Effect, 选择 Dynamic Range
4. 调节 Overall Gain (0是初始音量, 正值升高音量, 负值降低音量)

:::{.macbook-frame style="width:35rem;"}
![调节视频音量](https://cdn.mcp32.com/img/2026/09/1790011543.png)
:::
