---
title: "准备资产进行分块"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/preparing-assets-for-chunking-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "补丁和DLC", "常用补丁信息", "准备资产进行分块"]
---

# 准备资产进行分块

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 补丁和DLC / 常用补丁信息 / 准备资产进行分块

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/preparing-assets-for-chunking-in-unreal-engine

**虚幻引擎（UE）** 能够以打包文件的形式交付应用程序主可执行文件之外的资产。为此，你需要将资产整理成文件块，即烘焙过程可以识别的资产文件组。该指南将教你如何在 **虚幻编辑器** 中将资产整理成文件块。完成后，你将有一个示例项目，该项目将生成打包文件，你可以使用补丁系统交付该文件。

## 推荐资产

本指南中将使用以下资产：**Paragon** 中的 **Crunch** 、 **Boris** 和 **Khaimera** ，你可以从虚幻商城免费下载它们。只要你拥有可以安全分组到单独文件夹中的资产，你就无需使用这些特定资产。由于UE已经以这种方式整理Paragon角色资产，因此 **Paragon角色资产（Paragon Character Assets）** 是方便的测试用例。

## 必要设置

继续下一步之前，应查看[设置ChunkDownloader插件](../../using-chunkdownloader-for-patching-unreal-e-c18ea429/setting-up-the-chunkdownloader-plugin/index.md)。

如参考指南中所示，你需要：

1. 基于 **空白模板** 创建 **C++项目** 。将该项目命名为 **PatchingDemo** 。
2. 在 **插件（Plugins）** 菜单中启用 **ChunkDownloader** 插件。
3. 在 **项目设置（Project Settings）> 项目（Project）> 打包（Packaging）** 中，启用 **使用Pak文件（Use Pak File）** 和 **生成块（Generate Chunks）** 。
4. 在 **Visual Studio** 中编辑你项目的 `[ProjectName]Build.cs` 文件。
5. 生成Visual Studio项目文件。
6. 在Visual Studio中构建你的项目。

## 整理分块计划

现在，你已启用分块并设置了插件，你需要整理资产并将其打包为文件块。

> [!NOTE]
> 有关分块过程的更多信息，请参阅[烘培和分块](https://dev.epicgames.com/documentation/404)。

1. 在 **ParagonBoris** 文件夹中点击右键，找到 **创建高级资产（Create Advanced Asset）** > **杂项（Miscellaneous）** ，然后创建新的 **数据资产（Data Asset）** 。
2. 选择 **PrimaryAssetLabel** 作为新数据资产的基类。

   > [!TIP]
   > 你可以在C++中创建PrimaryAssetLabel的子类以便添加额外的元数据。如果在蓝图中为PrimaryAssetLabel创建子类，则这些子类将无法用于分块。
3. 将新的主要资产标签命名为 **Label_Boris** 。
4. 打开 **Label_Boris** ，并填写以下属性：

   | 属性 | 值 |
   | --- | --- |
   | **文件块ID（Chunk ID）** | 对于每个文件夹，这应该是唯一值。这里我们将 **1001** 用于 Boris。 |
   | **优先级（Priority）** | 该值应大于0。这里我们全部设置为 **1** 。 |
   | **烘焙规则（Cook Rule）** | 设置为 **始终烘焙（Always Cook）** 。 |
   | **标记我的目录中的资产（Label Assets in My Directory）** | 设置为 **启用（Enabled）** 。 |
   | **是运行时标签（Is Runtime Label）** | 设置为 **启用（Enable）** |
5. 对 **ParagonCrunch** 和 **ParagonKhaimera** 重复步骤1至4。在此示例中，我们将Crunch的 **ChunkID** 设置为 **1002** ，将Khaimera的 **ChunkID** 设置为 **1003** 。
6. 包装或烘焙项目的内容。

## 最终结果

如果一切设置正确，则在UE完成打包后，你将在构建目录中的 `/Windows/PatchingDemo/Content/Paks` 下看到打包文件。UE将用指定的文件块ID为每个文件命名，每个文件将包含你的三个角色的资产。

你也可以点击 **工具（Tools）> 审核（Audit）> 资产审核（Asset Audit）** ，在资产审核（Asset Audit）窗口中查看你的文件块。

你可以在[烘焙和分块](https://dev.epicgames.com/documentation/404)中找到有关资产审核的更多信息。
