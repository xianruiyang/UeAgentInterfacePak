---
title: "源面板参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/sources-panel-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "内容浏览器", "源面板参考"]
---

# 源面板参考

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 内容浏览器 / 源面板参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/sources-panel-reference-in-unreal-engine

**源（Sources）** 面板位于 **内容浏览器（Content Browser）** 左侧，包含虚幻引擎项目中的所有文件夹和集合的列表。你可以对其进行自定义，以包括其他类型的资产和资产整理功能，并将其用于启动一些常用编辑器操作。

当你从"源"面板选择一个或多个文件夹、集合或其他类型的资产组时，**资产视图（Asset View）** 面板将显示你的选项的内容。

![内容浏览器中的](../../../../assets/images/6d/6dc1eede3b5ffcc34b310a30b7d37b3f5274f68d5530c04de11c8b3ccab500ec.png)

## 切换源面板

你可以在内容浏览器右上角的 **设置（Settings）** 菜单中启用或禁用 **显示源面板（Show Sources Panel）** 选项，以打开和关闭"源"面板。关闭源面板后，你会有更多空间在 **资产视图（Asset View）** 中处理资产。

## 添加和删除源

默认情况下， **源（Sources）** 面板一开始显示两个资产源：

- 虚幻引擎项目中所有文件夹的层级列表，分组在 **项目名称** 下。
- 当前项目资产 **集合（Collections）** 的字母顺序列表。

你还可以添加一些资产源：

| **源** | **内容** | **如何添加** |
| --- | --- | --- |
| **收藏夹（Favorites）** | 你通过在资产视图中右键点击并从上下文菜单选择 **添加到收藏夹（Add To Favorites）** 而标记为收藏夹的资产。 | 从 **设置（Settings）** 菜单，启用 **显示收藏夹（Show Favorites）** 选项。 |
| **C++ Classes文件夹（C++ Classes folder）** | 虚幻引擎中所有C++类的可浏览层级。 | 从 **设置（Settings）** 菜单，启用 **显示C++ 类（Show C++ Classes）** 选项。 |
| **Developers文件夹（Developers folder）** | 可用于在多用户项目上与其他开发人员协作的文件夹。 | 从 **设置（Settings）** 菜单，启用 **显示开发人员内容（Show Developers Content）** 选项。 |
| **Engine Content文件夹（Engine Content folder）** | 带有各种内容和功能的现有资产集合。 | 从 **设置（Settings）** 菜单，启用 **显示引擎内容（Show Engine Content）** 选项。 |
| **特定于插件的内容文件夹（Plugin-specific content folders）** | 各种虚幻引擎插件添加的内容文件夹。 | 从 **设置（Settings）** 菜单，启用 **显示插件内容（Show Plugin Content）** 选项。 |
| **本地化内容（Localized content）** | `L10N/` 文件夹中的本地化内容。 | 从 **设置（Settings）** 菜单，启用 **显示本地化内容（Show Localized Content）** 选项。 |

## 基于源的资产显示

**资产视图（Asset View）** 显示当前所选源中的资产。你可以使用搜索和筛选器进一步控制哪些资产显示在资产视图中。

要查看来自多个文件夹的资产，你必须选择想要搜索的所有文件夹。你可以使用以下鼠标和按键组合来选择多个文件夹。

- **左键点击** 可将当前所选项替换为你点击的文件夹。
- **Shift + 左键点击** 可选择开始和结束点之间的一系列文件夹。
- **Ctrl + 左键点击** 可选择或取消选择单个文件夹。

## 右键点击上下文菜单

如果你 **右键点击**"源"面板中的文件夹，将显示以下上下文菜单。

| **选项** | **说明** |
| --- | --- |
| **新建文件夹（New Folder）** | 创建新文件夹作为当前所选文件夹的子文件夹。 |
| **在新内容浏览器中显示（Show in New Content Browser）** | 在新的"内容浏览器"窗口中打开此文件夹。 你可以同时打开最多四个内容浏览器实例，不包括内容侧滑菜单。 |
| 文件夹选项 |  |
| **添加/导入内容（Add/Import Content）** | 此子菜单提供与内容浏览器导航栏上的"添加（Add）"按钮相同的功能。使用它可在当前所选文件夹中导入或创建新资产。 |
| **在资源管理器(Windows)中显示（Show in Explorer (Windows)）** / **在访达中显示(macOS)（Show in Finder (macOS)）** | 在Windows资源管理器(Windows)或访达(macOS)中打开文件夹。 |
| **重命名（Rename）** | 使文件夹名称可编辑，以便进行更改。按Enter键以保存更改，或按Esc键以取消重命名。 |
| **添加到收藏夹（Add to Favorites）** | 将文件夹添加到"收藏夹（Favorites）"分段。 |
| **设置颜色（Set Color）** | 设置所选文件夹的颜色以用于整理用途。 |
| 批量操作 |  |
| **全部保存（Save All）** | 保存当前文件夹中已修改的所有资产。 |
| **全部重新保存（Resave All）** | 重新保存当前文件夹中的所有资产，无论它们是否已修改。 |
| **删除（Delete）** | 删除当前文件夹及其所有内容。 |
| **修复文件夹中的重定向器（Fix Up Redirectors in Folder）** | 查找所选文件夹中对所有重定向器的引用，并在可能的情况下将其重新保存，然后删除已修复其所有引用者的所有重定向器。 |
| **迁移（Migrate）** | 将此文件夹中的资产及其依赖性复制到其他项目的 `Content` 文件夹。有关更多信息，请参阅[迁移资产](../../assets-and-content-packs/migrating-assets/index.md)页面。 |
| **引用查看界面（Reference Viewer）** | 显示文件夹的引用图表。有关更多信息，请参阅[查找资产引用](../../assets-and-content-packs/reference-viewer/index.md)页面。 |
| **大小贴图（Size Map）** | 显示大致内存的交互式贴图，其所示为此文件夹中的资产及其引用内容所使用的内存。 |
| **审计资产（Audit Assets）** | 打开"资产审计"窗口，其中显示有关当前文件夹中资产的详细信息。你可以使用筛选器进一步优化此窗口中显示的信息。 |
| **着色器烘焙统计数据（Shader Cook Statistics）** | 显示与着色器烘焙相关的统计数据。 |
| **验证文件夹中的资产（Validate Assets in Folder）** | 验证文件夹中包含的资产并标记有问题的资产。 |
| 源功能按钮 |  |
| **连接到源功能按钮（Connect to Source Control）** | 将此文件夹连接到源功能按钮。将此文件夹连接到源功能按钮后，下面的操作将变为可用。 |
| **检出（Check Out）** | 将所选文件夹标记为已检出，从而将其锁定，防止其他用户进行编辑。 |
| **标记为添加（Mark for Add）** | 将所选文件夹标记为添加到源功能按钮服务器。 |
| **检入（Check In）** | 提交所有编辑和添加操作，然后解锁已检出的文件夹。 |
| **同步（Sync）** | 将此文件夹中的所有资产同步到最新版本。 这可能会覆盖你所做的所有本地更改。 |

| **选项** | **说明** |
| --- | --- |
| **移至此处（Move Here）** | 将文件夹移至新位置并将其从原始位置中删除。 |
| **复制到此处（Copy Here）** | 在目标文件夹中创建所选文件夹的副本。 |
| **高级复制到此处（Advanced Copy Here）** | 在目标文件夹中创建所选文件夹及其依赖性的副本。还将修复因移动而破坏的所有依赖性。 |
