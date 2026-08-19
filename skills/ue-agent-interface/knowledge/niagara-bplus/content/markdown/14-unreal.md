# 14-Unreal蓝图播放制作

# 14-Unreal蓝图播放制作

## 关键术语

- `UV`、`Substance`、`Substance Designer`、`蓝图`、`速度`、`纹理`、`火焰`、`SutcMeshAct`、`SuticMeshicl`、`57 actors (I selected)`、`Niagara`、`蒙太奇`、`Niagara System`、`Emitter`、`Spawn Rate`、`Spawn`、`Lifetime`、`Alpha`

## 分段知识

### 00:00:05-00:04:46 UV

- 本段定位：UV。
- 知识点：uvbrite, like uvbrite, like 所以这次例子呢就是我们用之前用过的背景 然后就不会用那个叫暗影的背景项目 因为要用这个点算页面角色。
- 知识点：这个在5.5版本还没迁移 所以用到5.4版本之前的课程 然后项目已经利用了 所以应该会进行下去 这里也会单独构建文件夹 从5号开始 而且一起利用我之前用过的4号等级也没问题。
- 知识点：打开x6号来使用 背景设置的话没什么特别的 就是没听过之前课程的人 只是用了第三方项目里的那个地图 所以不用太担心 这些材料我们定制后放进去做了。
- 知识点：背景设置 然后呢人家就是不这样 放材料只用检查图也没关系 我们把这个作为coronavirus 然后新建文件夹并单独分离一级别来使用。
- 知识点：会放0.4进去 这种话这个角色可能就不太需要了 删掉然后这个背景设置是怎么做的呢 现在打开第三人称地图 打开地图的话 简单给大家展示一下。

**关键画面：**

本图位于 `### 00:00:05-00:04:46 UV` 段的开头，但当前展示的还不是具体 UV 节点，而是课程工程的基础地图与目录结构。画面可直接确认：

- 当前是一个几乎空白的棋盘格测试场景
- 场景中可见默认玩家起点/控制器图标与一个半圆形编辑器辅助图标

右侧 `Outliner` 当前层级可直接读取：
- `Untitled (Editor)`
- `HLOD`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Landscape`
- `PlayerStart`
- `WorldDataLayers-1`
- `WorldPartitionMiniMap`

底部内容浏览器当前路径为：
- `Content > Signature`

当前可见的课程文件夹有：
- `Course_01`
- `Course_02`
- `Course_03`
- `Course_04`
- `Test`

左下收藏树还可辨认出其他项目目录：
- `ParagonGideon`
- `ParagonGreystone`
- `ParagonKhaimera`
- `ParagonPhase`
- `ThirdPerson`
- `Weapon_Pack`

这张图的作用是交代后续课程所依赖的工程骨架：作者不是在现有复杂关卡里直接做，而是先在一个干净场景里整理课程目录和基础世界对象，再逐步把前面课程的资源、角色和蓝图迁移进来。结合正文里“会单独构建文件夹”“打开第三人称地图”，可复现为：先准备一个最小化地图和清晰的课程文件夹结构，后面再接入角色、背景和特效资源。
本图继续是课程场景准备阶段，但已经切到一个具体关卡环境中。当前画面可直接确认：

- 当前打开的关卡标签为 `Ex_06`
- 视口里是一个简化的灰色地面/围墙测试场地
- 场地中央放置了一个人形角色占位

右侧 `Outliner` 当前层级可直接读取：
- `Ex_06 (Editor)`
- `Block01`
- `Block02`
- `Block03`
- `Cylinder`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Playground`
  - `SM_Cube`
  - `SM_Cube2`
  - `SM_Cube3`
  - `SM_Cube5`
  - `SM_Cube6`
  - `BP_ThirdPerson_Target_Project`

右下 `Details` 当前选中的是：
- `SM_Cube`
- `SM_Cube (Instance)`
- 类型为 `StaticMeshComponent`

中间弹出的保存进度框还给出一个关键事实：
- `Saving map: Ex_04.umap...`
- 路径中可见 `.../Signature/Course_05/Level/Ex_04/...`

底部内容浏览器当前路径为：
- `Content > Signature > Course_04 > Level`

可见的关卡资源有：
- `Ex_01`
- `Ex_02`
- `Ex_03`
- `Ex_04`
- `Ex_05`
- `Ex_06`

这张图说明作者的做法不是从零搭一个全新蓝图工程，而是明确复用前面课程的关卡模板和目录组织：`Course_04` 下已有一组 `Ex_01` 到 `Ex_06` 的测试关卡，当前又在保存/迁移与 `Course_05` 相关的关卡数据。结合正文里“利用我之前用过的 4 号等级也没问题”，可复现为：直接复用旧课的测试地图和基础角色摆位，把新课程的蓝图和特效工作接在已有练习关卡之上。
本图继续在测试关卡 `Ex_04` 中做基础项目配置，当前已经切到 `GameMode` 设置。画面可直接确认：

- 当前关卡标签为 `Ex_04`
- 视口仍是灰色测试场地
- 场景中保留 `PlayerStart`

右侧 `Outliner` 可读到：
- `Ex_04 (Editor)`
- `Block01`
- `Block02`
- `Block03`
- `Cylinder`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Playground`
  - `SM_Cube`
  - `SM_Cube2`
  - `SM_Cube3`
  - `SM_Cube5`
  - `SM_Cube6`
  - `PlayerStart`

底部内容浏览器当前路径为：
- `Content > ThirdPerson > Blueprints`

当前鼠标提示和选中项可直接确认：
- `BP_ThirdPersonGameMode`
- 路径：`/Game/ThirdPerson/Blueprints`
- `Parent Class = GameModeBase`

右侧 `World Settings` 面板当前最关键的字段为：

`Game Mode`
- `GameMode Override = BP_ThirdPersonG...`（界面截断，但与提示框一致，可确认是 `BP_ThirdPersonGameMode`）

此外还能看到：
- `Precomputed Visibility`
- `World Partition Setup`
- `Enable Streaming`

这张图把本段“打开第三人称地图”“默认表单类”的配置步骤钉住了：作者先把关卡的 `GameMode Override` 指到 `BP_ThirdPersonGameMode`，确保这个测试地图启动时会使用第三人称模板那套默认 Pawn/控制逻辑。对复现而言，这一步是后续角色替换和技能蓝图触发的入口，没有先把关卡挂到正确的 `GameMode`，后面改角色或按键逻辑都不会按预期工作。

### 00:04:46-00:08:22 蓝图

- 本段定位：蓝图。
- 知识点：打开看看 游戏模式就会这样出现 现在只需换掉我们要用的角色 好的 默认表单类然后 在这里搜索页面 选择页面播放器角色 然后然后就这样然后 就进去了。
- 知识点：在这里右键点击播放时 现在页面这个角色会出现吧 是的就是角色会出来 然后现在可能什么操作都不行 一开始这个 直接按ESG 现在我来打开页面。
- 知识点：这个角色的蓝图看看 嗯 好的这样打开确认一下 现在可观察到有错误出现了 创建基本的标准角色 现在导入的话 现在导入的话 全部都会这样出错 用势力这个角色来。
- 知识点：加入我们想要的技能动作 按下特定键时 可以重复使用那个技能的环境 现在简单设置一下就是 现在就可以用了 之前在蓝图课程中也提到过。
- 知识点：走吧 是的 那部分会直接用到 是的 在这种游戏环境下 其实制作效果非常重要 对吧 右vbr 所以只需将出错的部分 替换为其他节点即可 现在的话 除此之外。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`蓝图`。

**关键画面：**

本图进入 `### 00:04:46-00:08:22 蓝图` 段，当前打开的是：

- `BP_ThirdPersonGame...`（标签截断，但结合前文可判断为 `BP_ThirdPersonGameMode`）
- 视图页签：`Class Defaults`

顶部提示栏明确说明：
- `This is a data only blueprint, so only the default values are shown.`
- 如果要添加脚本或变量，需要 `Open Full Blueprint Editor`

当前页中可直接读取的关键类设置如下：

`Classes`
- `Game Session Class = GameSession`
- `Game State Class = GameStateBase`
- `Player Controller Class = PlayerController`
- `Player State Class = PlayerState`
- `HUD Class = HUD`
- `Default Pawn Class = BP_ThirdPersonCharacter`
- `Spectator Class = SpectatorPawn`
- `Replay Spectator Player Controller Class = PlayerController`
- `Server Stat Replicator Class = ServerStatReplicator`

`Game`
- `Default Player Name` 为空

`Game Mode`
- `Use Seamless Travel` 未启用
- `Start Players as Spectators` 未启用
- `Pausable` 已启用
- `Game Net Driver Replication System = Default`

这张图把蓝图段最关键的入口配置明确了：当前 `GameMode` 默认仍然使用 `BP_ThirdPersonCharacter` 作为 `Default Pawn Class`。结合正文“只需换掉我们要用的角色”，可复现为：先打开 `BP_ThirdPersonGameMode` 的 `Class Defaults`，确认默认 Pawn 目前还是模板角色，再把它替换成课程里真正要使用的角色蓝图。没有先定位到这里，后面进入游戏后出现的仍会是第三人称模板角色。
本图继续是 `蓝图` 段，但已经从 `GameMode` 切到实际要使用的角色蓝图：

- `PhasePlayerCharacter`
- 当前页签：`Event Graph`
- `Parent class: Character`

左侧组件树可直接确认该角色蓝图包含：
- `Capsule Component`
- `Arrow Component`
- `Mesh (CharacterMesh0)`
- `CameraBoom`
- `FollowCamera`

左侧变量区当前可见：
- `BaseTurnRate` (`Float`)
- `BaseLookUpRate` (`Float`)
- `SaveAttack` (`Boolean`)
- `IsAttacking` (`Boolean`)
- `AttackCount` (`Integer`)

中间事件图能辨认出的逻辑分区标签包括：
- `Mouse input`
- `Movement input`
- `Jump`
- `Touch input`

底部 `Compiler Results` 当前明确显示了至少两条错误/警告：
- `Input Axis Event references unknown Axis 'LookUp' for InputAxis LookUp`
- `In use pin <Unnamed> no longer exists on node Reset Orientation and Position...`

右侧 `Details` 面板能进一步确认角色资产设置：

`Animation`
- `Animation Mode = Use Animation Blueprint`
- `Anim Class = Phase_AnimBlueprint`（名称后半截被截断，但前缀 `Phase_AnimBlueprint` 可确认）

`Mesh`
- `Skeletal Mesh Asset = Phase_GDC`

`Materials`
- `Element 0 = MIC_Phase_jacket...`
- `Element 1 = MIC_Phase_body...`
- `Element 2 = MIC_T_Phase_Ski...`

这张图把蓝图段的核心问题说清了：作者并不是简单把角色蓝图换进来就结束，而是立刻发现迁移后的角色存在输入轴和节点失效问题。结合正文“现在可观察到有错误出现了”“只需将出错的部分替换为其他节点即可”，可复现为：先把 `Default Pawn` 切到 `PhasePlayerCharacter`，再进角色事件图处理输入轴名缺失和失效节点，否则角色虽然能加载出来，但控制和动作逻辑不会正常工作。
本图继续在 `PhasePlayerCharacter > Event Graph` 中处理输入修复，当前已经打开右键搜索面板并搜索：

- `inputaxis`

搜索结果里当前可直接看到一组可用的输入轴事件：

`Axis Events`
- `Look Up / Down Gamepad`
- `Look Up / Down Mouse`
- `Move Forward / Backward`
- `Move Right / Left`
- `Turn Right / Left Gamepad`
- `Turn Right / Left Mouse`

`Gamepad Events`
- `Gamepad Left Thumbstick X-Axis`
- `Gamepad Left Thumbstick Y-Axis`
- `Gamepad Left Trigger Axis`
- `Gamepad Right Thumbstick X-Axis`
- `Gamepad Right Thumbstick Y-Axis`
- `Gamepad Right Trigger Axis`

画面背景中同时能确认角色蓝图原本的移动逻辑仍在：
- 至少两个 `Add Movement Input` 节点
- 原有 `InputAxis MoveForward` 相关节点还保留在图中

底部 `Compiler Results` 依旧保留上一张里的问题提示：
- `Input Axis Event references unknown Axis 'LookUp' for InputAxis LookUp`
- `In use pin <Unnamed> no longer exists on node Reset Orientation and Position...`

这张图把修复路径进一步坐实了：作者没有停留在“看到报错”，而是直接在当前工程里搜索可用的输入轴事件，准备把失效的 `LookUp`/转向类旧节点替换成项目里现存的 `Look Up / Down Mouse`、`Move Forward / Backward` 等事件。对复现而言，这一步的关键不是保留旧课程里的轴名，而是以当前工程真实存在的输入事件为准，重接角色的移动和视角控制蓝图。

### 00:08:25-00:12:18 蓝图、火焰

- 本段定位：蓝图、火焰。
- 知识点：这样做之后 让我们再试一次播放 这样 然后这个视角就变成了 然后这个视角也能用鼠标转动了 然后 可以用 像方向键一样操作 然后 那么在这种状态下。
- 知识点：我们能技能就好了 嗯 左键会自动进行普通攻击 所以不是上次 而是之前的课程中 我们决定给这种普通攻击动作 加上简单的效果 然后 所以我们需要将我们想要的特定。
- 知识点：动画制作成蒙太奇来使用 并会配合这个技能 然后Q这个动作来使用 对直接做就行 为了做成简单技能 然后 这样双手展开的动作时 从身体中心开始。
- 知识点：火焰迅速蔓延的表现 会试着做出来 对这样进行应该可以 现在动画剪辑的部分 然后 为了做成蒙太奇点击一下 点击动画蒙太奇生成 现在是蒙太奇。
- 知识点：打开时需要在这里用notify加效果 为了在蓝图中使用 肯定要改成蒙太奇 请改成蒙太奇 然后这里标着default的这个部分 是可以用notify获取动作值的部分。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`蓝图`、`蒙太奇`、`火焰`。

**关键画面：**

本图进入 `### 00:08:25-00:12:18 蓝图、火焰` 段，当前已经切到 `Ex_04 (Play In Editor)` 的实际运行视角，用来验证前一段角色蓝图修复是否生效。画面可直接确认：

- `Phase` 角色已经正常出现在测试场地中央
- 视角是可操控的第三人称跟随视角，而不是卡死的默认占位状态

右侧 `Outliner` 当前可直接读取：
- `Ex_04 (Play In Editor)`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Playground`
  - `SM_Cube`
  - `SM_Cube2`
  - `SM_Cube3`
  - `SM_Cube5`
  - `SM_Cube6`
  - `BP_ThirdPersonGameMode10`
  - `GameNetworkManager0`
  - `GameSession0`
  - `GameStateBase0`
  - `HUD0`

右侧 `World Settings` 当前仍能确认：
- `GameMode Override = BP_ThirdPersonG...`

底部内容浏览器当前路径为：
- `Content > ParagonPhase > Characters > Heroes > Phase`

当前可见资源包括：
- `Animations`
- `Materials`
- `Meshes`
- `Skins`
- `Sounds`
- `Textures`
- `Animation...`（缩略图文字被截断）
- `Phase_Anime...`
- `Phase Blueprint Cl...`

结合字幕“这样，视角也能用鼠标转动了”，这张图说明前面输入轴和角色替换已经至少修到了可玩状态：角色能正确生成，且镜头旋转恢复正常。对复现而言，这一帧是后续给攻击和技能挂特效之前的必要验收点，若这里人物还不能正常转向和移动，后面的蒙太奇与火焰触发都没有意义。
本图继续是 `蓝图、火焰` 段，但当前焦点已经切到动画蒙太奇资源：

- `Ability_Q_Montage`

中间预览窗口当前直接显示：
- 正在预览 `Ability_Q_Montage`
- 角色做双臂展开姿势
- 左上统计：`LOD: 0`、`Current Screen Size: 0.918`
- `Triangles: 75,987`
- `Vertices: 51,992`
- `UV Channels: 1`
- `Approx Size: 145x54x181`

左侧 `Asset Details` 当前可直接读取的关键设置：

`Blend Option`
- `Blend Mode In = Standard`
- `Blend Mode Out = Standard`

`Blend Out`
- `Blend Out Trigger Time = -1.0`
- `Enable Auto Blend Out` 已启用
- `Blend Profile In = None`
- `Blend Profile Out = None`

`Animation`
- `Preview Pose Asset = None`
- `Rate Scale = 1.0`
- `Loop` 未启用
- `Skeleton = phase_Sk`

底部 Montage 时间线当前可确认：
- 一个绿色段 `Ability_Q`
- 所属 `Montage (DefaultGroup...)`
- 右上小标签显示 `Montage Sections`
- `Notifies` 轨道区域可见

右侧 `Asset Browser` 当前选中项为：
- `Ability_Q_Montage`

同列表中还能看到一组相关动画资源，例如：
- `Ability_E`
- `Ability_E_Additive`
- `Ability_E_Land`
- `Ability_Q`
- `Ability_Q_Additive`
- `Attack_AO`
- `Attack_AO_CC`
- `Attack_AO_CU`
- `Attack_AO_LBC`

这张图把本段“动画制作成蒙太奇来使用”“打开时需要在这里用 notify 加效果”的流程钉得很清楚：作者先把技能动作 `Ability_Q` 包装成 `Ability_Q_Montage`，保留标准混合设置和 `Notifies` 轨道，再在后续时间点上插入特效触发。对复现而言，关键不是直接对原始动画序列加特效，而是先改成 Montage，这样蓝图里才能更稳定地播放技能动作，并通过 Notify 精确控制火焰从身体中心扩散的触发时机。
本图继续在 `PhasePlayerCharacter > Event Graph` 中搭技能蓝图触发逻辑。当前能直接确认：

- 图中已有一个键盘事件节点：`Q`
- 当前从 `Pressed` 执行引脚拉出右键搜索面板
- 搜索关键字输入为：`do`

搜索结果区当前可见的可执行动作/节点包括：
- `Create MetaSound Object Array Literal`
- `Create MetaSound Object Literal`
- `Set Field Of View (FollowCamera)`
- `Set Use Field Of View for LOD (FollowCamera)`
- `Async Task Download Image`
- `Download Image`
- 若干碰撞事件绑定/解绑节点

虽然搜索结果列表本身还没滚到 `Do Once`，但字幕已明确说“然后用 `do once` 模式只播放一次”，因此可以确认作者此时就是在 `Q` 键触发链路后插入 `Do Once`，目的是限制技能触发为一次性执行，后续配合 `Reset` 端口再允许重复使用。

左侧变量区同时还能看到：
- `BaseTurnRate`
- `BaseLookUpRate`
- `SaveAttack`
- `IsAttacking`
- `AttackCount`

顶部标签还能确认当前相关资源同时打开着：
- `PhasePlayerCharacter`
- `Ability_Q_Montage`
- `Phase_AnimBlueprint`

这张图把蓝图、蒙太奇和技能输入真正串到一起了：不是只做出蒙太奇资源，而是要在角色蓝图里用 `Q` 键事件驱动一次性执行的技能链路。对复现而言，核心结构应为：

- 输入：`Q (Pressed)`
- 流程门：`Do Once`
- 后续动作：播放 `Ability_Q_Montage`、触发相应特效或后续重置逻辑

否则技能要么会被长按/连按重复刷出，要么无法按预期配合蒙太奇与火焰效果进行一次完整释放。

### 00:12:50-00:16:04 UV、Substance、Substance Designer

- 本段定位：UV、Substance、Substance Designer。
- 知识点：导入使用后输入要执行这个动作的消息 输入框里输入 播放速率可以理解为动画播放速度 可以完成时 这边要放到once reset里才能重复使用。
- 知识点：双击一下中间点的节点就能这样 可视化显示出来 设置非常简单 可以想象成以前我们做许别器工作时 设置角色的部分 其实用播放功能来确认一下。
- 知识点：这样q动作时 这样非常简单的地 在这里加上效果就能看到了 所以这样某种程度上 一角色进行游戏的同时 能制作效果的这种环境的话 现在就能有趣地进行工作了。
- 知识点：质量也能给作品机带来高质量构成 如果现在这个背景项目 可以制作特效的话 之前在之前项目中使用过的背景项目 也支持这个玩家角色的话呢。
- 知识点：我们之前使用了uvbrick 但现在这个角色如果5.5版本可以使用的话 uvbrick在那里这样展示技能也没问题 在背景中所以无论怎样都可以这样构成。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Substance Designer`、`纹理`、`速度`。

**关键画面：**

本图进入 `### 00:12:50-00:16:04 UV、Substance、Substance Designer` 段，但当前画面展示的仍是蓝图里“如何触发动作”的关键一环。当前位于：

- `PhasePlayerCharacter > Event Graph`

中间图表中当前可直接确认的蓝图结构为：

- 一个变量节点：`Mesh`
- 一个函数节点：`Play Montage`

二者连接关系清楚可见：
- `Mesh` 变量输出接到 `Play Montage` 的 `In Skeletal Mesh Component`

`Play Montage` 节点当前可直接读取：
- `Montage to Play = Ability_Q_Mont...`（界面截断，但与前一张资源标签可确认是 `Ability_Q_Montage`）
- `Play Rate = 1.0`
- `Starting Position = 0.0`
- `Starting Section = None`

节点右侧当前可见的可回调输出包括：
- `On Completed`
- `On Blend Out`
- `On Interrupted`
- `On Notify Begin`
- `On Notify End`
- `Notify Name`

右侧 `Details` 面板当前显示的是 `Mesh` 变量信息：
- `Variable Name = Mesh`
- `Variable Type = Skeletal Mesh C...`（界面截断，但可确认是 Skeletal Mesh 组件引用）

底部 `Compiler Results` 当前明确显示：
- `Compile of PhasePlayerCharacter successful`

这张图把技能蓝图的执行链真正落地了：不是只搜索 `Do Once` 或只创建 Montage 资源，而是明确用角色自身的 `Mesh` 调用 `Play Montage(Ability_Q_Montage)`。再结合节点右侧已经暴露出的 `On Notify Begin / End` 输出，可以推断后续火焰特效就会挂在 Montage Notify 时刻上。对复现而言，最小可复建链路应至少包括：

- 输入事件触发
- （可选）`Do Once`
- `Play Montage(Ability_Q_Montage)`，目标为角色 `Mesh`
- 在 `On Notify Begin/End` 或 Montage 内 Notify 位置再接特效触发
本图继续位于 `UV、Substance、Substance Designer` 段，但当前仍在 `Ex_04 (Play In Editor)` 里做角色与资源兼容性检查，而不是展示具体材质节点。画面可直接确认：

- `Phase` 角色已在测试场地中正常站立
- 视角为第三人称运行视角
- 当前没有明显火焰或 Niagara 特效，只是在验证基础角色表现

右侧 `Outliner` 当前仍可读到：
- `Ex_04 (Play In Editor)`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Playground`
  - `SM_Cube`
  - `SM_Cube2`
  - `SM_Cube3`
  - `SM_Cube5`
  - `SM_Cube6`
  - `BP_ThirdPersonGameMode10`
  - `GameNetworkManager0`
  - `GameSession0`
  - `GameStateBase0`
  - `HUD0`

底部内容浏览器当前路径为：
- `Content > ParagonPhase > Characters > Heroes > Phase > Animations`

当前可见并用于选择/比对的动画资源包括：
- `AimOffset`
- `Blend Spaces`
- `Ability_E`
- `Ability_E_Additive`
- `Ability_E_Land`
- `Ability_Q`
- `Ability_Q_Additive`
- `Ability_Q_Montage`
- `Ability_R`
- `Ability_R_...`
- `Bound`
- `Cast`
- `Cast_MSA`

这张图对应正文“之前项目中使用过的背景项目也支持这个玩家角色”的判断。可可靠确认的是：作者正在用当前背景测试关卡直接运行 `Phase` 角色，并同时浏览该角色的动画资源，确认这个环境至少能正常承载角色、动作和后续技能演出。对复现而言，这一步是把“角色能跑、动画能播、背景项目不冲突”先验证通过，然后才值得继续接火焰和纹理效果。
本图仍在 `UV、Substance、Substance Designer` 段，但当前画面没有显示角色或特效本体，而是回到测试关卡本身，继续把它当成可复用的实验场。画面可直接确认：

- 当前关卡为 `Ex_04 (Editor)`
- 视口中是简化的灰色测试场地
- `Playground > SM_Cube` 被选中
- 场地中仍保留 `PlayerStart` 图标

右侧 `Outliner` 当前可读到：
- `Ex_04 (Editor)`
- `Block01`
- `Block02`
- `Block03`
- `Cylinder`
- `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Playground`
  - `SM_Cube`
  - `SM_Cube2`
  - `SM_Cube3`
  - `SM_Cube5`
  - `SM_Cube6`
  - `PlayerStart`

底部内容浏览器仍位于：
- `Content > ParagonPhase > Characters > Heroes > Phase > Animations`

可见的一组动画资源仍包括：
- `AimOffset`
- `Blend Spaces`
- `Ability_E`
- `Ability_E_Additive`
- `Ability_E_Land`
- `Ability_Q`
- `Ability_Q_Additive`
- `Ability_Q_Montage`
- `Ability_R`
- `Bound`
- `Cast`
- `Cast_MSA`

这张图虽然不提供新的蓝图节点或材质参数，但它把本段的工作方式讲清楚了：作者把这个简化场地和 `Phase` 角色资源库组合起来，作为后续继续试验 UV、纹理、Substance/材质效果的基础环境。结合正文“如果现在这个背景项目可以制作特效的话”“无论怎样都可以这样构成”，可复现为：先确保背景关卡、角色资源和动画资源都能在同一工程内稳定共存，再在这个稳定环境里继续迭代更细的纹理和特效问题。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

