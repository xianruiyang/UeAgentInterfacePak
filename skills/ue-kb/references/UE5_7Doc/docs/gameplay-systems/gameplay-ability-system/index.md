---
title: "Gameplay技能系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-ability-system-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay技能系统"]
---

# Gameplay技能系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay技能系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-ability-system-for-unreal-engine

**Gameplay技能系统（Gameplay Ability System）** 是一种框架，用于编译[Actor](../gameplay-framework/actors/index.md)可以拥有和触发的属性、技能和交互。该系统可适应各种各样的[Gameplay驱动型](../data-driven-gameplay-elements/index.md)项目，例如 **角色扮演游戏** （RPG）、 **动作冒险（Action-Adventure）** 游戏和 **多玩家在线战术竞技** 游戏（MOBA）。

使用Gameplay技能系统，你可以：

- 使用[技能系统组件](gameplay-ability-system-component-and-gameplay-d4845966/index.md)。技能系统组件包括[Actor组件](../gameplay-framework/components/index.md)实现的所有基础功能。
- 技能系统组件实现了自己的[接口](https://dev.epicgames.com/documentation/404)，以访问Gameplay技能系统的框架并与之交互。
- 为Actor创建主动或被动[Gameplay技能](index.md)，使之与项目的Gameplay机制、[视觉效果](../../visual-effects/index.md)、[动画](../../animating-characters-and-objects/index.md)、[声音](../../working-with-audio/index.md)和其他数据驱动型元素进行协作。
- 使用[属性和属性集](gameplay-attributes-and-attribute-sets-for-the-1177ec4b/index.md)，在它们与Gameplay技能系统交互时存储、计算和修改Gameplay相关值。
- 使用[Gameplay效果](../index.md)更改属性，通过项目的设计直接修改属性值。Gameplay效果包含可确定Gameplay效果行为的Gameplay效果组件。
- [技能任务](gameplay-ability-tasks/index.md)（ `UAbilityTask` ）是处理Gameplay技能的一种专门形式的Gameplay任务类。使用Gameplay技能系统的游戏通常包括各种各样的自定义技能任务，它们实现了独特的Gameplay功能。它们在Gameplay技能执行期间执行异步工作，并能够在原生C++代码中调用委托或像[蓝图](../../blueprints-visual-scripting/index.md)那样在一个或多个输出执行引脚中移动来影响执行流程。

使用此系统，你可以创建单次攻击之类的技能，或添加更复杂的技能，例如根据来自用户和目标的数据触发许多状态效果的咒语。

## 《遗迹峡谷》示例

Echo的冲锋和攻击动画及其行走动画是Gameplay技能的示例。

请参阅[遗迹峡谷示例](../../samples-and-tutorials/sample-game-projects/valley-of-the-ancient-sample-game/index.md)，了解更多功能。

### 行走动画示例

### 冲锋攻击示例

## 主题目录

- [技能系统组件与属性](gameplay-ability-system-component-and-gameplay-d4845966/index.md) - 使用技能系统组件配合游戏玩法属性与属性集

- [Gameplay Ability](using-gameplay-abilities/index.md) - Gameplay Ability类概览。

- [Gameplay属性和属性集](gameplay-attributes-and-attribute-sets-for-the-1177ec4b/index.md) - 使用游戏玩法属性和属性集

- [Gameplay技能系统概述](understanding-the-unreal-engine-gameplay-ability-system/index.md) - 剖析什么是Gameplay技能系统，及其各个组件类的作用。

- [Gameplay效果](gameplay-effects-for-the-gameplay-ability-system/index.md) - 关于Gameplay技能系统中Gameplay效果的概述。

- [技能任务](gameplay-ability-tasks/index.md) - 技能任务类概览。
