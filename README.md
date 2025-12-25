# Beszel Agent for OpenWrt

Lightweight server monitoring agent packaged for OpenWrt routers and devices.

[Beszel](https://github.com/henrygd/beszel) is a lightweight server monitoring hub with historical data, docker stats, and alerts. This repository provides pre-built IPK packages for easy installation on OpenWrt.

## Installation

### 1. Find Your Architecture

Check your device architecture:

```sh
opkg print-architecture | awk 'BEGIN {max=0} {if ($3 > max) {max = $3; arch = $2}} END {print arch}'
```

### 2. Download Package

Download the appropriate IPK from [Releases](../../releases) page.

Or directly via wget:

```sh
wget https://github.com/vernette/beszel-agent-openwrt/releases/download/vX.X.X-24.10/beszel-agent_X.X.X-1_YOUR_ARCH.ipk
```

> [!NOTE]
> Replace `X.X.X` with the version number and `YOUR_ARCH` with your device architecture

### 3. Install

```sh
opkg install beszel-agent_*.ipk
```

## Configuration

Edit the configuration file:

```sh
vi /etc/config/beszel-agent # or nano
```

Configuration options:

```
config agent 'agent'
  option enabled '1' # enable agent
  option port '45876' # port for hub connection
  option public_key 'YOUR_PUBLIC_KEY_HERE' # public key from hub
```

Get your authentication key from the Beszel hub when adding a new system.

## Links

- [Beszel Project](https://github.com/henrygd/beszel)
- [Beszel Documentation](https://beszel.dev/)
