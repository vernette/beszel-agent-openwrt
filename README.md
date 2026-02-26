# Beszel Agent for OpenWrt

Lightweight server monitoring agent packaged for OpenWrt routers and devices.

[Beszel](https://github.com/henrygd/beszel) is a lightweight server monitoring hub with historical data, docker stats, and alerts. This repository provides pre-built IPK/APK packages for easy installation on OpenWrt.

## Installation

Check your device architecture:

```sh
grep DISTRIB_ARCH /etc/openwrt_release | cut -d"'" -f2
```

Download the appropriate package from the [Releases](../../releases) page.

Or directly via wget:

```sh
# opkg
wget -O beszel-agent.ipk https://github.com/vernette/beszel-agent-openwrt/releases/download/vX.X.X/beszel-agent_X.X.X-r1_YOUR_ARCH.ipk
```

```sh
# apk
wget -O beszel-agent.apk https://github.com/vernette/beszel-agent-openwrt/releases/download/vX.X.X/beszel-agent-X.X.X-r1_YOUR_ARCH.apk
```

> [!NOTE]
> Replace `X.X.X` with the version number and `YOUR_ARCH` with your device architecture

Install the package depending on your package manager:

```sh
# opkg
opkg install beszel-agent*.ipk
```

```sh
# apk
apk add --allow-untrusted beszel-agent*.apk
```

> [!NOTE]
> `--allow-untrusted` is required because the package is not signed with an OpenWrt key

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

  # if you want to use the outbound Websockets connection, you
  # also need to specify the `hub_url` and `token` options
  # (see https://beszel.dev/guide/security for details)
  option hub_url 'https://YOUR_BESZEL_HUB_URL_HERE'
  option token 'YOUR_AGENT_TOKEN_HERE'
```

Get your authentication key (and agent token, if necessary) from the Beszel hub when adding a new system.

## Links

- [Beszel Project](https://github.com/henrygd/beszel)
- [Beszel Documentation](https://beszel.dev/)
