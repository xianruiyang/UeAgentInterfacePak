# Cooking and Chunking

---
title: "Cooking and Chunking"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cooking-content-and-creating-chunks-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "游戏的打包（Packaging）和烘焙（Cooking）", "Cooking and Chunking"]
---

# Cooking and Chunking

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 游戏的打包（Packaging）和烘焙（Cooking） / Cooking and Chunking

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cooking-content-and-creating-chunks-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

当你 **烘焙** 项目时， **虚幻引擎** 可以将游戏资产拆分为独立的 **chunk** ，用于 DLC 和补丁等可独立分发的内容。chunk 是引擎资产管理系统能够识别的带编号资产集合；项目烘焙时，每个 chunk 都会生成一个 **.pak** 文件，随后可以通过内容分发系统进行分发。

可以使用 **[Asset Manager](https://dev.epicgames.com/documentation/assets/setting-up-your-production-pipeline/asset-management)** 或 **Primary Asset Label**将资产指定为属于特定 chunk。两者都会使用规则和元数据系统构建 chunk，并在烘焙过程中读取这些信息。以下小节概述如何使用这些工具，以及如何在编辑器中与 chunk 交互。

## 理解 Primary Asset Rule

一个 **primary asset** 是可由 Asset Manager 直接操作的资产，而 **secondary asset** 是在 primary asset 引用它们时自动加载的资产。烘焙和分块流程引用的是 primary asset 类型。

**Primary asset rule** 用于确定哪些 primary asset 对哪些 secondary asset 拥有管理权限，以及在烘焙过程中如何处理资产。这些规则由 `FPrimaryAssetRules` 结构定义，并由 Asset Manager 用于确定烘焙时如何处理 Asset。关于其中可用选项的详细信息 `FPrimaryAssetRules`，请查看它的 [API 页面](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/FPrimaryAssetRules?application_version=5.5) 。你可能还需要查看以下位置定义的 Cooking Rule： `EPrimaryAssetCookRule` [API 页面](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/EPrimaryAssetCookRule?application_version=5.5).

primary asset rule 的一个功能是组织 chunk。通过定义规则并为其指定 **Chunk ID**，所有符合该规则的 primary asset 都会被划分到具有该 ID 编号的 chunk 中。这些 primary asset 拥有管理权限的任何 secondary asset 也会一起被放入同一 chunk。

### Chunk 组织

未指定具体 chunk ID，或指定了负数 chunk ID 的任何资产，都会作为 chunk 0 的一部分打包。chunk 0 是随游戏基础数据分发的“默认”chunk。ID 值高于 0 的任何 chunk，都会在烘焙时被分离成不同的 `.pak` 文件。可以按适合项目的任意方式组织 chunk。例如，ShooterGame 示例项目包含三个 chunk：

- chunk 1 用于“Sanctuary”地图
- chunk 2 用于“Highrise”地图
- chunk 0 用于所有其它数据

ShooterGame 将地图识别为 primary asset，因此地图使用的任何 secondary asset，例如纹理或网格体，只要该地图对其拥有管理权限，就会使用该地图的 chunk ID。

再举一个例子，如果你正在制作 MOBA 或其它“英雄制”游戏，可以将不同英雄的基础资产划分到特定 chunk 中，也可以将额外服装或皮肤划分到各自的 chunk 中，以便单独分发。

## 在项目中定义 chunk

虚幻引擎提供多种方法来操作 primary asset rule 并定义 chunk。可以在 Asset Manager 中定义 primary asset rule，也可以直接在 `*Game.ini` 文件中编辑它们，或在 Content Browser 中使用 Primary Asset Label。

### 使用 Asset Manager 定义 chunk

可以通过打开 **Project Settings** 并导航到 **Game** > **Asset Manager**.

![Primary Asset Rules settings in the Asset Manager, under Project Settings](../../../../assets/images/a3/a36f9d3585911d3f11a5995c4ea22a0349d9bd74ab68254320fa239c5524c513.jpg)

在 Asset Manager 设置中编辑 Primary Asset Rule。点击图片可放大。

**Primary Asset Types to Scan** 用于指定希望 Asset Manager 识别为 primary asset 的资产类型。 **primary asset rule** 列表允许指定各个 primary asset 的 **Priority** 和 **Chunk ID** 。

### 使用配置中的规则覆盖定义 chunk

**Rules Overrides** 可用于在配置中为特定 primary asset 建立优先级和 chunk 设置。要使用 Rules Overrides 而不是 Primary Asset Label 为 ShooterGame 构建三 chunk 设置，应在以下文件中创建如下小节： `DefaultGame.ini`:

C++

```
[/Script/Engine.AssetManagerSettings]	+PrimaryAssetRules=(PrimaryAssetId="Map:/Game/Maps/Sanctuary",Rules=(Priority=-1,ChunkId=1,CookRule=Unknown))	+PrimaryAssetRules=(PrimaryAssetId="Map:/Game/Maps/Highrise",Rules=(Prority=-1,ChunkId=2,CookRule=Unknown))	+PrimaryAssetRules=(PrimaryAssetId="Map:/Game/Maps/ShooterEntry",Rules=(Priority=-1,ChunkId=0,CookRule=AlwaysCook))
```

*DefaultGame.ini 文件中的烘焙与分块规则。本示例中，我们添加了对启动地图“ShooterEntry”的显式引用。*

这会将主要游戏地图设置到特定 chunk 中，并使它们的所有引用也被加入这些 chunk。最后一个条目负责 chunk 0，确保游戏首次启动时加载的地图所引用的任何内容都位于 chunk 0，而 chunk 0 也是默认 chunk。优先级值 -1 会将优先级设为默认值 1。

### 使用 Primary Asset Label 定义 chunk

Primary Asset Label 是一种 data asset，用于指定其它资产参与烘焙和分块。与为单个资产创建规则相比，这种方式通常更快。

![An example of a Primary Asset Label in the Content Browser](../../../../assets/images/67/675760f179fd1a561c6769feaa44fad57ce04e5103663a065bca7a1a5cfbca72.jpg)

Content Browser 中的 Primary Asset Label 示例。

要创建 Primary Asset Label， **右键点击** 在 **Content Browser**中，然后点击 **Miscellaneous** > **Data Asset**.

![Creating a Data Asset in the Content Browser](../../../../assets/images/a9/a934def1ea7c100a2bb06682f30922f3f8c38ddfee5fdb1a5a18681615fea566.jpg)

在 **Pick Data Asset Class** 菜单中，选择 **PrimaryAssetLabel** 并点击 **Select**.

![The Pick Data Asset Class menu](../../../../assets/images/12/128ff769bc370663dcef9ca420099413bd38dba8a5d1bba11930dc393f6ec4e9.jpg)

创建新的 Data Asset 时会弹出 Pick Data Asset Class 菜单。点击图片可放大。

新的 primary asset label 会创建在 **Content Browser**中。如果 **双击** 它，就可以编辑它的数据。

![The Primary Asset Label for the Highrise chunk](../../../../assets/images/b2/b2c151b3660672b0b2af4ee85c44fdb4019d8c196e563ac53d65047858ebcb63.jpg)

ShooterGame 中 HighriseLabel Primary Asset Label 的设置。点击图片可放大。

Primary Asset Label 与 Asset Manager 中的 Primary Asset Rule 一样，同时包含 **Chunk ID** 和 **Priority**。不过，在 Primary Asset Label 中，可以一次性将这些规则应用到多个资产。 **Explicit Assets** 字段允许指定一组具体资产，也可以指定一个 **Asset Collection** 属于此 label。或者，可以勾选 **Label Assets in My Directory**，这样 primary asset label 就会影响 Content Browser 中同一文件夹下的所有资产。

## 打包 chunk

定义 chunk ID 后，打包项目会自动为每个 chunk 创建 .pak 文件。可以在项目的 `Saved/StagedBuilds/[PlatformName]/[ProjectName]/Content/Paks` folder.

![The location of Pak files in StagedBuilds](../../../../assets/images/a5/a5aba8dfd9a89f287e1beadf0921e6e83b9a30c3352fd24679560dfbe389df15.png)

打包后的 .pak 文件位于 StagedBuilds 文件夹中，在你的平台和项目对应子文件夹下的 Content/Paks 目录内。

The `.pak` 文件会根据所打包的平台生成，因此不能在不同平台之间互换。生成后，可以在所选分发系统中使用它们。

## 分析资产到 chunk 的分配

UE 提供了多个内置工具用于审计 chunk。使用这些工具，可以查看哪些 Asset 被分配到哪些 chunk、这些分配来自哪里，以及已分块资产的大小信息。

### Asset Audit 窗口

要打开 **Asset Audit 窗口**，请打开 **Windows** 下拉菜单，展开 **Developer Tools**，然后选择 **Asset Audit**.

![Locating the Asset Audit window in the Windows dropdown](../../../../assets/images/89/89537a0401cbbabdfe73e6139e1b7514d5b9e95266961d199a36306a9b0728df.jpg)

点击图片可放大。

Asset Audit 窗口会显示出来，但初始为空。

Asset Audit 窗口初次打开时的显示效果。点击图片可放大。

点击 **Add Chunks** 按钮会用当前项目中所有已存在 chunk 的摘要填充窗口。

在 ShooterGame 中，Asset 分布在三个 chunk 之间。点击图片可放大。

要检查单个 chunk，请右键点击它并选择 **Size Map** 或 **Reference Viewer**.

点击图片可放大。

### Size Map

这些 **size map** 会以可视化方式表示 chunk 中每个资产的类型和大小。Asset 会显示为带有图标或缩略图的彩色方框，并按资产大小缩放。嵌套在其它方框中的方框表示父子引用关系。例如，被某个材质引用的纹理会显示在该材质方框内部，因为加载材质会隐式涉及加载该纹理。

在 ShooterGame 中，chunk 0 包含显示游戏菜单并进入对局所需的资产，而 chunk 1 和 chunk 2 用于游戏的可玩地图。因此，chunk 0 比其它 chunk 更小，同时包含更多种类的资产类型。这里可以看到 chunk 0 和 chunk 1 的资产构成以及发布版总磁盘大小：

![Size map for Chunk 0](../../../../assets/images/45/451a067e7b7532901be0400299e7de9925e56673066fda59f412f08761838e99.jpg)

ShooterGame 的 chunk 0 包含许多独立资产，但总体较小。点击图片可放大。

> 图片已省略：Size map for chunk 1

chunk 1（图中所示）和 chunk 2 包含游戏发生的各个地图，因此它们呈现为一组大型互相关联资产。点击图片可放大。

size map 还支持可视化其中资产在编辑器中的内存使用量。同一组资产在编辑器中的内存大小，可能与发布产品中的磁盘空间占用存在显著差异。

> 图片已省略：Size map for Chunk 0 in Memory Size mode

以 Memory Size 模式显示的 chunk 0。此模式会根据资产在编辑器中的内存使用量缩放方框大小。点击图片可放大。

可以右键点击资产方框来检查或编辑单个资产。可以使用鼠标滚轮放大或缩小，也可以双击资产将其展开，使其填满窗口。

> 图片已省略：context menu for an individual asset in Chunk 0

“loading screen”纹理资产的上下文菜单。点击图片可放大。

### Reference Viewer

这些 [Reference Viewer](../../../understanding-the-basics/assets-and-content-packs/reference-viewer/index.md) 会生成一张图，将资产之间的引用表示为资产本身之间的连接网络。可以使用此工具检查 chunk 和单个资产。在 ShooterGame 示例中，检查 chunk 1 时只会显示两个直接连接的资产：“Sanctuary”地图，以及与 chunk 1 关联的 Primary Asset Label。

> 图片已省略：The reference graph for Chunk 1

Reference Viewer 中显示 ShooterGame 内 chunk 1 直接引用资产的图。图中已右键点击 sanctuary 地图资产节点。点击图片可放大。

在 Content Browser 或 Reference Viewer 中右键点击节点并选择 **Re-Center Graph** （或在 Reference Viewer 中双击节点）会显示该节点的引用。在下图中，我们已从 chunk 1 重新居中到 `Map:/Game/Maps/Sanctuary` 节点，由此可见“Sanctuary”地图在左侧被两个节点（chunk 1 以及 chunk 1 的 Primary Asset Label）引用，并在右侧引用许多子节点，例如 `M_FFA_Wall_01` 材质：

> 图片已省略：The reference graph for the Sanctuary map

在 Reference Viewer 中检查 ShooterGame 的“Sanctuary”地图（chunk 1 的一部分）。点击图片可放大。

> [!NOTE]
> 上方显示的图并不完整，它受 Reference Viewer 中设置的选项限制。限制图的范围可以大幅减少引擎构建该图所需的时间。关于这些选项的详细信息，请参阅 [Reference Viewer 页面](../../../understanding-the-basics/assets-and-content-packs/reference-viewer/index.md).

通过这种方式遍历引用，可以准确了解指定资产为何与另一资产或某个 chunk 关联。这有助于发现并移除不必要的资产引用，或调整分块策略以更好满足项目需求。

