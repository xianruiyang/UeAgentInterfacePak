---
title: "使用多个UV通道"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/working-with-multiple-uv-channels-with-mutable-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Mutable骨骼网格体生成", "Mutable开发指南", "使用多个UV通道"]
---

# 使用多个UV通道

> 路径：虚幻引擎5.7文档 / 管理内容 / Mutable骨骼网格体生成 / Mutable开发指南 / 使用多个UV通道

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/working-with-multiple-uv-channels-with-mutable-in-unreal-engine

Mutable支持在Mesh Section中使用多个UV通道，每个通道都有自己[布局策略](../texture-layouts/index.md)。这意味着纹理参数在每个UV通道上可以有不同的自定义选项。

## 如何使用？

要在Mutable中使用多个UV通道，材质图表和可自定义对象图表必须遵循一些规则。

在材质图表中，纹理必须被声明为纹理参数，才能被访问。纹理参数应具有有效的UV通道，通道可以在材质图表和Mesh Section节点中进行设置。部分节点需要进行相应的设置。

下方列出了可以与不同或多个UV通道进行交互的节点，并且概述了交互方式。

### Mesh Section节点

在此节点的节点属性（Node Properties）选项卡中，我们可以决定向其公开哪些纹理参数，以及布局将如何影响纹理。

[Mesh Section节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Mesh-Section)

### Skeletal Mesh节点

可以在节点属性（Node Properties）选项卡内的布局编辑器（Layout Editor）类别中，针对每个网格体分段定义每个UV通道的行为。

[Skeletal Mesh节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Skeletal-Mesh)

### Table节点

可以在节点属性（Node Properties）选项卡内的布局编辑器（Layout Editor）类别中，针对每个网格体分段定义每个UV通道的行为。

[Table节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Table)

### Edit Mesh Section修饰符节点

在任何对象中，都可以使用Edit Mesh Section修饰符节点编辑来自Mesh Section的纹理参数。此节点允许你选择要编辑的纹理，并允许你通过使用UV布局块来指定纹理的哪一部分受到影响。

Edit Mesh Section节点只能编辑来自单个UV通道的纹理。要编辑具有多个UV通道的Mesh Section的所有纹理，需要为每个要修改的通道 设置一个编辑节点。

[Edit Mesh Section节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Edit-Mesh-Section)

### Remove Mesh Blocks修饰符节点

节点属性中的"UV 布局（UV Layout）"属性可用于选择要从中删除块的UV通道。布局块内的网格体片段将从所有纹理和UV通道中删除。

[Remove Mesh Blocks节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Remove-Mesh-Blocks)。

### Texture Project节点

可以在此节点的属性选项卡中使用"布局（Layout）"选项指定要投影到的UV通道。

[Texture Project节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Texture-Project)。

### Group Projector Parameter节点

可以在此节点的属性选项卡中使用"UVLayout"选项指定要投影到的UV通道。

[Group Projector Parameter节点参考页面](https://github.com/anticto/Mutable-Documentation/wiki/Node-Group-Projector-Parameter)。
