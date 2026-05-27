---
title: "蓝图脚本编写基础"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/basic-scripting-with-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图简介", "蓝图脚本编写基础"]
---

# 蓝图脚本编写基础

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图简介 / 蓝图脚本编写基础

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/basic-scripting-with-blueprints-in-unreal-engine

蓝图为脚本语言提供了一种可视化的方法。就其本身而言，此系统与标准书面脚本语言有许多细微差别，例如数据类型化变量、数组、结构体等等。执行流的工作方式与在典型脚本语言中一样，但蓝图要求每个节点的显式线性执行。以下各页将更详细地介绍不同的变量类型、如何处理这些变量以及图表中节点的执行。

## 变量

变量可以采用各种不同的类型创建，包括布尔型、整数型和浮点型等数据类型。它们采用颜色编码，便于在您的蓝图中识别。蓝图变量还可以是用于保存对象、Actor和类等内容的引用类型。

## 执行流

在蓝图中，要执行的第一个节点是一个事件，然后是从左至右通过白色执行线的执行流。游戏运行时，您可以在编辑器中可视化执行流，这有助于调试。数据还流经采用匹配变量类型的彩色导线。当节点执行时，将对输入引脚进行评估，反向从右至左跟踪数据线，直到计算出最终结果并将其提供给节点。

带有执行引脚（非纯节点）的节点在执行时存储其输出引脚的值，而不带执行引脚（纯节点）的节点则在每次与其输出相连的节点执行时重新计算其输出。

- [连接节点](../../blueprint-workflows/connecting-nodes/index.md) - 蓝图中节点连接方式的范例。

- [事件](../../specialized-blueprint-visual-scripting-node-groups/events/index.md) - 从游戏性代码中调用的节点，在 EventGraph 中开始执行个体网络。

- [流程控制](../../specialized-blueprint-visual-scripting-node-groups/flow-control/index.md) - 用于根据情况控制执行流程的节点。

- [节点](../../specialized-blueprint-visual-scripting-node-groups/nodes/index.md) - 节点图表通过使用事件和函数调用来执行动作，从而对和该蓝图相关的游戏性元素作出反应。

- [自定义事件](../../specialized-blueprint-visual-scripting-node-groups/events/custom-events/index.md) - 用户创建的自定义事件，可以在图表中进行触发。
