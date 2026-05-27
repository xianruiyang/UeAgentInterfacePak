---
title: "编译配置参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/build-configurations-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "从GitHub下载虚幻引擎源代码", "编译配置参考"]
---

# 编译配置参考

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 从GitHub下载虚幻引擎源代码 / 编译配置参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/build-configurations-reference-for-unreal-engine

操作系统

Windows

从下拉菜单中选择一个选项以查看与之相关的内容

> [!NOTE]
> 谷歌已通知开发者WebRTC版本（早于M102）存在漏洞。 如需了解其影响、解决方法和更新，请参阅[此处](https://eoshelp.epicgames.com/s/news/eos-news-article-MCVDBTZSVM7VAJHF4ZGJVXZM52I4?language=en_US)。

## 编译配置描述

**虚幻引擎（UE）**通过**虚幻编译工具（UBT）**来使用自定义编译方法。 此工具负责处理引擎反射系统编译所必需的信息，将C++代码与蓝图、复制、序列化和垃圾回收进行整合。

Every build configuration contains two keywords. The first keyword indicates the state of the engine and your game project. For instance, if you compile using a **Debug** configuration, the build process forgoes optimization making it easer to debug. To be clear, every configuration, even Shipping builds, produce symbols for debugging if built form Visual Studio or if **Project Settings > Project > Packaging > Project > Include Debug Files** is turned on in the Unreal Editor. This means that you can still debug Development and Shipping configurations, they just may not be as easy to debug as the Debug configuration. The second keyword indicates the target you are building for. For example, if you want to open a project in Unreal, you need to build with the **编辑器** target keyword.

| Build Configuration - State | 说明 |
| --- | --- |
| **Debug** | This configuration builds both engine and game code in debug configuration without optimizations. This makes things slower, but is easier to debug. If you compile your project using the **Debug** configuration and want to open the project with the Unreal Editor, you must use the `-debug` flag in order to see your code changes reflected in your project. |
| **DebugGame** | This configuration builds game code without optimizations. This configuration is ideal for debugging only game modules. |
| **Development** | This configuration enables all but the most time-consuming engine and game code optimizations, which makes it ideal for development and performance reasons. Unreal Editor uses the **Development** configuration by default. Compiling your project using the **Development** configuration enables you to see code changes made to your project reflected in the editor. |
| **Shipping** | This is the configuration for optimal performance and shipping your game. This configuration strips out console commands, stats, and profiling tools. |
| **Test** | This configuration is the **Shipping** configuration, but with some console commands, stats, and profiling tools enabled. |

| Build Configuration - Target | 说明 |
| --- | --- |
| **Game** | This configuration builds a stand-alone executable version of your project, but requires cooked content specific to the platform. Please refer to the Reference page to learn more about cooked content. |
| **编辑器** | To open a project in Unreal Editor and see all code changes reflected, the project must be built in an **编辑器** configuration. |
| **Client** | If you are working on a multiplayer project using UE networking features, this target designates the specified project as being a Client in UE's client-server model for multiplayer games. If there is a `<GAME_NAME>Client.Target.cs` file, the **Client** build configurations will be valid. |
| **Server** | If you are working on a multiplayer project using UE networking features, this target designates the specified project as being a Server in UE's client-server model for multiplayer games. If there is a `<GAME_NAME>Server.Target.cs` file, the **Server** build configurations will be valid. |

### UE解决方案编译配置

编译UE解决方案时，即是将引擎的源代码与项目的源代码一同编译。 以此方式编译项目时可使用以下编译配置：

|  | 调试 | 调试游戏 | 开发 | 发布 | 测试 |
| --- | --- | --- | --- | --- | --- |
| **游戏（Game）** | ✓ | ✓ | ✓ | ✓ | ✓ |
| **编辑器（Editor）** | ✓ | ✓ | ✓ |  |  |
| **客户端（Client）** | ✓ | ✓ | ✓ | ✓ | ✓ |
| **服务器（Server）** | ✓ | ✓ | ✓ | ✓ | ✓ |

### UE项目编译配置

编译UE项目时，只会对项目的源代码进行编译。 以此方式编译项目时可使用以下编译配置：

|  | 调试 | 调试游戏 | 开发 | 发布 | 测试 |
| --- | --- | --- | --- | --- | --- |
| **游戏（Game）** |  | ✓ | ✓ | ✓ |  |
| **编辑器（Editor）** |  | ✓ | ✓ |  |  |
| **客户端（Client）** |  |  |  |  |  |
| **服务器（Server）** |  |  |  |  |  |
