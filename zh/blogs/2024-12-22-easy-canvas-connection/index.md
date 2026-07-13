---
title: "Easy Canvas 无法 Wi-Fi 连接解决方法"
author: 'Pinn Xu'
date: 2024-12-22
order: -20241222   # sidebar sort key: negative date => newest first
description: ""
# categories: [Windows, desktop.ini, Powershell, 电脑技巧, 解决方案]
categories: [Windows, 教程]
image: ""

aliases:
   - ../easy-canvas-connection/
---

# 无法通过数据线连接原因

如果通过数据线无法连接，可能是因为缺少或未开启 AMDS (Apple Mobile Device Service) 和 Bonjour Service 这两个服务。这两个服务应当是安装 iTunes 时自动安装的，但是如果你曾经卸载重装过 iTunes，而且是通过 Microsoft Store 重新下载的 iTunes，则可能没有这两个服务。这时需要卸载再通过其他途径重新下载 iTunes。

# 检查 AMDS 和 Bonjour 服务

1. 按 Win + R 打开 “运行” 窗口；输入“ services.msc ”，点击 “确定” 打开 “服务” 窗口。

![打开 service.msc](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713125354382.png){style="width:25rem;"}

2. 检查是否存在  Apple Mobile Device Service（AMDS）和 Bonjour ，和 EL Display Hub Service Application 服务。并检查它们是否处于 “正在运行” 状态，且启动类型 “自动”。

:::{layout-ncol=2}
![检查 Bonjour 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130516392.png){width="70%"}

![检查 AMDS 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130818769.png){width="90%"}
:::


![检查 EL Display Hub 服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131327750.png){style="width:25rem;"}

1. 如果存在这些服务，但没有正在运行，则右击服务，打开 “属性” 。

![打开属性](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131503624.png){style="width:20rem;"}

4. 将 “启动类型” 改成 “自动”，点击 “确定”。

![修改启动类型](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131522561.png){style="width:30rem;"}

5. 重新右击服务，点击 “重新启动”。（AMDS 服务同理）

![重启服务](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131622733.png){style="width:20rem;"}

# 若无 AMDS 和 Bonjour 服务：重新安装 iTunes

1. 按 Win + S 打开搜索栏，搜索 “iTunes”，查看电脑里是否已经安装了 iTunes。

![检查iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131640926.png){style="width:35rem;"}

2. 如果已经安装了 iTunes，但没有 AMDS 或 Bonjour 服务，则需要卸载并重新安装 iTunes。打开 控制面板，选择 “卸载程序”。

![卸载程序](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131736807.png){style="width:30rem;"}

3. 右击卸载 Bonjour 和 iTunes

:::{layout-ncol=2}
![卸载 Bonjour](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131827657.png){width="90%"}

![卸载 iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131846881.png){width="80%"}
:::

4. 如果卸载软件列表中没找到  iTunes，则打开开始菜单（按 Win），找到 iTunes，右击并卸载。

![在菜单中卸载 iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131909646.png){style="width:25rem;"}

5. 重新安装 iTunes。千万不要直接从 Microsoft Store 里重新安装 iTunes，而是打开[官网](https://www.apple.com.cn/itunes/)，下拉找到 “需要其他版本？”，选择 “Windows”，然后下载 iTunes64Setup.exe ，手动安装 iTunes。

![需要其他版本](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132013324.png){style="width:40rem;"}

![下载 Win iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132025674.png){style="width:35rem;"}

6. 安装好后重新打开服务，检查 AMDS 和 Bonjour 服务。

