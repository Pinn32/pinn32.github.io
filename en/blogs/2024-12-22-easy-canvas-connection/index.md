---
title: "Fixing Easy Canvas Connection Problems"
author: 'Pinn Xu'
date: 2024-12-22
order: -20241222   # sidebar sort key: negative date => newest first
description: "How to fix Easy Canvas failing to connect to a Windows PC over Wi-Fi or a USB cable."
categories: [Windows, Tutorial]
image: "https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713135350905.png"

aliases:
   - ../easy-canvas-connection/
---

# Can't Connect Over Wi-Fi

## Check the AMDS and Bonjour Services

1. Press Win + R to open the Run dialog, type `services.msc`, and click OK to open the Services window.

![Open services.msc](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713125354382.png){style="width:25rem;"}

2. Check that the Apple Mobile Device Service (AMDS), Bonjour, and EL Display Hub Service Application services are present, and confirm each one is Running with its startup type set to Automatic.

:::{layout-ncol=2}
![Check the Bonjour service](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130516392.png){width="70%"}

![Check the AMDS service](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713130818769.png){width="90%"}
:::


![Check the EL Display Hub service](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131327750.png){style="width:25rem;"}

3. If a service is present but not running, right-click it and open Properties.

![Open Properties](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131503624.png){style="width:20rem;"}

4. Set Startup type to Automatic and click OK.

![Change the startup type](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131522561.png){style="width:30rem;"}

5. Right-click the service again and choose Restart. (Do the same for AMDS.)

![Restart the service](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131622733.png){style="width:20rem;"}

## If the AMDS and Bonjour Services Are Missing: Reinstall iTunes

1. Press Win + S to open search, search for iTunes, and check whether it's already installed.

![Check for iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131640926.png){style="width:35rem;"}

2. If iTunes is installed but the AMDS or Bonjour services are missing, uninstall it and reinstall. Open Control Panel and choose Uninstall a program.

![Uninstall a program](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131736807.png){style="width:30rem;"}

3. Right-click to uninstall both Bonjour and iTunes.

:::{layout-ncol=2}
![Uninstall Bonjour](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131827657.png){width="90%"}

![Uninstall iTunes](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131846881.png){width="80%"}
:::

4. If you can't find iTunes in the uninstall list, press Win to open the Start menu, find iTunes, and right-click to uninstall it.

![Uninstall iTunes from the Start menu](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713131909646.png){style="width:20rem;"}

5. Reinstall iTunes. Don't install it from the Microsoft Store; instead, open the [official site](https://www.apple.com/itunes/), scroll down to "Looking for other versions?", choose Windows, download iTunes64Setup.exe, and install it manually.

![Looking for other versions](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132013324.png){style="width:40rem;"}

![Download iTunes for Windows](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260713132025674.png){style="width:35rem;"}

6. After installing, reopen the Services window and check the AMDS and Bonjour services.



# Why the USB Cable Connection Fails

A cable connection usually fails because the AMDS (Apple Mobile Device Service) and Bonjour services are missing or disabled. They're meant to install automatically along with iTunes, but if you've ever uninstalled iTunes and reinstalled it from the Microsoft Store, they may be gone. When that happens, uninstall iTunes and reinstall it from another source.
