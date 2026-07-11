---
title: "VPS SSH Login Troubleshooting Log"
author: 'Pinn Xu'
date: 2026-07-11
description: 'Restored SSH access after fail2ban blocked VPS login attempts caused by outdated username configuration.'
categories: [VPS, SSH, Linux, Tips]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711132059645.png"
---

# Backgroud

> **Issue: SSH connection failed after changing the VPS username**

1. Created a temporary sudo user to change the main VPS username
2. Tried connecting to VPS through new username
3. Failed to notice that my snippet of VPS connection was still using the old username
4. Tried connecting with an incorrect/non-existent username and password
5. After multiple failed attempts, SSH access stopped working


# Troubleshooting Process

## Access VPS via Remote Console

Logged into the VPS through the provider's Remote Console and started troubleshooting locally.

:::{.macbook-frame style="width:30rem;"}
![Remote Console](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711133608987.png)
:::


## Check SSH Service Status

Check SSH status:

```bash
systemctl status ssh
```

Found that the SSH service was not running.

![SSH status](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711134501146.png){style="width:30rem;"}

Start SSH and enable it on boot:

```bash
sudo systemctl start ssh   # start
sudo systemctl enable ssh  # enable on boot
systemctl status ssh       # check status
```


## Check Firewall Configuration

Check UFW status:

```bash
ufw status
```

Confirmed that the SSH port was not blocked by UFW and ruled out firewall issues.


## Check fail2ban Ban Status

Check fail2ban service:

```bash
sudo systemctl status fail2ban
```

See my own IP locally:

```bash
curl https://api.ipify.org
```

On the remote console, see whether my IP was banned:

```bash
# Check SSH jail status:
sudo fail2ban-client status sshd
# Banned IP list: <my_ip>
```

![Check Banned IP List](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260711135815268.png){style="width:30rem;"}

Cause:

- The SSH connection snippet still used the old username after the username change
- Multiple login attempts were made with an invalid username/password
- Failed attempts exceeded the fail2ban threshold (5 attempts)
- fail2ban automatically banned my IP (ban duration: 1 hour)


## Unban My IP

Check current banned IPs:

```bash
sudo fail2ban-client status sshd
```

Remove the IP ban:

```bash
sudo fail2ban-client set sshd unbanip <my_ip>
```

Restart fail2ban if needed:

```bash
sudo systemctl restart fail2ban
```

# Final Result

- SSH service restored
- UFW confirmed not causing the issue
- Root cause identified: fail2ban blocked my IP
- SSH connection successfully restored after unbanning the IP

# Follow-up Notes

- Update the SSH connection snippet immediately after changing usernames
- Avoid repeated login attempts with incorrect usernames/passwords in a short period
- Keep a backup sudo account before modifying SSH-related settings
- Check fail2ban status as one of the first troubleshooting steps when SSH login fails