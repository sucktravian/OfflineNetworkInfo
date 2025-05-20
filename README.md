# OfflineNetworkInfo

Retrieve static network settings directly from the Windows registry, even when the system is offline and tools like `ipconfig` or `Get-NetIPConfiguration` are unavailable.

## Features

- Lists interface name, IP address, subnet mask, gateway, and DNS servers.
- Supports systems even when disconnected from the network.
- Useful in recovery or forensic environments.

## Installation

You can install the module directly from the PowerShell Gallery:

```powershell
Install-Module -Name OfflineNetworkInfo
