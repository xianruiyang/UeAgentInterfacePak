# Title File Interface

---
title: "Title File Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/title-file-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "Title File Interface"]
---

# Title File Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / Title File Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/title-file-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

The **Online Services Title File Interface** provides support for your game to read files from your platform's backend online services at runtime.

Your game might require reading files not packaged with your title. The title file interface provides you with tools to read files that you have uploaded to backend online services. Examples of such information might include configuration files or a message of the day. This interface helps you to access and download these files for use at runtime.

For player-specific file storage, see the [User File Interface](../user-file-interface/index.md).

## API Overview

### Functions

The following table provides a high-level overview of the functions provided by the Title File Interface:

| Function | 说明 |
| --- | --- |
| [EnumerateFiles](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ITitleFile/EnumerateFiles?application_version=5.5) | Enumerate all available files. |
| [GetEnumeratedFiles](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ITitleFile/GetEnumeratedFiles?application_version=5.5) | Retrieve a cached list of files enumerated by a call to `EnumerateFiles`. |
| [ReadFile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/ITitleFile/ReadFile?application_version=5.5) | Read a file and return its contents. |

## Process Flow

To read a file from the backend online services with the Title File Interface, follow these steps:

1. `EnumerateFiles` asynchronously caches a list of all files available to retrieve from the online services with the interface.
2. `GetEnumeratedFiles` retrieves the list of files cached with the interface by `EnumerateFiles`.
3. For each file in the retrieved list, `ReadFile` reads the file asynchronously and returns its contents for use in your game.

## More Information

### Header File

Consult the `TitleFile.h` header file directly for more information as needed. The Title File Interface header file `TitleFile.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

For instructions on how to obtain the UE source code, see our documentation on [Downloading Unreal Engine Source Code](../../../../../get-started/install/downloading-source-code/index.md).

### Function Parameters and Return Types

See the [Functions](../../overview-of-online-services/index.md#functions) section of the Online Services Overview page for an explanation of function parameters and return types, including how to pass parameters and processing the results when functions return.

