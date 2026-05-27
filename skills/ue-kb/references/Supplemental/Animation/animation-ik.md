# Animation / IK / Control Rig 知识卡

## 适用范围

Animation Blueprint、Montage、BlendSpace、IK Rig、IK Retargeter、Control Rig、Root Motion 和动画通知。

## 官方资料入口

- 先读取 `official-sources.md` 中对应领域的 Epic 官方页面。
- 若主题和 UE 小版本相关，先确认项目使用的 UE 版本。

## 设计规则

- Animation Blueprint 负责姿态选择和混合，Gameplay 层负责权威状态。
- Montage 适合攻击、受击、交互等短时动作。
- 角色运行时动画必须先声明运动策略，再声明单个动画的运动模式。
- In-place 与 Root Motion 是互斥策略；不得用中间态设置伪装修复。
- 动画通知只做时序触发，权威校验仍放 Gameplay 层。

## 角色动画运动模式

将动画接入角色运行时图、BlendSpace、Montage 或 Retarget 结果前，先记录并验证 `motion_strategy` 和 `motion_mode`。

- `in_place`：动画不驱动角色整体位移；胶囊体、`CharacterMovement`、玩家输入、AI/Nav 或 Gameplay 逻辑负责移动。常用于普通移动、联网角色和 AI 巡逻。要求 root/整体位移锁定或可忽略，不能把源动画的 hips 漂移带进胶囊体外观。
- `root_motion`：动画通过真实 `root` 骨驱动整体位移或朝向，UE 从 Animation Sequence 或 Montage 提取 Root Motion 后移动角色。要求 Skeleton 有稳定 root 骨，root track 包含有意图的平移/朝向，AnimSequence、Montage、AnimBP Root Motion Mode 和移动逻辑一致。
- `additive_no_root_motion`：动画只叠加姿态、上半身、瞄准、表情、手部修正、武器反冲或类似局部表现。要求不注入非预期 root 位移/旋转；若会影响骨盆或躯干，必须确认 additive base pose 和层级遮罩正确。

`hips` / `pelvis` 不能当作 root 使用。它们是身体姿态骨，通常包含步态、重心和局部摆动；把它们当 root 会把身体姿态误当世界位移，常见结果是胶囊体与网格脱节、攻击时前后左右旋转、角色趴倒、滑步或网络校正异常。Mixamo 等来源缺少真实 root 时，应新增 root 骨并把有意图的水平位移/朝向转移到 root track，再锁定或清理 hips 的非预期整体漂移。

## 接入决策

- 先选 `motion_strategy`，再改资产：
  - `locomotion_in_place`：移动由 `CharacterMovement` 驱动；BlendSpace 只能使用真正原地 / root locked 的 walk、run、idle。
  - `montage_root_motion`：只让攻击、翻滚、处决等 Montage 驱动位移；AnimBP 使用 `RootMotionFromMontagesOnly`。
  - `full_root_motion_locomotion`：移动也由动画驱动；需要成套 start / stop / turn / strafe / walk / run root motion 动画和专门输入逻辑。
- `IgnoreRootMotion` 不是 in-place 修复方案，也不是完整 root motion 方案；不要用它掩盖前冲、回弹或 hips/root 烘焙错误。
- 目标是 `locomotion_in_place` 时，修资源：换 in-place 动画，或重新烘焙清理 root/hips 位移。不要批量开启 Root Motion。
- 目标是 `montage_root_motion` 时，只给目标 Montage 片段启用 Root Motion，并验证胶囊体实际跟随。
- 攻击、翻滚、处决等短时动作可以使用 Montage；默认仍按 `in_place` 处理，只有明确需要动画驱动位移时才改为 `root_motion`。
- 不要在同一个 State Machine 或 Slot 路径里混入未分类动画。确需混用时，先用 Gameplay 状态切换和 Montage/Root Motion 设置隔离责任。
- 来路不明、批量导入或 Retarget 后的动画先作为候选资产，不直接接入角色；先检查骨架轴向、root track、preview pose、曲线、notify 和运行时胶囊体效果。

## 推荐执行步骤

1. 明确目标、所有权、生命周期和运行时边界。
2. 先声明 `motion_strategy`，再为每个候选动画声明 `motion_mode`。
3. 建最小闭环，不先堆复杂表现。
4. 接入资产、图或 C++ 结构。
5. 做编辑器检查、运行时验证和失败日志。
6. 记录性能、维护和回退风险。

## 验证清单

- 在编辑器中确认资产、组件、图节点或配置确实按预期生成。
- 对 Blueprint、Material、Niagara、AnimBlueprint、Sequence 等资产执行对应编译或诊断命令。
- 对角色动画确认 `motion_strategy`、`motion_mode`、root 骨存在性、root track 位移/旋转、Root Motion 开关、Root Motion Root Lock、Montage Slot、AnimBP Root Motion Mode 与移动组件责任一致。
- `in_place` 与 `additive_no_root_motion` 必须确认 root 不产生非预期整体位移/旋转；`root_motion` 必须确认胶囊体跟随动画移动且不会遗留 mesh 偏移。
- 至少做一次运行时、预览或 headless 验证，避免只验证静态配置。
- 记录失败步骤、日志路径、关键 warning 和剩余风险。

## 常见失败模式

- 把表现层当成权威逻辑层，导致多人、存档或回放状态不同步。
- 动画未分类就接入角色，导致 CharacterMovement 与 Root Motion 同时或都不负责位移。
- 用 `EnableRootMotion=true` + `IgnoreRootMotion` 替代真正 in-place 资源或完整 root motion 链路。
- 在未选择完整 root motion 策略时批量开启所有角色动画 Root Motion。
- 用 hips/pelvis 代替 root，导致攻击、转身或混合时角色旋转、趴倒、滑步或胶囊体与网格分离。
- Mixamo/外部动画导入后只看预览姿态，没有修复 root 骨、轴向、root track 或 Retarget base pose。
- 只完成编辑器配置，没有做运行时验证。
- 资产引用、插件依赖或加载顺序缺失。
- 过度依赖 Tick、轮询或一次性脚本，后续维护困难。
