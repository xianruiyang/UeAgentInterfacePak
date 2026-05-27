---
title: "Mover"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mover-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Mover"]
---

# Mover

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Mover

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mover-in-unreal-engine

**Mover** 是一款虚幻引擎插件。它支持使用 **Network Prediction插件** 或 **Chaos的联网物理** 系统实现具有回滚网络功能的模块化Actor动作。该插件可以帮助Gameplay开发者制作角色动作，而无需网络方面的专业知识。

除了本分段中的文档，你也可以观看[An Introduction to the Mover Plugin | Unreal Fest 2024](https://www.youtube.com/watch?v=P4IKS5k47Wg)教程，详细了解Mover插件。你也可以在虚幻引擎目录：`\Engine\Plugins\Experimental\Mover\` 下的 `README.md` 文件中找到更多详情。

> [!NOTE]
> 我们希望Mover插件可以成为下一代制作角色动作的方法，并逐渐取代 **角色动作组件（CMC）（Character Movement Component (CMC)）** 系统。但是，Mover插件目前还在实验阶段，还有许多功能有待完善，其API、属性和数据格式还会变更。
>
> 即使Move进入生产就绪状态，我们在可以预见到的未来还是会继续支持CMC系统，并会提前就任何可能的停用计划发出充分通知。

## 主题

- [Mover功能与概念](mover-features-and-concepts/index.md) - 了解MoverComponents、移动模式，等等。

- [对比Mover和角色移动组件](comparing-mover-and-character-movement-component/index.md) - 了解这两种移动系统的差别。

- [Mover示例](mover-examples/index.md) - *Mover Examples插件中的示例内容指南。

- [Mover调试参考](mover-debugging-reference/index.md) - 了解如何调试你的Mover项目。
