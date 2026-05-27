---
title: "升级EOS SDK"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/upgrading-the-eos-sdk-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "虚幻引擎中的Epic在线服务", "升级EOS SDK"]
---

# 升级EOS SDK

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 虚幻引擎中的Epic在线服务 / 升级EOS SDK

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/upgrading-the-eos-sdk-in-unreal-engine

## 概述

**Epic在线服务（EOS）** **软件开发工具包（SDK）** 是允许你在游戏中访问EOS的一整套工具。多个 **虚幻引擎（UE）** **插件** 依赖EOS SDK才能正常运行，包括：

- 在线子系统EOS插件

  （OSS EOS）
- 在线服务EOS插件（OSSv2 EOS）
- EOS语音聊天插件

本页面介绍了如何：

- 在UE目录结构中找到EOS SDK文件

  。
- 升级EOS SDK

  。
- 查找有关EOS SDK的更多资源

  。

如需详细了解Epic在线服务，请参阅此页面的[更多资源](#%E6%9B%B4%E5%A4%9A%E8%B5%84%E6%BA%90)小节。

## EOS SDK的位置

EOS SDK模块位于以下目录中：

```
UNREAL_ENGINE_ROOT/Engine/Source/ThirdParty/EOSSDK
```

插件和模块可能会将此EOS SDK模块添加为依赖性，从而依赖EOS SDK。

#### 与EOS SDK模块相关的模块

此模块存在多个特定于平台的扩展，它们特定于平台的EOS SDK，并位于以下目录中：

```
UNREAL_ENGINE_ROOT/Engine/Platforms/<PLATFORM>/Source/ThirdParty/EOSSDK
```

EOS共享插件将公开公共EOS功能，并负责初始化和关闭EOS SDK运行时库。EOS共享插件位于以下目录中：

```
UNREAL_ENGINE_ROOT/Engine/Plugins/Online/EOSShared
```

## 升级EOS SDK

有三种方法可升级EOS SDK：

| **方法** | **说明** |
| --- | --- |
| [库和头文件的完全升级](#%E5%BA%93%E5%92%8C%E5%A4%B4%E6%96%87%E4%BB%B6%E7%9A%84%E5%AE%8C%E5%85%A8%E5%8D%87%E7%BA%A7) | 选择此方法可利用更新的SDK版本中的新API和漏洞修复。 |
| [仅限库的升级](#%E4%BB%85%E9%99%90%E5%BA%93%E7%9A%84%E5%8D%87%E7%BA%A7) | 选择此方法可利用更新的SDK版本中的漏洞修复，但不利用新API。 |
| [项目覆盖升级](#%E9%A1%B9%E7%9B%AE%E8%A6%86%E7%9B%96%E5%8D%87%E7%BA%A7) | 若选择此方法，你在编译引擎模块和编译项目模块时，可以针对不同版本的EOS SDK。 |

### 库和头文件的完全升级

此方法将升级整个SDK，包括库和头文件。这允许你针对新的头文件重新编译引擎和插件，这样你可以使用最近SDK版本中可用的所有新API和漏洞修复。

#### 步骤

请按照以下步骤将EOS SDK完全升级：

1. 从

   EOS开发人员门户

   下载你所需的EOS SDK版本。
2. 在

   Engine/Source/ThirdParty/EOSSDK/

   目录中，执行以下操作：

   - 不要删除

     EOSSDK.Build.cs

     或此目录中的其他松散文件。
   - 删除

     Engine/Source/ThirdParty/EOSSDK/

     的所有子目录。
3. 将新SDK的

   .zip

   文件解压到

   Engine/Source/ThirdParty/EOSSDK/

   中。这会在以下位置创建名为

   SDK

   的文件夹：

   Engine/Source/ThirdParty/EOSSDK/SDK

   。
4. 为其他特定于平台的SDK重复步骤1-3：

   - 对于Android和iOS：

     将

     .zip

     文件解压到

     Engine/Source/ThirdParty/EOSSDK/

     中，覆盖基础SDK。
   - 对于其他平台：

     将

     .zip

     文件解压到其相应目录

     Engine/Platforms/<PLATFORM>/Source/ThirdParty/EOSSDK/

     中的相应平台扩展中。
5. 将文件

   Engine/Source/ThirdParty/EOSSDK/SDK/Bin/libEOSSDK-Mac-Shipping.dylib

   移至以下位置

   Engine/Binaries/ThirdParty/EOSSDK/Mac/libEOSSDK-Mac-Shipping.dylib

   。

> [!WARNING]
> EOS SDK更新可能包含重大或必需的代码更改。我们建议你查阅[EOS SDK版本说明](https://dev.epicgames.com/docs/zh-Hans/epic-online-services/release-notes)，详细了解必需代码更改。

#### EOS引擎插件中的API版本

许多EOS引擎插件已迁移为在EOS选项结构体中设置特定API版本，而不是使用 `API_LATEST` 。

##### 旧版行为

之前，EOS引擎插件使用了 `API_LATEST` 作为EOS选项结构体中的版本号。因此，当你使用完全升级方法升级EOS SDK，并重新编译了引擎插件时，SDK有时会做出重大更改。发生这些重大更改是因为EOS SDK使用了新API版本中定义的行为合同，但使用EOS SDK的引擎插件预期的是插件最初编译所针对的头文件中的较旧API版本中定义的合同。因此你需要确保所有引擎版本都更新为使用新合同。

##### 当前行为

现在，不使用 `API_LATEST` ，而是使用编写插件所针对的头文件中指定的API版本。这意味着当你执行完全升级时，引擎代码仍使用旧头文件中的API版本。因此，EOS SDK继续采用编写插件所针对的合同。这样一来，引擎插件的运作方式就好像你执行了仅升级库一样。

其目的是让使用EOS的引擎插件更不容易发生SDK升级导致的重大更改。有时，SDK可能会更改选项结构体中的字段名称，或将其完全删除。当SDK更改字段名称或将其删除时，使用新头文件的编译可能失败。如果编译失败，请将旧头文件中的选项结构体定义复制粘贴到代码中，以便它可以继续使用旧定义。

##### 示例

考虑这样一种情况，EOS SDK添加了用于设置程序的网络状态的API。新SDK中的默认状态变为"离线"，相对于之前的默认状态"在线"发生了重大更改。由于引擎插件传递的是 `API_LATEST` ，当引擎插件针对新SDK重新编译时，SDK将为"离线"。

由于UE中不支持此新API，因此没有机制将网络状态设置为"在线"。SDK会保持"离线"状态，变得无法正常运行。

如果传递的是旧API版本（编写代码所针对的头文件中的 `API_LATEST` 值），SDK会知道它在添加网络状态API之前被针对头文件编写的内容调用，并且会像执行了仅限DLL的升级那样继续工作。

##### API版本警告

EOS插件中的常见模式在之前一直是在EOS选项结构体的用法旁边添加 `static_asserts` 。这些断言会在选项结构体的 `API_LATEST` 值更改时触发。这会提醒你发生了更改，并提示你采取必需措施。

遗憾的是，使用断言还意味着，当你执行EOS SDK的完全（库和头文件）升级时，你可能会在发生此类API版本升级时遇到编译失败。为了修复此问题，我们将 `static_asserts` 替换为了类似废弃的机制，转而在编译时发出警告。

###### 将警告设为静默

要将API版本警告设为静默，请将以下分段添加到引擎配置文件，例如 `DefaultEngine.ini` 。

```
[EOSShared]bEnableApiVersionWarnings=false;
```

### 仅限库的升级

此方法涉及仅升级库文件，但不升级头文件。这样你可以利用更新的SDK版本中的漏洞修复，或用你的SDK交换针对不同平台SDK版本构建的版本。此方法不需要重新编译引擎或插件，因为头文件没有更改。SDK应该继续按照编写它时所针对的SDK版本（头文件的SDK版本）中的相同方式运行。

#### 步骤

请按照以下步骤执行EOS SDK的仅限库的升级：

1. 替换其相应位置中的以下所有文件类型：

   - .dll
   - .so
   - .dylib
   - 其相应位置中的其他特定于平台的二进制文件。
2. 根据你使用的平台执行以下操作：

   - 对于Mac：

     请注意，二进制文件位于

     Engine/Binaries/ThirdParty/EOSSDK

     下，而其他平台则与之不同，全部都位于

     Engine/Source/ThirdParty/EOSSDK

     或

     Engine/Platforms/<PLATFORM>/Source/ThirdParty/EOSSDK

     下。在这种情况下，你只需要更新

     Engine/Binaries/ThirdParty/EOSSDK/Mac

     中的二进制文件。
   - 对于Android：

     将

     SDK/Bin/Android/Include

     文件夹保持不变，仅更新

     SDK/Bin/Android

     中包含

     .aar

     和

     .lib

     文件的其他子文件夹。
   - 对于IOS：

     忽略

     SDK/Bin/IOS/EOSSDK.framework/Headers

     文件夹，仅更新

     SDK/Bin/IOS/EOSSDK.framework

     文件夹的其他内容。

### 项目覆盖

项目覆盖方法支持你的项目提供其自己的EOS SDK。使用此方法，引擎模块可以继续针对 `Engine/Source/ThirdParty/EOSSDK` 中包含的EOS SDK编译，但项目模块可以选择针对引擎或项目中的SDK头文件编译。包括引擎模块在内的所有内容都会针对项目提供的EOS SDK二进制文件运行，因为EOS共享插件偏好在运行时加载项目提供的EOS SDK二进制文件，而不是引擎提供的二进制文件。

#### 步骤

要执行EOS SDK项目覆盖，请执行以下步骤：

1. 创建你自己的

   EOSSDK<PROJECT>

   模块，其中包含你的项目的EOS SDK。

   - 确保

     .Build.cs

     文件添加了

     RuntimeDependencies

     条目，用于将你的EOS SDK二进制文件复制到

     <PROJECT>/Binaries/<PLATFORM>

     。你也可以将二进制文件直接检入

     <PROJECT>/Binaries/<PLATFORM>

     中。
2. 在你项目的

   .Target.cs

   文件中设置

   EOSSDK_USE_PROJECT_BINARY=1

   。

   - 这会确保庞大的版本不会针对引擎EOS SDK二进制文件进行链接，而只针对你的项目提供的二进制文件。
3. 对于项目模块，选择是添加EOS SDK（引擎模块）还是你的项目的EOS SDK覆盖模块作为依赖性。

   - 这将指定你的项目模块针对哪组头文件进行编译。

## 产品名称

你可以在引擎配置文件中设置EOS SDK产品名称，如你的项目的 `DefaultEngine.ini` 。EOS SDK产品名称是在EOS覆层的在线状态信息中显示的名称。如果未在引擎配置中设置EOS SDK产品名称，则默认为你的项目名称。

### 设置EOS SDK产品名称

要设置你的产品名称，需在你的项目的 `DefaultEngine.ini` 中添加以下内容：

```
[EOSSDK]ProductName="<PRODUCT_NAME>"
```

其中 `<PRODUCT_NAME>` 是你的产品的名称。例如，要将"MyProduct"添加为你的产品的名称，请将以下内容添加到你的项目的 `DefaultEngine.ini` 中：

```
[EOSSDK]ProductName="MyProduct"
```

## 其他资源

EOS SDK和虚幻引擎是单独的产品。为方便起见，虚幻引擎包含了一个EOS SDK版本，但最新版本的虚幻引擎可能没有包含最新版本的EOS SDK。如需详细了解EOS SDK，请参阅以下[Epic开发者资源文档](https://dev.epicgames.com/docs/zh-Hans)：

- EOS入门

  ：设置Epic Games账号和组织的步骤，以及关于下载EOS SDK和请求访问主机的EOS SDK的说明。
- EOS SDK重要信息

  ：基础EOS SDK信息，包括各种可用的SDK下载、命名规范、错误处理，等等。
- EOS SDK API参考

  ：EOS SDK的完整API参考。
- EOS SDK版本说明

  ：每个EOS SDK版本的版本说明，包括新的API和漏洞修复。
