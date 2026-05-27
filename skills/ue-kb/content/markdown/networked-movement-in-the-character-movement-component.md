# Networked Movement in the Character Movement Component

---
title: "Networked Movement in the Character Movement Component"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/understanding-networked-movement-in-the-character-movement-component-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "网络编程教程和示例", "Networked Movement in the Character Movement Component"]
---

# Networked Movement in the Character Movement Component

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 网络编程教程和示例 / Networked Movement in the Character Movement Component

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/understanding-networked-movement-in-the-character-movement-component-for-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **角色 移动 组件** 是 一个 **Actor 组件** 该 提供 一个 encapsulated 移动 系统 使用 通用 模式 的 移动 用于 humanoid **角色**, 包括 walking, 下落, swimming, 和 flying. 该 角色 移动 组件 还 功能 robust 网络 Gameplay 集成. 它的 默认 移动 模式 为 所有 构建 到 复制 通过 默认, 和 它 提供 a framework 到 帮助 开发者 创建 自定义 联网 移动.

## 角色移动基础

[UCharacterMovementComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/UCharacterMovementComponent?application_version=5.5) comes preattached 到 该 [ACharacter](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/ACharacter?application_version=5.5) Actor 类 和 任何 **Blueprints** derived 从 它.

During its `TickComponent` function, `UCharacterMovementComponent` will call `PerformMovement` to calculate desired acceleration within the world based on what **移动 模式** 它 是 当前 使用 作为 良好 作为 该 玩家's 输入 变量, commonly represented 使用 该 *控制 输入* 变量 在 [APlayerController](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/APlayerController?application_version=5.5) . Once movement calculations are finalized, `UCharacterMovementComponent` applies the final movement to the owning character.

> [!NOTE]
> While `ACharacter` is derived from [APawn](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/APawn?application_version=5.5), Characters are not simply Pawns that have a character movement component added to them. `UCharacterMovementComponent` and `ACharacter` are designed to be used together, as `ACharacter` overrides several replicated variables and functions specifically to facilitate replication in `UCharacterMovementComponent`.

### PerformMovement 和 移动 物理

The `PerformMovement` function is responsible for physically moving the character in the game's world. In a non-networked game, `UCharacterMovementComponent` calls `PerformMovement` directly each tick. In a network game, `PerformMovement` is called by specialized functions for servers and clients to either perform the initial movement on a player's local machine or reproduce that movement on remote machines.

`PerformMovement` handles the following:

- Applies 外部 物理, 例如 impulses, forces, 和 gravity.
- Calculates 移动 从 动画 根 运动 和 ***根 运动 源***.
- Calls `StartNewPhysics`, which selects a `Phys*` function based on what movement mode the character is using.

Each movement mode has its own `Phys*` function that is responsible for calculating velocity and acceleration. For example, `PhysWalking` determines the character's movement physics when moving on the ground, while `PhysFalling` determines how it behaves in the air. If you wanted to debug the specifics of these behaviors, you would look inside each of these functions.

If a movement mode changes during a tick, such as when a character starts falling or collides with an object, the `Phys*` functions call `StartNewPhysics` again to continue the character's motion in the new movement mode. `StartNewPhysics` and the `Phys*` functions each pass through the number of iterations of `StartNewPhysics` that have occurred. The parameter `MaxSimulationIterations` is the maximum number of times this recursion is allowed.

## 移动复制概要

`UCharacterMovementComponent` uses its owner's **网络 角色** 到 确定 如何 到 复制 移动. 该 three 网络 roles 为 作为 遵循:

| 网络 角色 | 说明 |
| --- | --- |
| **自治 代理** | 该 角色 是 在 它的 *拥有者 客户端's* 机器, 正在 控制 本地 通过 a 玩家. |
| **权威端** | 该 角色 存在 在 该 服务器 hosting 该 游戏. |
| **模拟 代理** | 该 角色 存在 在 任何 其他 客户端 该 可以 参见 该 remotely-控制 角色, 是否 它's 正在 控制 通过 一个 AI 在 该 服务器 或 通过 一个 自治 代理 在 a 不同 客户端. |

The replication process follows a cycle within the `TickComponent` function, which repeats itself on every tick. As the character performs movement, copies of it on all the different machines in the network game make ***远程 Procedure 调用 (RPCs)*** 到 每个 其他 到 synchronize 移动 信息, 使用 不同 网络 roles 使用 不同 执行 路径 作为 适当.

The table below provides a step-by-step overview of what `UCharacterMovementComponent` does on each machine during this process:

| 步骤 | 说明 |
| --- | --- |
| 自治 代理 (拥有者 玩家's 客户端) |  |
| **1** | The owning client controls the autonomous proxy locally. `PerformMovement` runs the physical movement logic of the movement component. |
| **2** | The proxy builds an `FSavedMove_Character` containing data about how it just moved, then queues it in `SavedMoves`. |
| **3** | Similar `FSavedMove` entries are combined together. The autonomous proxy sends a condensed version of their data to the server with a ***ServerMove*** RPC. |
| Authoritative Actor (服务器) |  |
| **4** | The server receives the ServerMove and reproduces the client's movement using `PerformMovement`. |
| **5** | 该 服务器 检查 到 参见 如果 它的 位置 之后 该 ServerMove 匹配 该 客户端's 报告 结束 位置. |
| **6** | 如果 该 服务器 和 客户端's 最终 positions 匹配, 它 发送 a 信号 返回 到 该 客户端 saying 该 移动 曾 有效. Otherwise, 它 发送 a 校正 使用 a ***ClientAdjustPosition*** RPC. |
| **7** | The server sends its location, rotation, and current state to the simulated proxies on the other connected clients by replicating the `ReplicatedMovement` structure. |
| 自治 代理 (拥有者 玩家's 客户端) |  |
| **8** | If the client receives a ClientAdjustPosition, it reproduces the server's movement and uses its `SavedMoves` queue to re-trace its steps to get a new final position. When the move is successfully resolved, it removes the saved move from the queue. |
| 模拟 代理 (所有 其他 客户端) |  |
| **9** | 该 模拟 代理 直接 应用 已复制 移动 信息. ***网络 平滑*** 提供 visual cleanup 用于 该 最终 运动. |

此 流程 synchronizes 移动 之间 所有 three 类型 的 机器 内部 a 网络 游戏. 该 用户 控制 a 给定 角色 应 体验 minimal interference 从 该 服务器 和 保持 该 illusion 该 它们 为 控制 它们的 角色 本地, 和 它们 应 参见 其他 用户' 角色 执行 一个 approximation 的 该 移动 该 它们 为 所有 执行 在 它们的 自身 机器.

多数 的 此 流程's complexity focuses 在 mediating predictions 和 校正 之间 该 自治 代理 和 它的 counterpart 在 该 服务器 到 使 确保 该 players 具有 该 smoothest 体验 可能 在 控制 它们的 自身 角色. 模拟 代理, 通过 comparison, 仅 需要 到 stay 上 到 日期 位置 该 服务器 says 它们 应 是.

## 已复制 角色 移动 在-Depth

The following sections provide a detailed step-by-step walkthrough of the process briefly outlined above. Although a majority of projects are not expected to override `UCharacterMovementComponent`'s behavior, this will serve as a reference in case you need to develop similar functionality or need to find where to make modifications.

> [!NOTE]
> 此 章节 focuses 在 复制 a 角色's 法线 移动 模式. However, 存在 为 alternate 执行 路径 用于 根 运动 和 移动 当 基于 在 另一个 Actor, 其 follow 类似 步骤 到 那些 listed 在 此 章节.

### 本地 移动 在 该 拥有者 客户端

Autonomous proxies process movement locally in `TickComponent`, record it, then send it to the server to be reproduced and applied authoritatively. This section will break down the process that an autonomous proxy goes through on each tick.

#### Building 客户端 预测 数据

Autonomous proxies build an `FNetworkPredictionData_Client_Character` object called `ClientPredictionData` as part of their process for both recording moves and processing corrections from the server. Its parameters include:

- Timestamps 从 当 该 客户端 communicates 使用 该 服务器
- Lists 的 保存 或 pending 移动
- 保存 信息 从 服务器 校正
- 标志 denoting 如何 到 应用 校正
- 参数 determining 平滑 行为

`ClientPredictionData` also includes utility functions that interact with these parameters. You can find a full list of this object's information and functions in the [API 引用 用于 FNetworkPredictionData_Client_Character](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/FNetworkPredictionData_Client_Ch-?application_version=5.5). 它的 参数 为 referenced 和 changed 频繁 作为 该 客户端 执行 本地 移动, prepares 移动 到 发送 到 该 服务器, 和 流程 校正.

#### Reproducing 服务器 校正

Before the player's input or forces within the world are processed, the autonomous proxy calls `ClientUpdatePositionAfterServerUpdate`. This checks to see if the server has sent any corrections to the owning player. If it has, the variable `bUpdatePosition` inside `ClientPredictionData` will be true, and the character reproduces any moves sent from the server through the client correction process. For more information about server corrections, refer to the section below on Handling Client Error and Corrections.

#### 执行 和 录制 移动

Autonomous proxy characters call `ReplicateMoveToServer` during `TickComponent` instead of calling `PerformMovement` directly. This function surrounds `PerformMovement` with the necessary logic to record movement as the character performs it, then submits the move to the server. The `FSavedMove_Character` structure is a record of how the autonomous proxy started and ended its move during each tick, after which a minimum subset of its data is sent to the server through a ServerMove RPC. Its parameters include:

- 信息 关于 该 角色's 最终 位置 和 旋转
- 什么 移动 输入 曾 捕获
- 什么 速度 和 加速度 该 角色 held
- 根 运动 信息 捕获 从 **AnimMontages**

你 可以 review a 完整 列表 的 此 结构's 参数 在 该 [API 引用 用于 FSavedMove_Character](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/FSavedMove_Character?application_version=5.5). 此 信息 启用 该 服务器 到 重现 该 移动 该 该 玩家 performed, 然后 检查 针对 该 最终 位置 的 该 客户端.

After processing `PerformMovement`, the `ReplicateMoveToServer` function records the results of a character's movement in the client prediction data with an `FSavedMove_Character` structure called `NewMove`, which is then added to a buffer called `SavedMoves`. This buffer is ordered from the oldest saved move to the newest and acts as a queue until a saved move can be submitted to the server. Any similar moves in the buffer are combined together into a single `FSavedMove_Character` before being submitted to ease the strain on bandwidth. The parameter `PendingMove` acts as storage for moves that are waiting to be combined with an upcoming movement.

这些 将 是 已移除 从 该 缓冲区 当 它们 为 acknowledged, 或 *ACKed*. The server can ACK a move directly by confirming that the client's position is valid, or the client can ACK a move when it processes a correction from the server. The last move to be ACKed is saved in `LastAckedMove` for use in processing future corrections.

#### Submitting 移动 到 该 服务器

`ReplicateMoveToServer` finishes by running the function `CallServerMove`, which takes in the newest move and the oldest move in the queue that has not yet been ACKed by the server. This runs the final preparations for submitting a move to the server, attempts to submit the old move first (if applicable), then calls an appropriate ServerMove function to submit the finalized movement for the new move. The final ServerMove is submitted directly to the owning character of the `UCharacterMovementComponent` as an *不可靠* 服务器 RPC.

存在 为 两个 reasons 该 ServerMove 函数 为 不可靠:

1. 期间 法线 Gameplay, ServerMove 函数 为 称为 often enough 该 如果 它们 曾 designated 作为 可靠, 它们 可以 overflow 该 缓冲区 用于 可靠 函数, forcing 该 拥有者 玩家 到 disconnect.
2. 该 系统 用于 buffering 保存 移动 已经 ensures 该 移动 信息 lost 在 transit 将 是 resubmitted 和 评估. 此 提供 a 类似 safety net 到 a 可靠 函数, 但是 不 该 risk 的 overflowing 该 可靠 RPC 缓冲区, 和 使用 已添加 provisions 到 使 确保 移动 数据 该 是 过于 旧 gets discarded.

### 评估 移动 在 该 服务器

The server does not regularly tick movement in sync with the game's tick cycle. Instead, it waits to receive ServerMove calls from autonomous proxies, and `ServerMove_Implementation` handles movement on the server-side, reconstructing the client's movement and checking for discrepancies. This section will provide a walkthrough of the process that a ServerMove performs in detail.

> [!NOTE]
> This document broadly refers to `ServerMove` and `ServerMove_Implementation`, but there are multiple types of ServerMove calls depending on what kind of information is queued.

#### Building 服务器 预测 数据

The authority version of a character movement component creates an `FNetworkPredictionData_Server_Character` object called `ServerPredictionData`, which exists for the lifetime of the character. During `ServerMove_Implementation` this object will store information to be used by later processes to reproduce the owning client's movement. This object is continually modified in the background as the server receives data, and its parameters include:

- Timestamps 使用 到 计算 该 服务器's 增量 时间
- Pending 客户端 adjustments
- 标志 相关 到 resolving 时间 discrepancies
- 标志 denoting 是否 该 服务器 ACKs 或 corrects a 移动

你 可以 读取 它的 完整 列表 的 参数 和 函数 在 该 [API 引用 guide 用于 FNetworkPredictionData_Server_Character](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/FNetworkPredictionData_Server_Ch-?application_version=5.5).

#### Verifying 客户端 时间戳

The information sent with a ServerMove RPC includes a timestamp for when the move occurred. If the server's timestamp and the client's timestamp have too large of a discrepancy, the client's timestamp is considered expired and the move is discarded. Otherwise, the discrepancy is flagged to be resolved, and `UCharacterMovementComponent` uses `ProcessClientTimeStampForTimeDiscrepancy` to create an override for the delta time in the next step.

#### 计算 增量 时间

While delta time is usually obtained by keeping track of the time that has passed between the current tick and the previous tick, characters on the server do not use `TickComponent` to calculate movement. Instead, `ServerMove_Implementation` calls `GetServerMoveDeltaTime` and calculates movement as ServerMoves are received. If the server prediction data is flagged as trying to resolve a timestamp discrepancy, it will use `TimeDiscrepancyResolutionMoveDeltaOverride`. If there is no time discrepancy, it uses the server prediction data to create a delta time using the difference between the current ServerMove RPC's timestamp and the last ServerMove RPC's timestamp. To provide an extra layer of security, the majority of these calculations are performed with the server's timestamps instead of the client's, preventing clients from hacking their speed by speeding up their local game clock.

#### 评估 该 移动

The server next uses the data from the ServerMove RPC to reconstruct the owning player controller's control rotation, then calls the function `MoveAutonomous` to process the character's acceleration, rotation, and jump inputs.

`MoveAutonomous` uses the `PerformMovement` function to simulate the character's movement physics using this reconstructed data and the delta time supplied in the previous step. Instead of simulating movement from where the client started, the server simulates from the location where its own copy of the character was when it got the ServerMove call.

> [!NOTE]
> 如果 该 角色 是 执行 根 运动 从 一个 动画, MoveAutonomous 还 ticks 该 角色's 动画 姿势 使用 该 提供 增量 时间. 任何 动画 事件 将 触发 appropriately. Otherwise, 动画 ticks 通常.

### 处理 客户端 错误 和 校正

Server movement works from the assumption that the server and owning client are both starting their movement in the same locations, and that if the server performs the same moves that the client reports, the locations that they end their moves in will also be the same. If the client's moves get dropped due to connection problems or if the client submits bad data, however, the two will end in different locations, necessitating a correction. The function `ServerMoveHandleClientError` is responsible for these operations.

#### Determining 如果 Adjustments 为 Necessary

Issuing corrections frequently would strain bandwidth and cause the client to re-simulate a large number of saved moves too often, so we first check against the value returned from `WithinUpdateDelayBounds` to see if a minimum amount of time has passed between moves. If it returns `false`, then no corrections will be issued. If it returns true, then the rest of the process is permitted to run.

Next, we use `ServerCheckClientError` to see if the error between server and client is large enough to be worth correcting. If it returns true, or if something sets `bForceClientUpdate` to true to force a correction, then `ServerMoveHandleClientError` continues with the rest of the process.

The parameters for adjusting both these operations can be found in `BaseGame.ini`, and you can provide project-specific overrides in the `DefaultGame.ini` for your project. The value `ClientErrorUpdateRateLimit` determines the minimum delay in seconds for the server sending error corrections to a client. The value `MAXPOSITIONERRORSQUARED` is the square of the max position error that is accepted in network play without being corrected. Both of these can be found under the `[/Script/Engine.GameNetworkManager]` section of the config file.

如果 一个 调整 是 necessary, 该 服务器 预测 数据 fills 一个 **[FClientAdjustment](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/FClientAdjustment?application_version=5.5)** structure called `PendingAdjustment` with current movement variables sampled from the server's copy of the character, including location, rotation, velocity, and any objects that might be acting as a base for the character's movement. Otherwise, we set `PendingAdjustment`'s `bAckGoodMove` value to `true` to flag the client's movement as being valid.

#### 发送 客户端 Adjustments 或 ACKing 移动

The final call for acknowledging movement to the client is made with `SendClientAdjustment`. This function does not occur as part of `ServerMove_Implementation`. Rather, this is part of `UNetDriver::ServerReplicateActors`, which is called at the end of a tick on the server and is similarly responsible for calling other client adjustment RPCs. When `SendClientAdjustment` is called, it will act depending on how the prediction data we built in the previous steps is flagged.

If the server prediction data's `PendingAdjustment` is flagged with `bAckGoodMove` as `true`, it will call the `ClientAckGoodMove` RPC to ACK the move, telling the autonomous proxy on the owning client's machine that the move was valid. This will remove the original move from the `SavedMoves` buffer on the owning client's side and record it as the `LastAckedMove` for use in building future prediction data.

If the `PendingAdjustment` has `bAckGoodMove` flagged as false, it will call client adjustment functions to send the final corrections to the client.

#### 接收 客户端 Adjustments 在 自治 代理

The client adjustment RPCs include `ClientAdjustPosition`, `ClientAdjustRotation`, shortened versions of them that occur when velocity is zero, and versions of them specially used for root motion-based movement. The server may call more than one of these as part of `SendClientAdjustment`, depending on the nature and severity of what needs to be corrected. Each of these is capable of telling `ClientPredictionData` to ACK moves once the necessary corrections are applied, and each of them will flag `bUpdatePosition` to true.

The final corrections are then applied at the beginning of the client's next `TickComponent` using `ClientUpdatePosition`.

### 复制 移动 到 模拟 代理

角色 在 客户端 机器 其他 比 它们的 owners 为 模拟 代理 改为 的 自治 代理. 该 流程 用于 复制 移动 从 该 服务器 到 模拟 代理 是 highly simplified, 作为 模拟 代理' 仅 作业 是 responding 到 该 服务器. 改为 的 simulating 移动 物理, 当 它们 接收 移动 更新 从 该 服务器, 它们 设置 它们的 位置, 旋转, 和 速度 到 whatever 该 服务器 says 它们 应 是, 使用 a few 额外的 流程 到 使 它们的 移动 smoother 和 更多 believable.

#### Storing 已复制 移动 信息

When Actors replicate movement, they do not replicate their transforms directly. Instead, all Actors maintain a replicated variable called `ReplicatedMovement`, which uses the structure [FRepMovement](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/FRepMovement?application_version=5.5).

The boolean `bReplicateMovement`, represented by the **复制 移动** variable in Blueprint, flags Actors to store movement information in this structure and replicate it to clients. When a client receives updates to `ReplicatedMovement`, the **RepNotify** function `OnRep_ReplicatedMovement` unpacks the stored movement data and performs updates to the Actor's location and velocity accordingly.

Neither `ReplicatedMovement` or its OnRep are accessible inside of Blueprint, but `OnRep_ReplicatedMovement` can be overridden in C++, and `ReplicatedMovement`'s replication conditions can also be overridden in `GetLifetimeReplicatedProps`. This enables you to customize how movement replication behaves in C++ based Actor classes.

In `ACharacter`, the `ReplicatedMovement` structure is only replicated for simulated proxies. It will be ignored on autonomous proxies, who otherwise use the server move and client adjustment RPCs to process movement.

> [!NOTE]
> If a character is using another Actor as a base, it will use `ReplicatedBasedMovement` instead, which applies additional logic to make sure the client is based correctly according to the server. If the character uses the root motion system, all of these processes are ignored in favor of using `RepRootMotion`.

#### Ticking 移动 在 模拟 代理

When `UCharacterMovementComponent` runs `TickComponent` on a simulated proxy, it calls `SimulatedTick` to handle the logic for simulating movement. This does not perform the replicated movement outlined above. Instead, `SimulatedTick` continues moving in accordance with the most recently provided replicated movement data. When performing standard movement physics, it calls the `SimulateMovement` function, then performs final validations and network smoothing with `SmoothClientPosition`.

#### 执行 模拟 移动

The `SimulateMovement` function is responsible for moving simulated proxy characters. In addition to being called by `SimulatedTick`, it is also called by `OnRep_ReplicateMovement`. This function performs the following processes:

1. Calls the owning character's `GetReplicatedMovement` function to obtain a reference to `ReplicatedMovement`.
2. 执行 safety 检查 到 确保 该 已复制 移动 数据 是 有效 和 该 该 客户端's 基础 是 解决.
3. 检查 到 参见 如果 任何 网络 更新 具有 已经 接收.
4. Applies the character movement mode from the server, obtained with `GetReplicatedMovementMode`.
5. Resets 所有 标志 regarding 网络 更新.
6. Performs the logic for simulated moves based on the current `MovementMode` and information about the character's current state.

The logic for simulated moves is highly simplified compared with standard movement physics, such that it is mostly contained in the `SimulateMovement` function itself rather than broken into smaller functions. However, this function is still responsible for updating the character's local movement state, including what movement mode it should transition into, whether or not the character has landed on the ground, and what velocity it should have. This information ensures that the character can update its animation correctly and that its movements appear reasonably accurate.

#### 网络 平滑

如果 we 已复制 移动 通过 simply 复制 该 位置 和 旋转 的 a 角色, 然后 该 角色 将 seem 到 teleport 每个 few moments. 此 是 由于 到 该 渲染 速率 用于 a 本地 机器 正在 faster 比 该 速率 该 we 将 希望 到 发送 数据 超过 a 网络. A 客户端 可能 是 渲染 到 a monitor 使用 a 240 Hz refresh 速率, 用于 实例, 但是 该 已复制 移动 可能 是 发送 在 仅 30 Hz.

Network smoothing is a process that smooths out this motion, interpolating the character gradually from the source location towards a target location instead of snapping it to the target instantly. The source location is given by the character's current position, while the target is given by the client prediction data. The interpolation itself is handled in `SmoothClientPosition`, which uses [NetworkSmoothingMode](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/ENetworkSmoothingMode?application_version=5.5) 到 确定 什么 kind 的 interpolation 它 应 使用.

## 特殊 移动 情况

该 以下 sections contain 信息 在 通用 特殊 移动 情况, 包括 teleportation, 自定义 移动, 和 代码-驱动 移动 作为 你 可能 参见 在 特殊 能力.

### Teleporting a 角色 在 Multiplayer

你 可以 teleport a 角色 在 a 网络 游戏 通过 调用 任何 的 该 **SetLocation** 函数 或 该 **Teleport** 蓝图 节点, 提供 你:

1. 使 确保 它们 为 称为 在 该 服务器.
2. If using the `SetLocation` functions, set the `bTeleport` variable to true so it recognizes the move as a teleport.

![Teleporting a Character](../../../../../assets/images/db/db2efa44d32d9a41b69c6d667aa088a909fa550248d9bd7590d49042dc15b526.jpg)

如果 这些 条件 为 satisfied, 该 移动 是 recorded 在 该 服务器's 预测 数据 和 在 已复制 移动 作为 a teleport, 和 所有 客户端 响应 accordingly 通过 snapping 该 角色 到 该 期望 位置 改为 的 applying 平滑.

### 使用 自定义 移动 模式

The movement mode `MOVE_Custom` suspends all other movement physics, enabling you to implement custom movement logic without interference from `UCharacterMovementComponent`'s normal processes.

`UCharacterMovementComponent` is not normally Blueprintable, so custom movement in Blueprint is usually implemented directly inside Character using the **UpdateCustomMovement** 事件. 你 可以 使用 该 **自定义 移动 模式** byte 变量 到 提供 sub-模式, 任一 使用 a switch 在 整数 或 使用 a conversion 到 a 自定义 enum.

![Custom Movement Mode in Blueprint](../../../../../assets/images/6c/6c8c3c5d5eea4eb4f3dc256f6ebe4410c00620306bf758d8ad2d187f8f3df20c.jpg)

`UpdateCustomMovement` is called by the `PhysCustom` function in `UCharacterMovementComponent`. The functions `StartNewPhysics`, `PhysCustom`, and all the other movement physics functions are virtual functions, so if you create a custom `UCharacterMovementComponent` in C++, you can override them directly.

### 复制 特殊 情况 移动 使用 根运动

你 可能 需要 到 采用 直接 控制 的 a 角色's 移动 用于 brief periods, 例如 作为 期间 能力 创建 使用 该 **Gameplay 能力 系统** 或 期间 动画-驱动 动作. 当 此 是 simple 到 do 在 a 本地-仅 游戏, 已复制 特殊 情况 移动 需要 该 使用 的 根 运动, 其 generally refers 到 该 应用程序 的 移动 从 一个 动画. 该 根 运动 系统 具有 还 已经 adapted 到 permit 代码-驱动 特殊 情况 移动.

Root motion always takes precedence over standard movement physics, regardless of what movement mode the `UCharacterMovementComponent` is using. When your root motion is finished, normal movement will resume.

#### 从 AnimMontages

多数 应用程序 的 根 运动 为 expected 到 come 从 AnimMontages, 其 为 使用 用于 代码-triggered 一个-shot animations. 此 使用 的 根 运动 suspends 任何 其他 移动 该 你的 角色 是 执行 直到 该 结束 的 该 动画. 该 角色 改为 consumes 移动 从 它的 skeleton's 根 bone 和 translates 它 到 世界-空间 移动, 启用 该 动画 到 控制 如何 该 角色 移动. 当 此 completes, 该 使用 的 法线 物理 用于 该 角色 是 restored.

> [!NOTE]
> 如果 你的 角色 是 在 该 下落 移动 模式, gravity 是 仍然 应用 到 该 角色's Z 移动 even 当 该 角色 是 执行 根 运动.

Within the replication process outlined above, root motion information is captured by the `FSavedMove_Character` structure, including the AnimMontage it comes from, the character's track position within the montage, and parameters for the character's movement itself.

该 服务器 和 该 自治 代理 在 该 拥有者 客户端 do 不 检查 到 参见 该 它们 为 playing 该 相同 动画, 作为 此 是 通常 视为 a cosmetic feature. Therefore, 你 必须 program 你的 Gameplay 逻辑 到 确保 该 任何 AnimMontages 为 triggered 正确 在 所有 机器 connected 到 a 游戏. However, 模拟 代理 具有 parallel 流程 到 该 ones 概述 上方 用于 synching 根 运动-基于 移动.

> [!TIP]
> 该 Gameplay 能力 系统 插件 synchronizes AnimMontages 和 根 运动 通过 复制 该 能力 该 触发器 它们.

#### 从 根运动 源

Sometimes 你 可能 需要 到 控制 a 角色's 位置 手动 用于 特殊 情况. 用于 示例, 你 可能 需要 到 创建 a 特殊 能力 位置 a 角色 leaps a 特定 高度 到 该 air, 然后 lands 在 a 移动 目标.

Manually controlling the character with `SetLocation` and `SetRotation` is possible on standalone games, but in network games, this motion is not captured by the above replication process, so the server will see the client's final location as an error and issue a correction. Root motion from AnimMontages, meanwhile, follows only pre-computed motion from animations. This means that root motion can not normally take in real-time information from the game's world, such as the position of other characters, and it also can not be easily fine-tuned using gameplay variables.

**根 运动 源** 提供 a 表示 用于 programmers 到 手动 采用 控制 的 a 角色's 根 运动. 此 启用 你 到 控制 a 角色's 移动 programmatically 当 还 taking advantage 的 该 上方 系统 用于 处理 根 运动 期间 网络.

> [!NOTE]
> 根 运动 源 应 是 应用 到 自治 代理 在 该 拥有者 客户端.

到 使用 此 系统, 你 必须 创建 a 新增 FRootMotionSource 结构. 不同 FRootMotionSource variants exist 用于 不同 kinds 的 移动. 用于 实例, FRootMotionSource_MoveToForce 是 使用 用于 a straightforward 移动 从 a 开始 位置 到 a 目标 位置, 当 FRootMotionSource_JumpForce 遵循 a jump-例如 arc. 一次 你 具有 创建 一个 适当 根 运动 源, 你 可以 initialize 它的 属性 使用 该 期望 源 位置, 目标 位置, 和 参数 用于 如何 它的 移动 应 behave.

The function `UCharacterMovementComponent::ApplyRootMotionSource` will apply the root motion source to the character and return a handle that can be used to reference it later. The root motion sources themselves do not process movement. Instead, the character movement component performs movement consistent with the parameters in the provided `FRootMotionSource` in place of an animation. This is eventually added to `SavedRootMotion` within the `FSavedMove_Character` structure, capturing it in the replication cycle provided that the `FRootMotionSource` is applied to an autonomous proxy.

When the movement is completed, you must call `UCharacterMovementComponent::RemoveRootMotionSource` to remove it using the handle returned from `ApplyRootMotionSource`.

> [!TIP]
> The Gameplay Ability System plugin contains several ability tasks that utilize root motion sources, enabling abilities to perform complex sequences of programmatic movement. You can refer to `AbilityTask_ApplyRootMotionMoveToForce` for a basic example.

## Customizing 联网 角色 移动

Unreal Engine enables replicated Character movement support of custom function parameters. Developers who do not require this functionality and want to maintain the legacy API can define `SUPPORT_DEPRECATED_CHARACTER_MOVEMENT_RPCS` to a non-zero value in the project build files, and set the Console Variable "p.NetUsePackedMovementRPCs" to zero.

The Character Movement Component sends data across the network using an `FSavedMove_Character` struct. The system consolidates move data from one or more updates into a single variable-length bit stream for transmission across the network. By packaging old and new data together, this method avoids potential ordering issues involving `ServerMoveOld` RPCs being called after `ServerMove`, which could cause old (but still important) data to be incorrectly disregarded as obsolete. Internally, the Character Movement Component uses the new `CallServerMovePacked` function to serialize multiple `FSavedMove_Character` instances into an `FCharacterNetworkMoveDataContainer`, replacing the old usage of `CallServerMove`.

### Extending 保存 移动 数据

To add new data, first extend `FSavedMove_Character` to include whatever information your Character Movement Component needs. Next, extend `FCharacterNetworkMoveData` and add the custom data you want to send across the network; in most cases, this mirrors the data added to `FSavedMove_Character`. You will also need to extend `FCharacterNetworkMoveDataContainer` so that it can serialize your `FCharacterNetworkMoveData` for network transmission, and deserialize it upon receipt. When this setup is finised, configure the system as follows:

- Modify your Character Movement Component to use the `FCharacterNetworkMoveDataContainer` subclass you created with the `SetNetworkMoveDataContainer` function. The simplest way to accomplish this is to add an instance of your `FCharacterNetworkMoveDataContainer` to your Character Movement Component child class, and call `SetNetworkMoveDataContainer` from the constructor.
- Since your `FCharacterNetworkMoveDataContainer` needs its own instances of `FCharacterNetworkMoveData`, point it (typically in the constructor) to instances of your `FCharacterNetworkMoveData` subclass. See the base constructor for more details and an example.
- In your extended version of `FCharacterNetworkMoveData`, override the `ClientFillNetworkMoveData` function to copy or compute data from the saved move. Override the `Serialize` function to read and write your data using an `FArchive`; this is the bit stream that RPCs require.

To extend the server response to clients, which can acknowledges a good move or send correction data, extend `FCharacterMoveResponseData`, `FCharacterMoveResponseDataContainer`, and override your Character Movement Component's version of the `SetMoveResponseDataContainer`.

### Accessing Extended 移动 数据

To maintain backwards compatibility, there have been no changes to the function stack for working with client moves on the server and replaying them on the client after receiving a correction. While this provides a stable API for the legacy functions, it also means that those function signatures do not accomodate the new movement data. You can access this data on the server while processing a move, or on a client while replaying one, by calling `GetCurrentMoveData` and casting the returned `FCharacterNetworkMoveData` to your subclass.

