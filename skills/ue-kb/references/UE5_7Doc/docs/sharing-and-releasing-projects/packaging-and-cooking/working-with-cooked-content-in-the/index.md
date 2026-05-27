---
title: "在编辑器中使用已烘焙内容"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/working-with-cooked-content-in-the-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "游戏的打包（Packaging）和烘焙（Cooking）", "在编辑器中使用已烘焙内容"]
---

# 在编辑器中使用已烘焙内容

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 游戏的打包（Packaging）和烘焙（Cooking） / 在编辑器中使用已烘焙内容

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/working-with-cooked-content-in-the-unreal-engine

你可以在 **项目（Project）** 中使用 **已烘焙内容**，但在 **虚幻编辑器（Unreal Editor）** 中使用已烘焙内容时，还有额外的要求和限制。

> [!NOTE]
> 本文档目前仅适用于Windows平台的内容。

## 需要的配置

将以下选项添加到你的项目的 `DefaultEngine.ini` 文件：

```
		[/Script/UnrealEd.CookerSettings]		cook.AllowCookedDataInEditorBuilds=True		s.AllowUnversionedContentInEditor=1 
```

第一个选项对应于 **项目设置（Project Settings）** 中的 **允许在编辑器中使用烘焙内容（Allow Cooked Content in the Editor）** 选项，而第二个选项目前只能通过配置文件设置。

## 烘焙内容以在编辑器中使用

当你设置配置选项 `s.AllowUnversionedContentInEditor=1` 时，无需执行进一步的操作，就能使用已烘焙内容。

你可以在以下文件夹中找到你的项目中的已烘焙内容：

```
		Saved\Cooked\WindowsNoEditor\(ProjectName)\Content\ 
```

不同于未烘焙内容，已烘焙内容针对每个资产将包含多个文件。通常，一个资产将分割为单独的文件，包括 `.uasset`，还可能包括 `.uexp` 和 `.ubulk` 文件。所有这些文件都需要复制到项目的内容文件夹中，才能让烘焙内容正常工作。

## 编辑器中已烘焙内容的行为

在对资产进行版本控制和烘焙之后，就可以将其放入内容文件夹，而这些资产将按照预期显示在 **内容浏览器（Content Browser）** 中。

已烘焙资产将是只读的，并且无法为这些资产打开编辑器。例如，你无法在 **材质编辑器（Material editor）** 中查看已烘焙 **材质（Material）**，也无法在 **静态网格体编辑器（Static Mesh editor）** 中打开已烘焙网格体。

在已烘焙内容引用其他内容时，请特别小心。要保留引用，你必须维护已烘焙内容原始所在的相同文件夹结构，并且一旦烘焙，已烘焙资产就无法移动或重命名。在某些情况下，编辑器无法正确处理额外的 `.uexp`/`.ubulk` 文件。例如，通过内容浏览器删除已烘焙资产时，可能无法删除其 `.uexp`/`.ubulk` 文件。

目前没有受支持资产类型的穷举列表，以下列表也并不暗示其中列为可正常运作的类型是官方支持的。

以下资产类型进行了定期测试，在烘焙后应该可以正常运作：

- 纹理
- 材质
- 静态网格体
- 声波
- 级联粒子
- 动画序列
- 骨骼网格体
- 关卡序列
- AnimBPs
- BP_Enums

以下资产存在已知问题：

- Niagara
- 蓝图

未列出的一切类型，不一定能正常运作。如果使用其他资产类型，请谨慎操作。
