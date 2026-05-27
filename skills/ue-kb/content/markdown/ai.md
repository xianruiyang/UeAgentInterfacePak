# AI系统

---
title: "AI系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ai-system-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "AI系统"]
---

# AI系统

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / AI系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ai-system-settings-in-the-unreal-engine-project-settings

## AI系统

### AI系统

| **分段** | **说明** |
| --- | --- |
| **感知系统类（Perception System Class）** | 将用于生成感知系统的类，可以特定于游戏。 你可以从以下选项中选择： **无（None）** **AIPerceptionSystem** |
| **AIHotSpotManager类（AIHotSpotManager Class）** | 将用于生成热点管理器的类，可以特定于游戏。 你可以从以下选项中选择： **无（None）** **AIHotSpotManager** |
| **EnvQueryManager类（EnvQueryManager Class）** | 将用于生成环境查询管理器的类，可以特定于游戏。 你可以从以下选项中选择： **无（None）** **EnvQueryManager** |
| **启用调试器插件（Enable Debugger Plugin）** | 如果设置此项，将在模块启动时加载 `GameplayDebuggerPlugin`。 |
| **遗忘过期Actor（Forget Stale Actors）** | 如果设置此项，Actor的刺激过期后，感知系统会遗忘这些Actor。 如果不设置此项，即使Actor不再被感知到，并且其刺激已超过最长期限，感知系统也会记住Actor。 |
| **AISystem Class** | 要创建的特定AI系统类的列表，可以特定于游戏。 |
| **AISystem模块（AISystem Module）** | 用于生成AI系统的模块的名称。 如果非空，此模块必须实现 `IAISystemModule` 。 |

### 移动

| **分段** | **说明** |
| --- | --- |
| **可接受半径（Acceptance Radius）** | 默认AI移动可接受半径，用于确定AI是否达到路径末端。 |
| **路径跟随正常路径点可接受半径（Pathfollowing Regular Path Point Acceptance Radius）** | 此值供路径跟随的内部代码确定AI是否达到路径的点。 此值不能被用于路径的最后一个点。对于最后一个点，请参阅“可接受半径”。 |
| **路径跟随寻路链路可接受半径（Pathfollowing Nav Link Acceptance Radius）** | 类似于 `PathfollowingRegularPathPointAcceptanceRadius` ，由路径跟随的内部代码使用，但仅当路径上的下一个点表示寻路链路开始时才会应用。 |
| **重叠目标时完成移动（Finish Move on Goal Overlap）** | 如果为true，与目标重叠时将被默认计为完成移动。 |
| **接受部分路径（Accept Partial Paths）** | 为移动任务是否接受部分路径设置默认值。 |
| **允许扫射（Allow Strafing）** | 为移动任务是否允许扫射设置默认值。 |

### Gameplay任务

| **分段** | **说明** |
| --- | --- |
| **启用BT AITasks（已废弃）（Enable BT AITasks (deprecated)）** | 控制是否针为移动任务启用Gameplay任务（目前总是启用）。此设置已弃用，不应该在新项目中使用。 |

### 环境查询系统 (EQS)

| **分段** | **说明** |
| --- | --- |
| **允许控制器作为EQSQuerier（Allow Controllers as EQSQuerier）** | 如果启用，EQS不会就使用控制器作为查询器发出警告。 如果禁用，控制器有时会自动转换为Pawn，并且EQS会在用户的代码绕过转换或使用无Pawn的控制器时发出警告。 此项默认为禁用状态。 |

### 黑板

| **分段** | **说明** |
| --- | --- |
| **添加黑板自键（Add Blackboard Self Key）** | 如果启用， `SelfActor` 键会被自动添加到新的黑板资产。 编辑器还会通过 `PostLoad` 检查加载的所有黑板资产是否都具有 `SelfKey` 条目。 |

### 行为树

| **分段** | **说明** |
| --- | --- |
| **在BTEQSFail时清除BBEntry（Clear BBEntry on BTEQSFail）** | 如果启用，该参数将在EQS查询失败时清除掉指示的黑板条目。 |

### 感知系统

| **分段** | **说明** |
| --- | --- |
| **默认视觉碰撞通道（Default Sight Collision Channel）** | 指定视觉检查默认使用的碰撞通道。 你可以从以下选项中选择： **WorldStatic** **WorldDynamic** **Pawn** **可视性（Visibility）** **摄像机（Camera）** **PhysicsBody** **载具（Vehicle）** **可破坏物（Destructible）** |

