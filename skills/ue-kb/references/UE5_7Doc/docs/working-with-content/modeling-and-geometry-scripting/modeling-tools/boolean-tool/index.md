---
title: "布尔操作"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/boolean-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "布尔操作"]
---

# 布尔操作

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 布尔操作

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/boolean-tool-in-unreal-engine

**布尔** 工具用于为一对网格体进行删减或添加操作。它能让网格体快速添加细节以及置换效果。

## 访问工具

布尔工具位于 **建模模式（Modeling Mode）** 的 **模型（Model）** 类别中。如需详细了解建模模式以及访问方法，请参阅[建模模式概述](../../getting-started-with-modeling-mode/modeling-mode/index.md)。

## 使用布尔工具

你需要两个网格体才能使用该工具，因为新生成的网格体的最终效果取决于原有两个网格体的相交方式。网格体的选择顺序对于操作也很重要：

- 你的第一个选择将成为

  A

  。
- 你的第二个选择将成为

  B

  。

下表显示了你可以使用的四种操作。

| **操作** | **说明** |
| --- | --- |
| **A-B差集（Difference A - B）** | 从第一个网格体减去第二个网格体。 |
| **B-A差集（Difference B - A）** | 从第二个网格体减去第一个网格体。 |
| **交集（Intersection）** | 减去非重叠几何体。 |
| **并集（Union）** | 合并两个网格体并解决自相交。 |

选中两个网格体并激活工具后，你就能在视口中调整网格体了；可能是一个，可能是两个同时调整，具体取决于你的操作方式。

编辑网格体后，你可以选择下表中的操作方式，决定如何处理网格体的输出效果。

| **操作** | **说明** |
| --- | --- |
| **输出类型（Output Type）** | 选择要创建的Actor类型。仅在 **输出对象（Output Object）** 中选择了 **新对象（New Object）** 时才可用。 |
| **输出对象（Output Object）** | 确定是创建新Actor还是覆盖某个输入网格体。 |
| **在工具接受时（On Tool Accept）** | 确定在接受更改时所选网格体会发生什么。 |
