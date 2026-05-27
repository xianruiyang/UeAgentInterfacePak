# Connectivity Interface

---
title: "Connectivity Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/connectivity-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Connectivity Interface"]
---

# Connectivity Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Connectivity Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/connectivity-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

The **Online Services** **Connectivity Interface** provides you with tools to determine whether your game is connected to your platform's backend online services.

## API Overview

### Functions

The following table provides a high-level overview of the functions provided by the Connectivity Interface:

| Function | 说明 |
| --- | --- |
| [GetConnectionStatus](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IConnectivity/GetConnectionStatus?application_version=5.5) | Retrieve the connection status for the provided online service. |
| [OnConnectionStatusChanged](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IConnectivity/OnConnectionStat-?application_version=5.5) | The event triggered when an online service connection status changes. |

### Enumerated Classes

Online service connection status is represented by the [EOnlineServicesConnectionStatus](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/UE__Online__EOnl-?application_version=5.5) enumerated class.

#### EOnlineServicesConnectionStatus

| Value | 说明 |
| --- | --- |
| `Connected` | Connected to the online services. |
| `NotConnected` | Not connected to the online services. |

## Connection Status

`GetConnectionStatus` returns the current connection status for the provided online service. Some online services consist of multiple underlying microservices. Use the name of one of these microservices as a parameter for `GetConnectionStatus` to determine the particular microservice's connection status. If you don't specify an online service parameter, `GetConnectionStatus` returns `EOnlineServicesConnectionStatus::Connected` only if all underlying microservices are connected.

You can bind `OnConnectionStatusChanged` to events to inform you when the connection status of an online service or one of its microservices changes.

> [!NOTE]
> The organization of an online service and the accessibility of its particular microservices varies by platform. Consult your platform's online services documentation for more information.

## More Information

### Header File

Consult the `Connectivity.h` header file directly for more information as needed. The Connectivity Interface header file `Connectivity.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

For instructions on how to obtain the UE source code, see our documentation on [Downloading Unreal Engine Source Code](../../../../../get-started/install/downloading-source-code/index.md).

### Function Parameters and Return Types

Refer to the [Functions](../../overview-of-online-services/index.md#functions) section of the Online Services Overview page for an explanation of function parameters and return types, including how to pass parameters and processing the results when functions return.

