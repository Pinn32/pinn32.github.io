---
title: "VPS SSH 连接失败排查"
author: 'Pinn Xu'
date: 2026-07-11
description: '因使用旧用户名配置导致多次登录失败，触发 fail2ban IP 封禁，最终恢复 VPS SSH 访问。'
categories: [VPS, SSH, Linux, 技巧]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711132059645.png"

aliases:
    - ../vps-ssh-login-troubleshooting/
---

# 背景

> **问题：修改 VPS 用户名后 SSH 连接失败**

1. 创建了一个临时 sudo 账户，修改了 VPS 的主用户名
2. 尝试用新账户重新连接 VPS
3. 没发现我的 snippet 里仍然是旧用户名
4. 用错误的/不存在的用户名和密码尝试连接
5. 多次登录失败后，SSH 无法访问


# 排查过程

## 通过远程控制台访问 VPS

通过服务商提供的远程控制台（Remote Console）登录 VPS，在本地开始排查。

:::{.macbook-frame style="width:30rem;"}
![远程控制台](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711133608987.png)
:::


## 检查 SSH 服务状态

检查 SSH 状态：

```bash
systemctl status ssh
```

发现 SSH 服务没有运行。

![SSH状态](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711134501146.png){style="width:30rem;"}

启动 SSH 并设置开机自启：

```bash
sudo systemctl start ssh   # 启动
sudo systemctl enable ssh  # 开机自启
systemctl status ssh       # 检查状态
```


## 检查防火墙配置

检查 UFW 状态：

```bash
ufw status
```

确认 SSH 端口没有被 UFW 拦截，排除了防火墙的问题。


## 检查 fail2ban 封禁状态

检查 fail2ban 服务：

```bash
sudo systemctl status fail2ban
```

在本地查看自己的 IP：

```bash
curl https://api.ipify.org
```

在远程控制台上，查看自己的 IP 是否被封禁：

```bash
# 检查 SSH jail 状态：
sudo fail2ban-client status sshd
# Banned IP list: <my_ip>
```

![查看自己 IP 是否被封](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711135815268.png){style="width:30rem;"}

原因：

- 修改用户名后，用来连接 VPS 的 snippet 仍然使用旧用户名
- 多次使用无效的用户名/密码尝试登录
- 失败次数超过了 fail2ban 的阈值（5次）
- fail2ban 自动封禁了我的 IP（封禁时长: 1小时）


## 解封我的 IP

查看当前被封禁的 IP：

```bash
sudo fail2ban-client status sshd
```

解除该 IP 的封禁：

```bash
sudo fail2ban-client set sshd unbanip <my_ip>
```

如有需要，重启 fail2ban：

```bash
sudo systemctl restart fail2ban
```

# 最终结果

- SSH 服务已恢复
- 确认 UFW 不是问题所在
- 找到根本原因：fail2ban 封禁了我的 IP
- 解封 IP 后，SSH 连接成功恢复

# 后续注意事项

- 修改用户名后，立即更新 snippets
- 避免短时间内用错误的用户名/密码反复尝试登录
- 修改 SSH 相关设置前，先保留一个备用 sudo 账户
- 检查 fail2ban 状态作为 SSH 登录失败的优先排查项
