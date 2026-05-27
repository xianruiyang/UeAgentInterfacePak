---
title: "网格体切割"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mesh-cut-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "网格体切割"]
---

# 网格体切割

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 网格体切割

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mesh-cut-tool-in-unreal-engine

**网格体切割（Mesh Cut）** 工具能用一个网格体将另一个网格体切割为多个部分。你可以使用该工具将网格体分解为更小的组件并添加细节，省去在建模时手动添加边和删除面的麻烦。

## 访问工具

网格体切割位于 **建模模式（Modeling Mode）** 的 **建模（Model）** 类别中。如需详细了解建模模式以及访问方法，请参阅[建模模式概述](../../getting-started-with-modeling-mode/modeling-mode/index.md)。

## 使用网格体切割

网格体的控件会显示在视口中，以便随时调整切割效果。

类似于[布尔](../boolean-tool/index.md)工具，选择顺序很重要，具体如下：

- 第一个选定的网格体是被切割的网格体。
- 第二个选定的网格体用于定义切割的形状/边界。

> [!NOTE]
> 网格体切割是一种单次切割工具，意味着每次你想切割网格体，就要重新启动一次会话。

在使用过该工具后，你可以使用[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7-%E6%92%A4%E9%94%80%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板接受或取消更改。

## 设置

| **设置** | **说明** |
| --- | --- |
| **尝试修复孔洞（Try Fix Holes）** | 为true时，网格体切割会自动尝试填充数字错误造成的孔洞。 |
| **尝试折叠边缘（Try Collapse Edges）** | 为true时，布尔运算造成的额外边缘会折叠。 |
| **缠绕阈值（Winding Threshold）** | 确定一个网格体中的三角形是位于另一个网格体内部还是外部。 |
| **显示新边界（Show New Boundaries）** | 为true时，显示布尔运算中因数字错误造成的边界边缘。 |
| **使用第一个网格体的材质（Use First Mesh Materials）** | 为True时，仅第一个网格体保留其材质分配。其他所有三角形都分配材质0。 |
| **显示小工具（Show Gizmo）** | 切换变换小工具的可视性。 |
