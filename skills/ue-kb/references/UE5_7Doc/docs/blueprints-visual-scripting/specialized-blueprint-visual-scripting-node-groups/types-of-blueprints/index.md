---
title: "蓝图类型"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/types-of-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "专用蓝图节点组", "蓝图类型"]
---

# 蓝图类型

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 专用蓝图节点组 / 蓝图类型

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/types-of-blueprints-in-unreal-engine

有时候很难看一眼就决定应该使用哪种类型的**蓝图**，特别是 在涉及**蓝图宏库**和**蓝图类**的时候。 有一条很管用的经验法则，就是问你自己：

- *是不是有多个实例？*

如果你的实例不止一两个（例如一台电视机，可以用枪打爆，也可以打开/关闭）， 那么也许合理做法是创建一个蓝图类，并在其中设置相关代码。 如果没有那么多，而且你只需要一些辅助程序函数（例如查找X单位中的所有Actor），那么 在蓝图宏库中设置是最理想的。

## Level Blueprint

A **Level Blueprint** is a specialized type of **Blueprint** that acts as a level-wide global event graph. Each level in your project has its own Level Blueprint created by default that can be edited within the Unreal Editor, however new Level Blueprints cannot be created through the editor interface.

Events pertaining to the level as a whole, or specific instances of Actors within the level, are used to fire off sequences of actions in the form of Function Calls or Flow Control operations. Those familiar with Unreal Engine 3 should be very familiar with this concept as this is very similar to how Kismet worked in Unreal Engine 3.

Level Blueprints also provide a control mechanism for level streaming and [Sequencer](../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md) as well as for binding events to Actors placed within the level.

For more information on this section, please see [Level Blueprint](level-blueprint/index.md).

## Blueprint Class

A **Blueprint Class**, often shortened as **Blueprint**, is an asset that allows content creators to easily add functionality on top of existing gameplay classes. Blueprints are created inside of Unreal Editor visually, instead of by typing code, and saved as assets in a content package. These essentially define a new class or type of Actor which can then be placed into maps as instances that behave like any other type of Actor.

For more information on this section, please see [Blueprint Class](blueprint-class-assets/index.md).

## Data-Only Blueprint

A **Data-Only Blueprint** is a Blueprint Class that contains only the code (in the form of node graphs), variables, and components inherited from its parent. These allow those inherited properties to be tweaked and modified, but no new elements can be added. These are essentially a replacement for archetypes and can be used to allow designers to tweak properties or set items with variations.

Data-Only Blueprint are edited in a compact property editor, but can also be "converted" to full Blueprints by simply adding code, variables, or components using the full **Blueprint Editor**.

For more information on this section, please see [Data-Only Blueprint](blueprint-class-assets/index.md).

## Blueprint Interface

A **Blueprint Interface** is a collection of one or more functions - name only, no implementation - that can be added to other Blueprints. Any Blueprint that has the Interface added is guaranteed to have those functions. The functions of the Interface can be given functionality in each of the Blueprints that added it. This is essentially like the concept of an interface in general programming, which allows multiple different types of Objects to all share and be accessed through a common interface. Put simply, Blueprint Interfaces allow different Blueprints to share with and send data to one another.

Blueprint Interfaces can be made by content creators through the editor in a similar fashion to other Blueprints, but they come with certain limitations in that they cannot:

- Add new variables
- Edit graphs
- Add Components

For more information on this section, please see [Blueprint Interface](blueprint-interface/index.md).

## Blueprint Macro Library

A **Blueprint Macro Library** is a container that holds a collection of **Macros** or self-contained graphs that can be placed as nodes in other Blueprints. These can be time-savers as they can store commonly used sequences of nodes complete with inputs and outputs for both execution and data transfer.

Macros are shared among all graphs that reference them, but they are auto-expanded into graphs as if they were a collapsed node during compiling. This means that Blueprint Macro Libraries do not need to be compiled. However, changes to a Macro are only reflected in graphs that reference that Macro when the Blueprint containing those graphs is recompiled.

For more information on this section, please see [Blueprint Macro Library](blueprint-macro-library/index.md).
