---
title: "User Info Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/user-info-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "User Info Interface"]
---

# User Info Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / User Info Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/user-info-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

The **Online Services User Info Interface** provides you with tools to retrieve user information from an online service such as Steam or Epic Online Services for display in your game. This includes a player's:

- Platform Profile.
- Display Name.
- Avatar.

## API Overview

### Functions

The following table provides a high-level overview of the functions provided by the User Info Interface:

| Function | 说明 |
| --- | --- |
| **User Information** |  |
| [QueryUserInfo](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserInfo/QueryUserInfo?application_version=5.5) | Query user info for the list of account IDs. |
| [GetUserInfo](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserInfo/GetUserInfo?application_version=5.5) | Retrieve the user info for the account ID previously cached by `QueryUserInfo`. |
| **User Avatar** |  |
| [QueryUserAvatar](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserInfo/QueryUserAvatar?application_version=5.5) | Query user avatars for the list of account IDs. |
| [GetUserAvatar](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserInfo/GetUserAvatar?application_version=5.5) | Retrieve the user avatar for the account ID previously cached by `QueryUserAvatar`. |
| **Platform UI** |  |
| [ShowUserProfile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserInfo/ShowUserProfile?application_version=5.5) | Show the profile UI for the provided account ID. |

## Access User Info

Accessing user information with the User Info Interface works similarly to the other [Online Services Interfaces](../index.md).

`QueryUserInfo` caches the list of user display names associated with their corresponding account ID with the interface. `QueryUserInfo` requires you to provide the list of user account IDs for which you want to access display names as parameters. To access each user's display name, call `GetUserInfo` using their account ID.

## Access User Avatar

The workflow defined in the [Access User Info](index.md) section applies to accessing a user's avatar as well. `QueryUserAvatar` caches the information with the interface. `GetUserAvatar` retrieves each avatar individually.

## Platform User Profile

`ShowUserProfile` brings up the platform service's profile user interface for the provided user. Platform service profiles are specific to the platform on which the user is currently playing your game. Consult your platform service's documentation for more information on the profile user interface.

## More Information

### Header File

Consult the `UserInfo.h` header file directly for more information as needed. The User Info Interface header file `UserInfo.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

For instructions on how to obtain the UE source code, see our documentation on [Downloading Unreal Engine Source Code](../../../../../get-started/install/downloading-source-code/index.md).

### Function Parameters and Return Types

See the [Functions](../../overview-of-online-services/index.md#functions) section of the Online Services Overview page for an explanation of function parameters and return types, including how to pass parameters and how to process the results when functions return.
