---
title: "Horde代理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-agents-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde代理"]
---

# Horde代理

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde代理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-agents-for-unreal-engine

## 安装Horde代理

如需了解如何部署新代理，请参阅[Horde > 部署 > 代理](../../horde-deployment/horde-agent-deployment/index.md)。

## 池

池是一组可以互换使用的机器，通常是因为这些机器属于特定平台或硬件类。通过允许开发运维工程师配置从代理类型到物理机器的映射，池简化了构建管线的管理。

池在[.globals.json](../horde-schema/index.md#globals)文件中通过 `pools` 属性定义。代理可以通过Horde操作面板手动添加到池中，也可以在满足特定条件后自动添加到池中。例如，以下配置块定义了一个会自动包括所有Windows机器的池：

```
{    "name": "WinLargeRam",    "condition": "Platform == 'Win64' && RAM > 64gb"}
```

另请参阅：[条件表达式语法](../horde-conditions/index.md)

## 远程连接到代理

如果你有一组机器需要相同的登录凭证，你可以将UnrealGameSync配置为通过Horde操作面板中的链接打开远程桌面会话。

要启用此功能，请从Windows控制面板打开 **凭证管理器（Credential Manager）** ，然后选择 **Windows凭证（Credentials）** 。点击 **添加新的通用凭证...（Add a new generic credential...）** 链接，以创建一个新条目并将其命名为 `UnrealGameSync:RDP` 。根据需要输入登录用户名和密码。

在Horde中，代理对话框上的 **远程桌面（Remote Desktop）** 按钮将打开一个URL，其格式为 `ugs://rdp?host=[NameOrIP]` 。UnrealGameSync默认配置为处理 `ugs://` 链接，它会拦截这些链接，并在启动远程桌面应用程序之前为指定的 `NameOrIP` 添加一个Windows登录条目。
