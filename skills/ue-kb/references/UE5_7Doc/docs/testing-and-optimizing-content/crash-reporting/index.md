---
title: "崩溃报告"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/crash-reporting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "崩溃报告"]
---

# 崩溃报告

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 崩溃报告

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/crash-reporting-in-unreal-engine

当你的游戏崩溃时，虚幻引擎会创建崩溃报告，它可以将报告发送到 **崩溃报告客户端（Crash Report Client）** 。崩溃报告客户端是一个应用程序，可提示用户提供注释（可选）并向Epic Games提交崩溃报告。你可以自定义随你的游戏打包的崩溃报告客户端，将崩溃报告数据发送到你自己的服务器，以帮助调试游戏。

本指南提供了：

- 崩溃报告及其内容的概述。
- 有关在本地计算机上何处查找崩溃报告的信息。
- 崩溃报告的配置变量参考和项目设置。
- 如何为你自己的打包应用程序修改和配置崩溃报告器客户端。
- 崩溃报告服务推荐，你可以用它接收远程服务器上的崩溃报告。

## 崩溃报告

崩溃报告包含：

- 一个唯一的随机崩溃标识符，即

  崩溃guid

  。
- 有关错误的信息，例如类型（崩溃、断言、确保等），或崩溃线程和其他所有线程的调用堆栈。
- 计算机的系统信息和应用程序上下文信息，例如构建配置。
- 崩溃时的日志输出。这可以是设备运行时日志或项目编辑器日志。
- 游戏使用键/值对提供的额外上下文。
- 用户通过崩溃报告客户端提供的额外注释。

下面是在崩溃报告客户端中查看崩溃报告的示例：

![UE崩溃报告器客户端中显示的崩溃报告。它会提示用户提供关于他们在发生崩溃时正在执行什么操作的信息，并显示崩溃时刻的日志转储。](../../../assets/images/bd/bd0fc9d5519ac05daf738529534f6929a0f5f44f17608629be50ab92990be0b9.png)

### 在哪里查找本地崩溃报告

来自编辑器的崩溃报告存储在你的本地计算机上你的项目的 `Saved/Crashes` 文件夹中。

你也可以在用户本地计算机上的 `C:\Users[Your Windows Username]\AppData\Local[Project Name]\Saved\Crashes` 中找到崩溃报告。

### 虚幻引擎中的常见崩溃原因

以下是出现崩溃报告的最常见原因。这些原因都会启动崩溃报告器客户端，并在调用堆栈上方随附消息，详述遇到的崩溃类型。

| **崩溃源** | **说明** | **示例图像（点击放大）** |
| --- | --- | --- |
| **崩溃（Crash）** | 发生了程序无法处理的事情，因此程序关闭。发生崩溃的原因包括： 访问空对象。 尝试将数据写入不存在的对象。 访问的对象或数据已损坏。 堆栈溢出，通常是由于无限循环或无限递归。 内存不足（OOM）错误。 | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/987319b8-c2af-4c04-a45c-52b273fbacd0/crash.png) |
| **断言（Assert）** | 开发人员故意在代码中放入断言语句，使程序在特定条件下崩溃。这可以验证你关于某些内容在之后的运行期间可能会导致问题的预想，以便及早发现。例如： `check(Mesh != nullptr)` 如需详细了解虚幻引擎中的断言，请参阅[关于断言的文档页面](../../gameplay-systems/programming-with-cpp/asserts/index.md)。 | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/a0e42da7-72af-4c81-9105-c97044190c98/assert.png) |
| **确保（Ensure）** | "确保"会检查特定条件，但不会在解决false后崩溃。相反，它们会向输出日志生成消息，并在无人照管模式下向崩溃报告器发送报告。这可以用于你想监控的事项，但不一定是崩溃执行。例如： `ensure(Number >= 0)` 如需详细了解虚幻引擎中的确保，请参阅[关于断言的文档页面](../../gameplay-systems/programming-with-cpp/asserts/index.md)。 | [undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/583b378f-bd3c-41ff-8731-4a32164e441e/ensure.png) |

## 将自定义上下文添加到崩溃报告

除了添加到崩溃报告的标准信息之外，游戏项目还可以添加自己的自定义上下文，即 **游戏数据** 。这可以是关于游戏模式、玩家在世界中的位置信息，或对于调查漏洞至关重要的其他游戏状态信息。这些数据使用键/值对和 `FPlatformCrashContext::SetGameData` 函数添加。

GenericPlatformCrashContext.h

```
	/** 将任意游戏数据更新（或在尚不存在时添加）到崩溃上下文（传递了空字符串时将删除键） */	CORE_API static void SetGameData(const FString& Key, const FString& Value);
```

请注意，自定义上下文设置在发生错误 **之前**。收集崩溃报告时，会捕获游戏数据值的当前状态并写入报告。

例如，每当你的游戏进入新游戏模式时，调用：

MyGameMode.cpp

```
	void OnEnterMyGameMode()	{		FPlatformCrashContext::SetGameData(TEXT("GameMode"), TEXT("MyGameModeName"));	} 	void OnExitMyGameMode()	{		FPlatformCrashContext::SetGameData(TEXT("GameMode"), FString());	}
```

在该游戏模式期间发生的崩溃将包含以下XMLdata：

CrashContext.runtime-xml

```
 	<GameData>		<GameMode>MyGameModeName</GameMode>	</GameData> 
```

## 崩溃报告器基础设施

UE的崩溃报告基础设施包括以下组件：

1. 用户计算机上的 **崩溃报告客户端** ，随编辑器或你的游戏版本一起发行。崩溃报告客户端会将崩溃转储信息发送给你的终端。
2. 带有能管理、筛选和存储崩溃报告的应用程序和组件的 **服务器**。

下面各小节详述了其中每个组件，以及如何为你自己的组织设置它们。

## 崩溃报告器客户端

崩溃报告器客户端是一个单独程序，可用于编辑器版本，也可选择与用户计算机上的运行时版本打包使用。编辑器或打包的应用程序崩溃时，引擎会生成崩溃报告，然后启动崩溃报告器客户端（如果可用）。如果崩溃报告器不处于无人照管模式，它会显示带有崩溃数据的窗口，并提示用户发送或不发送报告。

### 将崩溃报告器客户端打包进你的游戏

默认情况下，打包的游戏中不含崩溃报告器客户端。要将其添加到你的打包版本中，请执行以下操作：

1. 在虚幻编辑器中，打开 **项目设置（Project Settings）** 并找到 **项目（Project）** > **打包（Packaging）** 。
2. 展开 **高级（Advanced）** 下拉菜单。
3. 启用 **包含崩溃报告器（Include Crash Reporter）** 设置。

你也可以将 `IncludeCrashReporter=True` 添加到你的项目的 `Config/DefaultGame.ini` 文件。

DefaultGame.ini

```
	[/Script/UnrealEd.ProjectPackagingSettings]	IncludeCrashReporter=True
```

### 配置自动崩溃报告

以下配置变量决定了崩溃报告器是否应该自动将崩溃报告发送给服务器。你可以在`[CrashReportClient]` 目录下的任意 `Engine.ini` 文件中进行此类配置。

| **配置变量** | **说明** |
| --- | --- |
| `bAgreeToCrashUpload` | 控制崩溃报告客户端是否应该自动发送崩溃事件。此变量仅用于Linux版本。它在Windows和Mac版本上默认为 `false` ，但在Linux版本上为 `true` 。 |
| `bSendUnattendedBugReports` | 控制是否以无人照管方式发送崩溃事件。如果启用，崩溃报告客户端将跳过对用户显示的步骤，并自动将崩溃事件发送给服务器。此变量适用于所有平台，并默认为 `true` 。 |

DefaultEngine.ini

```
	[CrashReportClient]	bAgreeToCrashUpload=false	bSendUnattendedBugReports=false
```

### 配置崩溃报告器客户端

你可以按项目自定义崩溃报告器客户端。CrashReportClient设置会同时更改崩溃报告器的行为和外观，包括公司名称和服务URL。要自定义崩溃报告器，将以下分段添加到你项目的 `DefaultEngine.ini` 文件：

DefaultEngine.ini

```
 	[CrashReportClient]	CompanyName="[Your Company Name]"	DataRouterUrl="[URL of your crash report server]"	UserCommentSizeLimit=4000	bAllowToBeContacted=true	bSendLogFile=true 
```

> [!NOTE]
> 上文的示例展示了CrashReportClient的一个条目，并非显示的所有值都是强制的。

#### 配置变量参考

下表列出了可用设置。这些应该添加到你的项目的Config/DefaultEngine.ini文件的[CrashReportClient]分段下：

| **属性** | **说明** | **默认值** |
| --- | --- | --- |
| CrashReportClientVersion | 崩溃报告客户端的版本号。 | 空 |
| CompanyName | 设置"允许联系"文本中显示的公司名称。如果为空，文本不会提到特定公司。 | 空 |
| DataRouterUrl | 将接收崩溃报告的服务器。 | 空 |
| UserCommentSizeLimit | 用户可以在注释字段中输入的最大字符数。 | 4000 字符 |
| bSendLogFile | 如果启用，将默认启用"发送日志文件（Send log file）"复选框。 | true |
| bHideLogFilesOption | 如果启用，将显示"发送日志文件（Send log file）"复选框。 | false |
| bAllowToBeContacted | 如果启用，将默认启用"允许联系（Allow contact）"复选框。 | true |
| bIsAllowedToCloseWithoutSending | 控制是否允许用户在不发送报告的情况下关闭对话框。 | true |
| bShowEndpointInTooltip | 控制"发送"按钮上显示的提示文本是否应该显示崩溃发送到的域。 | true |
| bIsAllowedToCopyFilesToClipboard | 控制是否应该显示"复制文件（Copy files）"按钮。允许用户将诊断文件复制到剪贴板。仅在Windows平台上可用。 | false |
| bHideRestartOption | 控制是否显示"发送并重启（Send and restart）"按钮。 | true |

### 崩溃事件会发送到何处？

编辑器版本始终包含崩溃报告客户端，但你可以选择是否将其包含在打包版本中。崩溃报告客户端会根据发生崩溃的构建类型，将崩溃报告和遥测发送到不同的目标。

打包构建始终使用特定于你的项目的崩溃报告器配置值，参见[配置崩溃报告器](#%E9%85%8D%E7%BD%AE%E5%B4%A9%E6%BA%83%E6%8A%A5%E5%91%8A%E5%99%A8)。从UE 5.4开始，Epic Games不再从打包构建接收报告，无论它们是开发还是发布构建，因为我们无法确定一个打包游戏是用于最终用户还是用于测试。

默认情况下，从Epic Games启动程序分发的编辑器构建会将漏洞报告发送给Epic Games，帮助识别虚幻引擎公共版本的问题。要选择退出无人照管的漏洞报告，请执行以下步骤：

1. 在虚幻编辑器中打开 **编辑器偏好设置（Editor Preferences）** 。
2. 找到 **隐私（Privacy）** > **漏洞报告（Bug Reports）** 类别。
3. 选择 **不发送（Don’t Send）** 。

![如果你不希望编辑器将漏洞报告发送给Epic Games，请在](../../../assets/images/47/4786d9499c2c72031f400e5d52fae29dd95225571256e919c3d99dd4d22afbdd.png)

隐私 > 漏洞报告"中选择"不发送"。" loading="lazy" />

发生崩溃时，构建仍会提示用户发送崩溃报告，但你可以选择退出这些选项，方法是关闭崩溃报告器客户端或点击 **关闭而不发送（Close Without Sending）** 。

从源创建的编辑器构建不会将崩溃报告数据发送给Epic Games。

下表汇总了UE在不同类型的构建中会将崩溃事件发送到何处：

| **构建类型** | **启动程序构建** | **源版本** |
| --- | --- | --- |
| **开发编辑器或游戏** | Epic Games/自定义 | 无/自定义 |
| **打包作品** | 无/自定义 | 无/自定义 |

## 崩溃报告服务器

要充分利用崩溃报告器，你需要设置服务器来接收远程用户的崩溃报告并将其符号化。UE不包括带有源代码或二进制文件的此类组件。但是，将源代码用于崩溃报告客户端，你就可以开始创建自己的自定义解决方案。此外，也有一些第三方崩溃报告服务可供你部署。

以下是UE社区中常用的崩溃报告服务。每一类服务都有相关文档，寿命了如何将其与UE的崩溃报告器集成：

| **崩溃报告服务** | **UE文档链接** |
| --- | --- |
| [[Backtrace](https://backtrace.io/)](https://backtrace.io/) | [[为虚幻引擎设置Backtrace](https://docs.saucelabs.com/error-reporting/platform-integrations/unreal/setup/)](https://docs.saucelabs.com/error-reporting/platform-integrations/unreal/setup/) |
| [[Bugsplat](https://www.bugsplat.com/)](https://www.bugsplat.com/) | [[Bugsplat -- 虚幻引擎](https://docs.bugsplat.com/introduction/getting-started/integrations/game-development/unreal-engine/)](https://docs.bugsplat.com/introduction/getting-started/integrations/game-development/unreal-engine/) |
| [[Sentry](https://sentry.io/welcome/)](https://sentry.io/welcome/) | [[Sentry -- 虚幻引擎的崩溃报告客户端](https://docs.sentry.io/platforms/unreal/configuration/setup-crashreporter/)](https://docs.sentry.io/platforms/unreal/configuration/setup-crashreporter/) |
