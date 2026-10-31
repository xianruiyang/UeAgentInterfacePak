# 世界、关卡与渲染

三阶段条目维护设计依赖、各阶段职责与发挥空间、产物分离和回流；路线条目维护玩家体验设计；白盒条目维护尺度与通行原理。前阶段交接可用设计与有效约束，不冻结全部几何；执行时如何把这些决定落到UE对象，由UAI场景制作入口维护。按当前问题选读，不要求每轮通读全部条目。

| 当前问题 | 知识条目 |
| --- | --- |
| 完整设计链、SVG多层图与原画；阶段归属、部件粒度、建筑模块应用、Blueprint与关卡布局、UE与外部软件分工；白盒尺度材质、形体与内容完成度、叙事与空间设计 | [场景制作的三个阶段](scene-production-stages.md) |
| 路线与开启顺序、行动承诺与空间状态变化、玩家视角下的区域辨识、目标预览、敌人行为引导、遭遇节奏与空间记忆 | [关卡路线结构与玩法选择](level-layout-and-player-guidance.md) |
| 功能空间的宽深高与容量、角色尺度、结构占用后的净空、地墙衔接、碰撞与机关空间 | [白盒、通行与机关空间](blockout-and-traversal.md) |
| 画面过亮、暗部不可读、照明与材质混淆、全局与局部曝光 | [光照、材质与曝光](lighting-and-exposure.md) |
| 透视与正交、FOV、取景、遮挡、编辑器视图与玩家相机 | [视口投影与取景](viewport-projection-and-framing.md) |
| 玩家入口、控制关系、关卡机关状态、检查点与存档 | [游戏框架与状态](../10-gameplay-framework/index.md) |
| 子关卡归属、Editor 与运行时流送、WP 空间加载、HLOD 配置和生成 | [流式关卡、World Partition 与 HLOD](streaming-partition-hlod.md) |

World、Level、Actor 与 Component 的对象关系见[核心概念](../01-core-concepts/index.md)。Lumen、Nanite、Virtual Shadow Maps、Landscape、Water 等系统目前未在此展开，具体行为和限制按所缺问题查对应版本资料；不从某个白盒案例推导通用渲染或流送配置。
