---
title: "推荐的资产命名规范"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/recommended-asset-naming-conventions-in-unreal-engine-projects"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "推荐的资产命名规范"]
---

# 推荐的资产命名规范

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 推荐的资产命名规范

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/recommended-asset-naming-conventions-in-unreal-engine-projects

在开发阶段中，随着 **虚幻引擎(UE)（Unreal Engine (UE)）** 项目日益复杂，**内容浏览器（Content Browser）** 中的 **资产（Assets）** 列表会不断扩充。这会导致资产出现各种变体版本，也会导致资产名称因过于相似而造成混淆。比如，你有一个文件夹名为"Soldier"，这个文件夹中有蓝图、纹理和模型，它们的名称中都带"Soldier"一词，但在简单列表中，很难区别它们。

在开发大型项目时，我们建议你在早期阶段为各类资产建立通用的命名规范。这样方便你和团队成员寻找文件，防止出现冲突或混淆。下述命名规范介绍了Epic Games如何对示例项目中的资产命名，以[ICVFX制片测试](../../samples-and-tutorials/engine-feature-examples/incamera-vfx-production-test-sample-project/index.md)为例：

```
		[AssetTypePrefix]_[AssetName]_[Descriptor]_[OptionalVariantLetterOrNumber] 
```

- `AssetTypePrefix` 将表明资产的类型，详情请参阅下表。
- `AssetName` 是资产的名称。
- `Descriptor` 将提供资产的更多上下文，表明其用法。例如，纹理是正常贴图还是不透明度贴图。
- `OptionalVariantLetterOrNumber` 是可选的，用于区分资产的多个版本或变体。

请考虑在你的项目中使用此命名规范，以便团队成员有多种途径来搜索内容浏览器中的资产。

> [!NOTE]
> 此命名规范仅是一种建议，旨在便于组织你的项目。你的项目要求应始终优先，而且有可能你的项目用不到所有的资产类型。

## 推荐的资产前缀

此表未列出所有可能性，因为随着新功能出现，新资产类型也会出现。如果你要使用的资产类型未列出，可以参考以下表格为其指定命名规范。

| 资产 | 前缀 |
| --- | --- |
| 通用 |  |
| [HDRI](../../building-virtual-worlds/lighting-the-environment/lighting-tools-and-plugins/hdri-backdrop-visualization-tool/index.md) | HDR_ |
| [材质](../../designing-visuals-rendering-and-graphics/unreal-engine-materials/index.md) | M_ |
| [材质实例](../../designing-visuals-rendering-and-graphics/unreal-engine-materials/instanced-materials/index.md) | MI_ |
| [物理资产](../../gameplay-systems/physics/physics-asset-editor/index.md) | PHYS_ |
| [物理材质](../../gameplay-systems/physics/physical-materials/index.md) | PM_ |
| [后期处理材质](../../designing-visuals-rendering-and-graphics/post-process-effects/post-process-materials/index.md) | PPM_ |
| [骨骼网格体](../../working-with-content/skeletal-mesh-assets/index.md) | SK_ |
| [静态网格体](../../working-with-content/static-meshes/index.md) | SM_ |
| [纹理](../../designing-visuals-rendering-and-graphics/textures/index.md) | T_ |
| [OCIO配置文件](../../working-with-media/managing-color/color-management-with-opencolorio/index.md) | OCIO_ |
| [蓝图](../../blueprints-visual-scripting/index.md) |  |
| Actor组件 | AC_ |
| 动画蓝图 | ABP_ |
| 蓝图接口 | BI_ |
| 蓝图 | BP_ |
| 曲线表 | CT_ |
| 数据表 | DT_ |
| 枚举 | E_ |
| 结构 | F_ |
| 控件蓝图 | WBP_ |
| [粒子效果](../../visual-effects/index.md) |  |
| Niagara发射器 | FXE_ |
| Niagara系统 | FXS_ |
| Niagara函数 | FXF_ |
| [骨骼网格体动画](../../animating-characters-and-objects/skeletal-mesh-animation-system/index.md) |  |
| 绑定 | Rig_ |
| 骨架 | SKEL_ |
| 蒙太奇 | AM_ |
| 动画序列 | AS_ |
| 混合空间 | BS_ |
| [ICVFX](../../working-with-media/integrating-media/icvfx/index.md) |  |
| NDisplay配置 | NDC_ |
| [动画](../../animating-characters-and-objects/cinematics-and-movie-making/index.md) |  |
| 关卡序列 | LS_ |
| Sequencer编辑 | EDIT_ |
| [媒体](../../working-with-media/integrating-media/media-framework/index.md) |  |
| 媒体源 | MS_ |
| 媒体输出 | MO_ |
| 媒体播放器 | MP_ |
| 媒体配置文件 | MPR_ |
| 其他 |  |
| [关卡快照](../collaboration-and-version-control/level-snapshots/index.md) | SNAP_ |
| [远程控制预设](../scripting-and-automating-the-unreal-editor/remote-control/index.md) | RCP_ |
