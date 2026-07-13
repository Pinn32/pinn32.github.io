---
title: "Easy Canvas 无法连接解决方法"
author: 'Pinn Xu'
date: 2024-12-22
order: -20241222   # sidebar sort key: negative date => newest first
description: "Easy Canvas 无法通过 Wi-Fi 或数据线连接 Windows 电脑解决办法"
categories: [Windows, 教程]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713135350905.png"

aliases:
   - ../easy-canvas-connection/
---

# 无法通过 Wi-Fi 连接

## 检查 AMDS 和 Bonjour 服务

1. 按 Win + R 打开 “运行” 窗口；输入“ services.msc ”，点击 “确定” 打开 “服务” 窗口。

![打开 service.msc](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713125354382.png){style="width:25rem;"}

2. 检查是否存在 Apple Mobile Device Service（AMDS）、Bonjour 以及 EL Display Hub Service Application 服务，并确认它们均处于 “正在运行” 状态、启动类型为 “自动”。

:::{layout-ncol=2}
![检查 Bonjour 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130516392.png){width="70%"}

![检查 AMDS 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130818769.png){width="90%"}
:::


![检查 EL Display Hub 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131327750.png){style="width:25rem;"}

3. 如果这些服务存在但未运行，右击服务并打开 “属性”。

![打开属性](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131503624.png){style="width:20rem;"}

4. 将 “启动类型” 改成 “自动”，点击 “确定”。

![修改启动类型](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131522561.png){style="width:30rem;"}

5. 重新右击服务，点击 “重新启动”。（AMDS 服务同理）

![重启服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131622733.png){style="width:20rem;"}

## 若无 AMDS 和 Bonjour 服务：重新安装 iTunes

1. 按 Win + S 打开搜索栏，搜索 “iTunes”，查看电脑里是否已经安装了 iTunes。

![检查iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131640926.png){style="width:35rem;"}

2. 如果已安装 iTunes 但没有 AMDS 或 Bonjour 服务，就需要卸载后重新安装。打开控制面板，选择 “卸载程序”。

![卸载程序](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131736807.png){style="width:30rem;"}

3. 右击卸载 Bonjour 和 iTunes

:::{layout-ncol=2}
![卸载 Bonjour](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131827657.png){width="90%"}

![卸载 iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131846881.png){width="80%"}
:::

4. 如果在卸载列表中找不到 iTunes，按 Win 打开开始菜单，找到 iTunes 后右击卸载。

![在菜单中卸载 iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131909646.png){style="width:20rem;"}

5. 重新安装 iTunes。注意不要从 Microsoft Store 安装，而应打开[官网](https://www.apple.com.cn/itunes/)，向下找到 “需要其他版本？”，选择 “Windows”，下载 iTunes64Setup.exe 后手动安装。

![需要其他版本](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132013324.png){style="width:40rem;"}

![下载 Win iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132025674.png){style="width:35rem;"}

6. 安装完成后重新打开服务窗口，检查 AMDS 和 Bonjour 服务。



# 无法通过数据线连接的原因

无法通过数据线连接，通常是因为缺少或未启用 AMDS（Apple Mobile Device Service）和 Bonjour 两个服务。它们本应在安装 iTunes 时自动装好，但如果你卸载后又从 Microsoft Store 重装过 iTunes，就可能缺失。此时需要先卸载，再从其他渠道重新安装 iTunes。