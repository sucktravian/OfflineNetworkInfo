# OfflineNetworkInfo

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/OfflineNetworkInfo.svg?label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/OfflineNetworkInfo)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PowerShell: 5.1+](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://docs.microsoft.com/en-us/powershell/)


Retrieve static network settings directly from the Windows registry, even when the system is offline and tools like `ipconfig` or `Get-NetIPConfiguration` are unavailable.
---
## Features

- Lists interface name, IP address, subnet mask, gateway, and DNS servers.
- Supports systems even when disconnected from the network.
- Useful in recovery or forensic environments.

---
## Installation

You can install the module directly from the PowerShell Gallery:

```powershell
Install-Module -Name OfflineNetworkInfo
Get-OfflineNetworkConfig
