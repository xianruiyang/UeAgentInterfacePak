---
title: "Horde虚幻构建加速器和远程编译教程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-unreal-build-accelerator-and-remote-compilation-tutorial-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde教程", "Horde虚幻构建加速器和远程编译教程"]
---

# Horde虚幻构建加速器和远程编译教程

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde教程 / Horde虚幻构建加速器和远程编译教程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-unreal-build-accelerator-and-remote-compilation-tutorial-for-unreal-engine

## 简介

Horde实现了一个面向泛型远程执行工作负载的平台，允许客户端利用其他机器上的空闲CPU周期来加速原本在本地执行的工作负载。利用Horde的远程执行平台，你可以按顺序向远程代理发出显式命令，例如"上传这些文件"、"运行此进程"、"将这些文件发回"等等。

**虚幻构建加速器(UBA)** 是Horde中随附的一款工具，它为第三方程序（如C++编译器）实现了轻量级虚拟化，使其能够在远程i算计上运行 - 根据需要向发起计算器请求信息。远程执行的进程表现得如同在本地计算机上执行一样，能看到相同的文件系统视图等等，并且必要时可以在幕后与远程计算机互相传输文件。

[虚幻编译工具(UBT)](../../../using-the-unreal-engine-build-pipeline/unreal-build-tool/index.md)可以使用UBA和Horde将构建任务分担给连接的代理，将工作量分摊到多台计算机上。

> [!NOTE]
> UBA仅在虚幻引擎5.5中才支持Windows。计划在未来的版本中支持Mac和Linux。

## 先决条件

- Horde服务器和一个或多个Horde代理（参阅[Horde安装教程]）(setting-up-your-production-pipeline/horde/tutorials/install-horde)）。
- 正在开发UE项目的工作站。
- 工作站和Horde代理之间在端口范围7000-7010内建立网络连接。
- 默认启用

  匿名

  身份验证方法（更多详细信息请参阅下文）

## 步骤

1. 在启动构建的机器上，确保你的UE项目已同步并在本地编译。
2. 使用以下内容更新 `Engine/Saved/UnrealBuildTool/BuildConfiguration.xml` ，配置UnrealBuildTool以使用你的Horde服务器：

   ```
        <?xml version="1.0" encoding="utf-8" ?>     <Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">		         <BuildConfiguration>				             <bAllowUBAExecutor>true</bAllowUBAExecutor>         </BuildConfiguration>		         <Horde>				             <Server>http://{{ SERVER_HOST_NAME }}:13340</Server>						             <WindowsPool>Win-UE5</WindowsPool>         </Horde>		         <UnrealBuildAccelerator>				             <bLaunchVisualizer>true</bLaunchVisualizer>         </UnrealBuildAccelerator>		     </Configuration>
   ```

   将 `SERVER_HOST_NAME` 更换为与你的Horde服务器安装关联的地址。

   - 根据你的偏好，可以从文件系统中的许多位置获取

     BuildConfiguration.xml

     ，包括通常在源代码控制下的位置。请参阅UnrealBuildTool文档中的

     构建配置

     ，了解更多细节。
3. 像平常一样通过IDE编译你的项目。你会看到如下日志行：

   ```
        [Worker0] Connected to AGENT-1 (10.0.10.172) under lease 65d48fe1eb6ff84c8197a9b0     ...     [17/5759] Compile [x64] Module.CoreUObject.2.cpp [RemoteExecutor: AGENT-1]
   ```

   这表明作业正在分散到多个代理。如果你启用了UBA查看器，你还可以看到关于多台机器上构建进度的图形概览。

   出于调试和调整目的，强制远程执行所有编译工作负载会很有用。为此，请在 `BuildConfiguration.xml` 文件中启用以下选项，或在UnrealBuildTool命令行上传递 `-UBAForceRemote` ：

   ```
    <UnrealBuildAccelerator>     <bForceBuildAllRemote>true</bForceBuildAllRemote> </UnrealBuildAccelerator>
   ```

   > [!NOTE]
   > 出于性能原因，不建议在与Horde服务器相同的机器上运行Horde代理。

   > [!NOTE]
   > 使用Horde的构建自动化功能时，请注意混合UBA代理池和构建自动化代理池。用于构建自动化的代理通常比计算辅助具有更高的要求，并且是一种更稀缺的资源。

## 启用身份验证

使用匿名身份验证模式时，无需身份验证，每个用户都拥有执行远程编译的完全访问权限。仅在测试阶段推荐这样，你应尽快切换到 `Horde` 或 `OpenIdConnect` 。一旦这样做，就必须向所谓的计算群集授予额外的权限。默认情况下，已定义名为 `default` 的群集。

利用远程编译的Horde作业会通过注入令牌自动获得访问权限，该令牌被设置为每个作业步骤的环境变量（ `UE_HORDE_TOKEN` ）。

下面是更新后的全局配置，其中包含一个 `默认` 群集和 `AddComputeTasks` ，允许UBT和UBA调度远程编译。要查看你的用户可以使用哪些声明，请以登录用户身份打开 `/api/v1/user/claims` 。

```
{  // ...  "plugins": {    // ...    "compute": {      // ...      "clusters": [        {          "id": "default",          "namespaceid": "horde.compute",          "acl": {            "entries": [              {                "claim": { "type": "http://epicgames.com/ue/horde/user", "value": "jane.smith" },                "actions": ["AddComputeTasks"]              }            ]          }        }      ]    }  }}
```
