# 游戏框架与状态

本页说明关卡玩法常用的对象职责及生命周期。它不是某一种游戏架构模板；对象选择取决于状态属于谁、存活多久、是否需要联网或跨会话保存。

## 角色、控制与关卡入口

| 对象 | 关键职责与边界 |
| --- | --- |
| Pawn / Character | 可被控制的游戏实体；Character 在 Pawn 基础上提供常用角色移动支持 |
| PlayerController | 玩家控制关系与输入处理的一部分；拥有 Pawn 与在场景中看见 Pawn 是不同的事 |
| GameMode | 游戏规则以及玩家进入、生成和重生策略；联网时实例主要存在于服务端 |
| PlayerStart | 出生位置候选；是否使用它、选择哪个位置由生成逻辑决定 |
| GameState / PlayerState | 按整体游戏或玩家归属组织需要同步的状态；不是磁盘存档的替代品 |
| GameInstance | 随游戏实例存活，可跨地图保留会话数据；关闭游戏后不会自动持久化 |
| SaveGame | 应用选择保存的数据载体；创建或修改对象不等于已写入存储 |

World Settings 的 GameMode Override 可以改变某张地图采用的规则。复用角色控制通常还涉及 Pawn 类、Controller、Possession、输入映射、移动组件和相机；只把角色网格摆进场景不等于复用了整套控制。相关引擎职责见 [Gameplay Framework](https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-framework-in-unreal-engine) 和 [Game Mode and Game State](https://dev.epicgames.com/documentation/en-us/unreal-engine/game-mode-and-game-state-in-unreal-engine?application_version=5.7)。

## 资产默认值、关卡实例与运行时状态

Blueprint 类默认值、地图中实例的覆盖值与运行中对象的值属于不同层次。保存地图不会自动保存玩家这次运行产生的游戏进度，运行时改动也不自动回写 Blueprint 默认值。

编辑器世界与 PIE 世界有各自对象实例。跨地图加载时，不随地图保留的 Actor 通常需要重新建立；关卡流送、World Partition 或网络环境会进一步影响实例何时存在。长期状态若只依赖某个当前 Actor 的内存引用，不能据此假定下次加载仍能恢复。

## 机关与交互的状态

可复用机关可以由 Actor 或组件拥有行为；跨机关的关卡进度可由合适的协调对象管理。两者应共享对“未解锁、可用、运行中、完成、中断”的含义，而不是靠模型位置或播放过一次动画来猜状态。

“门已解锁”与“门当前开到多少”通常不是同一类信息；“平台已可用”与“平台当前正在上行”也不一定需要相同的持久化策略。哪些状态重载后保留、哪些恢复到合法初态，由玩法决定。

重复交互、切换地图、角色离开或机关被销毁可能打断行为。一次动作暂时取得的输入、碰撞或移动模式控制需要有恢复语义；视觉播放结束不自动保证所有这些状态已经恢复。

## 检查点、保存、载入与重置

UE 提供存档机制，但不会自动定义“篝火”或“检查点”包含哪些功能。重生地点、恢复资源、敌人刷新、已解锁捷径、收集物和传送资格，是游戏自行选择的状态。

SaveGame 对象是内存中的数据。应用将所需值写入对象，再执行保存并处理成功或失败；载入后还需要把数据应用到实际世界。一个保存对象中有门的解锁标志，并不自动让地图里的门改变碰撞和位置。存档槽与用户索引用于定位同一份记录，具体支持依平台而定。参见 [Epic：Saving and Loading Your Game](https://dev.epicgames.com/documentation/unreal-engine/saving-and-loading-your-game-in-unreal-engine?lang=en-US)。

保存进度适合描述可重建的游戏语义，例如检查点标识、收集项标识和机关状态；运行时对象引用本身不能代替跨会话恢复关系。载入时对象尚未生成、未流送或版本发生变化，也需要由游戏确定应用时机与兼容方式。

重新打开地图、角色复活和完整清档是不同语义。完整重置涉及持久记录、当前内存状态以及世界中的实际表现；如果旧内存仍会自动保存，仅删除文件可能又把旧进度写回。重置的作用范围和不可逆影响应在玩家操作中明确，具体交互形式由产品设计决定。

检查点与捷径如何共同影响流程，见[关卡结构与玩家引导](../07-world-level-rendering/level-layout-and-player-guidance.md)；机关运动与空间净空见[白盒、通行与机关空间](../07-world-level-rendering/blockout-and-traversal.md)。
