---
title: "使用细节级别"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-levels-of-detail-in-mutable-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Mutable骨骼网格体生成", "Mutable优化和调试", "使用细节级别"]
---

# 使用细节级别

> 路径：虚幻引擎5.7文档 / 管理内容 / Mutable骨骼网格体生成 / Mutable优化和调试 / 使用细节级别

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-levels-of-detail-in-mutable-in-unreal-engine

在Mutable中使用细节级别（LOD）的原因有很多：

- 内存使用
- 处理器性能
- 加载时间

在Mutable中，你可以为每个LOD创建特定图表，利用角色的程序化构建进一步优化。这样，你只需要降低每个LOD的多边形数量和纹理大小，就能让基础角色形体之类的对象遵循常见的LOD优化。你还可以更进一步，在对象离得越远时，使用开销较小的操作为每个LOD定义不同的构建过程。

例如，想象一个角色手镯。在特写镜头中使用的顶部LOD中，手镯有自己的网格体，以及带有物理动画的复杂材质。在第二个LOD中，可以将手镯简化，换成具有单一材质且直接蒙皮到手臂骨骼的刚性网格体。在第三个LOD中，手镯可能只是手臂上的一个纹理贴片（如果手镯足够大）。在第四个LOD中，手镯可能完全消失。你可以使用相同的参数在不同的图表中定义所有这些情况，所以如果手镯的颜色可自定义，你可以在每个LOD上看到手镯颜色的变化。

## 定义组件的细节级别

你可以在图表中使用多个不同的节点来定义LOD。最重要的节点是[Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Mesh-Component)节点。此节点中定义的LOD数量将限制组件中可以定义的最大LOD数量。

例如，[Add To Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Add-To-Mesh-Component)节点只生成与其父节点[Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Mesh-Component)相同数量的LOD。如果某个LOD引脚没有连接，除非使用自动LOD，否则LOD将没有几何体。

用于控制LOD选择方式的LOD属性是标准的虚幻引擎属性。这些属性从参考骨骼网格体对象复制而来，你可以在那里进行设置。请注意，这意味着参考骨骼网格体对象必须具有LOD。

你还可以在 **对象属性（Object Properties）** 选项卡中找到更多LOD设置。

## 自动细节级别

由于可自定义对象可能变得非常大，你可以使用Mesh Component节点中的"自动LOD策略（Auto LOD Strategy）"字段来简化LOD的生成，而无需复制所有节点。如需详细了解，请参阅[Mesh Component](https://github.com/anticto/Mutable-Documentation/wiki/Node-Mesh-Component)节点参考。
