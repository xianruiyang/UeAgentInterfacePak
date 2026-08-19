# 24RibbonTrail元素1制作

# 24RibbonTrail元素1制作

## 关键术语

- `Emitter`、`Lifetime`、`Velocity`、`Color`、`Alpha`、`Scale Color`、`Ribbon`、`Material`、`UV`、`Multiply`、`Add`、`Sequencer`、`Niagara`、`Particle`、`Spawn Rate`、`Spawn`、`Niagara System`、`Particle Spawn`

## 分段知识

### 00:00:06-00:03:06 Add、Sequencer、粒子

- 本段定位：Add、Sequencer、粒子。
- 知识点：二十四节论后大家上次简单设置了序列器和动作 还有寻找参考的诀窍 还有一些关于设计叙事演出的技巧 就简单聊了聊 首先打开一个保存的关卡。
- 知识点：需要打开序列器 但序列器似乎没有保存在这里 这样拖放也没关系 这样直接双击打开序列器也是可以的 那么这样打开后 就这样 反正序列器里都保存好了。
- 知识点：会有这个动作 这次要制作的部分是双手展开时出现的彩带轨迹 这种彩带轨迹不是笔直的 而是有一定的曲线 然后在彩带轨迹之前 会附上这角色手上贴着的。
- 知识点：像能量的形态 也会附着上去 同时在彩带粒子生成时 还有一些小爆炸 一起观看 那么这次粒子中 因为粒子会增多。
- 知识点：需要适当分类放在文件夹上 如果上次的序列器中 这里的相机切换部分 这样被短暂切割了 就建议这样延长一下 这个将来如果渲染时 渲染的部分 谁可以参考。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`Add`、`粒子`、`系统`、`序列`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> UE `Untitled` 关卡打开，Viewport 显示亮色地形/网格场景。右侧 Outliner 为 `Untitled (Editor)`，可见 `HLOD`、`Lighting`、`DirectionalLight`、`ExponentialHeightFog`、`SkyAtmosphere`、`SkyLight`、`SM_SkySphere`、`VolumetricCloud`、`Landscape`，底部显示约 `94 actors (73 loaded)`。Content Browser 位于 `/Content/Tutorial`，包含 `Level`、`Material`、`Particle`、`Sequencer` 文件夹。字幕提示上一节已讲序列器、参考查找和叙事演出技巧。该图记录 p24 进入项目和课程回顾入口。
> 图表转写（UE-GTXT v4）
> `Ex_Ultimate_01` 关卡打开，Viewport 左上显示 `Pilot Active - Cine Camera Actor`。右侧 Outliner 选中 `Ex_Ultimate_01` LevelSequence，列表中可见 `Cine Camera Actor`、`Floor`、`Phase GDC_Hit`、`Phase GDC_PC` 等对象。Sequencer 面板当前约在 `0221` 帧，包含 `Camera Cuts`、`Cine Camera Actor`、`Phase GDC_PC`、`Phase GDC_Hit`；`CameraComponent` 字段可读 `Current Aperture 2.8`、`Current Focal Length 35.0`、`Intensity 3.0`、`Manual Focus Distance 100000.0`、`Size scale 2.0`，并勾选 `Spawned`。Content Browser 位于 `/Content/Tutorial/Sequencer`，可见 `CamTest_01`、`Ex_Projectile...`、`Ex_ShockWave_01`、`Ex_StrikeExp_01`、`Ex_Ultimate...`、`ExShake_01`、`ExShake_02`。该图记录已保存的 Ultimate Sequencer 与相机/角色轨道基础状态。
> 图表转写（UE-GTXT v4）
> Sequencer `Ex_Ultimate_01` 当前约在 `0114` 帧，包含 `Camera Cuts`、`Cine Camera Actor`、`Phase GDC_PC`、`Phase GDC_Hit`，并新增文件夹轨 `Trails_01`。Viewport 中可见两个角色和场景标记，当前处于相机预览。Content Browser 位于 `/Content/Tutorial/Particle`，资源文件夹 `Ex_01`、`Ex_02`、`Ex_03`、`Ex_04` 和资源 `PP_Test_01` 可见，其中 `Ex_04` 被选中。字幕提示新建文件夹。该图记录把后续彩带轨迹相关粒子资源归入 `Ex_04` 并在 Sequencer 中准备 `Trails_01` 分组。

### 00:03:11-00:06:04 Sequencer、粒子

- 本段定位：Sequencer、粒子。
- 知识点：Ultimate Project 01 然后我把这个拖到文件夹里 那么这样就可以折叠和展开 文件夹 那么 首先将这个粒子注册到序列器。
- 知识点：这里填充一下 这里要根据手的位置进行补捉 接着 适当向前移一点看 大约145对齐 现在只添加了一个左右排放 会在同样框架中生成 在15针上给一个键。
- 知识点：给一个生成键 然后在后面的针关闭生成 然后这个通过槽C合集 入纸后使用相同的粒子 不过这个 改名为02 位置适当移动一下 适当不完全对齐也没关系。
- 知识点：这样应该可以 这样生成 因为现在只会反复看最开始的部分 所以需要缩短持续时间 总持续时间是255针 但为了确认尽快。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`粒子`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Content Browser 进入 `/Content/Tutorial/Particle/Ex_04`，仅显示 Niagara 资源 `Ultimate_Projecti...`。Sequencer 中 `Trails_01` 文件夹已展开，新增 `Ultimate Projectile 01` 轨道，包含 `Spawned` 和 `Transform` 子轨；时间轴约在 `0114` 帧，`Camera Cuts` 与相机轨仍在上方。Viewport 中选中角色附近的 `Ultimate Projectile 01` NiagaraActor，右侧 Details 显示 `Ultimate Projectile 01 (Instance)` 下的 `NiagaraComponent (NiagaraComponent0)`。字幕说明把粒子拖到文件夹中，文件夹可以折叠和展开。该图记录第一个手部/轨迹源粒子注册到 Sequencer 的状态。
> 图表转写（UE-GTXT v4）
> Viewport 切到较近视角，`Ultimate Projectile 01` NiagaraActor 被选中，Gizmo 位于角色伸出的手附近。右侧 Outliner 选中 `Ultimate Projectile 01`，类型为 `NiagaraActor`，Details 仍显示 `NiagaraComponent`。Sequencer 当前约在 `0014` 帧，底部可见 `Ultimate Projectile 01` 轨道已加入长条片段；相机参数轨和角色轨保持在上方。该图记录将第一个粒子放到手部附近、为后续生成键和 Transform 对齐做准备。
> 图表转写（UE-GTXT v4）
> Sequencer `Trails_01` 下已有 `Ultimate Projectile 01` 和 `Ultimate Projectile 02` 两条 NiagaraActor 轨道，两者都展开了 `Spawned` 与 `Transform`，并在左侧出现生成关键帧。Viewport 中角色两侧各有一个粒子对象标记，绿色 Gizmo 箭头从两个对象延伸，表示两个对象已分别摆到双手附近的起始区域。时间轴约在 `0092` 帧，右侧仍可见 NiagaraActor 相关 Details。该图记录复制/添加第二个粒子并分别设置左右两侧生成轨的状态。

### 00:06:12-00:09:11 Sequencer、粒子、发射器

- 本段定位：Sequencer、粒子、发射器。
- 知识点：这样看一下 打开看看 这样在这里 添加发射器 就像我们最初创建的断代粒子那样 原粒子先来捕捉动作。
- 知识点：需要命名为 并且做成声音 设置为自我 然后给完全一秒 接下来会生成一个以喷发为基础的 生命周期是一秒。
- 知识点：在颜色模式中选择直接设置 这样明亮午时的颜色让它变得明亮 解锁服从模式 为了方便查看 接下来尺寸 非均匀的 在20到50之间 这个大小 需要看一下。
- 知识点：在这里添加速度 创建自我的固定问题 这次在这里将粒子变为一个Niagara 两个分开 现在安装在序列器上了吗 所以控制会用这个。
- 知识点：在这里两个粒子 就是要有不同的值 所以会把这个值做成用户参数 以便从外部控制 所以这里安加 会创建一个像料 这样参数就生成了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Sequencer`、`粒子`、`发射器`、`系统`、`序列`、`生命周期`、`速度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Projectile_01` 打开，System Overview 中只有系统节点 `Ultimate_Projectile_01`，包含 `Properties`、`User Parameters`、`System Spawn`、`System Update`、`System State`。左侧 Preview 区域为空，`Particle Counts` 未显示有效粒子；右侧 `Selection` 面板为空。该图记录新建或打开 Niagara 系统后的初始系统级结构，还没有添加具体发射器。
> 图表转写（UE-GTXT v4）
> Niagara 系统中新增 `Source` 发射器，System Overview 显示 `Emitter Summary`、`Emitter Spawn`、`Emitter Update`、`Particle Spawn`、`Particle Update`、`Render` 等分组；`Emitter State` 为 `Self`、`Infinite`，`Spawn Burst Instantaneous` 开启，`Add Velocity` 模块位于 `Particle Spawn` 下。右侧 Selection 面板选中 `Add Velocity`，提示 `The module has unmet dependencies`，可选修复 `Solve Forces and Velocity` 或 `ApplyInitialForces`。参数区显示 `Velocity Mode: Linear`，`Velocity` 为 `X 0.0 / Y 0.0 / Z 50.0`，`Velocity Speed Scale 1.0`，`Rotation Coordinate Space: Local`。左侧 Preview 显示 `Compiling...`。该图记录发射器初建、速度模块添加和依赖提示。
> 图表转写（UE-GTXT v4）
> `Ultimate_Projectile_01` 的 `User Parameters` 被选中，右侧 Selection 面板显示用户参数 `Velocity`，类型标记为 `USER`，数值为 `X 0.0 / Y 0.0 / Z 0.0`。System Overview 中 `Source` 发射器已包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Add Velocity`、`Particle State`、`Solve Forces and Velocity`、`Sprite Renderer`。左侧 Preview 显示一个白色发光粒子，`Particle Counts` 为 `1 Current, 2 Max (est.) - [Source] [Active]`。字幕说明数值最初设为 400 和 350。该图记录速度被抽成 Niagara 用户参数，用于后续由 Sequencer 中两个粒子实例分别传值。

### 00:09:13-00:12:08 Velocity、粒子

- 本段定位：Velocity、粒子。
- 知识点：选择添加速度模块 在这个参数窗口 拖到速度部分 这样链接就连接上了 这意味着使用输入的数值 Sprite Alarm会改为Velocity。
- 知识点：以这个速度这样飞去一秒钟 那么这样飞去的东西 这样斜着飞向地面 我们想要制作的系统是 这个形状是这样朝向地面飞去 那但是这样画出曲线 现在是直线。
- 知识点：用图表画出曲线 并朝向某个地面点弹跳的感觉 所以当它撞击那个地面时 生成某种交互性的另一个效果 并从那里延续生成 以这种方式演出 在粒子更新部分。
- 知识点：用缩放速度 来创建一个 然后在速度缩放部分 用曲线生成像辆 制作后会适当修改这个图表的值 现在只是一个从1到0的图表 就是所以会出现 适当变慢的动作。
- 知识点：值无论如何前进速度是强的 会逐渐减少的感觉 就是所以从2减少到 这个就简单线性制作 然后Z值从1减少到0.5 不要拉得太大 反正高度也不高。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`Velocity`、`粒子`、`系统`、`速度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 左侧 Parameters 面板展开 `User Exposed`，可见 `USER Velocity` 参数；同时列出大量 `System Attributes`、`Emitter Attributes` 和 `Particle Attributes`。右侧 Selection 面板选中 `Source` 发射器的 `Add Velocity` 模块，`Velocity` 输入框正在使用 `USER Velocity`，字段显示 `X 0.0 / Y 0.0 / Z 0.0`，`Velocity Speed Scale 1.0`，`Rotation Coordinate Space: Local`。System Overview 中 `Add Velocity` 模块被选中。字幕提示把参数窗口中的值拖到速度部分。该图记录把用户参数连接到 `Add Velocity.Velocity` 输入的操作。
> 图表转写（UE-GTXT v4）
> `Source` 发射器的 `Particle Update` 区域准备添加新模块，弹出 `Add new Module` 菜单。右侧 Selection 面板当前显示 `Particle State` 和 `Solve Forces and Velocity`，其中 `Solve Forces and Velocity` 可见 `Speed Limit 1000.0`、`Acceleration Limit 9999.0`、`Manually Enable Rotational Solver`。弹窗中 `Suggested` 列表包含 `Camera Offset`、`Scale Color`、`Shape Location`、`Skeletal Mesh Location`、`Update Mesh Orientation`，分类包含 `Audio`、`Beam`、`Camera`、`Collision`、`Color` 等。字幕说明在粒子更新部分使用缩放速度。该图记录在 `Particle Update` 中添加 `Scale Velocity` 的入口。
> 图表转写（UE-GTXT v4）
> `Source` 发射器已在 `Particle Update` 下加入 `Scale Velocity`，右侧 Selection 面板显示 `Coordinate Space: Local`，`Velocity Scale` 使用 `Vector from Curve`。`VectorCurve` 的 X/Y/Z 三条通道曲线可见，`CurvIndex` 为 `PARTICLES NormalizedAge`，底部 `Scale Curve` 字段为 `X 1.0 / Y 1.0 / Z 1.0`。左侧 Curves 面板选中 `Y` 通道，曲线从约 `1.0` 随时间下降到接近 `0`；Preview 中仍显示白色发光粒子，`Particle Counts` 为 `1 Current, 2 Max (est.)`。字幕强调当前 Y 轴很重要。该图记录 `Scale Velocity` 用归一化年龄曲线降低速度的设置。

### 00:12:13-00:15:06 粒子

- 本段定位：粒子。
- 知识点：最后会做成0.5 这样可以看并大肆减少 图表会画出曲线 如果这样看的话就是画出曲线 向定面下降 这样可以看出是什么感觉吗 这里我们来看看。
- 知识点：我们现在想调整到一个点 所以这里暂时停一下数值 这两个粒子的数值会设定成不同 做成无限的 但会改了一次 刚才不小心没有改 所以这里数值需要X轴。
- 知识点：更快 这样才能更进一步 而Y轴要适当增加 Z轴会适当减少 所以看 这样方式 这样方式 曲线在这里似乎适当太厉害 D轴了 有点控制困难 我就这样适当调整一下。
- 知识点：这里反方向外轴 指方复制 675-4倍 -这个放进去 然后我来播放一下。
- 核对对象：`粒子`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 仍选中 `Scale Velocity` 模块，右侧 `Velocity Scale` 为 `Vector from Curve`，`CurvIndex` 使用 `PARTICLES NormalizedAge`。曲线编辑器中 Y 通道被选中，左侧大曲线显示从约 `5` 开始，随后以弧线下降到接近 `0.5`；右侧小预览中 X/Y/Z 曲线同时可见，底部 `Scale Curve` 仍显示 `X 1.0 / Y 1.0 / Z 1.0`。字幕说明可以观察到曲线大幅减少。该图记录把速度缩放曲线从线性衰减调整为更明显的缓出下降。
> 图表转写（UE-GTXT v4）
> Niagara 时间轴面板打开，帧率为 `240 fps`，`Source` 轨道显示约 `0.00` 到 `2.00` 的发射器片段，当前播放头在约 `1.88`。右侧 Selection 面板选中 `Emitter State`，`Life Cycle Mode: Self`，`Inactive Response: Complete (Let Particles Finish then Kill...)`，`Loop Behavior: Once`，`Loop Duration Mode: Fixed`，`Loop Duration: 1.0`；`Spawn Burst Instantaneous` 中 `Spawn Count 1`、`Spawn Time 0.0`。左侧 Preview 显示 `0 Current, 1 Max (est.) - [Source] [Complete]`。该图记录发射器生命周期从持续循环改为一次性、持续约 1 秒的源粒子。
> 图表转写（UE-GTXT v4）
> 回到 `Ex_Ultimate_01` Sequencer，当前约在 `0067` 帧，`Trails_01` 下的 `Ultimate Projectile 02` 轨道被选中，`Spawned` 和 `Transform` 子轨可见，轨道上有生成关键帧。底部嵌入的 Niagara 参数窗口选中 `Source`，右侧 Details 显示 `Velocity` 字段为 `X 400.0 / Y 350.0 / Z -250.0`，`Activation` 区域中 `Auto Activate` 勾选。Viewport 左侧显示角色和一个紫色发光点。字幕提到“675负4倍”。该图记录在 Sequencer 中为第二个 NiagaraActor 实例设置外部速度参数，并把 Z 分量设为负值以形成下落/压低的运动意图。

### 00:15:18-00:18:16 Emitter、Alpha、Ribbon

- 本段定位：Emitter、Alpha、Ribbon。
- 知识点：这样方式 这样做之后 左右似乎像是扩散D 飞出去 所以在这附近会有一些反应效果出来 像链子一样的东西会出现 先这样放着之后再调整位置 因为这次只制作丝带。
- 知识点：和其他效果一起放的时候 颜色不分心调整一下 肤色在这里不做图表 黄色感觉首先 就这样给出 这种方式给出 用Alpha曲线制作 这个感觉我走。
- 知识点：从0到1 逐渐加深 圆几乎制作完成了 点击这个图标会直接生成这种形状 然后用Aemeter现在用来做 丝带 尝试添加一个emitter。
- 知识点：做成empty 名字定为ribbon 0.01 然后勾选本地 自我完成后给3秒 寿命是0.5 丝带大小现在是 缩到大约75 关闭精灵 如在战斗一样。
- 知识点：用其他emitter固定制作 做个输入 需要放入materials materials。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Alpha`、`Material`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ex_Ultimate_01` Viewport 中可见两个角色和源粒子播放结果，近处角色手部附近出现紫粉色发光点；底部嵌入的 Niagara/Sequencer 窗口显示 `Ultimate_Projectile_01`，时间轴约在 `0057` 帧。Outliner 可见 `Cine Camera Actor`、`Ex_Ultimate_01`、`Phase GDC_Hit`、`Phase GDC_PC`、`PostProcessVolume`、`SpotLight`、`SpotLight2` 等对象。Content Browser 位于 `/Content/Tutorial/Particle/Ex_04`，资源 `Ultimate_Projecti...` 可见。字幕说明左右粒子像扩散一样飞出去。该图记录源粒子速度和曲线调整后的 Sequencer 预览状态。
> 图表转写（UE-GTXT v4）
> Niagara `Ultimate_Projectile_01` 中选中 `Source` 发射器的 `Scale Color` 模块。右侧 Selection 显示 `Scale Mode: RGB and Alpha Separately`；`Scale RGB` 勾选，数值为 `X 3.0 / Y 1.0 / Z 0.5`；`Scale Alpha` 勾选并使用 `Float from Curve`，`FloatCurve` 随 `PARTICLES NormalizedAge` 从接近 0 上升到 1，底部 `Scale Curve` 为 `1.0`。左侧 Preview 显示暖色发光粒子，`Particle Counts` 为 `1 Current, 1 Max (est.) - [Source] [Active]`；Timeline 约在 `0.45`。该图记录源粒子颜色和 Alpha 随生命周期逐渐显现的设置。
> 图表转写（UE-GTXT v4）
> Niagara System 中新增 `Ribbon_Core_01` 发射器，与 `Source` 并列显示。`Ribbon_Core_01` 的 `Emitter State` 为 `Self / Infinite`，`Emitter Update` 下选中 `Spawn Particles from Other Emitter`；右侧 Selection 显示 `Particle Attribute Reader`，`Emitter Name: Source`，`Spawn Rate 10.0`，`Calculate Spawn Rate Per Particle` 勾选，`Spawn Rate Per Particle Cap 100.0`，`Spawning Enabled` 勾选，`Minimum Age Spawn Threshold 0.3333` 和 `Maximum Age Spawn Threshold 1.0` 为灰置状态。Timeline 左侧已有 `Ribbon_Core_01` 轨道，Preview 粒子计数显示 `Source` 已完成、`Ribbon_Core_01` 活跃。该图记录 Ribbon 发射器从 `Source` 粒子采样生成的核心机制入口。

### 00:18:19-00:21:15 Emitter、Material、SD

- 本段定位：Emitter、Material、SD。
- 知识点：sdb materials 在这里 在这里创建一个实例 我也会创建一个文件夹带走 从一开始就这样整理是好的 带走黄色的emitter的。
- 知识点：只修改名字 改成命 用se 会放进去 放进去看看 这样出现了 这里出现了 删除spray 会用tile by distance 下 引用 这样出来 这个关掉。
- 知识点：大约20个左右 就20个 这种曲线会出来 这样看的 然后 我们现在制作的丝带只会做一行 所以不需要像上次做三行十年 利用id给随机指 这次的例子来说。
- 知识点：因此 先动态 什么呢 因为什么看不太清楚 所以放入实真零指 学记的0.5先设定 固定值 数字的一值 先让它好看 然后 找找丝带形状想要的纹理。
- 知识点：上次做的丝带就不会差太多 反正是同一个角色的概念 首先颜色纹理将使用这个 然后发现将上次用的粗的 将会使用希望展示某个核心的线。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Emitter`、`Material`、`纹理`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ribbon_Core_01` 选中 `Ribbon Renderer`。右侧 `Ribbon Rendering` 中 `Material` 当前为 `None`，`Facing Mode: Screen`；`UV0 Settings` 中 `UV Mode: Non-Uniform Scale (By Total Length)`，`Leading Edge Transition: Locked`，`Trailing Edge Transition: Locked`，`Tiling Length 100.0`，`Offset 0.0 / 0.0`，`Scale 1.0 / 1.0`。下方 Content Browser 位于 `/Content/Tutorial/Material`，资源 `M_Ribbon_01` 被选中，提示显示路径 `/Game/Tutorial/Material`，资产长度 `54/210`，`Shading Model: Unlit`，`Lighting Mode: Volumetric Non Directional`，`Blend Mode: Translucent`，`Material Domain: Surface`。该图记录为 Ribbon Renderer 准备材质实例前的材质资源选择与 Renderer 初始参数。
> 图表转写（UE-GTXT v4）
> `MI_Ribbon_01_Ins_01` 材质实例打开，左侧预览显示深色底上的灰白纹理轮廓。右侧 Details 的 `Global Scalar Parameter Values` 包含 `Black_Bias 1.0`、`Color_Tile_U 0.5`、`Color_Tile_V 0.5`、`Desaturation 0.0`、`Edge_Pow 0.5`、`Edge_Str 1.0`、`Normal_Tile_U 0.5`、`Normal_Tile_V 0.5`、`Opacity_Pow 0.5`、`Opacity_Str 5.0`、`Opacity_Tile_U 1.0`、`RGB_Offset 0.01`。`Global Texture Parameter Values` 中 `Color_Tex` 为 `T_CloudScape_08_Details`，`Normal_Tex` 为 `T_CloudScape_08_Details_N`，`Opacity_Tex` 下方可见贴图槽。Content Browser 位于 `/Content/Resource`，多张纹理资源可见。该图记录 Ribbon 材质实例的初始标量和纹理输入。
> 图表转写（UE-GTXT v4）
> `MI_Ribbon_01_Ins_01` 材质实例预览显示黑色背景上的彩色云雾/彩带纹理，中心有多色拉伸条纹和环状块。右侧参数中 `Black_Bias 1.0`、`Color_Tile_U 0.5`、`Color_Tile_V 0.5`、`Desaturation 0.0`、`Edge_Pow 0.5`、`Edge_Str 1.0`、`Normal_Tile_U 0.5`、`Normal_Tile_V 0.5`、`Opacity_Pow 0.5`、`Opacity_Str 5.0`、`Opacity_Tile_U 1.0`、`RGB_Offset 0.01`。纹理输入改为 `Color_Tex: T_Cloud_Wisp_Chromatic_Tile`，`Normal_Tex: T_NoiseNormal_01`，`Opacity_Tex: T_Soft_Energy_Trail`；`Parent` 为 `M_Ribbon_01`。该图记录将 Ribbon 材质切换到彩色云雾纹理和能量拖尾透明贴图后的外观。

### 00:21:19-00:24:17 Color、Alpha、Scale Color

- 本段定位：Color、Alpha、Scale Color。
- 知识点：上次用的这个纹理将会使用 所以 缩小来看也可以就是黑色调是不需要的 核心感觉 颜色拼贴就留着吧。
- 知识点：饱和度也就留着吧 然后边缘强度的情况设置为1的指 亮度提高一点 然后发现拼贴也可以 技能强度显得太亮了 适当降低 看看 拼贴在0.5左右 看起来不错。
- 知识点：Rarity天仪就留着 也可以 然后这个是表达线的某种亮度为主要元素 所以这样 可以化成边际的吧 那么在这里 颜色部分我来调一下。
- 知识点：在这之前用Reborn与WebS来处理前面的线 让语言和这里连接前的曲线适当顺滑一下 就这样 然后用Scale Color 先给Alpha试试看。
- 知识点：用ColorForm Curve 设为0.1的值 就这样 应该可以了 不过有点皱皱的 我就把Tels增加到200 试试 现在估计颜色对好了吧。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Color`、`Alpha`、`Scale Color`、`Curve`、`纹理`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `MI_Ribbon_01_Ins_01` 预览继续显示彩色云雾纹理。右侧标量参数可读：`Edge_Pow 1.0`、`Edge_Str 20.0`、`Normal_Tile_U 0.5`、`Normal_Tile_V 0.5`、`Opacity_Pow 1.0`、`Opacity_Str 2.0`、`Opacity_Tile_U 0.5`、`RGB_Offset 0.01`；纹理输入为 `Color_Tex: T_Cloud_Wisp_Chromatic_Tile`、`Normal_Tex: T_NoiseNormal_01`、`Opacity_Tex: T_Soft_Energy_Trail`。`Material Property Overrides` 中 `Blend Mode` 勾选并设置为 `Additive`，`Shading Model` 显示 `Unlit`。该图记录把材质改成加法混合、增强边缘强度并降低透明强度后的 Ribbon 材质实例。
> 图表转写（UE-GTXT v4）
> 回到 Niagara `Ultimate_Projectile_01`，`Ribbon_Core_01` 的 `Ribbon Renderer` 选中。右侧 `Ribbon Rendering.Material` 设置为 `MI_Ribbon_01_Ins_01`，`Facing Mode: Screen`；`UV0 Settings` 中 `UV Mode: Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length 100.0`，`Offset 0.0 / 0.0`，`Scale 1.0 / 1.0`。`UV1 Settings.Draw Direction: Front to Back`。`Ribbon Shape.Shape: Plane`，`Width Segmentation Count 1`，`Multi Plane Count 2`，`Tube Subdivisions 3`；`Tessellation.Mode: Automatic`，`Max Tessellation Factor 16`，`Tessellation Angle 15.0`，`Screen Space` 勾选。Bindings 中 `Position Binding: PARTICLES Position`，`Color Binding: PARTICLES Color`，`Velocity Binding: PARTICLES Velocity`。该图记录 Ribbon Renderer 使用材质实例、按距离平铺 UV 并绑定粒子属性。
> 图表转写（UE-GTXT v4）
> `Ex_Ultimate_01` Sequencer/Viewport 预览中，两个角色之间远处和近处两侧可见粉白色 Ribbon 轨迹，轨迹呈细长发光线条并带轻微拖尾。Outliner 选中 `PostProcessVolume`，Details 中可见实例和 BrushComponent；底部嵌入 Niagara 窗口仍选中 `Ribbon_Core_01`，右侧 `Dynamic Material Parameters` 面板露出 `Float from Curve` 曲线。字幕说明轨迹后处理/体积会超出去，因此把后处理体积增大。该图记录 Ribbon Core 在 Sequencer 中已能生成可见双侧轨迹，并通过后处理体积覆盖范围辅助预览。

### 00:24:20-00:27:15 Curve

- 本段定位：Curve。
- 知识点：这种话 这里的尾部虽然有点不顺滑 但毕竟是要和其他元素混合在一起 现在看着爱言也没关系 稍后再和其他一起叠加看看 颜色用VectorForm。
- 知识点：Curve来处理 所以从图上看 这里圆适当带点黄的那里 调一下 从这里开始适当往粉色方向走走 就是之前做过的 可能会有一点相似的感觉 3到1指左右。
- 知识点：红色通道和绿色通道是移动 大约0.1蓝色通道 0.5到 大约0.2需要调整 然后把RGB通道变化的时间点提下 从黄色开始渐渐变成粉红色。
- 知识点：在这里用Stel Curve 乘以Float来做一个Curve 这是常用的方法 最开始会强烈 然后 逐渐让颜色在后面消失。
- 知识点：在这里适当加一点湿针 从Curve的0.3开始 从0开始 适当给一点就可以 当然这个核心的线条 是强调明亮力量的要素 所以不需要大的扭曲。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Curve`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ribbon_Core_01` 的 `Ribbon Renderer` 仍使用 `MI_Ribbon_01_Ins_01`，`UV Mode: Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length 100.0`，`Draw Direction: Front to Back`，`Shape: Plane`，Bindings 仍为 `PARTICLES Position/Color/Velocity`。Niagara Stack 中 `Ribbon_Core_01` 已加入 `Dynamic Material Parameters`、`Scale Ribbon Width`、`Scale Color`，并选中 `Scale Color`；Preview 左侧显示源粒子和 Ribbon 计数，Timeline 约 `0.19`。字幕说当前效果可以，但有点皱，准备把 Tiles 增加到 200 试试。该图记录材质已挂到 Ribbon Renderer，并准备通过平铺长度/颜色模块改善纹理皱褶感。
> 图表转写（UE-GTXT v4）
> `Ribbon_Core_01` 选中 `Scale Color` 模块。右侧 `Scale Mode: RGB and Alpha Separately`；`Scale RGB` 使用 `Vector from Curve`，曲线随 `PARTICLES NormalizedAge` 变化，X/Y/Z 三通道从约 1 逐步下降，底部 `Scale Curve` 为 `X 1.0 / Y 1.0 / Z 1.0`。`Scale Alpha` 使用 `Float from Curve`，曲线在开头快速从 0 上升到 1，随后逐渐下降到约 `0.1`，底部 `Scale Curve 1.0`。左下 Curves 面板选中 `Scale RGB` 的 Z 通道，曲线从 1 降到 0。字幕提示大约 0.2 后会再调整。该图记录 Ribbon 颜色与透明度随生命周期衰减的曲线。
> 图表转写（UE-GTXT v4）
> `Ribbon_Core_01` 选中 `Dynamic Material Parameters`。右侧显示 `Dynamic Parameter Index 0`，`Write Parameter Index 0` 勾选，参数 `Distortion` 使用 `Float from Curve`；曲线随 `PARTICLES NormalizedAge` 保持接近 `0.1` 的低值，底部 `Scale Curve 1.0`。下方可见 `RandomU 0.5`、`Dissolve 1.0`、`Param3-0 (Parameter not us...) 0.0`。`Dynamic Parameter Index 1/2/3` 的 `Write Parameter Index` 未勾选。左下 Curves 面板同时显示 `Scale Velocity`、`Scale Color` 与 `Ribbon_Core_01` 相关曲线。该图记录用动态材质参数给 Ribbon 材质传入低幅度 Distortion，并保持 Dissolve/RandomU 固定值。

### 00:27:29-00:30:18 Lifetime、Ribbon、Material

- 本段定位：Lifetime、Ribbon、Material。
- 知识点：反正相机这个位置 适当伸出去有点锐度 以前做过的 马达就会超出去了 所以我就把后处提升大 从20变成50看看 因为不方便 这样左右伸出线条时。
- 知识点：会有什么轨迹产生 感觉看到了 然后 可以再添加一些细节 再添加一个彩带 像在做混合一样 这里称为彩带 要保存吗关掉 再抬起来 从马达放入一些不同的东西。
- 知识点：立刻就能看出来 所以复制生成一个新的马达 命名为R 放到这个彩带里 首先先换纹理 看看效果如何 用这个纹理。
- 知识点：不透明度设为0.5 然后亮一些 看看 效果如何 生命周期设为0.7 出来了 但大小太小 那么把大小增大到150 看看 这样年的朋友出来了吗。
- 知识点：材质与纹理部分要检查 Blend Mode、Opacity/Alpha、Emissive、UV/Panner 和贴图输入。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Lifetime`、`Alpha`、`Opacity`、`Material`、`Panner`、`Emissive`、`材质`、`纹理`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ex_Ultimate_01` Viewport 中两侧粉白 Ribbon 轨迹更加明显，近处角色和远处角色之间可见细长光带。底部嵌入 Niagara 窗口仍显示 `Ribbon_Core_01` 的动态材质参数区域；右侧 Outliner 选中 `PostProcessVolume`，Details 中体积缩放字段露出，值行可见 `20.0 / 20.0 / 20.0`。字幕说明 Ribbon 或后处理会超出原范围，因此把后处理体积增大。该图记录在关卡预览中确认 Ribbon 线条伸出范围，并同步扩大后处理体积覆盖。
> 图表转写（UE-GTXT v4）
> Niagara System 中新增第三个发射器 `Ribbon_Main_01`，与 `Source`、`Ribbon_Core_01` 并列。`Ribbon_Main_01` 的栈包含 `Emitter State Self Infinite`、`Spawn Particles from Other Emitter`、`Initialize Particle`、`Sample Particles from Other Emitter`、`Particle State`、`Dynamic Material Parameters`、`Scale Ribbon Width`、`Render > Ribbon Renderer`。右侧 Ribbon Renderer 使用 `MI_Ribbon_01_Ins_01`，`UV Mode: Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length 200.0`，`Draw Direction: Front to Back`，`Shape: Plane`，Bindings 为 `PARTICLES Position/Color/Velocity`。Timeline 中新增 `Ribbon_Main_01` 轨道。该图记录复制/新增主 Ribbon 发射器并将平铺长度提升到 200 的状态。
> 图表转写（UE-GTXT v4）
> `Ribbon_Main_01` 选中 `Sample Particles from Other Emitter`。右侧参数显示 `Emitter Sampling Mode: Sequential`；`Filtering` 中 `Reject Particle If Sampled Index` 勾选，`Reject Particle By Sampled Age` 和 `Reject Particle on Sampled Partic...` 未勾选。`Position Sampling` 为 `Apply to Attribute`，`Applied Position Offset X 0.0 / Y 0.0 / Z 0.0`；`Velocity Sampling`、`Color Sampling`、`Age Sampling`、`Lifetime Sampling`、`Mass Sampling`、`Material Random Sampling` 均为 `Disabled`。多个 Renderer Bindings 采样项也显示 `Disabled`；底部 `Ribbon UV Distance` 为 `Apply to Attribute`。Timeline 当前约 `3.68`，Preview 计数显示 `Source` 完成、`Ribbon_Core_01` 和 `Ribbon_Main_01` 活跃。该图记录主 Ribbon 从其他发射器采样位置并保留其他属性设置的采样策略。

### 00:30:28-00:33:22 关键流程 11

- 本段定位：关键流程 11。
- 知识点：呈水状的部分 也会修改一下 这个希望有点黑色调 考虑到这个角色 有点强力技能的强调 为了混合黑色调 需要使用半透明 然后 点色协调器和消散保持原样。
- 知识点：降低边缘 这样极端的颜色会出现 并且瓦片正常会适当加粗 要 这一方向适当缩小一下 V方向 透明度应该没问题 透明度的瓦片扩增一下 正常的瓦片缩小。
- 知识点：但是这样 这样 颜色选项适当增大一下 这样看看 外曲从适当更强一点开始 外曲是0.1 但到0.3会很摇晃 如果看这里后面 适当增加了轻盈的感觉。
- 知识点：这样做 现在颜色和变化几乎是一样的 不太明显 但只要换颜色就能看得更清楚 溶解反而是为了更强调黑色 溶解也会做成盖子 所以从0.5开始 变得很。
- 知识点：反而有点黑色调显现出来 试点设置为0.5 会更深一点。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`透明度`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `MI_Ribbon_01_Ins_02` 材质实例打开，预览为深色背景上的彩色丝带纹理，整体比前一版更偏黑。右侧 `Global Scalar Parameter Values` 中可读 `Black_Bias 0.5`、`Color_Tile_U 0.5`、`Color_Tile_V 0.5`、`Desaturation 0.0`、`Edge_Pow 1.0`、`Edge_Str 20.0`、`Normal_Tile_U 0.5`、`Normal_Tile_V 0.5`、`Opacity_Pow 0.5`、`Opacity_Str 5.0`、`Opacity_Tile_U 0.5`、`RGB_Offset 0.01`。纹理输入为 `Color_Tex: T_Cloud_Wisp_Chromatic_Tile`、`Normal_Tex: T_NoiseNormal_01`，`Opacity_Tex` 使用黑白能量拖尾纹理；`Parent` 为 `M_Ribbon_01`，`Blend Mode` 为 `Additive`。该图记录第二个 Ribbon 材质实例的黑色调基础参数。
> 图表转写（UE-GTXT v4）
> Niagara 中选中 `Ribbon_Main_01` 的 `Dynamic Material Parameters`。右侧 `Dynamic Parameter Index 0` 的 `Write Parameter Index 0` 勾选，`Distortion` 使用 `Float from Curve`，曲线随 `PARTICLES NormalizedAge` 从低值逐渐上升到约 `0.1`；`RandomU 0.5`、`Dissolve 1.0`、`Param3-0 0.0`。`Dynamic Parameter Index 1/2/3` 未勾选。Timeline 当前约 `3.27`，左侧 Preview 计数显示 `Source` 完成，`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02` 活跃。字幕提示颜色选项稍微增大。该图记录主 Ribbon 动态材质 Distortion 低幅上升曲线和固定 Dissolve/RandomU。
> 图表转写（UE-GTXT v4）
> `Ribbon_Main_01` 仍选中 `Dynamic Material Parameters`，Preview 左侧可见一段粉白 Ribbon 轨迹和亮点。`Distortion` 的 `FloatCurve` 前半段从 0 上升到约 `0.1`，底部 `Scale Curve 1.0 / 0.3`；`Dissolve` 使用 `Float from Curve`，曲线从约 `0.5` 开始并逐步上升到 `1.0`，底部显示 `0.5 / 0.5`。`RandomU` 为 `0.5`，`Param3-0` 为 `0.0`。字幕说明黑色调反而显现出来。该图记录通过 Dissolve 曲线从中间值开始增强暗部显示。

### 00:33:25-00:36:20 材质、纹理与透明度控制

- 本段定位：材质、纹理与透明度控制。
- 知识点：因为这个区域给0.5 数值 所以这个力量区域为0.5 颜色这里的空白部分被更多填充 然后现在试试缩放颜色调整。
- 知识点：首先缩放曲线不是10 就用1 现在颜色值减少 这里黑色更明显 那么颜色将通过图表查看 这里之前的试点是0.5左右的 适当往后移 慢慢变化一下。
- 知识点：数值从粉色往紫色方向移动 颜色改变 就这样给试 疯狂频道都固定在工作值5变 这里的外频道值保持在0.3不变 只有蓝频道来回变动 一开始弱的时候。
- 知识点：就像黄色的感觉 逐渐变成紫色 比例 这样展示应该可以 但是这里有点这个纹理是波浪纹理 感觉偏向一侧 适当移动到中心 然后我们再用同样形状的丝带再加一层。
- 知识点：换成二其他的不动 只有大小反向翻转 然后随机远音将片移植设为 试试看 但是一看就闹出来了 这样看应该可以 先在这里看一下。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ribbon_Main_01` 的 `Dynamic Material Parameters` 继续显示 `Distortion` 和 `Dissolve` 两条 `Float from Curve`。Preview 中粉色 Ribbon 轨迹的空白/透明区域被更多填充，左侧粒子计数约为 `9 Current, 15 Max (est.) - [Ribbon_Main_01]`。`Distortion` 曲线保持前半段上升，`Dissolve` 曲线在可见范围内从约 `0.5` 向 `1.0` 过渡，`RandomU 0.5`、`Param3-0 0.0`。字幕说明颜色空白部分被更多填充。该图记录材质动态参数对主 Ribbon 透明区域填充效果的影响。
> 图表转写（UE-GTXT v4）
> `Ribbon_Main_01` 选中 `Scale Color`。右侧 `Scale Mode: RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，X/Y/Z 三通道在 `PARTICLES NormalizedAge` 上显示：红色通道约保持 1，绿色通道约在 0.3 附近，蓝色通道从约 0.2 上升到 1；`Scale Alpha` 使用 `Float from Curve`，曲线前段快速升到 1，再向尾端下降。左下 Curves 面板选中 Z 通道，曲线从约 0.2 升到 1。字幕说明开始弱时像黄色感觉。该图记录主 Ribbon 颜色从偏黄逐步增加蓝通道、转向紫粉色的曲线设置。
> 图表转写（UE-GTXT v4）
> Niagara 中复制出 `Ribbon_Main_02`，它与 `Ribbon_Main_01` 并列显示，栈结构相同：`Emitter State Self Infinite`、`Spawn Particles from Other Emitter`、`Initialize Particle`、`Sample Particles from Other Emitter`、`Particle State`、`Dynamic Material Parameters`、`Scale Ribbon Width`、`Scale Color`、`Ribbon Renderer`。右侧选中 `Ribbon_Main_02` 的 `Dynamic Material Parameters`，`Distortion` 和 `Dissolve` 曲线与主 Ribbon 类似，但 `RandomU` 显示为 `0.0`。Preview 中可见粉色 Ribbon 局部效果。字幕提示这样看应该可以。该图记录复制第二层主 Ribbon 并通过随机/参数差异叠加同形状轨迹。

### 00:36:24-00:39:22 材质、纹理与透明度控制

- 本段定位：材质、纹理与透明度控制。
- 知识点：丝带表现的很好 颜色变化似乎有点弱 所以验证效果颜色曲线 适当强调一下黑色区域 现在这里先改变颜色不透明度。
- 知识点：在中间的0.5时机将值调到1 以便更好地显示黑色区域 慢慢消失 然后需要适当减少一下 朋友的戴安娜参数外部值。
- 知识点：让多样性适当增强一些 然后在这里缩短比例曲线的视点 调整到6.75 这种感觉 某种程度上黑色调也很好看 这里轻盈的那种感觉也很好。
- 知识点：前面有点碎碎的感觉 将这里的宽度细分技术 设为 这里中间 这里一行再多出来的话 再多一行的话 纹理表现会更顺滑 丝带轨迹 无论如何看起来都很好。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Viewport 中可见左右两侧成对的粉白 Ribbon 弧形轨迹，轨迹从亮点处向外拖出并叠加多层条纹；两个角色位于棋盘地面上。底部嵌入 Niagara 窗口显示 `Ribbon_Main_02` 的参数面板，Sequencer 时间约在 `0128` 帧。Preview 计数显示 `Source`、`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02` 均有活跃/估算粒子。该图记录两层主 Ribbon 与核心 Ribbon 叠加后的关卡预览结果。
> 图表转写（UE-GTXT v4）
> `Ribbon_Main_02` 选中 `Scale Color`，右侧 `Scale RGB` 为 `Vector from Curve`，红色通道约保持 1，绿色通道约保持 0.4，蓝色通道随 `PARTICLES NormalizedAge` 从约 0.2 上升到 1；`Scale Alpha` 为 `Float from Curve`，在开头快速升到 1，并在后半段下降。左下 Curves 面板选中红色/Alpha 相关曲线，显示先升高、平台保持后下降的形态。Preview 计数显示 `Ribbon_Main_02` 活跃。该图记录第二层主 Ribbon 的颜色和透明度曲线，用于加强黑色区域和颜色变化。
> 图表转写（UE-GTXT v4）
> Niagara System 显示 `Source`、`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02` 四个发射器；左侧 Timeline 中也有三条 Ribbon 轨道和 `Source` 轨道。右侧选中 `Ribbon_Core_01` 的 `Ribbon Renderer`，材质为 `MI_Ribbon_v01_Ins_01`，`Facing Mode: Screen`，`UV Mode: Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length 200.0`，`Offset 0.0 / -0.1`，`Scale 1.0 / 1.0`，`Draw Direction: Front to Back`，`Shape: Plane`，`Width Segmentation Count 1`，`Tessellation Mode: Automatic`，Bindings 为 `PARTICLES Position/Color/Velocity`。该图记录为核心 Ribbon 更换/调整材质和 UV 偏移，使纹理表现更顺滑。

### 00:39:26-00:42:26 粒子

- 本段定位：粒子。
- 知识点：丝带现在已经完成了 现在将添加光部分和火花部分 然后这个粒子将结束 那么我们先从光开始加试试看光色 这个复制使用 这个起个名字叫光。
- 知识点：这里颜色感只需适当改变一下 用光渲染器制作 再用精灵渲染器秘密 删除 半径时 颜色高度也得删除。
- 知识点：尺度颜色 只用乘以浮点数制作 先将颜色值设为2010.75 放大到大约500 来看看 很好出来呢 感觉就像是完全跟随银河一样 很好出来了 然后现在在制作丝带粒子时。
- 知识点：这个有点不便了吧 所以即使做一好 如果丝带粒子突然看不见了 就可以尝试在这个部分添加ID 应该能出来 那么light是可以 用heatmeter的spark部分。
- 知识点：试着制作一下 首先我们使用平常用的 我们之前制作的sparkmatery 在本地创建。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`粒子`、`渲染器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara 中新增 `Light_01` 发射器，Timeline 选中 `Light_01` 轨道。`Light_01` 栈包含 `Emitter State Self Once`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Add Velocity Linear`、`Particle State`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Render > Light Renderer`。右侧选中 `Light_01` 的 `Scale Color`，`Scale Mode: RGB and Alpha Separately`；`Scale RGB` 为 `Multiply Vector by Float`，Vector 为 `X 2.0 / Y 1.0 / Z 0.75`，Float 输入为 `500.0`；`Scale Alpha` 为 `Float from Curve`，曲线从 0 逐渐升到 1。Preview 左侧显示粉色 Ribbon 轨迹和发光点。该图记录复制/新增光发射器，并用高倍率颜色值驱动 Light Renderer。
> 图表转写（UE-GTXT v4）
> Niagara 中新增 `Spark_01` 发射器，与 `Light_01` 并列。右侧选中 `Spark_01` 的 `Sprite Renderer`，`Material: DefaultSpriteMaterial`，`Source Mode: Particles`，`Material User Param Binding: None`，`Alignment: Unaligned`，`Facing Mode: Face Camera`，`Default Pivot in UV Space 0.5 / 0.5`，`Macro UVRadius 0.0`，`Pixel Coverage Mode: Automatic`，`Pixel Coverage Blend 1.0`，`Sorting.Sort Mode: None`，`Sort Only when Translucent` 勾选，`Sub Image Size 1.0 / 1.0`。Content Browser 位于 Niagara 默认资产目录，选中 `DefaultSpriteMaterial`。该图记录火花发射器初始 Sprite Renderer 材质和朝向设置。
> 图表转写（UE-GTXT v4）
> `Spark_01` 发射器选中 `Emitter State`。右侧 `Life Cycle Mode: Self`，`Inactive Response: Complete (Let Particles Finish then Kill...)`，`Loop Behavior: Infinite`，`Loop Duration 3.0`，`Scalability Mode: System`。System Overview 中 `Spark_01` 当前包含 `Emitter State System`、`Initialize Particle`、`Particle State`、`Render > Sprite Renderer`。Timeline 中 `Spark_01` 轨道从起点延伸到约 2 秒以上，`Light_01` 和三条 Ribbon 轨道在下方。该图记录 Spark 发射器生命周期设为自我控制、循环时长 3 秒的初始状态。

### 00:42:32-00:45:29 Color

- 本段定位：Color。
- 知识点：用self设置完成三秒 设置为1 然后 生命周期设置为 随机1到0.8范围内 增加大小 随机讨论 一物从2到4从3到6左右 增强并使用burst为速率。
- 知识点：不仅仅是速率 而是使用其他速率 修正并作为来源 和写给你 大约100个尝验证效果 那么 材料进入 然后需要 Colors增加一个 用修正制作服务。
- 知识点：忽略300 大约频率15的效果 先看一下 确实有出来 然后这里 制作形状 位置适当用球体 创建内空间的间距 大约25 然后 需要用颜色更明显。
- 知识点：制作比例一点 透明度基础上 用曲线 基本上在0.20机就开始消失 颜色将用向量从曲线给出 这里再用浮点数乘以向量 曲线来制作 这个适当强一点。
- 知识点：1500来 从0.5开始消失 颜色要用图形适当调整一下 和4代的某种颜色类似 从3开始 红通道用意的直来变动 然后 绿通道从1开始。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Color`、`生命周期`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Viewport 中暂未明显显示 Spark，但嵌入 Niagara 面板显示 `Spark_01` 已加入 `Curl Noise Force`。右侧可见 `Curl Noise Force` 参数：`Noise Strength 300.0`，`Noise Frequency 15.0`，`Noise Quality: Baked (Mediu...)`。Preview 粒子计数显示 `Spark_01` 约 `93 Max (est.)`，其他发射器包括 `Source`、`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02`、`Light_01`。该图记录 Spark 通过 Curl Noise 增加扰动运动，并在 Sequencer 预览中确认发射器已参与。
> 图表转写（UE-GTXT v4）
> `Spark_01` 选中 `Scale Color`。右侧 `Scale Mode: RGB and Alpha Separately`；`Scale RGB` 为 `Vector from Curve`，曲线随 `PARTICLES NormalizedAge` 逐步降低；下方 `Scale Curve` 使用 `Multiply Vector by Float`，Vector 为 `X 1.0 / Y 1.0 / Z 1.0`，Float 为 `Float from Curve`，该 Float 曲线从约 `3.0` 逐渐下降到接近 `0.5`。`Scale Alpha` 也使用 `Float from Curve`，曲线从 1 逐渐下降。`Spark_01` 栈中可见 `Shape Location Sphere`、`Particle State`、`Curl Noise Force`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。该图记录 Spark 的颜色强度和透明度随生命周期衰减。
> 图表转写（UE-GTXT v4）
> `Spark_01` 仍选中 `Scale Color`。右侧 `Scale RGB` 的 VectorCurve 中红色通道从约 1 向 0 降低，绿色通道也逐步降低，蓝色通道参与颜色转向；`Scale Curve` 仍为 `Multiply Vector by Float`，Float 曲线在前段高值后下降；`Scale Alpha` 的 FloatCurve 从 1 降到接近 0。Preview 粒子计数显示 `Spark_01` 活跃，Timeline 仍选中 `Spark_01` 轨道。该图记录 Spark 颜色从强亮逐渐转向紫粉并淡出的曲线微调。

### 00:45:33-00:48:29 粒子

- 本段定位：粒子。
- 知识点：大约0.1 蓝通道在 0.5反过来现在应该变成紫 这样做的时候适当调整一下颜色 那么我们来看一下 表现的很好 感觉站出来的效果不错 生命时间可能适当短一点也可以。
- 知识点：适当短一点也没问题 那么这次的粒子成为最核心的起点 这次粒子的生成似乎已经完成了 那么接下来后续会进入 下一个粒子的制作。
- 知识点：我们下次制作粒子的时候 在这里附加到某个手部动作上 制作粒子 这个粒子会附着在手上 以这种方式出现 非常简单的 是它有能量闪烁的那种感觉的表现。
- 知识点：可能是这种 这个方式可能会有些不同 因为现在是附加的方式 我们边做边看吧 表现是钻石形 名字需要叫做中级手部施法 这里拖动过来 然后在附加之前先从这里生成一针。
- 知识点：在前一针 这样在这里生成了吧 当然 在这里放入用针 然后在轨道上附加 这里这个页面就是GDCBC 如果看到的话搜索手柄 这个是L1 然后选择这个L1。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara 中选中 `Spark_01` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，内部 `Scale Curve` 为 `Multiply Vector by Float`，Vector 的 `X/Y/Z` 均为 `1.0`，Float 曲线随 `PARTICLES NormalizedAge` 下降；`Scale Alpha` 使用 `Float from Curve`。左下 Curves 面板选中 `Spark_01 Emitter > Scale Color > Scale RGB > VectorCurve Y`，曲线从约 `1.0` 逐步降到 `0`。Preview 计数显示 `Spark_01` 当前约 `95`、最大估计 `95`，字幕说明把 0.5 反向后颜色应转为紫色。该图记录 Spark 颜色曲线的反向调整。
> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，当前时间约 `0007`。Viewport 中角色手部附近可见小范围紫色施法效果；Sequencer 左侧轨道包含 Camera、`Phase`、`Trails_01`、`Ultimate Projectile 01`、`Ultimate Projectile 02`。Content Browser 位于 `/Content/Tutorial/Particle/Ex_04`，可见 `Ultimate_Hand...` 和 `Ultimate_Projecti...` 资源缩略图。该图记录从工程资源中准备把手部施法 Niagara 加入演出时间轴。
> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0001`，`Trails_01` 下新增 `Ultimate Hand Cast 01`。轨道加号菜单打开，顶部选项包括 `Attach`、`Audio`、`Event`、`Path`、`Transform`、`Spawn Track`、`Template Sequence`，下方列出 Components：`ArrowComponent0`、`NiagaraComponent0`、`Sprite`，以及 `Actor Hidden In Game` 等属性。Viewport 中角色手部附近显示 NiagaraActor/Gizmo，右侧 Details 可见 Attachment 区域和 `Auto Manage Attachment` 选项。该图记录为 `Ultimate Hand Cast 01` 添加 Attach 轨道的操作入口。

### 00:48:32-00:51:36 粒子

- 本段定位：粒子。
- 知识点：这样附着出来 那么这里我打开保护 从手中添加球体试试看 用基本材料 需要命名为Glow 然后必须检查本地才能仅仅附着在手上 移动生成一个Bust体。
- 知识点：刀锯一秒 颜色值同样让它适当发光 大小统一设置为10左右 通过大小模块缩放精灵 从出耳植一开始逐渐两倍成长 缩放颜色。
- 知识点：使用颜色缩放节点 大致上将颜色设为单色 而透明度则用曲线制作 这样 紧紧附着在手上 相机偏移适当拉一下 这个程度 这个粒子要用两次。
- 知识点：在这个动作中用一次 然后再转动时抓住手再用一次 因为要使用两次 自助更新继续使用 原始 那么我们来决定一下使用两次的针吧 首先这里的轨道部分按一下。
- 知识点：这样会让Naya创作一个组件 这里的轨道按加号 并会有FX系统切换轨道 所以设为非激活 需要在13针给个键再下一个针激活 这样 从这时起就激活到35针。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`系统`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0010`，`Ultimate Hand Cast 01` 展开后显示 `Attach` 轨道，时间轴片段标注 `Phase GDC_PC (FX_Hand_L1)`；`Spawned` 轨道处于勾选状态。Viewport 中相机近看角色手部，手部附近有绑定对象的 Gizmo 和黄色选框提示。该图记录 `Ultimate Hand Cast 01` 已绑定到 `Phase GDC_PC` 的 `FX_Hand_L1` 手部挂点。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_HandCast_01` 打开，发射器 `Glow_01` 包含 `Emitter State`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Scale Sprite Size`、`Scale Color` 和 `Sprite Renderer`。右侧选中 `Glow_01` 的 `Scale Color`，`Scale Mode` 为 `RGB and Alpha Separately`；`Scale RGB` 中可见 `X 3.0`、`Y 1.0`、`Z 0.5`；`Scale Alpha` 使用 `Float from Curve`，曲线从低值快速上升后维持。Preview 计数显示 `Glow_01` 当前 `0`、最大估计 `1`。该图记录手部光球的颜色倍率和 Alpha 曲线。
> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0013`，`Ultimate Hand Cast 01` 展开后包含 `NiagaraComponent0`、`FX System`、`Attach` 和 `Spawned`。`FX System` 轨道的下拉框显示为 `Activate`，时间轴上 `Attach` 片段仍标注 `Phase GDC_PC (FX_Hand_L1)`。Viewport 中角色手部附近可见绑定对象与 Gizmo。该图记录为手部施法粒子添加 FX System 激活轨道，并在绑定手部挂点后控制启用时段。

### 00:51:43-00:54:39 粒子

- 本段定位：粒子。
- 知识点：非激活的话 就是在这段时间内是激活状态 在35针再一次激活 反过来我放错了 其实这里应该出来 而这里要是真的在非激活状态 生成后到这里是激活的。
- 知识点：从这里非激活 一直非激活到这里 再从36针开始激活 旋转到57针为止 激活 持续激活 并且当在下一个针中停用 会变得好像 我来看看 这样出来 第一次出来。
- 知识点：第二次又出来 就这样能 向球体连接到这里 像是通过断代轨迹传递的 这样设定一下 我现在复制这个 然后再创建一个命名为 这一下目前附加在左手上。
- 知识点：我把这个删除再次附加给他 这样附加在PC上 Hand而已 这次用R而已 这样针区间是一样重复 双手上都会出现版 效果不错 这样序列设置都完成了。
- 知识点：现在我再增加一些 娜亚和粒子 先做一个更详细形状的圆球 命名为Glode 尺寸增大到差不多35 但不使用这个材料 而是在我们创建第一款 精灵爆炸时。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`粒子`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0036`，`Ultimate Hand Cast 01 > FX System` 的下拉菜单打开，选项包括 `Activate`、`Deactivate`、`Trigger`。时间轴上可见多个 FX System 关键帧，覆盖约第 13、36、57 帧附近的启停节点；Viewport 中角色双手附近可见两个手部标记/能量位置。该图记录在同一个手部施法轨道上继续设置激活与停用关键帧。
> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0018`，Viewport 中角色两侧手部都出现手部施法对象标记。`Ultimate Hand Cast 01` 的 `FX System` 轨道上已有多段激活/停用关键帧，时间轴在约 13、36、57 帧附近分布。画面右侧 Details 显示所选对象属性区域，底部字幕提示复制并命名为 02。该图记录将第一只手的施法光效复制为第二个手部版本，并保持相近的时间控制方式。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_HandCast_01` 中已有 `Glow_01` 和 `Glow_02` 两个发射器。右侧选中 `Glow_02` 的 `Sprite Renderer`，可读设置包括 `Material: DefaultSpriteMaterial`、`Source Mode: Particles`、`Material User Param Binding: None`、`Alignment: Unaligned`、`Facing Mode: Face Camera`、`Pivot In UV Space X 0.5 / Y 0.5`、`Macro UV Radius 0.0`、`Pixel Coverage Mode: Automatic`、`Sort Mode: None`、`Sub UV Image Size X 1.0 / Y 1.0`。Content Browser 位于 `/Content/Tutorial/Material/Ex_01`，可见多个 `MI_AdditiveDe...`、`MI_RadialUV...` 材质实例。该图记录第二个手部光球的 Sprite Renderer 基础设置和可选材质目录。

### 00:54:45-00:57:42 粒子

- 本段定位：粒子。
- 知识点：像光球的那种感觉 添加了细节 这次需要再加一个 跟随球体生成的丝带 用丝带命名 我们平时在制作时 制作丝带的素材 并以此为基础制作线条 因为这个已经挂在手上。
- 知识点：就会根据动作生成 所以就给100个的生成率 关掉粒子渲染 改为丝带渲染 现在这个材料是在制作 第一个粒子。
- 知识点：使用的核心材料 用这个1号的1号 因为线条生成有好的感觉 而且这个也用自我续航 设置为1秒 不过这个必须解锁 因为丝带需要留在世界空间 一直挂在手上是不行的吧。
- 知识点：光线设置为0.4秒大小 设置为50左右放进去 然后材料也放进去 然后缩放颜色 颜色只适当 α是 从0.2开始竟然消失 然后 在这一部分使用向量曲线。
- 知识点：在这里在缩放曲线上 再加一个浮动 重返浮动 从曲线最初有三个颜色 需要减少到大约10 颜色将以图形显示。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`粒子`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_HandCast_01` 中新增 `Ribbon` 发射器，与 `Glow_01`、`Glow_02` 并列。右侧选中 `Ribbon` 的 `Emitter Properties`：`Local Space` 未勾选，`Determinism` 未勾选，`Random Seed 0`，`Sim Target CPUSim`，`Calculate Bounds Mode Dynamic`，`Interpolated Spawning` 勾选，`Requires Persistent IDs` 未勾选。`Ribbon` 栈包含 `Emitter State Self Once`、`Spawn Rate`、`Initialize Particle`、`Particle State`、`Scale Color` 和 `Ribbon Renderer`。该图记录手部拖尾 Ribbon 发射器的入口结构。
> 图表转写（UE-GTXT v4）
> 选中 `Ribbon` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，内部 `Scale Curve` 为 `Multiply Vector by Float`；Vector 的 `X/Y/Z` 均为 `1.0`，Float 曲线低幅衰减。左下 Curves 面板选中 `Ribbon Emitter > Scale Color > Scale RGB > VectorCurve Y`，曲线从约 `1.0` 降到 `0`。`Scale Alpha` 使用 `FloatCurve`。Preview 计数显示 `Glow_01`、`Glow_02` 不活跃，`Ribbon` 最大估计约 `44`。该图记录 Ribbon 颜色与透明度的随生命周期衰减。
> 图表转写（UE-GTXT v4）
> `Ribbon` 发射器中选中 `Emitter State`。右侧 `Emitter State` 设置为 `Life Cycle Mode: Self`，`Inactive Response: Continue`，`Loop Behavior: Once`，`Loop Duration Mode: Fixed`，`Loop Duration: 1.0`。下方 `Spawn Rate` 模块中 `SpawnRate` 为 `100.0`。栈中还可见 `Initialize Particle`、`Particle State`、`Scale Color`、`Dynamic Material Parameters` 和 `Ribbon Renderer`。字幕提到动态参数也需要调整。该图记录 Ribbon 一次循环、1 秒生命周期和每秒 100 的生成率。

### 00:57:48-01:00:39 关键流程 20

- 本段定位：关键流程 20。
- 知识点：非常混乱的结果 视帧值还不是0的缘故 动态参数也 视帧值 从6.3 从0开始只给出0.1左右 随机选择0.5左右 给你 那么 线会出现吗 现在似乎非常明亮。
- 知识点：之前给了实觉 适当降低一下看看 感觉应该让人感觉到一些余影 而不是表现出一些 细致的线条 因为这部分并不是很详细的展示 反而手中的那个球体影响力更大吧。
- 知识点：这一部分在最初出现 刚开始的线适当抓一下 这一部分实在是 手部动作很快 反而大小可以减小一点 颜色适当亮一点会更好。
- 知识点：这种感觉应该会很好 断带的感觉现在似乎也出来了 就是增加一个灯光试试看 复制发光效果时 用光移号 显示为突发 不需要去掉相机。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`颜色`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ribbon` 的 `Particle Update` 组中已有 `Particle State`、`Scale Color`、`Dynamic Material Parameters` 和 `Ribbon Renderer`。点击 Particle Update 的加号后打开 `Add new Module` 菜单，搜索框输入 `ri`，结果列表中高亮 `Ribbon > Scale Ribbon Width`；同一列表还显示 Orientation、Mesh、Size、Skeletal Mesh、Sprite 等分类。右侧仍可见 `Dynamic Material Parameters` 的部分参数区域，左下曲线保持 Ribbon 颜色曲线。该图记录准备为 Ribbon 添加宽度缩放模块。
> 图表转写（UE-GTXT v4）
> `Ribbon` 的模块添加菜单仍打开，搜索 `ri` 后高亮 `Scale Ribbon Width`。左上 Preview 计数显示 `Glow_01`、`Glow_02` 不活跃，`Ribbon` 最大估计约 `46`。系统概览中 `Ribbon` 发射器的 `Particle Update` 区域已包含 `Dynamic Material Parameters`，右侧面板下方可见多个 Dynamic Parameter Index 的写入开关区域。该图记录在调整动态材质参数后继续补充 Ribbon 宽度控制模块。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_HandCast_01` 中 `Ribbon` 的 `Particle Update` 已加入 `Scale Ribbon Width`，发射器列表包含 `Glow_01`、`Glow_02`、`Ribbon`，并在下方新增复制出来的 `Glow_01001`。Preview 计数显示 `Glow_01001` 最大估计 `1`，`Ribbon` 最大估计约 `44`。`Glow_01001` 栈中可见 `Emitter State Self Once`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Camera Offset`、`Particle State`、`Scale Sprite Size` 等模块；字幕提示“用光01号”。该图记录复制 `Glow_01` 作为额外光效层，配合 Ribbon 宽度调整后的手部残影。

### 01:00:47-01:03:42 Lifetime、Velocity、Color

- 本段定位：Lifetime、Velocity、Color。
- 知识点：这部分是随便放的就好 通过Less Render 这里给我减去5左右 然后用Multiply 8 更接近白色适当放大一下 这里出现了光反应。
- 知识点：Lifetime 决定粒子存活时间，需要和 Spawn 数量、速度以及透明度曲线一起调。
- 知识点：通过 Add Velocity 或速度范围控制粒子运动方向和力度，必要时给最小/最大值增加随机性。
- 知识点：用100的简单频率 然后需要给Scal 颜色上色 Alpha就简单设为0.1 细节上不需要再调整了 因为它不是那么重要的粒子。
- 知识点：给Vector By Club赋予颜色值 然后只通过这个控制曲线 适当调亮 需要调的亮一点 这样 我们来看一下吗。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Spawn`、`Lifetime`、`Velocity`、`Color`、`Alpha`、`Multiply`、`Add`、`粒子`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_HandCast_01` 中新增 `Light_01` 发射器，Preview 计数显示 `Glow_01`、`Glow_02`、`Ribbon`、`Glow_01001`、`Light_01` 均处于不活跃状态。右侧选中 `Light_01` 的 `Initialize Particle`：`Lifetime Mode: Direct Set`，`Lifetime 1.0`；`Color Mode: Direct Set`，颜色值约为 `R 50.0 / G 50.0 / B 50.0 / A 1.0`；`Position Mode: Simulation Position`，Position Offset 未启用；`Sprite Size Mode: Uniform`，`Uniform Sprite Size 10.0`。该图记录手部施法系统中补充 `Light_01` 的基础初始化参数。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_01` 的 `Initialize Particle`，Preview 中可见一个高亮光团，粒子计数显示 `Spark_01` 当前约 `72`、最大估计约 `141`。右侧 `Lifetime Mode` 为 `Random`，`Lifetime Min 0.6`，`Lifetime Max 0.8`；`Color Mode` 显示 `Unset`，Position、Mass、Sprite、Mesh、Ribbon 属性多为未设置或默认。该图记录手部火花层的随机寿命区间，并保留后续颜色模块控制。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_01` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`；`Scale RGB` 使用 `Multiply Vector by Float`，Vector 约为 `X 3.0 / Y 2.0 / Z 0.5`，Float 使用从高值逐渐下降的曲线；`Scale Alpha` 同样使用 `Float from Curve`，曲线从接近 1 逐渐下降。Preview 中火花呈偏黄白的密集小光团，粒子计数约 `71 Current / 77 Max`。该图记录 Spark 颜色倍率与透明度衰减。

### 01:03:46-01:06:44 Sequencer、粒子、发射器

- 本段定位：Sequencer、粒子、发射器。
- 知识点：应该是这种方式 反正它们的发射器能作用 应该能够适当发挥 那么附加在手上的粒子也创建好了。
- 知识点：需要移动到文件夹 先保存一次序列 然后粒子也保存全部 那么最后在这里手的投影部分 和这里的四代轨迹连接的时候 用一个小爆炸 增强一下它们之间的联系。
- 知识点：作为交换 现在在我们制作四代轨迹视力时 是第二个视力 把这个小爆炸复制过来 稍作修改进调整水材之后这部分 那么名字就叫 AXA small。
- 知识点：我就会设为 这样 需要打开 然后把手柄也关掉 这是爆炸 首先需要先添加到序列器这里 放到文件夹里 实际在这里 项目四砖生成 前一针生成。
- 知识点：位置直也 几乎相同放进去 这是-27是145的位置 然后这样放入145 然后 在这里第14针给出生键 前一针现在左的 就会这样吧 这个也要有两个在两边。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`粒子`、`发射器`、`序列`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，Viewport 中角色手部附近可见手部粒子和光效。Sequencer 中 `Trails_01` 下包含 `Ultimate Projectile 01/02` 与 `Ultimate Hand Cast 01/02`；`Ultimate Hand Cast 01` 的 Attach 片段标注 `Phase GDC_PC (FX_Hand_L1)`，`Ultimate Hand Cast 02` 的 Attach 片段标注 `Phase GDC_PC (FX_Hand_R1)`，两者均有 `FX System` 下拉为 `Activate` 的轨道。Content Browser 位于 `/Content/Tutorial/Particle/Ex_04`，显示手部和投射物 Niagara 资源。该图记录左右手施法粒子已加入 Sequencer 并绑定到手部挂点。
> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0023`，Viewport 中角色双手两侧出现绿色方向箭头形标记。`Ultimate Hand Cast 02` 展开后 `FX System` 下拉显示 `Deactivate`，Attach 片段为 `Phase GDC_PC (FX_Hand_R1)`。Content Browser 中 `/Content/Tutorial/Particle/Ex_04` 下新增并选中 `Ultimate_Small...` 资源缩略图，与手部和投射物资源并列。该图记录开始创建用于手部与轨迹连接的小爆炸 Niagara 资源。
> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0013`，`Trails_01` 下新增 `Ultimate Small Exp 01`，其下有 `Spawned` 和 `Transform` 轨道；`Ultimate Hand Cast 02` 仍显示 `FX System: Activate` 与 Attach 片段 `Phase GDC_PC (FX_Hand_R1)`。Viewport 中角色两手附近仍显示绿色标记，底部小窗口打开 `Ultimate_Small_Exp_01` Niagara。该图记录把第一个小爆炸实例加入 Sequencer，并放在手部轨迹衔接的时间段。

### 01:06:47-01:09:41 UV、材质

- 本段定位：UV、材质。
- 知识点：这种话 就这样生成了 但现在适当修改一下例子吧 尺寸也大 首先删除这一部分 不一定需要中断的 需要只使用这四个 这里的材质。
- 知识点：首先需要改变一下形状 所以材质 我正在使用这个 然后就得复制一下 复制过来这里做一个 作为等级UV 走出来的形状 纹理的情况下。
- 知识点：发现无论如何对形状的影响最大 发现需要使用这个 以便呈现细致的形态 然后颜色需要使用这个 相似但适当不同的颜色。
- 知识点：这个压力我觉得可以 就这样保持 颜色的拼图 似乎有点过于皱缩 迷于方向 调高竖直 其他的看起来没问题 这种形态 怎么出来的 我看看 放进去应用大概这种感觉。
- 知识点：咕噜咕噜滴 生成时的感觉 可以这样看 预告不需要碰的样子 先把尺寸缩小 然后这一部分应用一下火化 现在整体上应该优先调整尺寸和颜色的部分。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Sequencer 当前时间约 `0020`，`Trails_01` 下可见 `Ultimate Small Exp 01` 和被选中的 `Ultimate Small Exp 02`，两者都带有 `Spawned` 与 `Transform` 轨道。Viewport 中角色两侧手部附近有绿色标记与选中 Gizmo，右侧 Outliner/Details 区域选中 NiagaraActor。底部 `Ultimate_Small_Exp_01` Niagara 窗口仍打开。该图记录复制第二个小爆炸实例，并将两个小爆炸分别安排到左右手附近。
> 图表转写（UE-GTXT v4）
> 材质实例 `MI_RadialUV_01_Ins...` 打开，预览为紫白色放射状小爆炸纹理。右侧 `Global Scalar Parameter Values` 中可读 `Color_Str 5.0`、`Color_Tile_U 5.0`、`Color_Tile_V 0.5`、`Desaturation 0.5`、`Diff_Tile_U 3.0`、`Diff_Tile_V 1.0`、`Edge_Pow 15.0`、`Normal_Tile_U 4.0`、`Normal_Tile_V 0.2`、`Opacity_Pow 1.0`、`Opacity_Str 10.0`、`RGB_Offset 0.0`。纹理输入包括 `Color_Tex: Space_02`、`Diff_Tex: T_Beam_Gradient`、`Normal_Tex: T_NoiseNormal_30`、`Opacity_Tex: T_BlackColor004_emis...`，Parent 为 `M_RadialUV_01`。该图记录小爆炸的放射 UV 材质实例参数。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Small_Exp_01` 打开，Preview 中显示紫色环形小爆炸，中间有横向亮线。系统包含 `Core_Sprite`、`Glow_01`、`Glow_03` 和灰显的 `Spark_02`。选中 `Core_Sprite` 的 `Camera Offset`，右侧 `Camera Offset Amount` 为 `50.0`。左侧粒子计数显示 `Core_Sprite`、`Glow_01`、`Glow_03` 活跃，`Spark_02` 禁用。该图记录小爆炸核心精灵的相机偏移和发射器结构。

### 01:09:45-01:12:38 关键流程 24

- 本段定位：关键流程 24。
- 知识点：反正只是小的8的用途 颜色值适当调整一下 红色通道 从0.3开始 到0.1 放 红色通道 从1到0.5 绿色通道 从1到0.3给 而蓝色通道现在。
- 知识点：从0.1到 刚才有点黄色太强 但现在有点紫色的混合感觉 看起来呢 还有 缩放曲线 从 到0应该可以 透明度 就保持这样 这个分数应该差不多可以 减少一下功用大小。
- 知识点：大小从150到大约100 生命时间适当减一点 0.5 偏移也都没问题 精灵大小 应该也可以直接使用 还有缩放颜色。
- 知识点：适当降低 再柔和一点 这样去应该可以 其他光效线生成的光效也暂时 减少到40左右 这个有点遮挡出来了 从0.2到 3.5 适当快一点 增大尺寸 这部分几乎没什么大问题。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `Core_Sprite` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`；曲线中红色通道从约 `1.0` 降到 `0.5`，绿色通道从约 `1.0` 降到 `0.3`，蓝色通道从低值上升到接近 `1.0`。`Scale Curve` 使用 `Multiply Vector by Float`，Float 曲线从较高值逐渐降到接近 `0`；`Scale Alpha` 曲线为先快速上升、保持后下降。Preview 中小爆炸呈粉紫色并带横向亮线。该图记录核心爆发颜色通道的紫色混合调整。
> 图表转写（UE-GTXT v4）
> `Core_Sprite` 仍选中 `Scale Color`，左侧 Preview 中小爆炸亮度更强，中心横向光线清晰。右侧 RGB VectorCurve 保持红色下降、绿色下降、蓝色上升的趋势；`Scale Curve` 的 Float 曲线继续从高值降到接近 `0`；`Scale Alpha` 曲线先升到 1 附近，保持后在末端衰减。底部 Curves 面板同步显示三条 RGB 曲线。字幕说明透明度保持当前状态、分数差不多。该图记录 Core_Sprite 颜色与透明度曲线的中间确认状态。
> 图表转写（UE-GTXT v4）
> 选中 `Glow_03` 的 `Scale Sprite Size`。右侧 `Scale Sprite Size Mode` 为 `Uniform Curve`，`Uniform Curve Sprite Scale` 使用 Float 曲线，曲线从约 `2.0` 逐渐上升到约 `3.5` 并保持。Preview 中小爆炸外圈呈柔和紫色，中心亮线仍保留；`Spark_02` 在系统概览中仍灰显。该图记录 `Glow_03` 光效层尺寸随生命周期放大的曲线。

### 01:12:43-01:15:40 关键流程 25

- 本段定位：关键流程 25。
- 知识点：颜色适当修正一下嘛 蓝色通道调到1左右 红色通道适当调低一点 不是这样 这样再这样看到了 蓝色通道适当调低 其实纸好像需要适当更改一下 红色通道适当调整强一些。
- 知识点：其他颜色通道现在调了吗 抱歉 1的直是对的 0.5是对的 是0.3吧 这个要看一下 对的5啊 2啊 1对吧 这里现在只想换红色频道 这个大约0.5。
- 知识点：大约0.5 感觉寿命也不错 好像可以了 最后适当动态参数一点 变得太快 然后我就要切换到火花了 火花也爆炸得很大了 只需要大约30个。
- 知识点：寿命 我不会碰寿命 寿命感觉不错 那么现在适当减一下 大约30 然后位置偏移设为35 适当减少代替降低速度。
- 知识点：收放速度就可以保持不变 颜色图适当修改一下 这个蓝色比例应该适当提升一下 从0.5到1。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`速度`、`颜色`、`动态参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `Glow_03` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，并通过 `Multiply Vector by Float` 乘以 Vector `X 10.0 / Y 10.0 / Z 10.0`；曲线中红色通道从约 `5` 下降，绿色通道从约 `2` 下降，蓝色通道保持较低并略微变化。Float 曲线随生命周期下降，`Scale Alpha` 曲线也逐渐衰减。Preview 中外圈变暗，紫色轮廓仍可见。该图记录 `Glow_03` 颜色强度的整体倍率和通道衰减。
> 图表转写（UE-GTXT v4）
> `Glow_03` 继续选中 `Scale Color`，右侧 RGB VectorCurve 仍显示红色高值下降、绿色中值下降、蓝色低值变化，`Scale Curve` 乘以 Vector `10.0 / 10.0 / 10.0`，Float 曲线从较高值降到低值；`Scale Alpha` 曲线在生命周期内逐步衰减。Preview 中小爆炸外圈更暗，紫色轮廓较轻。字幕说明寿命感觉不错。该图记录在不继续改寿命的前提下，继续用颜色曲线降低光效强度。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_02` 的 `Add Velocity` 模块，Preview 中紫色小爆炸周围出现约 30 个明亮火花点。右侧 `Velocity Mode` 为 `From Point`，`Velocity Speed 15.0`，`Constrain To Radius` 未启用，`Velocity Origin` 使用 `SimulationPosition`，`Origin Offset X 0.0 / Y 0.0 / Z 0.0`，`Origin Offset Coordinate Space` 为 `Local`。系统概览中 `Spark_02` 包含 `Initialize Particle`、`Shape Location: Sphere`、`Add Velocity From Point`、`Scale Color`、`Scale Velocity`、`Curl Noise Force` 和 `Solve Forces and Velocity`。该图记录小爆炸火花层的从点发散速度设置。

### 01:15:44-01:18:33 关键流程 26

- 本段定位：关键流程 26。
- 知识点：这一部分 0在时间上开始 0.5到现在为止变化和调整 从一开始就要变化才能有这种感觉 绿色频道会上传 我上传错了 0.7在这里 这个部分现在其他图表我上传错了。
- 知识点：0.5 从2到0.3 在这里 0.7到1的值为0.3 适当缩小一下尺寸 我们看一下 大约这个大小 用相机 我们来看看 看起来很好 这次我们制作了故事讲述演出的。
- 知识点：奇殿的丝带轨迹 从手上的投射开始 丝带生成并出现 下次后续会再添加一个丝带轨迹 现在是第二个动作跳跃 同时转动的动作 那个动作上再添加一个绸带轨迹。
- 知识点：根据那个绸带轨迹 会生成链条之类的 在这里退出的时候 这里后方会呈现三角形阵形 这样连接的方式来构成 在完成之前 我觉得这个聚光灯太亮了。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Small_Exp_01` 中选中 `Spark_02` 的 `Scale Color`。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 `Vector from Curve`，曲线中红色通道从较高值下降，绿色通道从约 `0.5` 降到约 `0.2`，蓝色通道从较低值上升到高值；`Scale Curve` 使用 `Multiply Vector by Float`，Float 曲线从高值逐渐降到接近 `0`；`Scale Alpha` 使用 Float 曲线衰减。`Spark_02` 发射器栈包含 `Shape Location: Sphere`、`Add Velocity From Point`、`Scale Color`、`Scale Velocity`、`Curl Noise Force`、`Solve Forces and Velocity`。该图记录火花颜色从暖色逐步转向偏蓝紫的收尾曲线。
> 图表转写（UE-GTXT v4）
> 选中 `Glow_03` 的 `Sprite Renderer`。右侧 Renderer 设置中可读 `Material User Param Binding: None`、`Alignment: Unaligned`、`Facing Mode: Face Camera`、`Default Pivot in UV Space 0.5 / 0.5`、`Macro UV Radius 0.0`、`Pixel Coverage Mode: Automatic`、`Sort Mode: None`、`Sub UV Image Size 1.0 / 1.0`。Bindings 区域显示 `Position Binding: Particles Position`、`Color Binding: Particles Color`、`Velocity Binding: Particles Velocity`、`Sprite Rotation Binding: Particles SpriteRotation`、`Sprite Size Binding: Particles SpriteSize`、`Dynamic Material Binding: Particles DynamicMaterialParameter...`。Preview 中紫色小爆炸和外围火花仍可见。该图记录 `Glow_03` 精灵渲染器绑定与面向相机设置。
> 图表转写（UE-GTXT v4）
> Level `Ex_Ultimate_01` 中以 `Pilot Active - Cine Camera Actor` 视角预览，Viewport 显示棋盘地面、上方目标角色和下方施法角色，施法角色附近有绿色方向标记与小光照区域。右侧 Outliner 包含 `Cine Camera Actor`、`Ex_Ultimate_01`、`Floor`、`Phase GDC_Hit`、`Phase GDC_PC`、`Ultimate Hand Cast 01/02`、`PostProcessVolume` 等对象；Details 当前选中 `Floor`。底部 Sequencer 当前约 `0086`，可见相机轨道和演出时间轴。该图记录用相机视角检查最终连接方式与整体构图。

### 01:19:06-01:19:18 关键流程 27

- 本段定位：关键流程 27。
- 知识点：适当把亮度降低一些 那么保存选择 这次课程辛苦大家了 那么下次课程再见。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Level Viewport 中选中 `SpotLight2`，可见聚光灯锥体线框指向场景中的角色。右侧 Details 处于 `SpotLight2 (Instance)`，Rendering 区域可读 `Affects World` 勾选、`Cast Shadows` 未勾选、`Indirect Lighting Intensity` 输入框为 `0.2`、`Volumetric Scattering Intensity 1.0`、`Intensity 8.0 cd`、`Attenuation Radius 1000.0`。底部 Sequencer 当前接近开头帧，字幕提示稍微降低亮度。该图记录最终阶段降低聚光灯亮度的参数入口。
> 图表转写（UE-GTXT v4）
> `SpotLight2` 仍被选中，Details 中 Rendering 区域继续显示 `Use Temperature` 未启用、`Temperature 6500.0`、`Affects World` 勾选、`Volumetric Scattering Intensity 1.0`、`Attenuation Radius 1000.0` 等字段。`Intensity` 输入框处于编辑状态，数值被调低到约 `1.0`。Viewport 中聚光灯锥体仍覆盖场景目标区域，底部字幕提示保存全部。该图记录完成亮度降低后准备保存资源。
> 图表转写（UE-GTXT v4）
> 最终画面仍选中 `SpotLight2`，Viewport 中聚光灯锥体、角色和棋盘地面保持在相机视野内。右侧 Details 的 Rendering 区域继续展示 `Indirect Lighting Intensity`、`Volumetric Scattering Intensity`、`Intensity`、`Light Color`、`Attenuation Radius` 等字段，`Intensity` 输入框仍处于编辑/确认状态，字幕显示课程结束语。该图记录最终灯光值确认与课程收尾画面。

## 补充视觉证据

### S01 00:01:42

> 图表转写（UE-GTXT v4）
> 补充截图显示 `Ex_Ultimate_01` Sequencer 和关卡总览。Viewport 处于 `Pilot Active - Cine Camera Actor`，画面中有两名角色、棋盘地面和局部光照。Content Browser 位于 `/Content/Tutorial/Sequencer`，可见 `CamTest_01`、`Ex_Projectile...`、`Ex_ShockWave_01`、`Ex_SpriteExp_01`、`Ex_Ultimate...`、`ExShake_01`、`ExShake_02` 等资源。Sequencer 中展开 `Cine Camera Actor > CameraComponent`，可读 `Current Aperture 2.8`、`Current Focal Length 35.0`、`Intensity (Post Process Setti...) 3.0`、`Manual Focus Distance 100000.0`、`Size scale (Post Process Setti...) 2.0`、`Spawned` 勾选；下方还有 `Phase GDC_PC`、`Phase GDC_Hit` 等轨道。该补充图记录本段演出资源、相机轨道和角色轨道的整体关系。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

