---
title: "面向Maya用户的虚幻编辑器和功能概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-editor-and-features-overview-for-maya-users"
breadcrumbs: ["虚幻引擎5.7文档", "入门指南", "面向Maya用户的虚幻引擎", "面向Maya用户的虚幻编辑器和功能概述"]
---

# 面向Maya用户的虚幻编辑器和功能概述

> 路径：虚幻引擎5.7文档 / 入门指南 / 面向Maya用户的虚幻引擎 / 面向Maya用户的虚幻编辑器和功能概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-editor-and-features-overview-for-maya-users

如果你要完全或部分从Maya工作流程转到虚幻引擎，可能会有一些挑战，因为原来的应用程序上有你依赖和熟悉的功能。 虽然两者在某些领域具有相似功能，但虚幻引擎提供的生态系统及其组织方式与Maya及其他DCC存在诸多差异。

本指南将逐步引导你了解如何开始使用虚幻引擎及其功能，并尽可能联系Maya的等效功能进行讲解。 本指南划分为多个小节，涵盖虚幻引擎新用户或临时用户需要了解的信息。

## 将项目迁移到虚幻引擎意味着什么？

- **虚幻引擎管线和传统管线**

  - 在传统管线工作流程中，每个部门都有自己的任务分配，例如光照、外观开发、绑定、角色创建等。 当内容在一个部门完成处理后，可能会转到下一个部门单独处理，这会浪费时间，因为每个部门生成的内容需要花费一些时间才能找到合适的解决方案。
  - 使用全面集成的虚幻引擎管线有助于避免往返式工作流程和导入/导出问题。 当所有人都在同一个工具和所见即所得的实时编辑器中协作时，部门间的协作也会更简单。
- **实时场景更新和全局时间轴**

  - Maya有主时间轴，用于表示场景的整体时间。 你可以设置关键点并跳转到特定时间点。 在虚幻引擎中，你无需专用时间轴即可实时工作。 但它提供Sequencer等专用工具，你可以在其中查看时间轴并设置关键点，从而为场景中的对象制作动画。
- **实时渲染和离线渲染**

  - 在Maya中，要使用Arnold或V-Ray渲染单帧，可能需要等待数分钟到数小时。 在虚幻引擎中，你可以实时查看结果。
- **虚幻引擎提供无缝资产集成**

  - FBX、Alembic和USD导入管线可保留你在Maya中创建的几何体、绑定和动画资产。
- **内置美术师友好型工具，重塑传统管线工作流程**

  - 虚幻引擎自带一套工具，涵盖从项目初期到最终输出的全流程开发。 它可以替代传统离线管线的全部环节，让你在做出修改时获得实时反馈。 无需等待即可看到最终结果。
  - 虚幻引擎还支持全套动画工作流程功能，包括骨骼网格体编辑工具、使用控制绑定进行绑定、动画师工具包插件、动画变形器等。
  - 借助引擎的材质编辑器、后期处理效果、粒子和物理系统，你可以使用迭代协作的工作流程，让团队共同为项目打造几乎任何风格和视觉效果。
  - 高质量照明系统具备动态全局光照和反射功能，并支持电影级质量阴影投射，无需任何额外设置即可运行。

## Maya与虚幻引擎之间的术语一致性

在全面学习虚幻引擎之前，我们先来梳理你可能熟悉的Maya术语及其在虚幻引擎中的对应概念。

| Autodesk Maya | 虚幻引擎 |
| --- | --- |
| 场景文件 | 项目 |
| 通道盒体/特性编辑器 | 细节面板 |
| 大纲视图 | 大纲视图/动画大纲视图 |
| 引用角色/资产 | 使用内容浏览器实例化 |
| 时间轴/摄影表/Trax编辑器 | Sequencer |
| 场景/环境集 | 关卡 |
| 动画场景文件 | 关卡序列 |
| 图表编辑器 | 曲线编辑器 |
| Hypershade | 材质编辑器 |

## 主题

> [!NOTE]
> 要了解并熟悉虚幻引擎及其功能，请探索以下主题。 最好从上到下依次学习，但每个主题也可独立学习，无需依赖其他页面内容。

- [虚幻引擎界面和导航](unreal-engine-interface-and-navigation/index.md) - 向Maya用户概述虚幻引擎的编辑器界面及导航控制方式。
- [从Maya向虚幻引擎导入内容](importing-content-into-unreal-engine-from-maya/index.md) - 面向Maya用户的虚幻引擎导入内容概述。
- [面向Maya用户的虚幻引擎材质和纹理的使用](using-materials-and-textures-in-unreal-engine-f-edc44cea/index.md) - 面向Maya用户的虚幻引擎材质系统和纹理概述。
- [面向Maya用户的虚幻引擎的光照和渲染](lighting-and-rendering-in-unreal-engine-for-maya-users/index.md) - 面向Maya用户的虚幻引擎的光照和渲染功能概述。
- [面向Maya用户的虚幻引擎脚本编写](scripting-in-unreal-engine-for-maya-users/index.md) - 面向Maya用户的虚幻引擎脚本编写功能概述。
- [面向Maya用户的虚幻引擎世界设计和编译](designing-and-building-worlds-in-unreal-engine-08ea3b63/index.md) - 面向Maya用户的虚幻引擎场景设计工具概述。
- [面向Maya用户的虚幻引擎动画制作](animating-in-unreal-engine-for-maya-users/index.md) - 面向Maya用户的虚幻引擎动画系统及其核心功能概述。
- [面向Maya用户的虚幻引擎过场动画和Sequencer的使用](using-cinematics-and-sequencer-in-unreal-engine-673b09a9/index.md) - 面向Maya用户的虚幻引擎过场动画工具Sequencer概述。
- [面向Maya用户的虚幻引擎其他功能和资源](additional-features-and-resources-of-unreal-eng-780a90f3/index.md) - 面向Maya用户的虚幻引擎其他功能及有用资源概述。
