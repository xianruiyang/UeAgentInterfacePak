---
title: "托管ChunkDownloader的清单和资产"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hosting-a-manifest-and-assets-for-chunkdownloader-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "补丁和DLC", "使用ChunkDownloader实现游戏补丁功能", "托管ChunkDownloader的清单和资产"]
---

# 托管ChunkDownloader的清单和资产

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 补丁和DLC / 使用ChunkDownloader实现游戏补丁功能 / 托管ChunkDownloader的清单和资产

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hosting-a-manifest-and-assets-for-chunkdownloader-in-unreal-engine

**虚幻引擎** 的 **ChunkDownloader** 修补解决方案要求你将.pak文件分发到Web服务器，并且你还必须构建 **清单文件（manifest file）** 。这是一个文本文件，其中包含用户希望下载的所有文件列表以及每个文件的预期大小。

当修补流程开始后，清单是ChunkDownloader将下载到用户设备的第一项内容，它使用此信息逐个请求和下载每个.pak文件。预期文件大小让系统能够识别每个文件的进度。

## 1. 必要设置

本指南使用[设置ChunkDownloader插件](../../using-chunkdownloader-for-patching-unreal-e-c18ea429/setting-up-the-chunkdownloader-plugin/index.md)和[准备资产进行分块](../../general-patching-information/preparing-assets-for-chunking/index.md)中的项目。

如参考指南中所示，你需要：

1. 基于 **空白模板** 创建 **C++项目** 。将该项目命名为 **PatchingDemo** 。
2. 在 **插件（Plugins）** 菜单中启用 **ChunkDownloader** 插件。
3. 在 **项目设置（Project Settings）> 项目（Project）> 打包（Packaging）** 中，启用 **使用Pak文件（Use Pak File）** 和 **生成块（Generate Chunks）** 。
4. 在 **Visual Studio** 中编辑你项目的 `[ProjectName]Build.cs` 文件。
5. 生成Visual Studio项目文件。
6. 在Visual Studio中构建你的项目。
7. 将 **Paragon** 的 **Boris** 、 **Crunch** 和 **Khaimera** 资产添加到该项目。
8. 基于 **主要资产标签（Primary Asset Label）** 为每个添加的资产调整 **数据资产（Data Asset）** 。

## 2. 构建清单文件

要创建清单文件，请按照以下步骤操作：

1. 在项目的基本目录内部创建名为 **PatchingDemoKey** 的文件夹。在我们的示例中，该文件夹为 **PatchingDemo/PatchingDemoKey** 。
2. 创建一个名为 **BuildManifest-Windows.txt** 的新文件，然后在文本编辑器中打开该文件。
3. 添加具有 `$NUM_ENTRIES` 字段的新行，将其值设置为等于你要追踪的pak文件数。在我们的示例中，此值为 **3** 。

   BuildManifest-Windows.txt

   ```
        $NUM_ENTRIES = 9 
   ```
4. 添加具有 `$BUILD_ID` 字段的新行，将其值设置为 **PatchingDemoKey** 。

   BuildManifest-Windows.txt

   $BUILD_ID = PatchingDemoKey
5. 为你的每个.pak文件添加条目，并包含以下信息：

   - **.pak文件名（.pak filename）** 。
   - **.pak的文件大小（字节）（.pak's file size in bytes）** 。要找到此信息，请右键点击.pak文件，并查看其 **属性（properties）** 。

   ```
         确保使用该.pak文件的文件大小，而不是磁盘大小。 
   ```

   - **.pak版本（.pak version）** 。你可以将其设置为任意字符串。
   - **.pak编号（.pak number）** 。此值应该匹配你用于主要资产标签的 **文件块索引（chunk index）** 。
   - **.pak文件路径（.pak file path）** ，相对于清单文件所在位置。

   每个字段都必须在同一行中，用制表符分隔，否则将无法正确解析。例如，我们的pakchunk1001行如下所示：

   ```
        BuildManifest-Windows.txt      pakchunk1001-WindowsNoEditor.pak	922604157	ver 1001	/Windows/pakchunk1001-WindowsNoEditor.pak 
   ```
6. 将 `/WindowsNoEditor/PatchingDemo/Content/Paks/` 中的.pak文件和名为 **Windows** 的子文件夹中的清单复制到 **PatchingDemoKey** 文件夹。

无论何时打包你的项目或要更改可供用户使用的文件，都需要重复此流程。我们示例的最终清单文件如下所示：

BuildManifest-Windows.txt

```
	$NUM_ENTRIES = 9	$BUILD_ID = PatchingDemoKey	pakchunk1001-Windows.ucas	462081824	ver01	1001	/Windows/pakchunk1001-Windows.ucas	pakchunk1002-Windows.ucas	928512432	ver01	1002	/Windows/pakchunk1002-Windows.ucas	pakchunk1003-Windows.ucas	944181856	ver01	1003	/Windows/pakchunk1003-Windows.ucas	pakchunk1001-Windows.utoc	426692	ver01	1001	/Windows/pakchunk1001-Windows.utoc	pakchunk1002-Windows.utoc	606278	ver01	1002	/Windows/pakchunk1002-Windows.utoc	pakchunk1003-Windows.utoc	581683	ver01	1003	/Windows/pakchunk1003-Windows.utoc	pakchunk1001-Windows.pak	339	ver01	1001	/Windows/pakchunk1001-Windows.pak	pakchunk1002-Windows.pak	339	ver01	1002	/Windows/pakchunk1002-Windows.pak	pakchunk1003-Windows.pak	339 ver01	1003	/Windows/pakchunk1003-Windows.pak 
```

> [!NOTE]
> 索引为0的文件也位于 `[Build_Folder]/Windows/PatchingDemo/Content/Paks` 目录中。你不需要将它们的信息添加到Manifest文件中并将它们复制到PatchingDemoKey中。

## 3. 将文件托管到本地测试服务器

现在，你已经打包了文件，那么需要将其托管到服务器上以供您的游戏下载，并且需要告知ChunkDownloader如何找到服务器。出于演示目的，我们将设置一个简单的本地网站。

1. 在Windows资源管理器中，打开 **开始菜单（Start Menu）** ，搜索 **打开或关闭Windows功能（Turn Windows Features on or off）** ，将其打开。
2. 在 **Windows功能（Windows Features）** 菜单中，启用 **Internet Information Services** ，然后点击 **确定（OK）** 。
3. 打开 **Internet Information Services管理器（IIS管理器）（Internet Information Services Manager (IIS Manager)）** ，然后启用 **目录浏览（Directory Browsing）** 。
4. 在窗口左侧的 **连接（Connections）** 菜单中，展开 **网站（Sites）** 并点击 **默认网站（Default Web Site）** 。
5. 在 **默认网站主页（Default Web Site Home）** 菜单中，双击 **MIME类型（MIME Types）** 。
6. 在 **MIME类型（MIME Types）** 菜单中， **点击右键** 然后点击 **添加（Add）** 。
7. 在 **添加MIME类型（Add MIME Type）** 窗口中，将 **文件扩展名（File Name extension）** 设置为 **.pak** ，然后将 **MIME类型（MIME type）** 设置为 `application/octet-stream` 。

   这将确保IIS在收到请求时就可以下载文件。
8. 找到 **默认网站（Default Web Site）** 文件夹。默认为 `C:\inetpub\wwwroot` 。创建名为 **PatchingDemoCDN** 的文件夹。
9. 将 **PatchingDemoKey** 文件夹复制到 **PatchingDemoCDN** 中。
10. 打开你的项目的 `DefaultGame.ini` 文件，然后添加以下信息以定义 **CDN基本URL（CDN Base URL）** ：

    DefaultGame.ini

    [/Script/Plugins.ChunkDownloader PatchingDemoLive] +CdnBaseUrls=127.0.0.1/PatchingDemoCDN

    此URL将ChunkDownloader指向文件所在的网站。 **PatchingDemoLive** 限定符让你可以根据目标平台来使用不同的CDN部署配置。

> [!NOTE]
> 我们在此示例中使用的URL仅指向我们在早前步骤中设置的本地网站。如果你要尝试连接至具有本地局域网或远程CDN的服务器，你需要提供额外的配置和安全性。

## 最终结果

现在，你已经将资产拆分成.pak文件，然后放到本地网站上，你可以利用虚幻引擎中的修补解决方案访问这些文件。
