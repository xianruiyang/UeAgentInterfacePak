---
title: "User File Interface"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/user-file-interface-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "在线服务", "在线服务接口", "User File Interface"]
---

# User File Interface

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 在线服务 / 在线服务接口 / User File Interface

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/user-file-interface-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

The **Online Services User File Interface** provides support for your game to read user-specific files from your platform's backend online services at runtime.

Your game might require you to read user files that are not packaged with your title. Examples may include configuration files or user-specific game save files. This interface helps you to access and download these files for use at runtime.

For title-specific file storage, see the [Title File Interface](../title-file-interface/index.md).

## API Overview

### Functions

The following table provides a high-level overview of the functions provided by the User File Interface:

| Function | 说明 |
| --- | --- |
| [EnumerateFiles](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/EnumerateFiles?application_version=5.5) | Enumerate all available files. |
| [GetEnumeratedFiles](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/GetEnumeratedFiles?application_version=5.5) | Retrieve a cached list of files enumerated by a call to `EnumerateFiles`. |
| [ReadFile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/ReadFile?application_version=5.5) | Read a file and return its contents. |
| [WriteFile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/WriteFile?application_version=5.5) | Write the file contents to a file with the provided name. |
| [CopyFile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/CopyFile?application_version=5.5) | Copy the file contents to another file. |
| [DeleteFile](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/OnlineServicesInterface/Online/IUserFile/DeleteFile?application_version=5.5) | Delete a file. |

## Process Flow for Reading Files

To read, copy, or delete a file from the backend online services with the User File Interface, follow these steps:

1. `EnumerateFiles` caches a list of all files available to retrieve from the online services with the interface.
2. `GetEnumeratedFiles` retrieves the list of files cached with the interface by `EnumerateFiles`.
3. For each file in the retrieved list, `ReadFile` reads the file and returns its contents.

## Modifying Files

The User File Interface also supports operations for modifying files:

- `WriteFile` creates new files or overwrites existing ones.
- `CopyFile` copies the contents of a user file to a different user file.
- `DeleteFile` deletes the user file with the provided name from the backend online services.

## More Information

### Header File

Consult the `UserFile.h` header file directly for more information as needed. The User File Interface header file `UserFile.h` is located in the directory:

C++

```
Engine\Plugins\Online\OnlineServices\Source\OnlineServicesInterface\Public\Online
```

For instructions on how to obtain the UE source code, see our documentation on [Downloading Unreal Engine Source Code](../../../../../get-started/install/downloading-source-code/index.md).

### Function Parameters and Return Types

See the [Functions](../../overview-of-online-services/index.md#functions) section of the Online Services Overview page for an explanation of function parameters and return types, including how to pass parameters and processing the results when functions return.
