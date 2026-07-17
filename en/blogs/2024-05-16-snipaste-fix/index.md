---
title: "Fix Snipaste Stuck on Top of the Screen"
author: 'Pinn Xu'
date: 2024-05-16
order: -20240516   # sidebar sort key: negative date => newest first
description: 'Three ways to handle a frozen Snipaste paste that pins itself over the whole screen.'
categories: [Windows, Tutorial]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716195638111.png"

aliases:
    - ../snipaste-fix/
---

# The Problem

- Operating system: Windows 10
- Snipaste version: 2.9.1

Snipaste froze while taking a screenshot. The paste pinned itself over the entire screen and could not be closed, and it blocked every other window.

:::{.macbook-frame style="width:40rem;"}
![The Frozen Paste Pinned over the Entire Screen](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194801657.png)
:::


# Method 1: Kill the Snipaste Process

This takes advantage of how Snipaste replaces pastes: swap the full-screen paste for a small one first, then end the process.

1. Press `Win + S` to bring up the taskbar and the search bar.
2. Type one or two short words in the search box and copy them.
3. Press `F3` to paste. The new paste (the text you just copied) replaces the old full-screen one. It is still frozen, but small enough to leave the rest of the screen usable.
4. Press `Ctrl + Shift + Esc` (or right-click the taskbar) to open Task Manager, switch to the Details tab, find `snipaste.exe`, right-click it, and end the task. Reopen Snipaste afterwards and it works normally.

:::{.img-frame style="width:25rem;"}
![Bring Up the Search Bar and Copy Some Text](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194858968.png)
:::

:::{.img-frame style="width:35rem;"}
![End snipaste.exe in Task Manager](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260716194935793.png)
:::


# Method 2: Restart the Computer

1. Press `Win + D` (or another shortcut such as `Win + S`) to bring up the taskbar.
2. Close all other programs from the taskbar, then restart the computer.


# Method 3: Uninstall and Reinstall

1. Press `Win + D` (or another shortcut) to bring up the taskbar.
2. Open the Start menu, find Snipaste, right-click to uninstall, then install it again.
