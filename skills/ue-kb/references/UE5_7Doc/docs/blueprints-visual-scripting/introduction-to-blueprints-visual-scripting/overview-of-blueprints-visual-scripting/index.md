---
title: "蓝图可视化脚本概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-blueprints-visual-scripting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图简介", "蓝图可视化脚本概述"]
---

# 蓝图可视化脚本概述

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图简介 / 蓝图可视化脚本概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-blueprints-visual-scripting-in-unreal-engine

虚幻引擎中的 **蓝图可视化脚本（Blueprint Visual Scripting）** 系统是使用基于节点的接口创建Gameplay元素的可视化编程语言。基于节点的工作流程为设计师提供了通常只有程序员才能使用的广泛脚本概念和工具。此外，在虚幻引擎的C++实现方案中，可用的蓝图特有标记可以让程序员创建基线系统，并让设计师扩展这些系统。

就像许多常用的脚本语言，你可以使用该系统在引擎中定义面向对象（OO）的类或对象。系统连同你定义的对象常常直接称为"蓝图"。

这是否意味着蓝图就是虚幻脚本的替代品？答案既肯定又否定。之前利用虚幻脚本进行的游戏性编程和其他操作仍然可以通过C++代码进行处理。同时，蓝图并非刻意为替代虚幻脚本而生，但它们的许多用途确实和虚幻脚本相同，例如：

- 扩展类
- 保存并编辑默认属性
- 管理类的子对象（如组件）实例化

期望达到的结果是：gameplay程序员构建基础类，基础类则公开一套有用的函数和属性；这些基础类形成的蓝图可使用这些函数和属性并进行延展。

下表对虚幻脚本（出自虚幻引擎3）、C++、蓝图中诸多要素处理方法进行了比较，帮助旧版虚幻引擎用户过渡到新版，并对本地代码和蓝图进行比较。

| 虚幻脚本（UE3） | 蓝图（UE4 / UE5） | C++（UE4 / UE5） |
| --- | --- | --- |
| .uc file | 蓝图资源 | .h/.cpp files |
| UClass | UBlueprintGeneratedClass | UClass |
| 延展[ClassName] | ParentClass | : [ClassName] |
| 变量 | 变量 | UProperty() |
| 函数 | 图表/事件 | UFunction() |
| defaultproperties{} | 类默认项 | 本地构造函数 |
| 默认组件 | 组件列表 | 本地构造函数 |

## 蓝图类型

蓝图有数种类型，每种均有其独特用法，包括创建新类型编写关卡事件脚本，或是定义其他蓝图使用的接口和宏。

### 蓝图类

***Blueprint Class（蓝图类）***, 一般缩写为 ***Blueprint(蓝图)***,是一种允许内容创建者轻松地基于现有游戏性类添加功能的资源。 *蓝图* 是在虚幻编辑器中可视化地创建的，不需要书写代码，会被作为类保存在内容包中。 实际上，这些类蓝图定义了一种新类别或类型的Actor，这些Actor可以作为实例放置到地图中， 就和其他类型的Actor的行为一样。

### 纯数据蓝图

**Data-Only Blueprint（仅包含数据的蓝图）** 是指仅包含代码(以节点图表的形式)、变量及从其父类继承的组件 的类蓝图。仅包含数据的蓝图允许您调整及修改继承的属性，但是不能添加新元素。 从本质上讲，这些蓝图是原型的替代物，设计人员可以使用它们来调整属性或者设置具有变种的项目。

Data-Only Blueprints(仅包含数据的蓝图) 是在合并的属性编辑器中进行编辑的，但是也可以通过使用完整的 **蓝图编辑器** 来添加代码、 变量或组件，来将其转换为完整的蓝图 。

请参见[类蓝图](../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-class-assets/index.md)以访问更多文档。

**关卡蓝图（Level Blueprint）** 是一种专业类型的 **蓝图（Blueprint）**，用作关卡范围的全局事件图。 在默认情况下，项目中的每个关卡都创建了自己的关卡蓝图，您可以在虚幻编辑器中编辑这些关卡蓝图， 但是不能通过编辑器接口创建新的关卡蓝图。

与整个级别相关的事件，或关卡内Actor的特定实例， 用于以函数调用或流控制操作的形式触发操作序列。 熟悉虚幻引擎3的人应该非常熟悉这个概念， 因为它与Kismet在虚幻引擎3中的工作原理非常相似。

关卡蓝图还提供了关卡流送和[Sequencer](../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)的控制机制， 以及将事件绑定到关卡内的Actor的控制机制。

请参见[关卡蓝图](../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/level-blueprint/index.md)以访问更多文档。

### 蓝图接口

**蓝图接口（Blueprint Interface）** 是一个或多个函数的集合 - 只有名称，没有实施 - 可以添加到其他蓝图中。任何添加了该接口的蓝图都保证拥有这些函数。接口的函数 可以在添加它的每个蓝图中提供功能。在本质上，这类似于一般编程中的接口概念， 它允许多个不同类型的对象通过一个公共接口 共享和被访问。简单地说，蓝图接口允许不同的蓝图相互共享和发送数据。

内容创建者可以通过编辑器以与其他蓝图类似的方式创建蓝图接口， 但它们仍有一定的局限性，原因在于以下操作不可执行：

- 添加新变量
- 编辑图表
- 添加组件

请参见[蓝图接口](../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-interface/index.md)和[接口快速入门指南](https://dev.epicgames.com/documentation/unreal-engine/interface-quick-start-guide-in-unreal-engine)以访问更多文档。

### 蓝图宏库

**蓝图宏库（Blueprint Macro Library）** 是一个容器，它包含一组 **宏** 或自包含的图表，这些图表可以 作为节点放置在其他蓝图中。它们可以节省时间，因为它们可以存储常用的节点序列， 包括执行和数据传输所需的输入和输出。

宏在引用它们的所有图表之间共享，但是它们会自动扩展到图表中， 就像它们在编译期间是一个折叠节点那样。这意味着蓝图宏库不需要编译。但是， 对宏的更改仅反映在重新编译包含这些图表的蓝图时 引用该宏的图表中。

请参见[宏库](../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-macro-library/index.md)和[创建宏](../../blueprint-workflows/making-macros/index.md)以访问更多文档。

### 蓝图工具

**蓝图工具**（简称 **Blutility**），是用于执行编辑器行为或延展编辑器功能的纯编辑器蓝图。其可将不带参数的[事件](../../specialized-blueprint-visual-scripting-node-groups/events/index.md)作为 UI 按键公开，并能执行对 *蓝图* 公开的任意函数，同时对视口中当前选定的 Actor 集产生作用。

## 蓝图剖析

蓝图功能由诸多元素定义。部分元素默认存在，其余可按需添加。这些元素可用于定义组件、执行初始化和设置操作、对事件作出响应、组织并模块化操作， 以及定义属性等行为。

### 组件窗口

了解组件（Components）后，**蓝图编辑器（Blueprint Editor）** 中的 **组件（Components）** 窗口允许您将组件添加到蓝图。这提供了以下方法：通过胶囊组件（CapsuleComponent）、盒体组件（BoxComponent）或球体组件（SphereComponent）添加碰撞几何体，以静态网格体组件（StaticMeshComponent）或金属网格体组件（SkeletalMeshComponent）形式添加渲染几何体，使用移动组件（MovementComponent）控制移动。还可以将组件（Components）列表中添加的组件指定给实例变量，以便您在此蓝图或其他蓝图的图表中访问它们。

### 构造脚本

创建蓝图类的实例时，**构造脚本（Construction Script）** 在组件列表之后运行。它包含的节点图表允许蓝图实例执行初始化操作。构造脚本的功能可以非常丰富，它们可以执行场景射线追踪、设置网格体和材质等操作，从而根据场景环境来进行设置。例如，光源蓝图可判断其所在地面类型，然后从一组网格体中选择合适的网格体，或者，栅栏蓝图可以向各个方向射出射线，从而确定栅栏可以有多长。

### 事件图表

蓝图的EventGraph包含一张节点图表，它使用时间和函数调用来执行操作，以响应与蓝图相关联的Gameplay时间。这被用于为蓝图的所有实例添加公共功能。交互性和动态响应也在这里设置。例如，光源蓝图可以对伤害事件做出响应，方法是关闭其 `LightComponent`，并更改其网格体所使用材质。这将自动为光源蓝图的所有实例提供此行为。

请参见[EventGraph](../../anatomy-of-a-blueprint/event-graph/index.md)以访问更多文档。

### 函数

**函数（Functions）** 是属于特定 **蓝图（Blueprint）** 的节点图表，它们可以从蓝图中的另一个图表 执行或调用。函数具有一个由节点指定的单一进入点，函数的名称 包含一个执行输出引脚。当您从另一个图表调用函数时，输出执行引脚将被激活， 从而使连接的网络执行。

### 变量

**Variables（变量）** 是保存值或参考世界场景中的对象或Actor的属性。这些 属性可以由包含它们的 **蓝图（Blueprint）** 通过内部方式访问，也可以 通过外部方式访问，以便设计人员使用放置在关卡中的蓝图实例 来修改它们的值。
