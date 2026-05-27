---
title: "Rundown Server WebSocket API Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/WebAPI/RundownServerWebSocketAPIReference"
breadcrumbs: ["虚幻引擎5.7文档", "Unreal Engine Web API Documentation", "Rundown Server WebSocket API Reference"]
---

# Rundown Server WebSocket API Reference

> 路径：虚幻引擎5.7文档 / Unreal Engine Web API Documentation / Rundown Server WebSocket API Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/WebAPI/RundownServerWebSocketAPIReference

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## 请求：ping

**消息类型：** /脚本/AvalancheMedia.AvaRundownPing

客户端发布此请求，用于在消息总线上发现服务器。可用服务器会响应一个[消息：Pong](#message:pong).

**属性：**

| 名称 | 说明 |
| --- | --- |
| bAuto | 如果请求源自自动计时器则为 true；如果请求源自用户交互则为 false。 |
| RequestedApiVersion | API 版本 该 客户端 具有 已经 implemented 针对. 如果 unspecified 该 服务器 将 consider 该 latest 版本 是 requested. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"bAuto": true,		"requestedApiVersion": -1,		"requestId": -1	}
```

## 请求: GetServerInfo

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetServerInfo

请求 该 extended 服务器 信息. 响应 是 [Message: ServerInfo](#message:serverinfo).

**属性：**

| 名称 | 说明 |
| --- | --- |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"requestId": -1	}
```

## 请求: GetPlayableAssets

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetPlayableAssets

请求 a 列表 的 playable 资产 该 可以 是 已添加 到 a rundown 模板. 响应 是 [Message: PlayableAssets](#message:playableassets).

**属性：**

| 名称 | 说明 |
| --- | --- |
| 查询 | 该 search 查询 其 将 是 compared 使用 该 资产 名称. |
| Limit | 该 最大 数量 的 search 结果 返回. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"query": "",		"limit": 0,		"requestId": -1	}
```

## 请求: GetRundowns

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetRundowns

请求 该 列表 的 rundowns 该 可以 是 opened 在 该 当前 服务器. 响应 是 [Message: Rundowns](#message:rundowns).

**属性：**

| 名称 | 说明 |
| --- | --- |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"requestId": -1	}
```

## 请求: LoadRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownLoadRundown

Loads 该 给定 rundown 用于 播放 操作. 此 将 还 打开 一个 关联 播放 上下文. 仅 一个 rundown 可以 是 opened 用于 播放 在 a 时间 通过 该 rundown 服务器. 如果 另一个 rundown 是 opened, 该 之前的 一个 将 是 closed 和 所有 当前 playing 页面 停止, unless 该 rundown 编辑器 是 opened. 该 rundown 编辑器 将 保持 该 播放 上下文 alive.

如果 该 路径 是 空, nothing 将 是 done 和 该 服务器 将 reply 使用 a [Message: ServerMsg](#message:servermsg) message 表示 其 rundown 是 当前 已加载.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"requestId": -1	}
```

## 请求: CreateRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownCreateRundown

创建 a 新增 rundown 资产.

该 完整 包 名称 是 going 到 是: [PackagePath]/[AssetName] 该 完整 资产 路径 是 going 到 是: [PackagePath]/[AssetName].[AssetName] 用于 所有 其他 请求, 该 rundown 引用 是 该 完整 资产 路径.

响应 是 [Message: ServerMsg](#message:servermsg).

**属性：**

| 名称 | 说明 |
| --- | --- |
| PackagePath | 包 路径 (excluding 该 包 名称) |
| AssetName | 资产 名称. |
| bTransient | 创建 该 rundown 作为 a transient 对象. **Remark:** 用于 游戏 构建, 该 创建 rundown 将 始终 是 transient, regardless 的 此 标志. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"packagePath": "",		"assetName": "",		"bTransient": true,		"requestId": -1	}
```

## 请求: DeleteRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownDeleteRundown

Deletes 一个 现有 rundown.

响应 是 [Message: ServerMsg](#message:servermsg).

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"requestId": -1	}
```

## 请求: ImportRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownImportRundown

Imports rundown 从 JSON 数据 或 文件.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RundownFile | 如果 指定, 此 是 a 服务器 本地 路径 到 a JSON 文件 从 其 该 rundown 将 是 导入. |
| RundownData | 如果 指定, JSON 数据 包含 该 rundown 到 导入. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"rundownFile": "",		"rundownData": "",		"requestId": -1	}
```

## 请求: ExportRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownExportRundown

导出 a rundown 到 JSON 数据 或 文件. 此 命令 是 支持 在 游戏 构建.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RundownFile | 可选 路径 到 a 服务器 本地 文件 位置 该 rundown 将 是 保存. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"rundownFile": "",		"requestId": -1	}
```

## 请求: SaveRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownSaveRundown

请求 该 该 给定 rundown 是 保存 到 磁盘. 该 rundown 资产 必须 具有 已经 已加载, 任一 通过 一个 编辑 命令 或 播放, prior 到 此 命令. Unloaded 资产 将 不 是 已加载 通过 此 命令. 此 命令 是 不 支持 在 游戏 构建.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| bOnlyIfIsDirty | 该 保存 命令 将 是 executed 仅 如果 该 资产 包 是 dirty. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"bOnlyIfIsDirty": false,		"requestId": -1	}
```

## 请求: CreatePage

**消息类型：** /脚本/AvalancheMedia.AvaRundownCreatePage

请求 a 新增 页面 是 创建 从 该 指定 模板 在 该 给定 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| IdGeneratorParams | Defines 该 参数 用于 该 页面 ID generator 算法. 参见 [Struct: CreatePageIdGeneratorParams](#struct:createpageidgeneratorparams). |
| TemplateId | Specifies 该 模板 用于 该 newly 创建 页面. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"idGeneratorParams":		{			"referenceId": -1,			"increment": 1		},		"templateId": -1,		"requestId": -1	}
```

## 请求: DeletePage

**消息类型：** /脚本/AvalancheMedia.AvaRundownDeletePage

请求 该 页面 是 删除 从 该 给定 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | ID 的 该 页面 到 是 删除. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"requestId": -1	}
```

## 请求: CreateTemplate

**消息类型：** /脚本/AvalancheMedia.AvaRundownCreateTemplate

请求 该 创建 的 a 新增 模板. 如果 successful, 该 响应 是 [Message: ServerMsg](#message:servermsg) 使用 a "模板 [ID] 创建" 文本. 该 ID 的 该 创建 模板 可以 是 parsed 从 该 message's 文本. 还 a secondary [Message: PageListChanged](#message:pagelistchanged) 事件 使用 已添加 模板 ID 将 是 发送.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| IdGeneratorParams | Defines 该 参数 用于 该 页面 ID generator 算法. 参见 [Struct: CreatePageIdGeneratorParams](#struct:createpageidgeneratorparams). |
| AssetPath | Specifies 该 资产 路径 到 assign 到 该 模板. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"idGeneratorParams":		{			"referenceId": -1,			"increment": 1		},		"assetPath": "",		"requestId": -1	}
```

## 请求: CreateComboTemplate

**消息类型：** /脚本/AvalancheMedia.AvaRundownCreateComboTemplate

请求 该 创建 的 a 新增 组合 模板. 如果 successful, 该 响应 是 [Message: ServerMsg](#message:servermsg) 使用 a "模板 [ID] 创建" 文本. 该 ID 的 该 创建 模板 可以 是 parsed 从 该 message's 文本. 还 a secondary [Message: PageListChanged](#message:pagelistchanged) 事件 使用 已添加 模板 ID 将 是 发送.

**Remark:** A combination 模板 可以 仅 是 创建 使用 过渡 逻辑 模板 该 为 在 不同 过渡 图层.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| IdGeneratorParams | Defines 该 参数 用于 该 页面 ID generator 算法. 参见 [Struct: CreatePageIdGeneratorParams](#struct:createpageidgeneratorparams). |
| CombinedTemplateIds | Specifies 该 模板 ID 该 为 组合. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"idGeneratorParams":		{			"referenceId": -1,			"increment": 1		},		"combinedTemplateIds": [],		"requestId": -1	}
```

## 请求: DeleteTemplate

**消息类型：** /脚本/AvalancheMedia.AvaRundownDeleteTemplate

请求 删除 的 该 给定 模板.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | Specifies 该 *模板* ID 到 删除. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"requestId": -1	}
```

## 请求: ChangeTemplateBP

**消息类型：** /脚本/AvalancheMedia.AvaRundownChangeTemplateBP

设置 该 页面's 模板 资产. 此 applies 到 模板 页面 仅.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| TemplateId | Specifies 该 模板 ID 到 修改. |
| AssetPath | Specifies 该 资产 路径 到 assign. |
| bReimport | 如果为 true, 该 资产 将 是 re-导入 和 该 模板 信息 将 是 refresh 从 该 源 资产. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"templateId": -1,		"assetPath": "",		"bReimport": false,		"requestId": -1	}
```

## 请求: GetPages

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetPages

请求 该 列表 的 页面 从 该 给定 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"requestId": -1	}
```

## 请求: GetPageDetails

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetPageDetails

请求 该 页面 细节 从 该 给定 rundown. 响应 是 [Message: PageDetails](#message:pagedetails).

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | 指定 该 requested 页面 ID. |
| bLoadRemoteControlPreset | 此 将 请求 该 a managed 资产 实例 gets 已加载 到 是 accessible 通过 WebRC. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"bLoadRemoteControlPreset": false,		"requestId": -1	}
```

## 请求: PageChangeChannel

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageChangeChannel

设置 该 通道 的 该 给定 页面. 该 页面 必须 是 有效 (和 不 a 模板) 和 该 通道 必须 exist 在 该 当前 分析. Along 使用 该 对应 响应, 此 将 还 触发 a [Message: PageChannelChanged](#message:pagechannelchanged) 事件.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | Specifies 该 页面 该 将 是 modified. |
| ChannelName | Specifies a 有效 通道 到 设置 用于 该 指定 页面. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"channelName": "",		"requestId": -1	}
```

## 请求: ChangePageName

**消息类型：** /脚本/AvalancheMedia.AvaRundownChangePageName

设置 页面 名称. Works 用于 模板 或 实例 页面. 通过 默认, 该 命令 将 设置 该 页面's "friendly" 名称 作为 它 是 该 一个 使用 用于 显示 用途. 该 页面 名称 是 reserved 用于 native 代码 使用. Along 使用 该 对应 响应, 此 将 还 触发 a [Message: PageNameChanged](#message:pagenamechanged) 事件.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | Specifies 该 页面 或 模板 该 将 是 modified. |
| PageName | Specifies 该 新增 页面 名称. |
| bSetFriendlyName | 如果为 true, 该 页面's friendly 名称 将 是 设置. 该 页面 名称 是 usually 设置 通过 该 native 代码. 用于 显示 用途, 它 是 preferable 到 使用 该 "friendly" 名称. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"pageName": "",		"bSetFriendlyName": true,		"requestId": -1	}
```

## 请求: UpdatePageFromRCP

**消息类型：** /脚本/AvalancheMedia.AvaRundownUpdatePageFromRCP

此 是 a 请求 到 保存 该 managed 远程 控制 预设 (RCP) 返回 到 该 对应 页面 值.

**属性：**

| 名称 | 说明 |
| --- | --- |
| bUnregister | Unregister 该 远程 控制 预设 从 该 WebRC. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"bUnregister": false,		"requestId": -1	}
```

## 请求: PageAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageAction

请求 用于 a program 页面 命令 在 该 当前 播放 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| PageId | Specifies 该 页面 ID 该 是 该 目标 的 此 操作 命令. |
| 操作 | Specifies 该 页面 操作 到 执行. 参见 [Enum: PageActions](#enum:pageactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"pageId": -1,		"action": "None",		"requestId": -1	}
```

## 请求: PagePreviewAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownPagePreviewAction

请求 用于 a 预览 页面 命令 在 该 当前 播放 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| PreviewChannelName | Specifies 其 预览 通道 到 使用. 如果 左侧 空, 该 rundown's 默认 预览 通道 是 使用. |
| PageId | Specifies 该 页面 ID 该 是 该 目标 的 此 操作 命令. |
| 操作 | Specifies 该 页面 操作 到 执行. 参见 [Enum: PageActions](#enum:pageactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"previewChannelName": "",		"pageId": -1,		"action": "None",		"requestId": -1	}
```

## 请求: PageActions

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageActions

命令 到 执行 a program 操作 在 多个 页面 在 该 相同 时间. 此 是 necessary 用于 页面 到 是 部分 的 该 相同 过渡.

**属性：**

| 名称 | 说明 |
| --- | --- |
| PageIds | Specifies a 列表 的 页面 ID 该 为 该 目标 的 此 操作 命令. |
| 操作 | Specifies 该 页面 操作 到 执行. 参见 [Enum: PageActions](#enum:pageactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"pageIds": [],		"action": "None",		"requestId": -1	}
```

## 请求: PagePreviewActions

**消息类型：** /脚本/AvalancheMedia.AvaRundownPagePreviewActions

命令 到 执行 a 预览 操作 在 多个 页面 在 该 相同 时间. 此 是 necessary 用于 页面 到 是 部分 的 该 相同 过渡.

**属性：**

| 名称 | 说明 |
| --- | --- |
| PreviewChannelName | Specifies 其 预览 通道 到 使用. 如果 左侧 空, 该 rundown's 默认 预览 通道 是 使用. |
| PageIds | Specifies a 列表 的 页面 ID 该 为 该 目标 的 此 操作 命令. |
| 操作 | Specifies 该 页面 操作 到 执行. 参见 [Enum: PageActions](#enum:pageactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"previewChannelName": "",		"pageIds": [],		"action": "None",		"requestId": -1	}
```

## 请求: TransitionAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownTransitionAction

命令 到 覆盖 过渡 逻辑 直接. 作为 它 当前 stands, we 可以 仅 具有 1 过渡 每个 通道. 如果 存在 是 一个 问题 使用 它, 它 可能 块 further 播放.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 通道 该 是 该 目标 的 此 操作 命令. |
| 操作 | Specifies 该 页面 过渡 操作 到 执行. 参见 [Enum: TransitionActions](#enum:transitionactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"action": "None",		"requestId": -1	}
```

## 请求: TransitionLayerAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownTransitionLayerAction

命令 到 覆盖 过渡 逻辑.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 通道 该 是 该 目标 的 此 操作 命令. |
| LayerNames | Specifies 该 过渡 逻辑 图层 用于 此 操作 命令. |
| 操作 | Specifies 该 页面 图层 操作 到 执行. 参见 [Enum: TransitionLayerActions](#enum:transitionlayeractions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"layerNames": [],		"action": "None",		"requestId": -1	}
```

## 请求: GetProfiles

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetProfiles

请求 a 列表 的 所有 配置文件 已加载 用于 该 当前 广播 配置. 响应 是 [Message: 配置文件](#message:profiles).

**属性：**

| 名称 | 说明 |
| --- | --- |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"requestId": -1	}
```

## 请求: DuplicateProfile

**消息类型：** /脚本/AvalancheMedia.AvaRundownDuplicateProfile

Duplicates 一个 现有 分析. Fails 如果 该 新增 分析 名称 已经 exist. Fails 如果 该 源 分析 执行 不 exist.

**属性：**

| 名称 | 说明 |
| --- | --- |
| SourceProfileName | Specifies 该 现有 分析 到 是 duplicated. |
| NewProfileName | Specifies 该 名称 的 该 新增 分析 到 是 创建. |
| bMakeCurrent | 如果为 true 该 创建 分析 是 还 made "当前". Equivalent 到 [请求: SetCurrentProfile](#request:setcurrentprofile). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"sourceProfileName": "",		"newProfileName": "",		"bMakeCurrent": true,		"requestId": -1	}
```

## 请求: CreateProfile

**消息类型：** /脚本/AvalancheMedia.AvaRundownCreateProfile

创建 a 新增 空 分析 使用 该 给定 名称. Fails 如果 该 分析 已经 exist.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ProfileName | 名称 到 是 给定 到 该 newly 创建 分析. |
| bMakeCurrent | 如果为 true 该 创建 分析 是 还 made "当前". Equivalent 到 [请求: SetCurrentProfile](#request:setcurrentprofile). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"profileName": "",		"bMakeCurrent": true,		"requestId": -1	}
```

## 请求: RenameProfile

**消息类型：** /脚本/AvalancheMedia.AvaRundownRenameProfile

Renames 一个 现有 分析.

**属性：**

| 名称 | 说明 |
| --- | --- |
| OldProfileName | Specifies 该 名称 的 该 现有 分析 到 是 renamed. |
| NewProfileName | Specifies 该 新增 名称. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"oldProfileName": "",		"newProfileName": "",		"requestId": -1	}
```

## 请求: DeleteProfile

**消息类型：** /脚本/AvalancheMedia.AvaRundownDeleteProfile

Deletes 该 指定 分析. Fails 如果 分析 到 是 删除 是 该 当前 分析.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ProfileName | Specifies 该 目标 分析. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"profileName": "",		"requestId": -1	}
```

## 请求: SetCurrentProfile

**消息类型：** /脚本/AvalancheMedia.AvaRundownSetCurrentProfile

指定 分析 是 made "当前". 该 当前 分析 becomes 该 上下文 用于 所有 其他 broadcasts 命令. Fails 如果 一些 通道 为 当前 broadcasting.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ProfileName | Specifies 该 requested 分析. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"profileName": "",		"requestId": -1	}
```

## 请求: GetChannel

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetChannel

请求 信息 (设备, 状态, 等) 在 a 指定 通道.

响应 是 [Message: ChannelResponse](#message:channelresponse).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 requested 通道. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"requestId": -1	}
```

## 请求: GetChannels

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetChannels

请求 信息 (设备, 状态, 等) 在 所有 通道 的 该 当前 分析.

响应 是 [Message: 通道](#message:channels).

**属性：**

| 名称 | 说明 |
| --- | --- |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"requestId": -1	}
```

## 请求: ChannelAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelAction

请求 a 广播 操作 在 该 指定 通道(s).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道 用于 该 操作. 如果 左侧 空, 该 操作 将 应用 到 所有 通道 的 该 当前 分析. |
| 操作 | Specifies 该 广播 操作 到 执行 在 该 目标 通道(s). 参见 [Enum: ChannelActions](#enum:channelactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"action": "None",		"requestId": -1	}
```

## 请求: ChannelEditAction

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelEditAction

请求 一个 编辑 操作 在 该 指定 通道.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道 用于 该 操作. |
| 操作 | Specifies 该 编辑 操作 到 执行 在 该 目标 通道. 参见 [Enum: ChannelEditActions](#enum:channeleditactions). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"action": "None",		"requestId": -1	}
```

## 请求: RenameChannel

**消息类型：** /脚本/AvalancheMedia.AvaRundownRenameChannel

请求 a 通道 到 是 renamed.

**属性：**

| 名称 | 说明 |
| --- | --- |
| OldChannelName | 现有 通道 到 是 renamed. |
| NewChannelName | Specifies 该 新增 通道 名称. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"oldChannelName": "",		"newChannelName": "",		"requestId": -1	}
```

## 请求: GetDevices

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetDevices

请求 a 列表 的 设备 从 该 rundown 服务器. 该 服务器 将 reply 使用 [Message: DevicesList](#message:deviceslist) 包含 该 设备 该 可以 是 enumerated 从 该 本地 host 和 所有 connected hosts 通过 该 运动 design 播放 服务.

**属性：**

| 名称 | 说明 |
| --- | --- |
| bShowAllMediaOutputClasses | 如果为 true, listing 所有 media 输出 类 在 该 服务器, even 如果 它们 don't 具有 a 设备 提供者. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"bShowAllMediaOutputClasses": false,		"requestId": -1	}
```

## 请求: AddChannelDevice

**消息类型：** /脚本/AvalancheMedia.AvaRundownAddChannelDevice

添加 一个 enumerated 设备 到 该 给定 通道. 此 命令 将 fail 如果 该 通道 是 实时.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| MediaOutputName | 该 指定 名称 是 一个 的 该 enumerated 设备 从 [Message: DevicesList](#message:deviceslist), [Struct: OutputDeviceItem](#struct:outputdeviceitem)::名称. |
| bSaveBroadcast | 保存 广播 配置 之后 此 操作 (true 通过 默认). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"mediaOutputName": "",		"bSaveBroadcast": true,		"requestId": -1	}
```

## 请求: EditChannelDevice

**消息类型：** /脚本/AvalancheMedia.AvaRundownEditChannelDevice

修改 一个 现有 设备 在 该 给定 通道. 此 命令 将 fail 如果 该 通道 是 实时.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| MediaOutputName | 该 指定 名称 是 一个 的 该 enumerated 设备 从 [Struct: 通道](#struct:channel)::设备, [Struct: OutputDeviceItem](#struct:outputdeviceitem)::名称 field. 必须 是 该 instanced 设备 从 任一 [Message: 通道](#message:channels), [Message: ChannelResponse](#message:channelresponse) 或 [Message: ChannelListChanged](#message:channellistchanged). 这些 名称 为 不 该 相同 作为 当 adding a 设备. |
| 数据 | (Modified) 设备 数据 在 该 相同 格式 作为 [Struct: OutputDeviceItem](#struct:outputdeviceitem)::数据. 参见: [Struct: 通道](#struct:channel), [Message: DevicesList](#message:deviceslist) |
| bSaveBroadcast | 保存 广播 配置 之后 此 操作 (true 通过 默认). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"mediaOutputName": "",		"data": "",		"bSaveBroadcast": true,		"requestId": -1	}
```

## 请求: RemoveChannelDevice

**消息类型：** /脚本/AvalancheMedia.AvaRundownRemoveChannelDevice

移除 一个 现有 设备 从 该 给定 通道. 此 命令 将 fail 如果 该 通道 是 实时.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| MediaOutputName | 该 指定 名称 是 一个 的 该 enumerated 设备 从 [Struct: 通道](#struct:channel)::设备, [Struct: OutputDeviceItem](#struct:outputdeviceitem)::名称 field. 必须 是 该 instanced 设备 从 任一 [Message: 通道](#message:channels), [Message: ChannelResponse](#message:channelresponse) 或 [Message: ChannelListChanged](#message:channellistchanged). 这些 名称 为 不 该 相同 作为 当 adding a 设备. |
| bSaveBroadcast | 保存 广播 配置 之后 此 操作 (true 通过 默认). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"mediaOutputName": "",		"bSaveBroadcast": true,		"requestId": -1	}
```

## 请求: GetChannelImage

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetChannelImage

Captures 一个 图片 从 该 指定 通道. 该 捕获 图片 是 25% 的 该 通道's resolution. Intended 用于 预览. 响应 是 [Message: ChannelImage](#message:channelimage).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"requestId": -1	}
```

## 请求: GetChannelQualitySettings

**消息类型：** /脚本/AvalancheMedia.AvaRundownGetChannelQualitySettings

Queries 该 给定 通道's quality 设置. 响应 是 [Message: ChannelQualitySettings](#message:channelqualitysettings).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"requestId": -1	}
```

## 请求: SetChannelQualitySettings

**消息类型：** /脚本/AvalancheMedia.AvaRundownSetChannelQualitySettings

设置 该 给定 通道's quality 设置.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| 功能 | Advanced 视口 客户端 引擎 功能 indexed 通过 FEngineShowFlags 名称. 参见 [Struct: ViewportQualitySettingsFeature](#struct:viewportqualitysettingsfeature). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"features": [],		"requestId": -1	}
```

## 请求: SaveBroadcast

**消息类型：** /脚本/AvalancheMedia.AvaRundownSaveBroadcast

保存 当前 广播 配置 到 a JSON 文件 在 该 配置 文件夹 在 该 服务器.

**属性：**

| 名称 | 说明 |
| --- | --- |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"requestId": -1	}
```

## Message: ServerMsg

**消息类型：** /脚本/AvalancheMedia.AvaRundownServerMsg

此 message 是 该 默认 响应 message 用于 所有 请求, unless a 特定 响应 message 类型 是 指定 用于 该 请求. 在 success, 该 message 将 具有 a Verbosity 的 "日志" 和 该 文本 可能 contain 响应 payload 相关 数据. 在 failure, a message 使用 Verbosity "错误" 将 是 发送. 此 message's RequestId mirrors 该 的 该 对应 请求 从 该 客户端.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Verbosity | 调试, 日志, 警告, 错误, 等. |
| 文本 | Message 文本. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"verbosity": "",		"text": "",		"requestId": -1	}
```

## 消息：Pong

**消息类型：** /脚本/AvalancheMedia.AvaRundownPong

该 服务器 将 发送 此 message 到 该 客户端 在 响应 到 [请求：ping](#request:ping). 此 是 使用 到 discover 该 服务器's 条目 点 在 该 message bus.

**属性：**

| 名称 | 说明 |
| --- | --- |
| bAuto | 如果为 true 它 是 a reply 到 一个 自动 ping. Mirrors 该 bAuto 标志 从 ping message. |
| ApiVersion | API 版本 该 服务器 将 communicate 使用 用于 此 客户端. 该 服务器 可能 honor 该 requested 版本 如果 可能. 版本 newer 比 服务器 实现 将 obviously 不 是 honored 任一. 客户端 应 expect 一个 older 服务器 到 reply 使用 一个 older 版本. |
| MinimumApiVersion | 最小 API 版本 该 服务器 implements. |
| LatestApiVersion | Latest API 版本 该 服务器 支持. |
| HostName | 服务器 Host 名称 |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"bAuto": true,		"apiVersion": -1,		"minimumApiVersion": -1,		"latestApiVersion": -1,		"hostName": "",		"requestId": -1	}
```

## Message: ServerInfo

**消息类型：** /脚本/AvalancheMedia.AvaRundownServerInfo

Extended 服务器 信息.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ApiVersion | API 版本 该 服务器 将 communicate 使用 用于 此 客户端. |
| MinimumApiVersion | 最小 API 版本 该 服务器 implements. |
| LatestApiVersion | Latest API 版本 该 服务器 支持. |
| HostName | 服务器 Host 名称 |
| EngineVersion | Holds 该 引擎 版本 checksum |
| InstanceId | 应用程序 实例 标识符. 参见 [Struct: Guid](#struct:guid). |
| InstanceBuild | 参见 [Enum: ServerBuildTargetType](#enum:serverbuildtargettype). |
| InstanceMode | 参见 [Enum: ServerEngineMode](#enum:serverenginemode). |
| SessionId | Holds 该 标识符 的 该 会话 该 该 应用程序 belongs 到. 参见 [Struct: Guid](#struct:guid). |
| ProjectName | 该 unreal 项目 名称 此 服务器 是 运行 从. |
| ProjectDir | 该 unreal 项目 目录 此 服务器 是 运行 从. |
| RemoteControlHttpServerPort | Http 服务器 端口 的 该 远程 控制 服务. |
| RemoteControlWebSocketServerPort | WebSocket 服务器 端口 的 该 远程 控制 服务. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"apiVersion": -1,		"minimumApiVersion": -1,		"latestApiVersion": -1,		"hostName": "",		"engineVersion": 0,		"instanceId": "00000000000000000000000000000000",		"instanceBuild": "Unknown",		"instanceMode": "Unknown",		"sessionId": "00000000000000000000000000000000",		"projectName": "",		"projectDir": "",		"remoteControlHttpServerPort": 0,		"remoteControlWebSocketServerPort": 0,		"requestId": -1	}
```

## Message: PlayableAssets

**消息类型：** /脚本/AvalancheMedia.AvaRundownPlayableAssets

列表 的 所有 可用 playable 资产 在 该 服务器. Expected 响应 从 [请求: GetPlayableAssets](#request:getplayableassets).

**属性：**

| 名称 | 说明 |
| --- | --- |
| 资产 | 参见 [Struct: SoftObjectPath](#struct:softobjectpath). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"assets": [],		"requestId": -1	}
```

## Message: Rundowns

**消息类型：** /脚本/AvalancheMedia.AvaRundownRundowns

列表 的 所有 rundowns. Expected 响应 从 [请求: GetRundowns](#request:getrundowns).

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundowns | 列表 的 Rundown 资产 路径 在 格式: [PackagePath]/[AssetName].[AssetName] |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundowns": [],		"requestId": -1	}
```

## Message: ExportedRundown

**消息类型：** /脚本/AvalancheMedia.AvaRundownExportedRundown

服务器 reply 到 [请求: ExportRundown](#request:exportrundown) 包含 该 导出 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| RundownData | 导出 rundown 在 JSON 格式. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"rundownData": "",		"requestId": -1	}
```

## Message: PlaybackContextChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPlaybackContextChanged

Rundown 特定 事件 广播 通过 该 服务器 到 帮助 状态 显示 或 相关 contexts 在 控制 应用程序.

**属性：**

| 名称 | 说明 |
| --- | --- |
| PreviousRundown | 之前的 rundown (可以 是 空). |
| NewRundown | 新增 当前 rundown (可以 是 空). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"previousRundown": "",		"newRundown": "",		"requestId": -1	}
```

## Message: 页面

**消息类型：** /脚本/AvalancheMedia.AvaRundownPages

- 列表 的 页面 从 该 当前 rundown.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 页面 | 列表 的 页面 descriptors 参见 [Struct: PageInfo](#struct:pageinfo). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"pages": [],		"requestId": -1	}
```

## Message: PageDetails

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageDetails

服务器 响应 到 [请求: GetPageDetails](#request:getpagedetails) 请求.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageInfo | 页面 信息. 参见 [Struct: PageInfo](#struct:pageinfo). |
| RemoteControlValues | 远程 控制 值 用于 此 页面. 参见 [Struct: PlayableRemoteControlValues](#struct:playableremotecontrolvalues). |
| RemoteControlPresetName | 名称 的 该 远程 控制 预设 到 解决 通过 WebRC API. |
| RemoteControlPresetId | Uuid 的 该 远程 控制 预设 到 解决 通过 WebRC API. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageInfo":		{			"pageId": -1,			"pageName": "",			"pageSummary": "",			"friendlyName": "",			"isTemplate": false,			"templateId": -1,			"combinedTemplateIds": [],			"assetPath": "None",			"statuses": [],			"transitionLayerName": "",			"bTransitionLogicEnabled": false,			"commands": [],			"outputChannel": "",			"bIsEnabled": false,			"bIsPlaying": false		},		"remoteControlValues":		{			"entityValues":			{			},			"controllerValues":			{			}		},		"remoteControlPresetName": "",		"remoteControlPresetId": "",		"requestId": -1	}
```

## Message: PagesStatuses

**消息类型：** /脚本/AvalancheMedia.AvaRundownPagesStatuses

事件 发送 当 a 页面 状态 更改.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageInfo | 页面 信息. 参见 [Struct: PageInfo](#struct:pageinfo). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageInfo":		{			"pageId": -1,			"pageName": "",			"pageSummary": "",			"friendlyName": "",			"isTemplate": false,			"templateId": -1,			"combinedTemplateIds": [],			"assetPath": "None",			"statuses": [],			"transitionLayerName": "",			"bTransitionLogicEnabled": false,			"commands": [],			"outputChannel": "",			"bIsEnabled": false,			"bIsPlaying": false		},		"requestId": -1	}
```

## Message: PageListChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageListChanged

事件 发送 当 a 页面 列表 (可以 是 模板, 页面 或 页面 views) 具有 已经 modified.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| ListType | Specifies 其 页面 列表 具有 已经 modified. 参见 [Enum: PageListType](#enum:pagelisttype). |
| SubListId | Specifies 该 uuid 的 该 页面 视图, 在 情况 该 事件 concerns a 页面 视图. 参见 [Struct: Guid](#struct:guid). |
| ChangeType | Bitfield 值 表示 什么 具有 changed: bit 0: 已添加 页面 bit 1: 移除 页面 bit 2: 页面 ID Renumbered bit 3: Sublist 已添加 或 已移除 bit 4: Sublist renamed bit 5: 页面 视图 reordered 参见 EAvaPageListChange 标志. |
| AffectedPages | 列表 的 页面 ID affected 通过 此 事件. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"listType": "Instance",		"subListId": "00000000000000000000000000000000",		"changeType": 0,		"affectedPages": [],		"requestId": -1	}
```

## Message: PageBlueprintChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageBlueprintChanged

事件 发送 当 a 页面's 资产 是 modified. Note: 此 applies 到 模板 仅.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | 指定 该 modified 页面 ID. |
| BlueprintPath | 资产 该 页面 是 当前 分配 到 (后置 modification). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"blueprintPath": "",		"requestId": -1	}
```

## Message: PageChannelChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageChannelChanged

事件 发送 当 a 页面's 通道 是 modified.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | 指定 该 modified 页面 ID. |
| ChannelName | 通道 该 页面 是 当前 分配 到 (后置 modification). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"channelName": "",		"requestId": -1	}
```

## Message: PageNameChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageNameChanged

事件 发送 当 a 页面's 名称 是 modified.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | 指定 该 modified 页面 ID. |
| PageName | 新增 页面 名称 是 当前 分配 到 (后置 modification). |
| bFriendlyName | Indicate 是否 该 名称 或 friendly 名称 该 changed. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"pageName": "",		"bFriendlyName": true,		"requestId": -1	}
```

## Message: PageAnimSettingsChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageAnimSettingsChanged

事件 发送 当 a 页面's 动画 设置 是 modified.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Rundown | Rundown 资产 路径: [PackagePath]/[AssetName].[AssetName] |
| PageId | 指定 该 modified 页面 ID. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"rundown": "",		"pageId": -1,		"requestId": -1	}
```

## Message: PageSequenceEvent

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageSequenceEvent

此 message 是 发送 通过 该 服务器 当 a 页面 序列 事件 occurs.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 通道 | Specifies 该 广播 通道 该 事件 occurred 在. |
| PageId | 页面 ID 关联 使用 此 事件. |
| InstanceId | Playable 实例 uuid. 参见 [Struct: Guid](#struct:guid). |
| AssetPath | 完整 资产 路径: /PackagePath/PackageName.AssetName |
| SequenceLabel | Specifies 该 label 使用 到 identify 该 序列. |
| 事件 | 开始, Paused, Finished 参见 [Enum: PlayableSequenceEventType](#enum:playablesequenceeventtype). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channel": "",		"pageId": -1,		"instanceId": "00000000000000000000000000000000",		"assetPath": "",		"sequenceLabel": "",		"event": "None",		"requestId": -1	}
```

## Message: PageTransitionEvent

**消息类型：** /脚本/AvalancheMedia.AvaRundownPageTransitionEvent

此 message 是 发送 通过 该 服务器 当 a 页面 过渡 事件 occurs.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 通道 | Specifies 该 广播 通道 该 事件 occurred 在. |
| TransitionId | UUID 的 该 过渡. 参见 [Struct: Guid](#struct:guid). |
| EnteringPageIds | 页面 该 为 entering 该 场景 期间 此 过渡. |
| PlayingPageIds | 页面 该 为 已经 在 该 场景. 可能 获取 kicked 输出 或 更改 期间 此 过渡. |
| ExitingPageIds | 页面 该 为 requested 到 exit 该 场景 期间 此 过渡. Typically 部分 的 a "采用 输出" 过渡. |
| 事件 | 开始, Finished 参见 [Enum: PageTransitionEvents](#enum:pagetransitionevents). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channel": "",		"transitionId": "00000000000000000000000000000000",		"enteringPageIds": [],		"playingPageIds": [],		"exitingPageIds": [],		"event": "None",		"requestId": -1	}
```

## Message: 配置文件

**消息类型：** /脚本/AvalancheMedia.AvaRundownProfiles

响应 到 [请求: GetProfiles](#request:getprofiles). 包含 该 列表 的 所有 配置文件 在 该 广播 配置.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 配置文件 | 列表 的 所有 配置文件. |
| CurrentProfile | 当前 激活 分析. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"profiles": [],		"currentProfile": "",		"requestId": -1	}
```

## Message: DevicesList

**消息类型：** /脚本/AvalancheMedia.AvaRundownDevicesList

响应 到 [请求: GetDevices](#request:getdevices).

**属性：**

| 名称 | 说明 |
| --- | --- |
| DeviceClasses | 列表 的 输出 设备 类 参见 [Struct: OutputClassItem](#struct:outputclassitem). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"deviceClasses": [],		"requestId": -1	}
```

## Message: ChannelListChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelListChanged

此 message 是 发送 通过 该 服务器 如果 该 列表 的 通道 是 modified 在 该 当前 分析. 通道 已添加, 已移除, pinned 或 类型 (预览 vs program) changed.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 通道 | 列表 的 通道 信息. 参见 [Struct: 通道](#struct:channel). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channels": [],		"requestId": -1	}
```

## Message: ChannelResponse

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelResponse

此 message 是 发送 通过 该 服务器 在 响应 到 [请求: GetChannel](#request:getchannel) 或 作为 一个 事件 如果 a 通道's states, 渲染 目标, 设备 或 设置 是 changed.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 通道 | 通道 信息 参见 [Struct: 通道](#struct:channel). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channel":		{			"name": "",			"type": "Program",			"state": "Offline",			"issueSeverity": "None",			"devices": []		},		"requestId": -1	}
```

## Message: 通道

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannels

响应 到 [请求: GetChannels](#request:getchannels)

**属性：**

| 名称 | 说明 |
| --- | --- |
| 通道 | 列表 的 通道 信息. 参见 [Struct: 通道](#struct:channel). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channels": [],		"requestId": -1	}
```

## Message: AssetsChanged

**消息类型：** /脚本/AvalancheMedia.AvaRundownAssetsChanged

事件 广播 当 一个 资产 事件 occurs 在 该 服务器.

**属性：**

| 名称 | 说明 |
| --- | --- |
| AssetName | 资产 名称 仅, 不 该 包 路径. (Keeping 用于 legacy) |
| AssetPath | 完整 资产 路径: /PackagePath/PackageName.AssetName |
| AssetClass | 完整 资产 类 路径. |
| bIsPlayable | 如果为 true 该 资产 是 a "playable" 资产, i.e. 一个 资产 该 可以 是 设置 在 a 页面's 资产. |
| EventType | Specifies 该 事件 类型, i.e. 已添加, 移除, 等. 参见 [Enum: AssetEvent](#enum:assetevent). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"assetName": "",		"assetPath": "",		"assetClass": "",		"bIsPlayable": false,		"eventType": "Unknown",		"requestId": -1	}
```

## Message: ChannelImage

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelImage

响应 到 [请求: GetChannelImage](#request:getchannelimage).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ImageData | Byte 数组 包含 该 图片 数据. Expected 格式 是 compressed jpeg. |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"imageData": [],		"requestId": -1	}
```

## Message: ChannelQualitySettings

**消息类型：** /脚本/AvalancheMedia.AvaRundownChannelQualitySettings

响应 到 [请求: GetChannelQualitySettings](#request:getchannelqualitysettings).

**属性：**

| 名称 | 说明 |
| --- | --- |
| ChannelName | Specifies 该 目标 通道. |
| 功能 | Advanced 视口 客户端 引擎 功能 indexed 通过 FEngineShowFlags 名称. 参见 [Struct: ViewportQualitySettingsFeature](#struct:viewportqualitysettingsfeature). |
| RequestId | 请求 标识符 (客户端 分配) 用于 匹配 服务器 响应 使用 它们的 对应 请求. |

**JSON 格式:**

```
	{		"channelName": "",		"features": [],		"requestId": -1	}
```

## Struct: Guid

A globally 唯一 标识符 (mirrored 从 [FGuid](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Core/Misc/FGuid))

**属性：**

| 名称 | 说明 |
| --- | --- |
| A |  |
| B |  |
| C |  |
| D |  |

**JSON 格式:**

```
	{		"a": 0,		"b": 0,		"c": 0,		"d": 0	}
```

## Struct: SoftObjectPath

A struct 该 包含 a 字符串 引用 到 一个 对象, 任一 a 顶部 关卡 资产 或 a subobject. **Note:** 该 完整 C++ 类 是 located 此处: [FSoftObjectPath](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/FSoftObjectPath)

**属性：**

| 名称 | 说明 |
| --- | --- |
| AssetPath | 资产 路径, patch 到 a 顶部 关卡 对象 在 a 包 参见 [Struct: TopLevelAssetPath](#struct:toplevelassetpath). |
| SubPathString | 可选 FString 用于 subobject 内部 一个 资产 |

**JSON 格式:**

```
	{		"assetPath": "None",		"subPathString": ""	}
```

## Struct: TopLevelAssetPath

A struct 该 可以 引用 a 顶部 关卡 资产 例如 作为 '/路径/到/包.AssetName' **Note:** 该 完整 C++ 类 是 located 此处: [FTopLevelAssetPath](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/FTopLevelAssetPath)

**属性：**

| 名称 | 说明 |
| --- | --- |
| PackageName | 名称 的 该 包 包含 该 资产 e.g. /路径/到/包 |
| AssetName | 名称 的 该 资产 内部 该 包 e.g. 'AssetName' |

**JSON 格式:**

```
	{		"packageName": "None",		"assetName": "None"	}
```

## Struct: CreatePageIdGeneratorParams

Defines 该 参数 用于 该 页面 ID generator 算法. 该 ID generator 使用 a 序列 策略 到 search 用于 一个 unused ID. 它 是 定义 通过 a 开始 ID 和 a search direction.

**属性：**

| 名称 | 说明 |
| --- | --- |
| ReferenceId | 开始 ID 用于 该 search. |
| Increment | (初始) Search increment. **Remark:** 用于 负 increment search, 该 limit 的 该 search 空间 可以 是 reached. 如果 no 唯一 ID 是 找到, 该 search 将 continue 在 该 正 direction 改为. |

**JSON 格式:**

```
	{		"referenceId": -1,		"increment": 1	}
```

## Struct: PageInfo

页面 信息

**属性：**

| 名称 | 说明 |
| --- | --- |
| PageId | 唯一 标识符 用于 该 页面 内部 该 rundown. |
| PageName | 短 页面 名称, usually 该 资产 名称 用于 模板. 它 是 显示 作为 该 页面 说明 如果 存在 是 no 页面 概要 或 用户 friendly 名称 指定. |
| PageSummary | 概要 是 生成 从 该 远程 控制 值 用于 此 页面. 它 是 显示 作为 该 页面 说明 如果 存在 是 no 用户 friendly 名称 指定. |
| FriendlyName | 用户 editable 页面 说明. 如果 不 空, 此 应 是 使用 作为 该 页面 说明. |
| IsTemplate | 表示 如果 该 页面 是 a 模板 (true) 或 一个 实例 (false). |
| TemplateId | 页面 实例 属性: 模板 ID 用于 此 页面. |
| CombinedTemplateIds | 模板 属性: 用于 combination 模板, lists 该 模板 该 为 组合. |
| AssetPath | 模板 属性: playable 资产 路径 用于 此 模板. 参见 [Struct: SoftObjectPath](#struct:softobjectpath). |
| Statuses | 列表 的 页面 通道 statuses. 存在 将 是 一个 条目 用于 每个 通道 该 页面 是 playing/previewing 在. 参见 [Struct: ChannelPageStatus](#struct:channelpagestatus). |
| TransitionLayerName | 过渡 图层 名称 (表示 该 页面 具有 过渡 逻辑). |
| bTransitionLogicEnabled | Indicate 如果 该 模板 资产 具有 过渡 逻辑. |
| 命令 | 页面 命令 该 可以 是 executed 当 playing 此 页面. 参见 [Struct: PageCommandData](#struct:pagecommanddata). |
| OutputChannel |  |
| bIsEnabled | Specifies 如果 该 页面 是 启用 (i.e. 可以 是 played). |
| bIsPlaying | 表示 如果 该 页面 是 当前 playing 在 它's program 通道. |

**JSON 格式:**

```
	{		"pageId": -1,		"pageName": "",		"pageSummary": "",		"friendlyName": "",		"isTemplate": false,		"templateId": -1,		"combinedTemplateIds": [],		"assetPath": "None",		"statuses": [],		"transitionLayerName": "",		"bTransitionLogicEnabled": false,		"commands": [],		"outputChannel": "",		"bIsEnabled": false,		"bIsPlaying": false	}
```

## Struct: ChannelPageStatus

**属性：**

| 名称 | 说明 |
| --- | --- |
| 类型 | 参见 [Enum: BroadcastChannelType](#enum:broadcastchanneltype). |
| 状态 | 参见 [Enum: PageStatus](#enum:pagestatus). |
| bNeedsSync |  |

**JSON 格式:**

```
	{		"type": "Program",		"status": "Unknown",		"bNeedsSync": false	}
```

## Struct: PageCommandData

页面 命令 数据 是 存储 在 JSON 序列化 字符串 在 该 页面 到 是 compatible 使用 外部 apps.

**属性：**

| 名称 | 说明 |
| --- | --- |
| 名称 | 命令 名称: 字符串. |
| Payload | 命令 payload: JSON formatted 字符串. |

**JSON 格式:**

```
	{		"name": "",		"payload": ""	}
```

## Struct: PlayableRemoteControlValues

容器 用于 该 远程 控制 值 的 a playable.

**属性：**

| 名称 | 说明 |
| --- | --- |
| EntityValues | 值 作为 a binary 数组 的 该 远程 控制 实体. 参见 [Struct: PlayableRemoteControlValue](#struct:playableremotecontrolvalue). |
| ControllerValues | Controller 值. 参见 [Struct: PlayableRemoteControlValue](#struct:playableremotecontrolvalue). |

**JSON 格式:**

```
	{		"entityValues":		{		},		"controllerValues":		{		}	}
```

## Struct: PlayableRemoteControlValue

**属性：**

| 名称 | 说明 |
| --- | --- |
| 值 | 该 远程 控制 实体 或 Controller's 值 存储 作为 a JSON formatted 字符串. |
| bIsDefault | Indicate 如果 该 值 是 a 默认 值 从 a 模板. 此 是 使用 到 know 其 值 到 更新 当 更新 该 页面's 值 从 该 模板 (reimport 页面). 此 是 设置 到 true 仅 当 该 值 为 从 该 模板. 如果 值 为 modified 通过 一个 编辑 操作, 它 将 是 设置 到 false. |

**JSON 格式:**

```
	{		"value": "",		"bIsDefault": false	}
```

## Struct: OutputClassItem

输出 设备 类 信息

**属性：**

| 名称 | 说明 |
| --- | --- |
| 名称 | 类 名称 |
| 服务器 | 名称 的 该 播放 服务器 此 类 曾 seen 在. 该 名称 将 是 空 用于 该 "本地 流程" 设备. |
| 设备 | Enumeration 的 该 可用 设备 的 此 类 在 该 给定 host. Note 该 不 所有 类 可以 是 enumerated. 参见 [Struct: OutputDeviceItem](#struct:outputdeviceitem). |

**JSON 格式:**

```
	{		"name": "",		"server": "",		"devices": []	}
```

## Struct: OutputDeviceItem

输出 设备 信息

**属性：**

| 名称 | 说明 |
| --- | --- |
| 名称 | Specifies 该 设备 名称. 此 是 使用 作为 "MediaOutputName" 在 [请求: AddChannelDevice](#request:addchanneldevice) 和 [请求: EditChannelDevice](#request:editchanneldevice). |
| OutputInfo | Extra 信息 关于 该 设备. 参见 [Struct: BroadcastMediaOutputInfo](#struct:broadcastmediaoutputinfo). |
| OutputState | Specifies 该 状态 的 该 输出 设备. 参见 [Enum: BroadcastOutputState](#enum:broadcastoutputstate). |
| IssueSeverity | 在 情况 该 设备 是 实时, 此 extra 状态 表示 如果 该 设备 是 operating 通常. 参见 [Enum: BroadcastIssueSeverity](#enum:broadcastissueseverity). |
| IssueMessages | 列表 的 errors 或 警告. |
| 数据 | Raw JSON 字符串 representing a 序列化 UMediaOutput. 此 数据 可以 是 edited, 然后 使用 在 [请求: EditChannelDevice](#request:editchanneldevice). |

**JSON 格式:**

```
	{		"name": "",		"outputInfo":		{			"guid": "00000000000000000000000000000000",			"serverName": "",			"deviceProviderName": "None",			"deviceName": "None"		},		"outputState": "Invalid",		"issueSeverity": "None",		"issueMessages": [],		"data": ""	}
```

## Struct: BroadcastMediaOutputInfo

Extra 信息 关于 该 Media 输出 对象. 此 是 使用 到 确定 该 状态 的 服务器 hosting 该 设备.

**属性：**

| 名称 | 说明 |
| --- | --- |
| Guid | 唯一 标识符 用于 此 输出. 允许 easier management 用于 客户端/服务器 状态 和 配置 复制. 参见 [Struct: Guid](#struct:guid). |
| ServerName | 该 服务器 名称 如果 该 media 输出 曾 从 a 远程 服务器. 此 将 是 空 如果 该 设备 曾 本地. |
| DeviceProviderName | 该 设备 提供者 名称, ex: BlackMagic, 用于 此 设备 (如果 任何). |
| DeviceName | 设备 名称 从 该 设备 提供者. 用于 设备 该 具有 no 提供者 (例如 NDI 用于 实例), 此 是 该 名称 的 该 源 或 equivalent. |

**JSON 格式:**

```
	{		"guid": "00000000000000000000000000000000",		"serverName": "",		"deviceProviderName": "None",		"deviceName": "None"	}
```

## Struct: 通道

通道 信息

**属性：**

| 名称 | 说明 |
| --- | --- |
| 名称 | Specifies 该 通道 名称. |
| 类型 | 参见 [Enum: BroadcastChannelType](#enum:broadcastchanneltype). |
| 状态 | 参见 [Enum: BroadcastChannelState](#enum:broadcastchannelstate). |
| IssueSeverity | 参见 [Enum: BroadcastIssueSeverity](#enum:broadcastissueseverity). |
| 设备 | 列表 的 设备. 参见 [Struct: OutputDeviceItem](#struct:outputdeviceitem). |

**JSON 格式:**

```
	{		"name": "",		"type": "Program",		"state": "Offline",		"issueSeverity": "None",		"devices": []	}
```

## Struct: ViewportQualitySettingsFeature

**属性：**

| 名称 | 说明 |
| --- | --- |
| 名称 | 该 名称 的 该 feature 在 该 引擎 显示 标志. |
| bEnabled | 如果为 true 此 引擎 feature 显示 标志 应 是 启用. |

**JSON 格式:**

```
	{		"name": "",		"bEnabled": false	}
```

## Enum: ServerBuildTargetType

构建 targets. 此 将 帮助 确定 该 设置 的 功能 该 为 可用.

**值:**

| 名称 | 说明 |
| --- | --- |
| Unknown |  |
| 编辑器 |  |
| 游戏 |  |
| 服务器 |  |
| 客户端 |  |
| Program |  |

## Enum: ServerEngineMode

一个 编辑器 构建 可以 是 launched 在 不同 模式 但是 它 可以 还 是 a dedicated 构建 目标. 该 引擎 模式 组合 使用 该 构建 目标 将 确定 该 设置 的 functionalities 可用.

**值:**

| 名称 | 说明 |
| --- | --- |
| Unknown |  |
| 编辑器 |  |
| 游戏 |  |
| 服务器 |  |
| Commandlet |  |
| 其他 |  |

## Enum: BroadcastChannelType

该 通道 类型 defines 什么 它 是 使用 用于 在 该 广播 framework.

Primarily, 该 通道 类型 是 intended 到 解决 通道 collisions 之间 simultaneous "program" 和 "预览" playbacks 在 a 给定 系统. 在 其他 words:

- 通道 选择 用于 rundown 页面 是 restricted 到 "program" 通道.
- 通道 选择 用于 预览 是 restricted 到 "预览" 通道.

它 是 thus 不 可能 用于 a 用户 到 mistakenly 选择 该 相同 通道 用于 两者 预览 和 program.

一些 额外的 restrictions 为 应用 根据 到 通道 类型:

- 预览 通道 必须 仅 具有 outputs 本地 到 该 流程. "远程" previews 为 不 支持.
- [后端] 播放 请求 类型 (program 或 预览) 必须 匹配 使用 该 通道 类型. 此 是 a safety net 用于 任何 其他 extended 代码 路径 该 为 不 在 该 运动 Design 插件.

**值:**

| 名称 | 说明 |
| --- | --- |
| Program |  |
| 预览 |  |

## Enum: PageStatus

**值:**

| 名称 | 说明 |
| --- | --- |
| Unknown | 无效 页面 状态. |
| Offline | 输出 是 offline. |
| 缺失 | 当 该 页面 是 不 可用, i.e. 该 资产 是 不 存在 在 该 本地 内容. |
| 需要 同步 | 输出 的 日期 |
| 同步 | 资产 是 正在 downloaded. |
| 可用 | 当 该 页面 是 存在 在 本地 内容, 但是 不 已加载. |
| Loading | 加载/开始 具有 已经 requested. |
| 已加载 | 页面 是 已加载 在 内存 和 就绪 到 play. |
| Playing | 页面 是 当前 playing 在 一个 输出 通道. |
| Previewing | 页面 是 当前 playing 作为 本地 预览. |
| 错误 | Something bad happened. |

## Enum: PageListType

Rundown's 页面 列表 类型.

**值:**

| 名称 | 说明 |
| --- | --- |
| 模板 |  |
| 实例 |  |
| 视图 |  |

## Enum: PageActions

支持 页面 动作 用于 播放.

**值:**

| 名称 | 说明 |
| --- | --- |
| 加载 |  |
| Unload |  |
| Play |  |
| Play 下一个 |  |
| Stop |  |
| Force Stop |  |
| Continue |  |
| 更新 值 |  |
| 采用 到 Program |  |

## Enum: TransitionActions

支持 过渡 动作 用于 播放.

**值:**

| 名称 | 说明 |
| --- | --- |
| Force Stop | 此 操作 将 forcefully stop 指定 transitions. |

## Enum: TransitionLayerActions

支持 页面 逻辑 图层 动作 用于 播放.

**值:**

| 名称 | 说明 |
| --- | --- |
| Stop | 触发 该 输出 过渡 用于 该 指定 图层. |
| Force Stop | Forcefully stop, 不 过渡, 页面 在 该 指定 图层. |

## Enum: PlayableSequenceEventType

**值:**

| 名称 | 说明 |
| --- | --- |
| 开始 |  |
| Paused |  |
| Finished |  |

## Enum: PageTransitionEvents

**值:**

| 名称 | 说明 |
| --- | --- |
| 开始 |  |
| Finished |  |

## Enum: BroadcastOutputState

状态 的 该 media 输出.

**值:**

| 名称 | 说明 |
| --- | --- |
| 无效 | 无效/Uninitialized 状态. |
| Offline | 用于 远程 输出 该 是 不 connected, 输出 禁用. |
| 空闲 | 服务器 Connected 或 本地 (MediaCapture 状态: 停止) |
| Preparing | MediaCapture 状态: Preparing |
| 实时 | Broadcasting (MediaCapture 状态: Capturing) |
| 错误 | MediaCapture 错误 (unrecoverable) |

## Enum: BroadcastIssueSeverity

在 情况 该 广播 设备 是 实时 (参见 EAvaBroadcastOutputState), 此 extra 状态 表示 如果 该 设备 是 operating 通常.

**值:**

| 名称 | 说明 |
| --- | --- |
| None |  |
| 警告 |  |
| Errors |  |

## Enum: BroadcastChannelState

通道 状态 是 a union 概要 的 该 输出's states.

**值:**

| 名称 | 说明 |
| --- | --- |
| Offline | 表示 该 所有 通道 outputs 为 offline. |
| 空闲 | 表示 该 在 least 一些 的 该 通道 outputs 为 空闲 (但是 none 为 实时). |
| 实时 | 表示 该 在 least 一些 的 该 通道 outputs 为 实时. |

## Enum: AssetEvent

Generic 资产 事件

**值:**

| 名称 | 说明 |
| --- | --- |
| 已添加 |  |
| 已移除 |  |

## Enum: ChannelActions

通道 广播 动作

**值:**

| 名称 | 说明 |
| --- | --- |
| 开始 | 开始 广播 的 该 指定 通道(s). |
| Stop | Stops 广播 的 该 指定 通道(s). |

## Enum: ChannelEditActions

**值:**

| 名称 | 说明 |
| --- | --- |
| 添加 | 添加 新增 通道 使用 给定 名称. |
| 移除 | Removes 通道 使用 给定 名称. |
