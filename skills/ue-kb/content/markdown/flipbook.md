# Flipbook组件

---
title: "Flipbook组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/flipbook-components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D Flipbooks", "Flipbook组件"]
---

# Flipbook组件

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D Flipbooks / Flipbook组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/flipbook-components-in-unreal-engine

**Flipbook组件** 为常规原始组件，可将其在3D环境中随意放置、将其附着于其他组件，或使其被其他组件所附着。每个Flipbook组件实例均可指定一个自定义颜色。该颜色将作为顶点颜色传递至Flipbook材质。也可指定一个自定义材质，替换Flipbook中定义的默认材质。

可通过调用 **SetFlipbook** 变更当前Flipbook资产，但请注意须将 **移动性** 属性设为 **可移动**（或在构建Actor时调用）。利用组件上的多种其他方法，还可对播放速度、播放方向、循环等进行控制。

> [!NOTE]
> 使用Flipbook组件的C++文档仍在编写过程中，请查阅 [UPaperFlipbookComponent](https://dev.epicgames.com/documentation/404) 中的更多内容，详细文档我们将尽快奉上。

## 设置

通过下方链接了解更多使用蓝图的Flipbook组件。

- Paper 2D Flipbooks

