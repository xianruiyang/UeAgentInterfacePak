---
title: "从GitHub下载虚幻引擎源代码"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/downloading-source-code-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "安装虚幻引擎", "从GitHub下载虚幻引擎源代码"]
---

# 从GitHub下载虚幻引擎源代码

> 路径：虚幻引擎5.7文档 / 入门指南 / 安装虚幻引擎 / 从GitHub下载虚幻引擎源代码

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/downloading-source-code-in-unreal-engine

操作系统

Windows

从下拉菜单中选择一个选项以查看与之相关的内容

本页面为订阅用户详细介绍如何从虚幻引擎GitHub仓库下载**虚幻引擎（UE）**的源代码，以及如何利用源代码快速上手。

> [!WARNING]
> 要访问[https://github.com/EpicGames/UnrealEngine](https://github.com/EpicGames/UnrealEngine)上的仓库，你必须满足以下条件：
>
> - 拥有Epic Games账号，
> - 拥有GitHub账号，
> - 已根据[GitHub上的UE](https://www.unrealengine.com/ue-on-github)一文所述步骤，将GitHub账号与你的Epic Games账号关联。

你无需下载源代码就能使用虚幻引擎。 如果你想直接下载并安装虚幻引擎的二进制文件版本，请参阅[安装虚幻引擎](../index.md)一文，以了解如何[获取虚幻](https://www.unrealengine.com/)。 不过，你会发现掌握源代码会为你和项目带来宝贵的信息。 例如：

- 你将获得Epic工程师每天争分夺秒地完成的最新功能和漏洞修复。
- 如果你发现了我们尚未修复的漏洞，但这对你的项目来说影响重大，你可以自己在源代码版本中修复并重新生成二进制文件，以便让项目正常运行。
- 你可以将自己的修复和功能提交给Epic，从而优化引擎并为整个虚幻社区提供帮助。

> [!NOTE]
> 如果你是虚幻引擎的授权用户，你可以通过我们的Perforce服务器访问源代码，而无需通过GitHub的公开仓库访问代码。

## 访问GitHub上的虚幻引擎源代码

虚幻引擎提供完整的C++源代码访问权限，以便用户研究、定制、扩展和调试整个虚幻引擎，并毫无阻碍地完成项目。

随着我们在主线上持续开发新功能，我们位于GitHub上的源代码库也会持续更新。因此你甚至无需等到下一个产品版本就能获得最新的代码。

要访问虚幻引擎源代码，请按以下步骤操作：

1. 前往[GitHub](https://github.com/)并注册账号。
2. 使用经验证的Epic Games[账号](https://accounts.unrealengine.com/)登录[UnrealEngine.com](https://www.unrealengine.com/)。 要打开账号操作面板，请将鼠标悬停到**用户名**上，并在下拉菜单中选择**个人（Personal）**。
3. 打开账号操作面板后，在侧边栏中选择**关联 （Connections）**选项卡。 选择**账号（Accounts）**选项卡，然后选择GitHub图标下方的**关联（Connect）**按钮。
4. 如果你尚未签署《虚幻引擎终端用户许可协议》，需要先浏览协议条款并勾选复选框，然后选择**关联账号（Link Account）**。 如果你登出了GitHub账号，在点击"关联账号"按钮后将会被跳转到GitHub登录。
5. 要完成OAuth应用程序授权流程，请点击**授权EpicGames（Authorize EpicGames）**按钮。 如需详细了解此流程，请参阅[GitHub关于授权OAuth应用程序的概述](https://docs.github.com/en/apps/oauth-apps/using-oauth-apps/authorizing-oauth-apps)。
6. GitHub会发送邮件邀请你加入GitHub上的@EpicGames组织。 你必须在7天内点击邮件内的**加入@EpicGames（Join @EpicGames）**按钮，完成GitHub与Epic Games账号的关联流程。

完成上述步骤后，你将收到来自Epic Games的邮件，确认你的GitHub和Epic Games账号关联成功。 如果你没有收到确认邮件，或账号遇到问题，请向[客服](https://www.epicgames.com/site/customer-service)求助。 现在，你就可以前往我们的[GitHub页面](https://github.com/EpicGames/UnrealEngine)（需要登录）下载完整源代码了。

## 源代码分支

你应该已经注意到，我们已将UE源代码发布在若干个分支中。

![github分支](../../../../assets/images/d8/d86bf9808c2a6aa55b5280234b19ea288fedab223b17d4aeb136d7a79a4fcb7a.jpg)

名字中含有dev、staging和test字样的分支是典型的Epic内部工作分支，对终端用户基本没有用处。在我们稳定新版本或进行在线修正时，可能会时不时出现一些短暂存在的分支。

### 发布分支

**版本（Release）**分支始终代表当前官方版本。 这些分支已经过我们QA团队的充分测试，非常适合用来学习虚幻引擎以及开发项目。 我们会努力保证版本的稳定与可靠，并争取每隔几个月就发布一个新版本。

### 主分支

虚幻引擎大部分活跃的开发工作都发生在[ue5-main](https://github.com/EpicGames/UnrealEngine/tree/ue5-main)分支上。 此分支代表着最新的引擎版本，可能存在错误或未经过编译。 我们将其开放给渴望测试最新功能或与我们同步进行开发的开发者。

> [!WARNING]
> 如果你选择在此分支上工作，请注意它可能比当前官方版本及下一个即将发布的版本分支更超前。 因此，在我们从ue5-main分支直接创建一个新分支作为未来的官方版本前，你创建的、能够在ue5-main分支中运行的内容和代码可能与公开版本不兼容。

> [!NOTE]
> 请参阅我们的[设置Visual Studio文档](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-studio-development-environmen-6a24252b/index.md)，确保你所用的Visual Studio版本与准备使用的虚幻引擎版本兼容。

1. 安装[Windows版GitHub](https://windows.github.com/)，然后[分叉并克隆我们的仓库](https://guides.github.com/activities/forking/)。

   要通过命令行使用Git，请参阅[设置Git](https://help.github.com/articles/set-up-git/)以及[分叉仓库](https://help.github.com/articles/fork-a-repo/)等文档。

   如果你不想用Git，你可以通过右侧的 '下载ZIP'（Download ZIP）按钮获取源代码。 Windows内置的解压工具会将从网上下载的zip文件内容标记为不安全和不宜执行，因此请右键单击zip文件，并选择 '属性...' 和 '解锁'，然后再进行解压。 第三方zip工具通常不需要进行此操作。
2. 安装**Visual Studio**。

   所有桌面版Visual Studio都可以编译虚幻引擎，包括Visual Studio社区版。社区版是面向小型团队和个人开发者的免费工具。 请参阅我们的[设置Visual Studio](../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-studio-development-environmen-6a24252b/index.md)文档，确保你下载了使用虚幻引擎所必须得所有VS组件。
3. 在资源管理器中打开你的源代码文件夹，并运行`Setup.bat`。

   这样将下载引擎的二进制内容和先决程序，并设置虚幻文件关联。 在Windows上，可能会显示SmartScreen警告。 请点击**更多信息（More info）**和**依然运行（Run anyway）**以继续。

   引擎二进制文件的完整下载包需要一些时间才能完成下载。 后续检出只需要下载增量部分，速度将会大幅提高。
4. 运行`GenerateProjectFiles.bat`来为引擎创建项目文件。 这个过程应该不超过一分钟即可完成。
5. 双击`UE5.sln`文件以将项目加载到Visual Studio中。 将你的解决方案配置设置为**开发编辑器（Development Editor）**，将解决方案平台设置为**Win64**，然后右键点击**UE**目标并选择**编译（Build）**。 大概需要10-40分钟完成编译，具体取决于系统规格。
6. 编译完成后，可以将启动项目设置为**UE5**并按**F5**进行调试，以便从Visual Studio加载编辑器。

> [!NOTE]
> 本 页为许可用户展示如何通过GitHub上的源代码库 下载并构建虚幻引擎。 如果你想下载二进制 版本的虚幻引擎，请阅读我们的[安装虚幻引擎](../index.md) 文档以了解如何[获取虚幻](https://www.unrealengine.com/)。

## 其他目标平台

- 如果你安装了Android NDK，可以通过设置脚本下载**Android**支持。 详见[安卓快速入门](../../../mobile-development/android-support/getting-started-and-setup-for-android-projects/setting-up-unreal-engine-projects-for-android-d-db209844/index.md)指南。
- **iOS**开发需要使用Mac。 相关指南见[iOS快速入门](../../../mobile-development/ios-ipados-and-tvos-support/getting-started-and-setup-guides-for-ios-and-tvos/setting-up-an-unreal-engine-project-for-ios/index.md)指南。
- 开发 诸如Sony PlayStation、Microsoft Xbox和Nintendo Switch主机和其他平台 的开发存在权限限制。 你必须拥有这些第三方平台的注册开发者账号才能进行相关开发。

如需 这些平台的额外文档或指南， 请访问Epic专业支持网站， 或前往[虚幻引擎论坛](https://forums.unrealengine.com/)的各平台板块下载对应的归档文件。

如果 你没有访问这些资源的权限，请先前往这些第三方平台网站 注册一个开发者账号， 然后联系你的Epic Games 账号管理员（如有），如果没有，请填写并提交虚幻引擎[主机开发申请](https://epicgames.secure.force.com/Forms/FormConsoleAccessRequest?) 表格。 Epic会联系你并发送一封 可供数字签名的正式协议。 申请一经批准，你就将 收到关于如何访问目标平台源代码、二进制文件 及其他内容的指南。

## 许可和贡献

你在GitHub上对虚幻引擎的访问和使用受[虚幻引擎最终用户许可协议](https://www.unrealengine.com/eula)的约束。 如果你不同意这些条款（我们会不时对它们加以修订），你将不会被获准访问或使用虚幻引擎。

我们欢迎你通过GitHub上的[拉取请求](https://github.com/EpicGames/UnrealEngine/pulls/)为虚幻引擎的开发做出贡献。 我们大部分的积极开发都在**主** 分支中进行，所以我们更喜欢在那里接受拉取请求（对于新 功能而言尤其如此）。 我们尽力确保所有新代码都遵守

Epic Games 编码标准

。 所有贡献均受 EULA条款的约束。

## 后续步骤

现在你已经下载并设置了虚幻引擎，你可以随时[从源代码编译引擎](building-unreal-engine-from-source/index.md)。

#### 注意事项

当你首次编译源代码并启动编辑器时，加载时间可能会比较长。 引擎会针对你的平台优化内容并将信息保存为 *派生数据缓存*，这种优化应该只会进行一次。

你为虚幻引擎代码设置的Fork分支会与你的GitHub账号权限关联。 如果你取消了订阅或切换了GitHub用户名，则需要重新创建Fork分支并从本地副本上传改动内容。
