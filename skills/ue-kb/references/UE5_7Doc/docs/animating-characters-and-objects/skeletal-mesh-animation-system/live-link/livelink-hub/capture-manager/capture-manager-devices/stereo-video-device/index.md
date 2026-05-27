---
title: "立体视频设备"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/stereo-video-device"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "LiveLink Hub", "捕获管理器", "捕获管理器设备", "立体视频设备"]
---

# 立体视频设备

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / LiveLink Hub / 捕获管理器 / 捕获管理器设备 / 立体视频设备

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/stereo-video-device

**立体视频**设备让你可以将成对的视频摄取为立体镜头试拍。 视频还可能随附一份音频文件（`.wav`）。

![立体设备详情](../../../../../../../../assets/images/e7/e7b532397cbfe0283f4682d1baf3bec666c712dfebb736a4b4972597ceca1342.jpg)

- **显示名称（Display Name）**：**设备（Devices）**列表中的设备显示名称。
- **镜头试拍目录（Take Directory）**：成对视频的文件所在根文件夹的路径。 此文件夹可包含子文件夹。
- **视频发现表达式（Video Discovery Expression）**：可从视频的文件夹和文件名中提取的[令牌](index.md#discovery-expression-tokens)，用于识别镜头试拍。
- **音频发现表达式（Audio Discovery Expression）**：可从音频文件的文件夹和文件名中提取的[令牌](index.md#discovery-expression-tokens)，用于识别镜头试拍。

立体视频设备预期在**镜头试拍目录**中找到的内容的直观示例如下：

Console Output

```
+-- take_1
|   +-- top.mov
|   \-- bot.mov
|
+-- take_2
|   +-- audio.wav
|   |-- top.mov
|   \-- bot.mov
|
|-- top.mov
```

## 发现表达式令牌

**视频发现表达式**和**音频发现表达式**用于定义镜头试拍中的视频和音频文件的命名规范。 可用的令牌如下：

|  |  |
| --- | --- |
| `<Slate>` | 场记板名称。 |
| `<Name>` | 立体设备组中的摄像机的标识符。 |
| `<Take>` | 镜头试拍编号。 |
| `<Any>` | 任意有效字符串。 |
| `<Auto>` | 在不使用其他令牌的情况下，根据目录结构自动识别镜头试拍。 |

你可以使用定界符 `_-.\` 来分隔令牌。

> [!NOTE]
> 若未使用`<Auto>`令牌，那么`<Slate>`和`<Name>`都必须存在。

以镜头试拍`MyTakeFolder/MySlate_MyName_SomeString-005.mov`为例。 若视频发现表达式被设为默认值`<Auto>`，则识别以下令牌：

|  |  |
| --- | --- |
| **Slate** | `MyTakeFolder` |
| 名称 | `MySlate_MyName_SomeString-005` |
| **Take** | `1`（默认值） |

但若视频发现表达式被设为`<Slate>_<Name>_<Any>-<Take>`，则提取以下令牌：

|  |  |
| --- | --- |
| **Slate** | `MySlate` |
| **Name** | `MyName` |
| Take | `5` |
| **Any** | `SomeString` |

以上两种情况均会忽略拓展名`.mov`。

这一点对音频文件也同样适用，即所有音频扩展名（例如`.wav`）都会被忽略。
