# Online Services External UI Interface

---
title: "Online Services External UI Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/external-ui-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Online Services External UI Interface"]
---

# Online Services External UI Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Online Services External UI Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/external-ui-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

The **Online Services External UI Interface** provides access to your platform's online services external user interface. A platform-specific External UI can be useful for:

- User login
- Friends and social interaction

## API Overview

| Function | 说明 |
| --- | --- |
| [ShowLoginUI](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IExternalUI/ShowLoginUI?application_version=5.5) | Display the default online service's login UI. |
| [ShowFriendsUI](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IExternalUI/ShowFriendsUI?application_version=5.5) | Display the default online service's friends UI. |
| [OnExternalUIStatusChanged](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IExternalUI/OnExternalUIStatusChanged?application_version=5.5) | Event triggered when the external UI status changes. |

Access to the External UI interface only succeeds if the Online Services platform implementation that you are using supports the External UI interface.

## Accessing the External UI Interface

Some online services have built-in, standardized user interfaces that are displayed whenever certain operations are performed. Examples of operations that display the built-in UI might include:

- Logging in to online services
- Inviting a player to a session
- Adding a friend

These operations might bring up a game-independent form, overlay, screen, or workflow that the user must navigate to access that feature. This is generally done to ensure that certain sensitive interactions are always handled the same way, and are controlled by the company that owns the online service rather than individual, third-party developers. These features are also not standard across every online service, and in some cases, may only exist on one particular service or system. To handle these disparate features, the Online Services plugin collects them and provides the External UI Interface to interact with them.

## More Information

### Header File

See the `ExternalUI.h` header file directly for more information as needed. The External UI Interface header file `ExternalUI.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

For instructions on how to obtain the UE source code, see our documentation on [Downloading Unreal Engine Source Code](../../../../../get-started/install/downloading-source-code/index.md).

### Function Parameters and Return Types

See the [Functions](../../overview-of-online-services/index.md#functions) section of the Online Services Overview page for an explanation of function parameters and return types, including how to pass parameters and processing the results when functions return.

