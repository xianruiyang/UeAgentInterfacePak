# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答

# 高级游戏日志记录 (GLS) 插件（UE5 的运行时日志记录插件）的常见问题解答

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/lpbK/unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5
- 原始文件：unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5.origin.md
- 分段：第 1/5 段

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/lpbK/unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 14173 字符。

## 摘要

此常见问题解答涵盖了有关安装、配置和使用游戏日志系统 (GLS) 的最常见问题 - 一个适用于 U 的高级运行时日志记录插件...

## 中文整理

### 介绍

高级游戏日志记录 (GLS) 是虚幻引擎 5 开发人员的必备工具，可直接在桌面、移动和控制台平台上的发布版本中实现实时日志管理。

### 高级游戏日志记录 (GLS)

由于平台限制，发布版本的登录通常具有挑战性，但 GLS 凭借其用于过滤、搜索和可视化日志的直观界面使这变得毫不费力。无论您是在调试移动游戏还是在控制台上进行测试，GLS 都可以简化您的工作流程，从而节省时间和资源。 GLS 在设计时充分考虑了开发人员和 QA 团队的需求，即使在最受限的环境中，也能确保您保持对日志的控制，从而为高效调试提供可靠的解决方案。

![教程图片](assets/unreal-engine-epic-for-indies-faq-for-advanced-game-logging-gls-plugin-runtime-logging-plugin-for-ue5/image-01.jpg)

### 立即获取游戏日志系统 (GLS)！

您可以在 Fab 上购买 GLS。请尝试 GLS 的演示版。您可以在此处阅读或留下评论。您可以阅读文档。尝试示例构建（Windows、Android）。

### 常问问题

### 基础知识：购买、安装、启动

### 我可以在购买前试用免费版本吗？

是的 — GLS 有免费演示版。请注意： - 下载 GLS 的演示版本。下载 GLS 的演示版。 - 演示必须安装到引擎中，而不是项目中：Engine/Plugins/Marketplace/GameLogsSystem 演示必须安装到引擎中，而不是项目中：Engine/Plugins/Marketplace/GameLogsSystem - 它仅适用于虚幻引擎的 Epic Launcher 版本。它仅适用于虚幻引擎的 Epic Launcher 版本。 - 它没有源代码，因此：不会在自定义/源版本上编译，在发布版本中不起作用，仅适用于 Windows。它没有源代码，因此： - 不会在自定义/源版本上编译，不会在自定义/源版本上编译， - 不适用于 Shipping 版本，不适用于 Shipping 版本， - 仅适用于 Windows。仅适用于 Windows。 Fab 上的完整版本支持 Launcher + GitHub 引擎构建、运输/开发配置以及虚幻引擎支持的所有平台。

### 如果 GLS 在 Mac/iOS 等设备上无法运行怎么办？

对于 Mac/iOS 和其他非 Windows 平台，您需要： - 将插件移至您的项目：来自 Engine/Plugins/GameLogsSystem 的 YourProject/Plugins/GameLogsSystem 将插件移至您的项目：来自 Engine/Plugins/GameLogsSystem 的 YourProject/Plugins/GameLogsSystem - 在编辑 → 插件中启用它。在编辑 → 插件中启用它。 - 为您的目标平台编译项目。为您的目标平台编译项目。 GLS 代码适用于所有主要 UE 平台 - 您只需要一个项目端构建，以便 Unreal 可以针对 Mac/iOS（以及其他非预编译目标）进行编译。

### 如何在我的项目中正确安装和启用 GLS（引擎与项目插件）？

GLS 通过 Fab 或 Epic Launcher 安装。该插件会直接添加到您在安装过程中选择的引擎中。如果您打算自己编译 GLS，则只需将 GLS 移至 Project/Plugins 文件夹中（例如，对于 Mac/iOS 或任何自定义引擎构建）。要启用 GLS： - 将插件添加到您的 .uproject 文件或 将插件添加到您的 .uproject 文件或 - 转到编辑 → 插件，找到游戏日志系统，启用它，然后重新启动编辑器。进入编辑→插件，找到游戏日志系统，启用它，然后重新启动编辑器。

### 为什么插件安装后没有出现在“项目设置”中？

这通常意味着该插件被禁用。进入编辑→插件，启用游戏日志系统，然后重新启动编辑器。

### 我是否需要将 GLS 从引擎/插件移动到项目/插件？何时需要？

通常不会——GLS 在 Engine 文件夹中工作正常。您只需将其移至 Project/Plugins 中，如果： - 您使用源构建引擎并且必须手动编译 GLS，您使用源构建引擎并且必须手动编译 GLS， - 您需要在预编译二进制文件不支持的平台上使用 GLS（Mac/iOS，控制台），您需要在预编译二进制文件不支持的平台上使用 GLS（Mac/iOS，控制台）， - 您想要在项目中修改插件的代码。您想要修改项目中插件的代码。对于所有其他情况，将 GLS 保留在 Engine/Plugins 中就足够了。

### 我可以在引擎/插件和项目/插件中保留 GLS 吗？

是的，但项目/插件中的 GLS 始终优先于引擎版本。技术上是允许的，但只有在您清楚地了解自己在做什么时才使用此选项（例如，测试修改版本），因为： - Engine 和 Project 中的不同版本可能会导致混乱， Engine 和 Project 中的不同版本可能会导致混乱， - 您可能认为您正在使用 Engine 版本，而实际上项目版本处于活动状态。您可能认为您正在使用引擎版本，而实际上项目版本处于活动状态。推荐：除非有特定原因，否则每个项目仅保留一份 GLS 的活动副本。

### 如何在游戏或编辑器中打开 GLS 叠加层？

在 PC 上，使用默认热键：ALT + SHIFT + G。您可以在以下位置更改此设置：项目设置 → 插件 → 游戏日志系统 → OverlayInputMappings。

### 如何更改任何平台的覆盖激活按钮？

您可以在以下位置完全自定义激活键：项目设置 → 插件 → 游戏日志系统 → OverlayInputMappings 您可以： - 设置您自己的键盘/游戏手柄/触摸输入，设置您自己的键盘/游戏手柄/触摸输入， - 更改打开覆盖所需的保持延迟。更改打开叠加层所需的保持延迟。

### 如何从代码或蓝图手动打开 GLS 叠加层？

您可以通过编程方式控制叠加： UGLSOverlaySubsystem* Overlay = UGLSOverlaySubsystem::Get(const UObject* Context); if (Overlay) { 覆盖->DisplayOverlay(); }

### 航运业的 GLS

### 为什么 GLS 覆盖层不显示 Shipping 版本中的日志？

最常见的是因为 GLS 日志记录在设置中被禁用。确保您启用：并在您的配置中：[/Script/GLS.GLSSettings] bEnableLogsInShippingBuilds=True 还要确保您通过 GLS_LOG 或 PrintStringToGLS 进行日志记录 - 常规 UE_LOG 在 Shipping 中被删除。

### 我可以在发布版本中查看 UE_LOG 日志吗？

