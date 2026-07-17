---
title: "Snipaste 截图卡死在最前端解决办法"
author: 'Pinn Xu'
date: 2024-05-16
order: -20240516   # sidebar sort key: negative date => newest first
description: 'Snipaste 贴图卡死并置顶覆盖整个屏幕时的三种处理方法。'
categories: [Windows, 教程]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716195638111.png"

aliases:
    - ../snipaste-fix/
---

# 问题描述

- 操作系统：Windows 10
- Snipaste 版本：2.9.1

使用 Snipaste 截图时程序卡死，贴图置顶覆盖整个屏幕，无法关闭，也无法操作其他窗口。

:::{.macbook-frame style="width:40rem;"}
![卡死的贴图置顶覆盖整个屏幕](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194801657.png)
:::


# 方法一：结束 Snipaste 进程

利用 Snipaste 的贴图替换机制，先把全屏贴图换成小尺寸贴图，再结束进程：

1. 按 `Win + S` 唤出任务栏和搜索栏。
2. 在搜索栏内输入一两个简短的文字并复制。
3. 按 `F3` 触发贴图。新贴图（刚复制的文字）会替换掉覆盖全屏的旧贴图；它仍处于卡死状态，但尺寸小，不再遮挡屏幕。
4. 按 `Ctrl + Shift + Esc`（或右击任务栏）打开任务管理器，切换到【详细信息】，找到 `snipaste.exe`，右击结束任务。之后重新打开 Snipaste 即可正常使用。

:::{.img-frame style="width:25rem;"}
![唤出搜索栏并复制一段文字](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194858968.png)
:::

:::{.img-frame style="width:35rem;"}
![在任务管理器中结束 snipaste.exe](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194935793.png)
:::


# 方法二：重启电脑

1. 按 `Win + D`（或 `Win + S` 等其他快捷键）唤出任务栏。
2. 从任务栏关闭其他所有程序，然后重启电脑。


# 方法三：卸载重装

1. 按 `Win + D`（或其他快捷键）唤出任务栏。
2. 打开开始菜单，找到 Snipaste，右击卸载，然后重新安装。
