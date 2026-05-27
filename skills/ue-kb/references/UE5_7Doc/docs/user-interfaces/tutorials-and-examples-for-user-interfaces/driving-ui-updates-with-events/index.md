---
title: "使用事件来驱动UI的更新"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/driving-ui-updates-with-events-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "用户界面教程和示例", "使用事件来驱动UI的更新"]
---

# 使用事件来驱动UI的更新

> 路径：虚幻引擎5.7文档 / 创建用户界面 / 用户界面教程和示例 / 使用事件来驱动UI的更新

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/driving-ui-updates-with-events-in-unreal-engine

制作UI元素时，建议对内容进行优化，以提高性能并减少低效。例如，根据项目范围，[属性绑定](../../umg-editor-reference/property-binding-for-umg/index.md)可适用于向UI传递信息。但若有更为复杂的UI设置，或需优化项目，建议按需更新UI。

此参考指南中将讲解向HUD传递信息的三种方式。这三种方法均可完成任务。第三个实例未使用tick事件进行更新，而非使用[事件调度器](../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/event-dispatchers/index.md)手动更新信息，达到开销和性能最佳平衡。

## 示例1.函数绑定

在此示例中，我将学习使用 **函数绑定（Function Binding）** 更新玩家的生命/能量。

此处已设置基础生命/能量。

![Hierarchy structure of the HUD widget](../../../../assets/images/47/475bf3ed3fede20b65c8e4dcd42f5c1e520152c586ca30352fd337c7547f5bdb.png)

设置好显示后，为名为 **GetHealth** 和 **GetEnergy** 的进度条 **创建绑定**。此类函数绑定投射到玩家角色蓝图，并指定生命和能量定义的变量。

以下为GetHealth的绑定。为进行调试，已添加 **Print String** 节点将生命变量的值打印到屏幕。

![undefined](../../../../assets/images/78/78aac420b43913be498fc30b1cb5ca6d4edb5a4580dd1fe6d0c73b21d8bbfed1.jpg)

点击查看大图。

在下图中可看到玩家角色的生命和能量值被传递到HUD并在其中反映。同时还可看到，即使未更新生命值时，蓝色调试文本同样表明仍然逐帧检查生命值。

![Gameplay Example](../../../../assets/images/e0/e0554494c6ad741326171e5c4721df27bbd7007d10ca3398e15c8a3456738a82.jpg)

本质上，使用此种方法等同于提问："玩家角色蓝图是什么？"而在了解后，逐帧"提供生命和能量值"。对于小而简单的系统，此方法的效果上佳；但使用较复杂系统，且逐帧检查多个属性的更新时，此设置将导致性能降低。

## 示例2.属性绑定

第2种方法是 **属性绑定**，比函数绑定开销更低。

现在使用相同生命/能量设置，了解属性绑定的工作原理。

![Hierarchy structure of the HUD widget](../../../../assets/images/47/475bf3ed3fede20b65c8e4dcd42f5c1e520152c586ca30352fd337c7547f5bdb.png)

在[控件蓝图](../../basics-of-user-interface-development/building-your-ui/widget-blueprints-in-umg/index.md)的 **事件图表** 中，使用 **Event Construct** 获取对玩家角色蓝图的引用。

通过使用Event Construct，将投射到角色蓝图一次，并将信息存储为引用，以便脚本无需逐帧调用该信息。

![BP script of the HUD Widget Blueprint](../../../../assets/images/f5/f53b6cdfd0d9eb51339605b4076c3fbfe58a0c2d3d606172541c58f355b2bc02.jpg)

之后可将进度条的值直接绑定到角色蓝图中的变量。

![Set bind for percent value](../../../../assets/images/56/5606d390adb329bd52c88cc8a2262d2ee7d93d2a72385cf3a2d35870864cbe0c.png)

利用此方法，则无需逐帧投射并检查"玩家角色蓝图是什么？"相反，仅逐帧查询生命和能量值。

根据项目规模，此方法更为高效；但若系统更复杂，则使用事件驱动可能更好。

## 示例3.事件驱动

现在将学习仅在事件变更时更新HUD的方法，继续使用相同生命/能量设置。

![Hierarchy structure of the HUD widget](../../../../assets/images/47/475bf3ed3fede20b65c8e4dcd42f5c1e520152c586ca30352fd337c7547f5bdb.png)

在角色蓝图中，将 **事件调度器** 节点添加到递减生命的脚本末端。在此范例中，该事件调度器节点为 **Call Update Health**。

为进行测试，将生命设为按下 **F** 键时递减。

![BP Script for causing damage of the Character](../../../../assets/images/d3/d3ed1dad60319957d5b0da29a75fcae02f19df0483fad5ef9dcad8b7fa4770b3.jpg)

现在减少生命时，将调用此事件调度器。在HUD控件蓝图的事件图表中，可再次使用Event Construct获取并保存对玩家角色蓝图的引用。还可将自定义事件绑定到该角色蓝图中的事件调度器，调用事件调度器时便调用该自定义事件。

> 图片已省略：undefined

点击查看大图。

现在，HUD控件蓝图中的自定义事件将在玩家生命变化时检查并更新其显示，而非无论是否变化固定进行检查。

下图展示将生命和能量整合到同一个Event Construct脚本中的方法。

自定义事件 **UpdateHealth** 和 **UpdateEnergy** 与角色蓝图中的事件调度器绑定，仅在角色生命/能量值变化时调用。在绑定后构造HUD时，还可调用这两个自定义事件初始化显示。

> 图片已省略：undefined

点击查看大图。
