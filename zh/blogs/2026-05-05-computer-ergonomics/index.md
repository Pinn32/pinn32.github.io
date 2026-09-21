---
title: '如何更省力地玩电脑'
author: 'Pinn Xu'
date: 2026-05-05
order: -20260505   # sidebar sort key: negative date => newest first
description: '通过鼠标、触控板、按键映射和双拼输入，减少操作电脑时的移动距离并均衡双手负担。'
categories: [Mac, Windows, 效率]
image: "https://cdn.mcp32.com/img/2026/09/1790028147.png"

aliases:
  - ../computer-ergonomics/
---

# 前言

由于长期使用电脑，为了让手和手臂更舒适省力，我逐渐做了以下几项调整。**这些设置的共同目标是：缩短高频操作的移动距离，平衡双手负担，减少重复动作带来的疲劳。** 可以先观察自己最频繁、最容易疲劳的操作，再逐步调整鼠标速度、按键位置和左右手分工等。


# 使用外接鼠标, 并提高指针速度

先将电脑的光标速度调至最快，再通过外接鼠标的自定义设置 (我使用 Logi M750) 继续提高指针速度。以 Macbook 为例，比起使用妙控手势控制电脑，使用加速后的鼠标光标控制电脑更省力，其优势有：

1. 移动幅度更小，避免腱鞘炎
2. 右手肘关节不必长时间弯曲，可以随意伸展、变换姿势 (见 @fig-touchpad-vs-mouse-arm)

![触控板vs鼠标右手臂对比](https://cdn.mcp32.com/img/2026/09/1790021810.png){#fig-touchpad-vs-mouse-arm style="width:35rem;"}


# 把常用操作映射到鼠标物理快捷键

我的鼠标有四个可自定义按键，分别设置成拷贝 (Cmd+C)、粘贴 (Cmd+V)、删除 (Delete) 和创建副本 (Cmd+D)。此外，Logi Options+ 支持针对不同应用单独配置，因此在视频剪辑、绘图或音乐软件中，也可以把这些按键替换为更常用的专属快捷键。

![鼠标自定义快捷键](https://cdn.mcp32.com/img/2026/09/1790029453.png){#fig-mouse-keys style="width:20rem;"}

![软件专属快捷键](https://cdn.mcp32.com/img/2026/09/1790029501.png){#fig-mouse-custom-keys style="width:35rem;"}

还可以通过 Mac Mouse Fix 等第三方工具设置长按、双击等快捷操作，但它与 Logi Options+ 不兼容，因此我没使用。而且我的现有配置已经够用，所以暂时没有叠加更多工具。

# 左手控制触控板

MacBook 的触控板紧邻键盘。打字过程中需要短暂移动光标时，我会直接用左手操作触控板，不必把右手在键盘和鼠标之间来回移动。

外接鼠标和内置触控板并不冲突：右手负责持续、精确的指针操作，左手负责输入间隙中的快速调整。同时，身为右撇子的我用左手使用触控板，可以更好地保持双手的平衡。

<!-- ![左手使用触控板](https://cdn.mcp32.com/img/2026/09/1790019923.png){#fig-lefthand-trackpad style="width:30rem;"} -->

![左手使用触控板](https://cdn.mcp32.com/img/2026/09/1790020158.png){#fig-lefthand-trackpad style="width:30rem;"}

# 左手拇指按空格

空格键使用频率很高，作为右撇子的我，有意使用左手拇指按空格。这个调整几乎没有学习成本，却能把一部分重复动作从右手转移到左手，均衡双手的负担。

![左手拇指按空格](https://cdn.mcp32.com/img/2026/09/1790024251.png){#fig-lefthand-space style="width:30rem;"}


# 将 CapsLock 映射为 Delete

我把 CapsLock 映射为 Delete 键，这样左手小拇指无需离开主键区便能删除文字，比伸手按键盘右上角的 Delete 更省距离，也进一步减少了右手的工作量。

这是我目前感受最明显的输入优化之一，如 @fig-keyboard-heatmap 所示，Delete 键的使用频率远高于 CapsLock 键，而其位置却比 CapsLock 更靠远，且需要右手移动。对于右撇子来说，右手既要控制鼠标，又要控制键盘，本身工作量就比左手大；把 CapsLock 映射成 Delete 则可以减轻右手负担，同时提高左手的利用率。

大写字母可以通过 `Shift + 字母` 输入；与此同时我的中英文切换也设置在 Shift 上。原来的 Delete 键可以继续保留，需要向前删除时可以按 `Fn + Delete`；也可以把 Delete 键映射成 CapsLock 或者其他快捷键。

![键盘按键频率热力图](https://cdn.mcp32.com/img/2026/09/1790018907.png){#fig-keyboard-heatmap style="width:40rem;"}

![用左手控制删除键](https://cdn.mcp32.com/img/2026/09/1790024131.png){#fig-delete-with-lefthand style="width:30rem;"}

# 使用双拼输入

双拼把每个汉字的声母和韵母分别映射到一个按键。熟悉键位后，大多数拼音只需按两次，与全拼相比明显减少击键次数，也能提高中文输入速度。

![全拼vs双拼](https://cdn.mcp32.com/img/2026/09/1790022385.png){#fig-fullpinyin-vs-doublepinyin style="width:40rem;"}

以下是 **自然码双拼方案** 的键位分布。除自然码之外，还有多种双拼方案可以选择。

![自然码双拼键位 ([图源](https://shuangpin.xyz/chart/ziranma/))](https://cdn.mcp32.com/img/2026/09/1790022851.png){#fig-doublepinyin-keys style="width:40rem;"}


# 用软件快捷方式

除了硬件和按键调整，我也会使用 Raycast、应用内快捷键、macOS 自定义快捷键，以及 Automator 或「快捷指令」自动化重复操作。这些工具同样可以减少点击和键盘操作，不过更偏向软件工作流，日后有机会再单独整理成文章。

![RayCast Snippet 例子](https://cdn.mcp32.com/img/2026/09/1790024459.png){#fig-raycast-snippet-example style="width:35rem;"}

![其他自定义快捷键例子](https://cdn.mcp32.com/img/2026/09/1790024669.png){#fig-other-custom-keys-example style="width:40rem;"}

