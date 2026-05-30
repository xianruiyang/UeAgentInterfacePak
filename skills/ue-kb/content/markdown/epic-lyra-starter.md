# 将 Epic 在线服务与 Lyra Starter 游戏结合使用

# 将 Epic 在线服务与 Lyra Starter 游戏结合使用

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/375e/unreal-engine-using-epic-online-services-with-lyra-starter-game

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 20927 字符。

## 摘要

分步教程描述如何使用 Epic Online Services 获取适用于 UE5 的 Lyra 示例游戏

## 中文整理

### 概览

与虚幻引擎 5.0 一起发布的 [Lyra Starter Game](https://docs.unrealengine.com/5.0/en-US/lyra-sample-game-in-unreal-engine/) 旨在作为开发可发布多人游戏的示例和基础。它的设计具有完整的在线和多人游戏支持，并与 [Epic Online Services](https://dev.epicgames.com/en-US/services) (EOS) 后端集成。但是，如果没有额外的设置，您从 Epic Games Launcher 下载的 Lyra 版本将无法在 EOS 上运行。本教程旨在帮助程序员（或任何想要学习的人）完成设置在 Lyra 中完全启用 EOS 支持所需的适当帐户和选项的过程。完成本教程中的步骤后，您将顺利创建可以在 Epic Games Store 或其他平台上发布的多人游戏。本具体教程仅涵盖设置 PC 游戏以使用 EOS，但可以作为使用 EOS 实现全平台跨平台游戏的基础。

### Epic 帐户和引擎设置

要在 Lyra 中使用 EOS，您需要设置用于 EOS 和引擎源代码访问的帐户： 1. 您将需要至少 2 个 Epic 帐户来测试多人游戏。如果您正在阅读本教程，您可能已经拥有一个帐户，但您将需要第二个帐户来测试多人游戏。要创建新帐户，您可以转到正常的 [Epic Games Store 页面](https://store.epicgames.com/en-US/)，选择“登录”，然后使用新的电子邮件地址和密码进行注册。使用第二个浏览器登录您的第二个帐户会更快。 2. 要启用完整的 EOS 支持，您需要一个有权访问虚幻引擎源代码的帐户。除非您可以通过共享公司源代码控制服务器或 Epic 的 perforce 服务器进行访问，否则您应该首先按照 [GitHub 页面上的 UE](https://www.unrealengine.com/en-US/ue-on-github) 中所述将您的主 Epic 帐户与 GitHub 同步。 3. 获得源代码访问权限后，您应该按照[UE5下载虚幻引擎源代码文档](https://docs.unrealengine.com/5.0/en-US/downloading-unreal-engine-source-code/)中的步骤实际下载并安装引擎源代码。您将需要安装引擎的 Release 分支，并且可以使用 Visual Studio 2019 或 Visual Studio 2022。下载源代码并运行 Setup.bat 可能需要很长时间，因此您可以在等待完成时继续其余的帐户创建操作。 4. 您需要在两个帐户上启用双因素身份验证才能访问 EOS 开发人员工具。这可以在登录后从“帐户”页面完成，或者应在下一步中提示。 5. 两个 Epic 帐户都需要访问 [EOS 开发者门户](https://dev.epicgames.com/portal/)，当您导航到该站点（或从主 [EOS 页面](https://dev.epicgames.com/en-US/services) 选择开发者门户）时，它将要求您接受许可证并创建组织。您应该使用您的主帐户创建一个组织（您可以在**组织设置**中重命名）。它还可以为您的辅助帐户创建一个组织，但本教程中不会使用它。 6. 使用开发门户登录您的主帐户和组织后，您可以将辅助帐户添加到组织。开发中的测试可能不需要这样做，但现在是设置它的好时机。为此，请选择左侧的**组织**部分，从**团队**选项卡中单击**邀请**，然后填写您的辅助帐户的电子邮件地址。该角色对于开发测试并不重要，因此您可以在单击“邀请”之前选择“社区工具”。 7. 您的辅助帐户将在电子邮件中收到邀请链接，您需要在登录辅助帐户时访问该链接。您可以将该 URL 复制粘贴到您的辅助帐户已登录的浏览器中以接受邀请。接受邀请后，辅助帐户将不会用于测试期间登录以外的任何其他用途。

![组织设置页面示例](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-01.jpg)

### EOS 产品设置

现在您已经拥有具有开发人员访问权限的 Epic 帐户和组织，您需要在后端设置一个可在 Lyra 本地副本中使用的产品。要在 PC 上开发和测试 Lyra，需要完成核心 EOS 游戏服务和 Epic 帐户服务的设置。 [Epic Account Services (EAS)](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/index.html) 提供旨在与 EOS 集成的身份验证和社交工具。如果您有权访问平台或发布商提供的其他身份验证系统，则不需要使用 EAS。 Lyra 使用 EAS 处理开发登录以及与 Epic Games Store 的集成。本节中的步骤均在 [开发者门户](https://dev.epicgames.com/portal/) 中执行，并涵盖与 [EOS 设置指南](https://dev.epicgames.com/en-US/news/how-to-set-up-epic-online-services-eos) 和 Epic 帐户服务 [入门] 相同的信息页](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/GettingStarted/index.html): 1. 首先，您需要设置一个[产品](https://dev.epicgames.com/docs/services/en-US/DevPortal/ProductManagement/index.html)。如果左侧已列出一个产品，则可以选择它，选择 **产品设置**，然后将其重命名为“Lyra 测试产品”之类的名称。或者，您可以使用仪表板上的 **创建产品** 按钮添加新产品。现在，在左侧选择您的产品以查看各种 EOS 功能的选项。 2. 接下来，您需要为您的 Lyra 版本设置 [客户端](https://dev.epicgames.com/docs/services/en-US/DevPortal/ClientCredentials/index.html) 和客户端策略。从“**产品设置**”中，单击“**客户**”选项卡，该选项卡将提示您阅读并接受法律协议。执行此操作后，您可能会看到有关附加许可证的通知，对于本教程，您将需要接受 Epic 帐户服务的许可证。 3. 单击 **添加新客户端** 按钮创建一个新客户端并将其命名为“Lyra Test Client”或类似名称。然后，您需要单击“**添加新客户端策略**”，并将其命名为“点对点客户端”，因为它可以重复用于多个产品。对于策略类型，选择 **Peer2Peer **，因为它提供了 Lyra 所需的一切。单击“**保存并退出**”两次以保存您的新策略和客户端。 4. 由于 Lyra 使用 Epic Account Services 作为身份机制，因此您需要[设置一个应用程序](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/GettingStarted/index.html)以将您之前定义的产品与 EAS 连接。为此，请选择左侧的 **Epic 帐户服务**，然后单击现有应用程序（可能称为 UserName 的产品）上的 **权限 ** 字段。或者，您可以单击“**创建应用程序**”，然后单击右上角的“**权限**”选项卡。 [品牌设置](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/BrandReview/index.html)需要在发布前设置，但开发和测试时不需要设置。 5. 在 **权限 ** 页面上，您应该启用 **在线状态** 和 **朋友 **，因为 Lyra 需要它们来启用社交功能。单击“**保存更改**”，然后选择“**链接的客户端**”。 6. 在“链接的客户端”页面上，选择 Lyra 测试客户端（或任何您所称的名称）以将其链接到此应用程序，然后单击“**保存更改**”。这样就完成了开发和测试所需的产品设置，**产品设置**页面包含您稍后需要的所有信息。 7. EOS设置的最后一步是安装[开发者身份验证工具](https://dev.epicgames.com/docs/services/en-US/EpicAccountServices/DeveloperAuthenticationTool/index.html)。这使得多人游戏测试变得更加容易，因为您可以使用每个帐户登录一次，而不必每次启动游戏时都进行两步登录。 UE5 源安装的 **Engine/Source/ThirdParty/EOSSDK/Tools** 文件夹内有一个身份验证工具的副本。或者，它可以在 EOS SDK 中找到，可以从开发门户下载。您正在寻找一个名为 **EOS_DevAuthTool-win32-x64-1.0.1.zip** 之类的文件，您应该将其解压缩到方便以后使用的地方。

![设置后的 Epic 帐户服务页面示例](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-02.jpg)

![设置完成后的示例产品设置页面](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-03.jpg)

### 安装和配置 Lyra

此时，您应该拥有完整下载的引擎版本和完整设置的 EOS 产品。

这些步骤介绍了安装、配置和构建 Lyra 的过程，以便它可以与 EOS 一起使用。

其中一些步骤反映了[一般 Lyra 文档](https://docs.unrealengine.com/5.0/en-US/lyra-sample-game-in-unreal-engine/) 中的步骤。

如果您已经将 Lyra 安装到从启动器下载的二进制版本的引擎中，则可以跳到步骤 7: 1。

打开 Epic Games Launcher（使用您的主帐户登录），选择左侧的 **Unreal Engine**，然后选择顶部的 **Samples **。

单击“**Lyra Starter Game**”，然后单击“**创建项目**”。

2.

不要**接受默认设置。

相反，为项目命名（如果您打算将 Lyra 改编到另一个游戏中，您应该在此处使用该名称）并选择安装引擎源代码的根文件夹。

例如，如果您将引擎源代码安装到 **C:\UE5**，请单击“浏览”选择该文件夹，然后单击“创建”下载项目。

之后，您应该有一个 Engine 子文件夹和一个与您刚刚选择的项目名称（默认为 LyraStarterGame）匹配的子文件夹。

3.

此时，您应该安装位于 **Engine/Extras/UnrealVS** 中的 [UnrealVS 扩展](https://docs.unrealengine.com/5.0/en-US/using-the-unrealvs-extension-for-unreal-engine-cplusplus-projects/)，因为它可以轻松更改 Visual Studio 内的启动项目和命令行参数。

4.

转到引擎源代码安装的根目录（例如 **C:\UE5**）并运行 **GenerateProjectFiles.bat** 以创建一个名为 **UE5.sln** 的新解决方案文件。

双击该文件以加载 Visual Studio，加载完成后，您应该会看到您的 LyraStarterGame 版本列在解决方案资源管理器侧的游戏类别下（以及 LyraGameEOS）。

5.

右键单击 LyraStarterGame（或您命名的任何名称），选择 **设置为启动项目**，然后[构建项目](https://docs.unrealengine.com/5.0/en-US/compiling-game-projects-in-unreal-engine-using-cplusplus/)。

这将编译 Lyra 及其所需的所有引擎功能，并且可能需要很长时间。

如果出现任何编译错误，则需要先解决它们，然后才能继续。

默认情况下，Visual Studio 将编译开发编辑器版本，但如果您想调试 Lyra 游戏代码，也可以使用 DebugGame 编辑器。

6.

从源代码构建 Lyra 后，您可以从调试菜单运行它（第一次会很慢，因为它需要编译着色器）并探索示例。

7.

一旦您知道 Lyra 正常运行，您就需要针对 EOS 进行设置。

Lyra 附带了 EOS 特定的配置文件，这些配置文件是使用 [通用用户插件文档](https://docs.unrealengine.com/5.0/en-US/common-user-plugin-in-unreal-engine-for-lyra-sample-game/) 中描述的 CustomConfig 功能启用的。

需要修改的具体文件是位于项目内 **Config/Custom/EOS** 文件夹中的 **DefaultEngine.ini** 的副本。

打开该文件并找到以 **";+Artifacts=(ArtifactName=”** 开头的行。

并删除开头 **;** 以取消注释。

8.

您现在需要为之前制作的 EOS 产品修改此行。

您需要的信息都可以在 EOS 仪表板的产品设置页面上看到。

[EOS OSS 插件文档](https://docs.unrealengine.com/4.27/en-US/ProgrammingAndScripting/Online/EOS/) 中描述了执行此操作的过程，但以下是重要字段： - **ArtifactName** 用于标记此独特的设置组合，它应与同一文件中的 DefaultArtifactName=OSSv1EOS 行的值匹配。

在开发后期，您可以设置多个条目，以根据商店后端的工件设置选择正确的设置。

- **ProductID**、**ClientID** 和 **ClientSecret ** 应从开发门户的产品和客户端部分中的相同字段复制。

您可以单击带有两个方块的按钮将这些值复制到剪贴板，然后将它们粘贴到文本编辑器中。

- **SandboxID **描述了如何查找成就等数据，您现在可以使用默认 Live 沙箱的 ID。

同样，**DeploymentID ** 可以设置为发布 ID，因为游戏仍处于开发阶段。

一旦您进一步进行开发，您可能需要创建多个部署以进行测试和发布。

- **EncryptionKey **用于加密保存在云端的客户端编写的文件，但Lyra实际上并未使用该功能。

您可以将此值设置为“0”或任何带引号的随机 64 位数字。

9.

修改配置文件后，保存，设置过程就完全完成了。

### 准备从 Visual Studio 进行测试

理论上，此时一切都应该完全正常工作，但现在是在编辑器和打包版本中测试游戏的时候了： 1. 在 Visual Studio 中，您应该启用 UnrealVS 工具栏（右键单击并在列表中查找它），然后将 ** -game -customconfig=EOS** 添加到命令行部分。您的项目名称应该已经在命令行文本框中。 2. 然后，再次调试项目以使用该命令行启动，该命令行告诉它以独立游戏模式启动并使用 EOS 配置文件。启动完成后，您应该会看到错误消息“登录失败未实现”，如果单击“确定”，您应该会看到 Lyra 主菜单。此错误消息意味着它正在尝试使用 EOS 但无法实际登录，因为您没有在命令行上指定足够的信息。如果您没有看到登录失败错误消息，则配置文件可能有问题，因此您应该在输出日志中搜索任何错误...

![错误提示EOS已启用但登录失败](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-04.jpg)

![UnrealVS 中的示例命令行](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-05.jpg)

### 在编辑器构建中测试 EOS

![游戏第一个实例的主机设置](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-06.jpg)

![第二个实例上的加入屏幕显示可加入的主机](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-07.jpg)

### 打包 LyraGameEOS

![来自编辑器的打包 LyraGameEOS](assets/unreal-engine-using-epic-online-services-with-lyra-starter-game/image-08.jpg)

### 下一步

