---
title: "发布项目"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/preparing-unreal-engine-projects-for-release"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "游戏的打包（Packaging）和烘焙（Cooking）", "发布项目"]
---

# 发布项目

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 游戏的打包（Packaging）和烘焙（Cooking） / 发布项目

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/preparing-unreal-engine-projects-for-release

使用 **虚幻编辑器（Unreal Editor）** 打包项目的发布版本以便发行。本页面以面向Windows平台打包项目为例，介绍如何打包发布版项目。按照以下步骤通过 **项目启动程序（Project Launcher）** 打包你的项目。打包过程的细节取决于你建立的项目针对哪个平台，即你是在创建Windows游戏、发行移动设备项目还是在针对另一平台。据此，你对完成的打包内容所采取的步骤将有所不同。

下例打包的是1.0版第三人称游戏，针对的是64位Windows系统，使用的语言为英语。

## 打开项目启动程序

1. 点击虚幻编辑器（Unreal Editor）**工具栏（Toolbar）** 的 **平台（Platforms）** 按钮，然后选择 **项目启动程序（Project Launcher）** 。
2. 点击 **添加（Add）** 按钮创建一个新的自定义启动配置文件。
3. 设置该配置文件的名称和说明。

## 自定义项目的调整

发布流程中有许多可用的设置。

#### 项目

在 **项目（Project）** 分段下，你可以设置特定项目，或使用 **任意项目（Any Project）** 。

#### 构建

1. 将 **构建（Build）** 配置设置为 **发行（Shipping）** 。
2. （可选）如果你需要将 **虚幻自动化工具（UAT））** 编译为版本的一部分，请展开 **高级设置（Advanced Settings）** 。

#### 烘焙

1. 在下拉菜单中，选择 **按常规（By the Book）** 作为烘焙方法。
2. 选中你要烘焙的内容所面向的所有平台的复选框。在本例中，为了进行Windows测试，我们选择了 **WindowsNoEditor** 。
3. 选中你要烘焙本地化内容时所面向的所有文化的复选框。
4. 选中要烘焙的贴图的复选框。
5. 在 **发布/DLC/修补设置（Release/DLC/Patching Settings）** 中：

   - 选中

     创建游戏的发布版本以进便发行。（Create a release version of the game for distribution.）

     复选框。
   - 输入该发布版的版本号。
6. 展开 **高级设置（Advanced Settings）** ，确保启用以下选项，并启动以及你的特定项目的发行方法所需的其他选项：

   - 压缩内容（Compress content）

     。
   - 保存无版本包（Save packages without versions）

     。
   - 将所有内容存储到单个文件（UnrealPak）（Store all content in a single file (UnrealPak)）

     。
7. 此外，在 **高级设置（Advanced Settings）** 下，将 **烘焙器编译配置（Cooker build configuration）** 设置为 **发行（Shipping）** 。

#### 打包

将此版本设置为 **打包并存储在本地（Package & store locally）** 。

#### 部署

1. 将 **部署（Deploy）** 设为 **不部署（Do not Deploy）** 。
2. 完成上述所有设置后，使用右上角的 **返回（Back）** 按钮返回主配置文件窗口。
3. 点击 **发布（Release）** 配置文件旁的启动图标。
4. 项目启动程序将经历构建、烘焙和打包过程。这可能需要一些时间，具体视项目复杂性而定。
5. 操作完成后，关闭窗口或点击 **完成（Done）** 。现在你可以通过以下步骤测试补丁。
6. 保存 `[ProjectName]\Releases[ReleaseVersion][Platform]` 中的资产注册表和pak文件。在本例中，路径为 `ThirdPersonGame\Releases\1.0\WindowsNoEditor` 。

   > [!TIP]
   > 未来的所有补丁或DLC都需要根据资产注册表和pak文件进行检查。
7. 在Windows上，你可以从 `[ProjectName]\Saved\StagedBuilds\WindowsNoEditor` 进行项目运行测试。

> [!NOTE]
> 虽然Steam允许你上传完整的游戏包并会为你执行更新流程，但通过Steam发行时，仍然推荐 使用这里概述的发布版本。如果你以后决定添加其他支持的平台或发行方法，这样做将使添加过程更加顺利。
