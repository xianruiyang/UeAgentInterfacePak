# 25RibbonTrail元素2制作

# 25RibbonTrail元素2制作

## 关键术语

- `Lifetime`、`Velocity`、`Alpha`、`Ribbon`、`Beam`、`Material`、`UV`、`Multiply`、`Normal`、`Curve`、`材质`、`粒子`、`Niagara`、`Emitter`、`Particle`、`Spawn Rate`、`Niagara System`、`Spawn`

## 分段知识

### 00:00:05-00:04:42 粒子

- 本段定位：粒子。
- 知识点：您好,在25光油中致以问候 上次我们尝试制作了第一部分的轨迹 因此这样就在文件夹内进行了分离 这次我们要除了最初的那个伸手动作之后。
- 知识点：接下来跳起来旋转 伸出的动作是绳索动作的某个手部的绳索效果 以及小的集中效果也试着制作一下 在写之前我们觉得背景图有点亮 这个就无论如何。
- 知识点：相机会以这种方式捕捉 所以这个角色现在主要是背影 这个角色更明显 所以想适当去掉聚光灯 整体照明似乎太亮 需要适当改变一下这个方向 这样做。
- 知识点：觉得这样看可能更好 似乎更舒适一些 那么在这种状态下我就会继续进行 首先把这个文件夹收起 制作第一部分 然后新建文件夹 叫做锥字 需要做,我还会做。
- 知识点：顺序改变一下 反正要再做一个丝带托盘 所以就把第一次的项目复制过来 在这里进行修改后使用 就这样 在轮廓方面也会这样进行很多工作 项目2的名字已经存在了。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`Particle`、`粒子`、`用户参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，Viewport 显示棋盘地面、上下两个角色和中间白色效果对象。Sequencer 当前在起始帧附近，`Trails_01` 分组被选中，内部可见 `Ultimate Projectile 01/02`、`Ultimate Hand Cast 01/02`、`Ultimate Small Exp 01/02` 等轨道，部分 `Spawned` 与 `Transform` 轨道展开。Content Browser 位于 `/Content/Tutorial/Sequencer`，选中 `Ex_Ultimate...` 资源。该图记录上一段轨迹与手部粒子的时间轴状态，作为复制制作第二段轨迹的起点。
> 图表转写（UE-GTXT v4）
> 以 `Pilot Active - Cine Camera Actor` 视角查看关卡，Viewport 中角色、白色目标点和手部方向标记位于棋盘地面上。Sequencer 当前约 `0007`，上方可见 Camera Cuts 缩略帧；左侧轨道包含 `Camera Cuts`、`Cine Camera Actor`、`Phase GDC_PC`、`Phase GDC_Hit`、`Trails_01`，并新建了 `Trails_02` 分组。Content Browser 位于 `/Content/Tutorial/Particle/Ex_04`，选中 `Ultimate_Projectile...` 资源，旁边还有 `Ultimate_Hand...` 与 `Ultimate_Small_E...`。该图记录新建第二段轨迹分组并准备复制第一段投射物资源。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Projectile_02` 打开，System Overview 中包含 `Source`、`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02`、`Light_01`、`Spark_01` 等发射器。左侧 Timeline 显示 `Light_01`、`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02`、`Source`、`Spark_01` 的绿色时间段，当前时间约 `2.36`。Preview 计数显示 `Source` 完成，`Ribbon_Core_01`、`Ribbon_Main_01`、`Ribbon_Main_02` 和 `Spark_01` 活跃。字幕提示这里再次使用用户参数。该图记录第二段投射物系统复制后的发射器结构。

### 00:04:42-00:09:34 Velocity、粒子、发射器

- 本段定位：Velocity、粒子、发射器。
- 知识点：现在在第二个粒子中做的 用3的particle来控制time particle的部分。
- 知识点：会有点类似于这个 所以先关闭 然后一个一个调整 要删除了 看一下 首先需要3的发射器 然后Ret Velocity会再创建一下 发射器设置为3个。
- 知识点：生命时间设置为大约0.6秒 大小设为大约15和40 将velocity向前发送大约1200 然后用showing location设置为球体。
- 知识点：给50亚小只把x轴改为0.1 你应该记得之前做的那个 然后Ret Velocity再加一个 从点给你提供大约135的数值 显示位置在这里。
- 知识点：deep mining打开 用固定值种子 用5号种子来使用 接下来在Skull Velocity调整一下图表 x轴开始是慢慢的然后逐渐变快。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`Velocity`、`粒子`、`发射器`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ultimate_Projectile_02` 中选中 `Source` 的 `Add Velocity Linear`。右侧 `Velocity Mode` 为 `Linear`，Velocity 可读 `X 400.0 / Y 350.0 / Z -250.0`，`Velocity Speed Scale 1.0`；Rotation 区域显示 `Rotation Mode: Default`、`Rotation Coordinate Space: Local`。System Overview 中 `Source` 包含 `Initialize Particle`、`Add Velocity Linear`、`Particle State`、`Scale Velocity`、`Solve Forces and Velocity`、`Scale Color`、`Sprite Renderer`。该图记录第二段 Source 的线性初始速度。
> 图表转写（UE-GTXT v4）
> 选中 `Source` 的 `Scale Velocity`，右侧 `Coordinate Space` 为 `Local`，`Velocity Scale` 使用 `Vector from Curve`。曲线中红色 X 通道从低值逐步升到约 `2`，绿色 Y 通道从约 `5` 快速下降到负值后保持，蓝色 Z 通道保持较低变化；底部 Curves 面板同步显示三通道曲线，红色曲线末端提示 `Time 1 / Value 2`。Preview 中可见少量白色粒子。该图记录 Source 速度缩放曲线，用于让轨迹开始慢、后续拉开。
> 图表转写（UE-GTXT v4）
> 选中 `Ribbon_Core_01` 的 `Spawn Particles from Other Emitter`。右侧 `Particle Attribute Reader` 中 `Emitter Name` 为 `Source`，`Spawn Rate 20.0`，`Calculate Spawn Rate Per Particle` 未勾选，`Spawning Enabled` 勾选；`Minimum Age Spawn Thresh` 约 `0.333`，`Maximum Age Spawn Thresh` 约 `1.0`。System Overview 中 `Ribbon_Core_01` 的 `Emitter State` 为 `Self Infinite`，并从 `Source` 采样生成 Ribbon 粒子。该图记录核心 Ribbon 从 Source 发射器采样的生成关系。

### 00:09:34-00:14:21 材质、粒子

- 本段定位：材质、粒子。
- 知识点：一个一个开启来看 这个可能需要ID 因为会同时制作三个 所以这次先开核心 这样现在ID没有了 这样现在ID没有设置 所以这样出来的话 那边的中段。
- 知识点：好像是因为缺少赞助 对吗 被抢走了 先用一几 不使用无限改为一次性 生命周期是0.3 如果是0.3就行 需要抓住非常短的时机 扭曲部分似乎可以保持不变。
- 知识点：这一部分就像以前提供的随机值一样 换成随机范围的前置 然后用种子值作为例子 ID记得吧 所以这里用表达式 用固定的 像这样写 溶解部分可以保持原样。
- 知识点：还有颜色的部分 看起来也可以保持不变 然后现在需要删除一个主控 我觉得不需要两个 这里只需添加一个ID 就这样做吧 接下来需要把生命周期设置为0.5。
- 知识点：适当长一点 在这里用AR 不一样 需要换成Undanness模式 同样需要用粒子i 然后这里的部分 应该关闭吧 其他时针或这里的溶解应该可以不换。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`粒子`、`生命周期`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `Source` 的 `Emitter Properties`。右侧 CPU Emitter Properties 中 `Local Space` 勾选，`Determinism` 未勾选，`Random Seed 0`，`Sim Target CPUSim`，`Interpolated Spawning` 勾选，`Requires Persistent IDs` 勾选；Scalability 显示 Low/Medium/High/Epic/Cinematic 按钮。`Emitter State` 区域可见 `Life Cycle Mode: Self`、`Inactive Response: Complete`、`Loop Behavior: Once`、`Loop Duration Mode: Fixed`、`Loop Duration 1.0`，下方 `Spawn Burst Instantaneous` 的 Spawn Count 为 `3`。该图记录 Source 发射器的一次性循环、局部空间和固定 ID 设置。
> 图表转写（UE-GTXT v4）
> 选中 `Ribbon_Main_01` 的 `Initialize Particle`。右侧 `Lifetime Mode` 为 `Direct Set`，`Lifetime 0.5`；`Position Mode` 为 `Simulation Position`；Ribbon Attributes 中 `Ribbon Width Mode: Direct Set`，`Ribbon Width 150.0`。System Overview 中 `Ribbon_Main_01` 为 `Self Infinite`，包含 `Sample Particles from Other Emitter`、`Dynamic Material Parameters`、`Scale Ribbon Width`、`Scale Color` 和 `Ribbon Renderer`。Preview 中可见粉红色短条状 Ribbon 片段。该图记录主 Ribbon 粒子的短生命周期和初始宽度。
> 图表转写（UE-GTXT v4）
> 材质实例 `MI_Ribbon_01_Ins_03` 打开，预览为黑底上的白灰色撕裂状 Ribbon 纹理。右侧 `Global Scalar Parameter Values` 可读 `Black_Bias 2.0`、`Color_Tile_U 0.5`、`Color_Tile_V 0.5`、`Desaturation 0.0`、`Edge_Pow 1.5`、`Edge_Str 200.0`、`Normal_Tile_U 0.6`、`Normal_Tile_V 0.3`、`Opacity_Pow 0.5`、`Opacity_Str 15.0`、`Opacity_Tile_U 1.2`、`RGB_Offset 0.0`。Texture 参数中 `Color_Tex` 为 `T_Cloud_Wisp_Chromatic_Tile`，`Normal_Tex` 为 `T_NoiseNormal_01`，`Opacity_Tex` 使用黑白裂纹类贴图；Parent 为 `M_Ribbon_01`，Blend Mode 为 `Translucent`。该图记录第二段 Ribbon 的黑白撕裂材质基础。

### 00:14:24-00:19:16 关键流程 04

- 本段定位：关键流程 04。
- 知识点：做了一下 那么现在倒线的部分已经制作好了 在这个状态下再看看 是不是正确的出来 位置好像对的 圆的部分 只适当 靠内聚集一下 然后这一部分不要太死板。
- 知识点：这样 在一定程度上这里身体 会倒的样子 来源少一点的理由 在这一部分 火花部分 添加一下 暂时Bosco Gassmo 5.00左右就行了 这里。
- 知识点：应该换成1.400 生命时间适当减少一下吗 这里也可能基础布置是ID 以ID进行 阴影位置 大小应该不需要改动 20左右就行了 颜色保持不变。
- 知识点：应该可以 颜色也大致能合得上 相机试图看一下 没有转动呢 换过了 火花部分似乎有点太亮了 适当亮一点 颜色调节部分适当减少一下吧。
- 知识点：大概1200左右 时间拉到0.2 似乎适当好一点 尺寸适当减小一点 这些颗粒太显眼 会不太好呢 现在状态似乎不错 希望你能随时保测 这样一直看。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 选中 `Ribbon_Main_01` 的 `Ribbon Renderer`。右侧 `Material` 为 `MI_Ribbon_01_Ins_03`，`Material User Param Binding: None`，`Facing Mode: Screen`；`UV0 Settings` 中 `UV Mode: Tiled By Distance (By Particles.RibbonUVDistance)`，`Tiling Length 200.0`，Offset `0.0 / 0.0`，Scale `1.0 / 1.0`；`UV1 Settings` 的 `Draw Direction` 为 `Front to Back`；`Ribbon Shape` 为 `Plane`，`Width Segmentation Count 1`，`Multi Plane Count 2`，`Tube Subdivisions 3`。该图记录主 Ribbon Renderer 的材质、屏幕朝向与 UV 平铺方式。
> 图表转写（UE-GTXT v4）
> 选中 `Spark_01` 的 `Initialize Particle`。右侧 `Lifetime Mode` 为 `Random`，`Lifetime Min 0.6`，`Lifetime Max 0.4`；`Color Mode` 为 `Unset`；`Position Mode: Simulation Position`。Sprite Attributes 中 `Sprite Size Mode: Random Non-Uniform`，`Sprite Size Min X 2.0 / Y 4.0`，`Sprite Size Max X 3.0 / Y 6.0`；Sprite Rotation 和 UV Mode 均为 Unset。Preview 计数显示 `Spark_01` 活跃约 `8`，最大估计约 `284`。该图记录火花层的随机生命周期和非均匀尺寸范围。
> 图表转写（UE-GTXT v4）
> 回到关卡相机视图检查 `Ex_Ultimate_01`，Viewport 中施法角色附近出现两团明亮白粉色小爆发和少量飞散粒子。右侧 Outliner 选中 `DirectionalLight`，Details 显示 `DirectionalLight (Instance)`；底部 Sequencer 当前约 `0018`，上方 Camera Cuts 缩略帧显示多段亮光变化。底部还打开 `Ultimate_Projectile_02` Niagara 窗口，当前选中 `Spark_01` 的 Initialize Particle。该图记录在相机中检查第二段轨迹和火花初始效果。

### 00:19:16-00:24:04 Lifetime、Multiply

- 本段定位：Lifetime、Multiply。
- 知识点：需要复制这个光源来用 把光的部分也放进去试试 用这个光源 把光的部分也放进去试试 用0.1来调整 光源就是一个就足够了 寿命也一 我这个不需要球体。
- 知识点：从这个点也不需要吧 直线飞过去 红色速度在这里 最轴的值被填入了 我就会去掉它 这样 然后scale height 无关系 这里用multiply。
- 知识点：vector by plot 然后只需要放大 light render半径10也高亮 大约是 看到了 刚好看起来 那么现在这里循环部分 持续进行的简单子效果元素。
- 知识点：一些添加一下 我们比起现在开始的添加 我们以前做的particle中 有个叫small x pad的 打开它 这四个复制一下 适当变形 所以这里etc过来这里用。
- 知识点：带到这里来用 会比较好 这些原本是会用做burst的东西 但是会变成循环 然后循环制作 并且序列也一次调成循环形式 那么从更新部分开始。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`Lifetime`、`Multiply`、`序列`、`生命周期`、`速度`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ultimate_Projectile_02` 中选中 `Source`，右侧显示 `Emitter Properties` 与 `Emitter State`。`Local Space` 勾选，`Sim Target CPUSim`，`Interpolated Spawning` 与 `Requires Persistent IDs` 勾选；`Life Cycle Mode: Self`，`Inactive Response: Complete`，`Loop Behavior: Once`，`Loop Duration Mode: Fixed`，`Loop Duration 1.0`。下方 `Spawn Burst Instantaneous` 的 `Spawn Count` 为 `3`。左侧 Timeline 显示 `Ribbon_Core_01`、`Ribbon_Main_01`、`Source`、`Spark_01` 等时间段，字幕提示复制光源来用。该图记录在加入光效前回到 Source 的一次性发射设置。
> 图表转写（UE-GTXT v4）
> 选中 `Light_01` 的 `Light Renderer`，中间弹窗显示正在保存 `/Game/Tutorial/Particle/Ex_04/Ultimate_Projectile_02`，进度约 `78%`。右侧 `Light Rendering` 中 `Use Inverse Squared Falloff` 勾选，`Affects Translucency`、`Alpha Scales Brightness` 未勾选，`Radius Scale 10.0`，`Color Add` 为 `10.0 / 10.0 / 10.0`，`Renderer Visibility 0`；Bindings 中 `Renderer Enabled Binding: None`。Preview 计数显示 `Light_01` 活跃。该图记录光源渲染器的半径和颜色增强参数，并保存第二段 Niagara 资源。
> 图表转写（UE-GTXT v4）
> 同时打开 `Ultimate_Projectile_02` 与 `Ultimate_Small_Exp_01` 标签。System Overview 中出现从小爆炸系统复制来的发射器：`Glow_01`、`Glow_03`、`Core_Sprite`，并与 `Ribbon_Core_01`、`Ribbon_Main_01`、`Light_01`、`Source`、`Spark_01`、`Spark_02` 等并列。选中 `Glow_01` 的 `Camera Offset`，右侧 `Camera Offset Amount` 输入为 `10`。左侧 Timeline 中 `Glow_01` 时间段被选中，Preview 显示一条横向柔光。该图记录从 `Ultimate_Small_Exp_01` 复制光效层到第二段投射物系统，并调整 `Glow_01` 相机偏移。

### 00:24:04-00:29:00 Lifetime

- 本段定位：Lifetime。
- 知识点：太具体的感觉 就看起来也不太好 这样应该可以 然后同样这个朋友也 增加duration 减少rate重复生成 同样lifetime随机为1.2左右。
- 知识点：会复上 这样出来 编译后出来的东西看起来 复制使用时好像没有更新 然后在colloger部分 去掉这个scale大小去这个 多增加一些波动性。
- 知识点：两边是数字的温度 波动性两边是数值1 中间大约这样 而且尺寸也随机性 随机均于100-75左右 现在颜色非常强烈。
- 知识点：不需要使用向亮 就这样使用单一颜色 需要把它向前移动0.1 然后灵会 这样使用可以吧 差不多像镜头播放器一样 感觉被创造出来了 给这个纹理平衡的感觉。
- 知识点：希望每种都能持续生成 所以这个是循环模式 用无限的方式 持续重复生成 然后得分可以一个一个来 一秒感觉太长了 就有点重复 重叠的部分有点明显。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Lifetime`、`纹理`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Projectile_02` 打开，System Overview 中已加入来自 `Ultimate_Small_Exp_01` 的 `Glow_01`、`Glow_03`、`Core_Sprite`，并保留 `Ribbon`、`Source`、`Spark_01`、`Spark_02`、`Light` 等发射器。当前选中 `Glow_01` 的 `Scale Color` 模块，右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 Direct Set，值为 `X 5.0 / Y 2.0 / Z 1.0`；`Scale Alpha` 为 Float from Curve，曲线先快速升高再向生命周期末端衰减到 0。Preview 中可见一条较薄的水平发光带，`Glow_01` 计数约为 current 3 / max 6。该图记录第一层 Glow 的颜色倍率和透明度衰减。
> 图表转写（UE-GTXT v4）
> 当前选中 `Ultimate_Projectile_02` 中 `Glow_03` 的 `Scale Color` 模块。右侧 `Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 Direct Set，值为 `X 5.0 / Y 1.0 / Z 1.0`；`Scale Alpha` 使用 Float from Curve，曲线在前段快速出现，随后逐步下降。Preview 中粉紫色弧形光带比上一层更明显，`Core_Sprite` 与 `Spark_02` 在左侧时间轴处于关闭或未参与显示状态，`Glow_03` 计数约为 current 2 / max 3。该图记录第二层 Glow 的颜色倍率和透明度变化。
> 图表转写（UE-GTXT v4）
> 当前选中 `Core_Sprite` 的 `Spawn Burst Instantaneous` 模块。右侧参数中 `Spawn Count` 为 `1`，`Spawn Time` 为 `0.0`，`Loop Count Limit` 字段灰显。Preview 时间约 `9.34`，画面中央是紫色圆形核心和横向透镜式发光线，周围仍有轨迹系统的其他发射器列表。该图记录核心精灵只在起始瞬间生成一个粒子，用于集中爆发中心。

### 00:29:00-00:33:41 Alpha

- 本段定位：Alpha。
- 知识点：大约一二五程度适当少减一点 但是这种循环效果的情况 现在内部填充是从里面到外面 反过来改变会好一点 这种方式 而且 外国只是不改也行的。
- 知识点：位置只是调整一下张密度 适当一点 并且 缩放曲线值有点强 自然感觉的程度 颜色只是适当 修改是有必要的 红色通道维持一致 浮通道大约零点五 紫色适当增加。
- 知识点：这样重叠的方式在创建这个抄袭时 Alpha彼此表达 持续强的指位是也没关系 这种感觉应该可以去 比如说点亮火花 火花现在是扩散的方式爆发。
- 知识点：但要让它一直聚集在内部 所以 需要给你大约五秒 这一部分都已经完成了 但需要改成杀死 反正 一旦无效就马上消失 这样做 我觉得需要大幅减少生命周期。
- 知识点：生成 速度 只生成大约一百个 大小应该可以不用修改 适当增加到 将形状位置放大 让它们聚集在内部技能速度会删除。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`生命周期`、`速度`、`颜色`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 当前选中 `Core_Sprite` 的 `Initialize Particle` 模块。右侧 `Lifetime Mode` 为 Direct Set，`Lifetime` 为 `1.0`；`Color Mode` 为 Unset；`Position Mode` 为 `Simulation Position`；`Sprite Size Mode` 为 Uniform，`Uniform Sprite Size` 为 `125.0`；`Sprite Rotation` 与 `UV Mode` 未设置。Preview 中核心为紫色圆形光球，中央带水平亮线。该图记录核心精灵的生命周期、生成位置来源和统一尺寸。
> 图表转写（UE-GTXT v4）
> 当前选中 `Core_Sprite` 的 `Scale Color` 模块。`Scale Mode` 为 `RGB and Alpha Separately`，`Scale RGB` 使用 Vector from Curve：红色通道基本保持高值，绿色通道从高值逐步降到约 `0.5`，蓝色通道由低值逐步升高到高值；下方 `Scale Curve` 为 Multiply Vector by Float，Vector 为 `1 / 1 / 1`，FloatCurve 提供整体强度变化。`Scale Alpha` 使用 FloatCurve，曲线先升到强值再逐步淡出。Preview 显示紫色核心光球和横向光线。该图记录 Core 的颜色渐变与 Alpha 淡出。
> 图表转写（UE-GTXT v4）
> 当前选中 `Spark_02` 的 `Curl Noise Force` 模块。右侧参数为 `Noise Strength 300.0`、`Noise Frequency 15.0`、`Noise Quality/Cost Baked (Medium)`，`Mask Curl Noise` 未勾选。Preview 中紫色核心外侧分布少量亮点粒子，`Spark_02` 计数约为 current 51 / max 58。该图记录 Spark 层使用 Curl Noise 形成围绕核心扰动的设置。

### 00:33:41-00:38:35 粒子、发射器、系统

- 本段定位：粒子、发射器、系统。
- 知识点：试试 几乎完成了 颜色值 现在似乎也不坏 在音讯器中看一看 这里首先要设置成循环阶段 在这里大大在我们要消失的时机 大约一九零针时消失 因为会马上变动。
- 知识点：大约在九十针时 在这里添加耐落组件 然后添加FX系统切换轨道 然后在这里 一九零针时让其停用 在之前的针是激活的 那么这里就会生成 到这里区间效果会一直循环出来。
- 知识点：会出来 看起来不错 出乎意料的是那些火花部分不太显眼 适当让它在眼中显现 去掉 比尺寸更想要颜色值。
- 知识点：需要适当让它凸起 把自由发挥的时间适当放慢 需要以这种方式尝试修改 适当更好吧 暂时在这种时刻 看不太清楚的火花部分 这样东西最终要到一定程度。
- 知识点：在演出构成的状态下 一个一个再调整 现在这样感觉可以适当合适 那么最重要的部分要再加一个 我们无论如何 这样构成这个演出的原因之一就是。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 核对对象：`粒子`、`发射器`、`系统`、`渲染器`、`颜色`、`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 仍选中 `Spark_02` 的 `Curl Noise Force` 模块，参数保持 `Noise Strength 300.0`、`Noise Frequency 15.0`、`Noise Quality/Cost Baked (Medium)`，`Mask Curl Noise` 未勾选。Preview 中紫色核心周围的粒子比上一帧更清晰，`Spark_02` 计数约为 current 52 / max 59。字幕说明这种效果像是在吸引周围力量。该图记录 Curl Noise 后 Spark 围绕核心聚集的视觉结果。
> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，Viewport 中角色附近可见紫色核心效果。Sequencer 当前约 `0165` 帧，在 `Trails_02` 分组下展开 `Ultimate Center Projectile_01` 与 `NiagaraComponent0`，可见 `FX System` 轨道，事件区间显示为 `Activate`，`Spawned` 处于勾选状态。时间轴上该 Niagara 组件在当前段落内保持激活，用于让第二段轨迹效果在指定帧段循环播放。底部另有 Niagara 编辑器窗口作为参考。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Projectile_02` 中新增 `StaticBeam` 发射器并选中 `Beam Emitter Setup`。Preview 显示一条蓝色斜向光束，`StaticBeam` 计数为 current 100 / max 100。右侧 `Beam Start` 为 `Simulation Position`，`Absolute Beam Start` 已勾选；`Beam End` 直接设置为 `X 200.0 / Y 200.0 / Z 0.0`，`Absolute Beam End` 未勾选；`Use Beam Tangents` 未勾选。`StaticBeam` 堆栈包含 `Emitter State Self Infinite`、`Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Color`、`Solve Forces and Velocity`、`Ribbon Renderer`。该图记录静态 Beam 发射器的基础端点和模块结构。

### 00:38:35-00:43:25 Beam、UV、材质

- 本段定位：Beam、UV、材质。
- 知识点：类似线条的效果 而构成这条线的方式与丝带渲染器相同 非常简单 因此 这里的默认值是模拟位置表示中心值 这样理解 因此水材质结构与丝带水材质的构建几乎相同。
- 知识点：首先我们需要准备一个水材质 然后开始 那个水条 那个水材质是我们之前 工作过的 Monderboard 袋子 大师材料适当简单修改 复制 袋子名称更改为Beam。
- 知识点：打开进行 以前我们魔法阵材料制作 实应这些参数删除 不掉吧 简单更改进行 但是通常基本的平铺 或者颜色控制适当保留。
- 知识点：进行动态 形式有扭曲 所以这里部分是不必要的 这里部分直接UV插入 这个曲线有倍率 AZ连金钱突发平铺 直接创建 这样删除部分也不需要 因为用刀去掉也会很简单。
- 知识点：这样去形的通 不过这里需要加R型 而且这里不需要电源控制 需要直接连接到LR 不过这里的颜色部分。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`纹理`、`渲染器`、`速度`、`颜色`、`透明度`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 继续查看 `StaticBeam` 的 `Beam Emitter Setup`。Preview 中蓝紫色光束从核心区域向一侧延伸，左侧 `StaticBeam` 计数仍为 current 100 / max 100。右侧保留 `Beam Start: Simulation Position`、`Absolute Beam Start` 勾选、`Beam End X 200.0 / Y 200.0 / Z 0.0`、`Absolute Beam End` 未勾选、`Use Beam Tangents` 未勾选。字幕说明线的构造方式与 Ribbon Renderer 类似。该图记录 Beam 初始形态与 Ribbon 构造思路的衔接。
> 图表转写（UE-GTXT v4）
> Material `M_Beam_01` 打开，左侧预览为黑底白色条纹状光束材质。Details 中 Material Domain 为 `Surface`，Blend Mode 为 `Translucent`，Shading Model 为 `Unlit`，`Cast Ray Traced Shadows` 已勾选。图中可见 UV 与法线扰动片段：若干 Texture Coordinate/参数节点进入 `Append` 和 `Add(+)`；`Normal_Tile_U`、`Normal_Tile_V` 进入 `Append` 后参与 `Multiply`；`Normal_Tex` 纹理采样经过 `Mask(R)` 后接入乘法链；`Opacity_Tile_U` 与常量 `1` 组成 `Append` 并继续连接到右侧未完全显示的透明度采样逻辑。Stats 显示 Texture samplers 4/16、Pixel Shader texture lookups 5。该图记录 Beam 材质的基础属性和 UV/Normal/Opacity 前段节点。
> 图表转写（UE-GTXT v4）
> `M_Beam_01` 材质图显示 Normal 与 Opacity 的滚动采样片段。`Normal_Tex` 纹理采样进入 `Mask(R)` 后接入 `Multiply`；`Opacity_Tile_U`、`Opacity_Tile_V` 进入 `Append`，再与 `OpacityU_Speed` 参与 `Multiply`；`Time` 与常量 `0` 组成 `Append` 并输入 `Panner`，`Panner` 的坐标结果进入 `Add`，随后连接到 `Opacity_Tex` 纹理采样。右侧还能看到 `Edge_Pow`、`Opacity_Pow` 等参数节点的部分区域。左侧材质预览仍为黑底白色条纹。该图记录透明度纹理随时间平移的节点链。

### 00:43:25-00:48:14 Multiply、材质、光束

- 本段定位：Multiply、材质、光束。
- 知识点：拿出来 制作颜色渐变 默认只为 0.5 0.5 1 0.5 现在某个势力的颜色 作为默认使用 这里进行呈法 下一个也这样呈法 使用它 那么这里的方向从0到1。
- 知识点：渐变吧 Bias什么 控制 除了那个黑色改成颜色 这样用的话应该可以 最后在默认上适当改一下 侧面 就是放0.3左右 不透明度唯一的指纹 是素貌JT-A-S-T-I-D-P-B-T。
- 知识点：颜色 指U适当调整一下 纹理是 资源适当改一下 用简单的法线贴图 把线条改成这种线 更改这个值的原因是 像这个主材质一样。
- 知识点：现在可以使用 直接插入使用 未来也可以用作秘密 这里也作为参数 结束颜色 用初始颜色 秘密 颜色纹理也用这个。
- 知识点：几乎完成了 颜色发光 怎么会不是 低压力程度 需要增强透明度 因为会用黑色调 那么看起来完成了 这样使用 都好了 我这里连接一下 现在这样出来的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Multiply`、`材质`、`纹理`、`贴图`、`颜色`、`透明度`、`曲线`、`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `M_Beam_01` 材质图进入黑色偏移与边缘控制片段。左侧 Details 显示当前选中 Constant Vector，`R/G/B` 均为 `0.0`。图中可见两个黑色 Constant3Vector 节点、`Black_Bias` 参数接入 `Power`，并与 `Edge_Str`、`Desaturation` 等参数共同进入 `Lerp` 与 `Multiply` 链；`Lerp` 标注输入大致为 `0 / 1 / 0.5`。该图记录光束材质中用于压暗、边缘强度和去饱和控制的节点片段。
> 图表转写（UE-GTXT v4）
> 当前选中 `Color_Tex` 纹理参数，Details 中 `Parameter Name` 为 `Color_Tex`，`Sort Priority` 为 `32`，纹理资产显示为 `T_CloudScape_08_Details`。材质图中 `Color_Tex` 纹理采样进入 `Desaturation`，其 Fraction 由 `Desaturation` 参数控制；`Start_Color` 参数为偏紫色 `(1.0, 0.5, 1.0, 1.0)`，`End_Color` 参数为偏粉色 `(1.0, 0.5, 0.5, 1.0)`，两者进入 `Lerp`，结果再与去饱和后的纹理进行 `Multiply`。预览中光束条纹呈粉白色。该图记录 Beam 颜色贴图、起止颜色渐变和去饱和控制。
> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Projectile_02` 中选中 `StaticBeam` 的 `Emitter State`。Preview 显示紫色核心、周围火花和一条延伸光束，`StaticBeam` 计数为 current 100 / max 100。右侧 `Emitter State` 中 `Life Cycle Mode` 为 `Self`，`Inactive Response` 为 Complete，`Loop Behavior` 为 `Infinite`，`Loop Duration` 为 `4.0`，`Loop Delay` 为 `0.0`。下方 `Beam Emitter Setup` 使用 `Beam Start: Simulation Position`，`Beam End` 改为 `Make Vector`：X 由 `Multiply Float` 得到，A 为 `650.0`、B 为 `1.0`，Y 为 `0.0`，Z 为 `0.0`。`Spawn Burst Instantaneous` 中 `Spawn Count` 为 `100`，`Spawn Time` 为 `0.0`。该图记录 StaticBeam 的循环状态、最终长度参数和生成数量。

### 00:48:14-00:52:53 Alpha、Ribbon、Multiply

- 本段定位：Alpha、Ribbon、Multiply。
- 知识点：这样在循环结束时 是的,侦探就会消失 那么我再改一下 这东西单独删除 直接做成线 用1的纸直接用 这里把Scale Curve增大到150左右。
- 知识点：形状现在出来了 这样某种 感觉力量不断传递 会以注入力量的方式使用 现在非常浓密到这纹理的轮廓。
- 知识点：出来了 但这是我编辑纹理是做错的 所以这种错误也是不能犯 我们无论如何在这里会很弱 所以就不会显露出来 不需要担心 外轮廓只是适当改动 适当有点晃动的感觉。
- 知识点：颜色做成Scale 颜色会空出 这里只有一个Multiply Curve 调整一下亮度 需要看着大约10的纸使用 先调整Alpha Alpha也会做。
- 知识点：重要的是 现在默认的 Curve Index设置为 Normalize这部分 现在逐步生成的带子 是用这个写的 Normalize as。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：Renderer 决定最终可见形态；Sprite、Mesh、Ribbon 的材质、朝向、排序和尺寸语义不同。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Alpha`、`Curve`、`Multiply`、`纹理`、`粒子`、`颜色`、`曲线`、`光束`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ultimate_Projectile_02` 中选中 `StaticBeam`。右侧 `Emitter State` 显示 `Life Cycle Mode: Self`，`Inactive Response` 为 Kill，`Loop Behavior` 为 `Once`，`Loop Duration Mode` 为 Fixed，`Loop Duration` 为 `5.0`，`Loop Delay` 为 `0.0`。`Beam Emitter Setup` 中 `Beam Start` 为 `Simulation Position`，`Absolute Beam Start` 已勾选；`Beam End` 使用 `Make Vector`，X 由 `Multiply Float` 得到，A 为 `650.0`、B 为 `1.0`，Y/Z 为 `0.0`。`Spawn Burst Instantaneous` 为 `Spawn Count 100`、`Spawn Time 0.0`。Timeline 中 `StaticBeam` 绿色段延伸到约 5 秒，Preview 计数显示该发射器完成。该图记录 Beam 从无限循环改为一次性 5 秒持续，并保留 100 条 Ribbon 粒子生成。
> 图表转写（UE-GTXT v4）
> 当前仍在 `StaticBeam`，选中 `Scale Color` 模块并打开输入选择菜单。`Scale Mode` 为 `RGB and Alpha Separately`；`Scale RGB` 使用 `Multiply Vector by Float`，Vector 为 `X 1.0 / Y 1.0 / Z 1.0`，Float 选择 `Float from Curve`，曲线在左下 Curves 面板中从约 `10` 随归一化进度下降到 `0`。右侧菜单候选包含 `Float from Curve`、`Lerp Float`、`Multiply Float`、`Random Range Float` 等 Niagara 输入。该图记录 Beam 颜色强度通过曲线控制，并准备按 Ribbon 顺序或归一化进度驱动。
> 图表转写（UE-GTXT v4）
> `StaticBeam` 的 `Scale Color` 参数已展开。`Scale RGB` 仍为 `Multiply Vector by Float`，Vector 为 `1 / 1 / 1`，FloatCurve 从高值快速下降到接近 0，`CurveIndex` 使用 `Particles.RibbonLinkOrder`，`Scale Curve` 为 `1.0`。`Scale Alpha` 为 `Float from Curve`，Alpha 曲线整体约在 `0.2` 附近并在末端保持低值，`CurveIndex` 同样使用 `Particles.RibbonLinkOrder`。Preview 中光束呈粉白色细线并伴随核心光效和火花，`StaticBeam` 当前 100 / 100。该图记录 Beam 沿 RibbonLinkOrder 逐步衰减亮度和透明度。

### 00:52:53-00:57:26 Lifetime、Velocity、Beam

- 本段定位：Lifetime、Velocity、Beam。
- 知识点：这样会比较好 然后再加一个 刚才在这里 Being made Setup 就是我控制这里的曲线 这个Beam effect 要动画化的话 在这里更新部分。
- 知识点：搜索Beam 就可以找到更新的Beam 一定要创建这个 最后有这个 这个更新笔 这里和Beam相关的这些数值 才会每帧更新 在这里用Platform。
- 知识点：Cover 创建B部分 一开始生成时 我就想让它生成 原本是这种曲线 现在看起来逐渐缩小 随时间推移长度向暗点点缩小 感觉力量变弱了 临时生成时。
- 知识点：定时约0.15 完成时 这里的点增多可见 这次训练进行时 定时走出可行 这样方式调整可行 几乎完成了 现在的循环中 仅需持续一个光点 所以现在不需要Velocity。
- 知识点：改成前 Lifetime改为5 限制持续5秒 只可保持 最后确认一下 这样出去 这个Beam和现在这个Triangle的方向 现在调整 让它看起来更像一个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Lifetime`、`Velocity`、`粒子`、`曲线`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `StaticBeam` 仍选中 `Scale Color`。System Overview 中可见 `Core_Sprite`、`Spark_02`、`StaticBeam` 三个发射器并列，`StaticBeam` 堆栈包含 `Emitter State Once`、`Beam Emitter Setup`、`Spawn Burst Instantaneous`、`Initialize Particle`、`Spawn Beam`、`Beam Width`、`Particle State`、`Solve Forces and Velocity`、`Dynamic Material Parameters`、`Scale Color`、`Ribbon Renderer`。右侧 RGB 与 Alpha 曲线均继续使用 `Particles.RibbonLinkOrder` 作为 CurveIndex。Preview 中光束由核心向外延伸，整体亮度随条带顺序衰减。该图记录 `Scale Color` 调整后的 Beam 模块顺序和预览状态。
> 图表转写（UE-GTXT v4）
> `Ultimate_Projectile_02` 中新增或复制了 `Light_01001`，当前选中其 `Initialize Particle`。右侧参数为 `Lifetime Mode: Direct Set`，`Lifetime 0.6`；`Color Mode: Direct Set`，颜色数值约 `R 50.0 / G 50.0 / B 50.0 / A 1.0`；`Position Mode: Simulation Position`。Sprite Attributes 中 `Sprite Size Mode` 为 `Non-Uniform`，`Sprite Size X 15.0 / Y 40.0`，Sprite Rotation 和 UV 均为 Unset。`StaticBeam` 堆栈中可见已加入 `Update Beam`。Preview 中核心附近有短促亮点和光束。该图记录短生命周期光点与 Beam 每帧更新模块。
> 图表转写（UE-GTXT v4）
> Material `M_Beam_01` 打开，左侧预览显示黑底粉白色碎片状光束贴图。Details 中材质属性为 `Material Domain: Surface`、`Blend Mode: Translucent`、`Shading Model: Unlit`，`Cast Ray Traced Shadows` 已勾选。中央材质图显示完整 Beam 材质网络：左侧 UV/Time/Panner/纹理采样链进入中部的 Normal、Opacity 和颜色控制；右侧可见 `Start_Color`、`End_Color`、`Color_Tex`、`Opacity_Tex`、多组 `Multiply/Add/Power/Lerp` 节点，并最终连接到材质输出。Stats 显示 Texture samplers 4/16、shader count 2。该图记录 Beam 材质在添加透明度、颜色和法线控制后的整体网络。

### 00:57:26-01:02:13 粒子

- 本段定位：粒子。
- 知识点：将这个适当调整比例 等适当使用 除了粒子外 再试着添加这里发生的爆炸粒子 我们这里 说过复制使用吧 所以复制为2号 先调整位置等 名字有些混习。
- 知识点：就用党帝的 所以这里放轨迹 最初这一丝带轨迹生成时 应该出现吧 定在57针上 似乎可以做到 Coojin-shun Zonai Station。
- 知识点：设置为70和140左右 然后同样的东西 也会在这里到达时再出现一次 所以会复制使用两次 然后这个 是Townmate 怀疑Newtown在Town。
- 知识点：先删除Keep值 位置值是 X轴的700吗 这个角色位置的对应位 只适当降低高度 然后 将在72针生成 这一部分如果 实际不对可以稍后修改 关于位置或这些。
- 知识点：一次 出来的似乎很好 现在尺寸这些东西 有点小 那么打开Particle一次 尺寸这些东西 适当调整一下 大致上其他部分不用动 只要适当增大尺寸。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`Particle`、`粒子`、`生命周期`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> Niagara System `Ultimate_Small_Exp_02` 打开，Preview 中出现紫色环形爆炸、中心暗部和外侧白色火花。Particle Counts 显示 `Core_Sprite` 1/1、`Glow_01` 1/1、`Glow_03` 1/1、`Spark_02` 30/30 均 Active。System Overview 中包含系统节点、`Core_Sprite`、`Glow_01`、`Glow_03` 和 `Spark_02`，每个发射器均为 `Emitter State Self Once`，并含有 `Spawn Burst Instantaneous`、`Initialize Particle`、`Camera Offset`、`Particle State`、`Dynamic Material Parameters` 或 `Scale Color`、`Sprite Renderer` 等模块。该图记录复制出的第二个小爆炸系统的基础结构和预览。
> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，当前帧约 `0057`。`Trails_02` 分组下包含 `Ultimate Center Projectile_01`，并在其下方放置 `Ultimate Hit Exp 01` 与选中的 `Ultimate Hit Exp 02`，两者都有 `Spawned` 和 `Transform` 轨道。右侧 Details 显示选中对象使用 `Ultimate_Small_Exp_02`，Transform 位置字段可见约 `70.0 / 0.0 / 140.0`，旋转字段为 `0.0 / 0.0 / 0.0`，缩放为 `1.0 / 1.0 / 1.0`。Viewport 使用 Cine Camera Actor 视角，棋盘地面上等待播放效果。该图记录第二个爆炸粒子被复制到 Sequencer 的时间点和可见 Transform 字段。
> 图表转写（UE-GTXT v4）
> 回到 `Ultimate_Small_Exp_02`，当前选中 `Glow_01` 的 `Initialize Particle`。右侧 `Lifetime Mode` 为 Direct Set，`Lifetime 0.35`；`Color Mode` 为 Unset；`Position Mode` 为 `Simulation Position`；`Sprite Size Mode` 为 `Non-Uniform`，`Sprite Size X 300.0 / Y 150.0`；Sprite Rotation 和 UV 均为 Unset。Preview 显示白粉色强光爆发和水平光线。该图记录第一层 Glow 被放大为宽扁形爆发片。

### 01:02:13-01:07:11 Niagara、Material、UV

- 本段定位：Niagara、Material、UV。
- 知识点：尺寸同样低 再加尺寸 火花质量适当增加 这里尺寸是大约30 这里位置要增大才会有变大感觉 1.2生命周期。
- 知识点：适当再强一点 同样颜色可以不变 这样做 首先会在这里添加一种 新的序列形式 需要复制这个来使用 只做一个提示 然后 在材质方面会做新的材质。
- 知识点：名字定为霓虹咖啡序列 在这里命名 打开后不是复杂的着色器 可以认为几乎是加法的着色 需要用加法 在资源中 拿取掉为墨水喷嘴的纹理。
- 知识点：去掉降色和功率 两个相乘 取出粒子颜色 数字连接为3 指甲这样控制使用 α只是和粒子颜色直接连接。
- 知识点：uv也可以不连接 需要适当给你剪点纸 这是什么方式的纹理呢 上面的格子数 纹理分成了格子 横八数八就是八成八 那么这里是第一针 这里最后是结束针。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Niagara`、`Material`、`材质`、`纹理`、`粒子`、`序列`、`生命周期`、`颜色`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> 当前选中 `Ultimate_Small_Exp_02` 中 `Glow_03` 的 `Initialize Particle`。右侧 `Lifetime` 为 `0.5`，`Color Mode` 为 Unset，`Position Mode` 为 `Simulation Position`。Sprite Attributes 中 `Sprite Size Mode` 为 `Uniform`，`Uniform Sprite Size` 为 `35.0`；Sprite Rotation 与 UV 未设置。Preview 仍为白粉色爆发核心和水平光线，Particle Counts 显示 `Core_Sprite`、`Glow_01`、`Glow_03`、`Spark_02` 均 Active。该图记录第三层 Glow 的短生命周期和统一尺寸。
> 图表转写（UE-GTXT v4）
> `Ultimate_Small_Exp_02` 中选中复制出的 `Glow_03001`，右侧为 `Sprite Renderer`。Material 绑定为 `MI_AdditiveDe_01_Ins_03`；`Source Mode` 为 `Particles`；`Material User Param Binding` 为 None；`Alignment` 为 `Unaligned`；`Facing Mode` 为 `Face Camera`；Default Pivot in UV Space 为 `0.5 / 0.5`；`Macro UVRadius` 为 `0.0`；Sorting 中 `Sort Mode` 为 None，`Sort Only when Translucent` 勾选。Content Browser 位于 `/Content/Tutorial/Material`，可见 `M_AdditiveDe_01`、`M_AdditiveDe_02`、`M_Mesh_01`、`M_RadialUV_01`、`M_Ribbon_01`、`M_Sequence_01` 等材质资源。该图记录新增 Glow 层使用的加法材质实例和 Sprite Renderer 绑定。
> 图表转写（UE-GTXT v4）
> Material `M_Sequence_01` 打开，左侧预览为 8x8 序列贴图格子，显示白到蓝紫色的动作/喷溅帧。Details 中材质为 `Surface`、`Blend Mode: Additive`、`Shading Model: Unlit`。材质图中 `Texture Sample` 的 RGB 接入 `Desaturation`，Fraction 来自常量 `0.5`；随后进入 `Power`，Exp 由常量 `3` 控制；结果进入 `Multiply`，再与常量 `1` 和 `Particle Color` 相乘，输出到材质 `Emissive Color`。`Particle Color` 的 Alpha 通道连接到 `Opacity`。Stats 显示 Texture samplers 2/16、shader count 1。该图记录序列贴图材质的加法发光和粒子颜色驱动。

### 01:07:11-01:11:55 UV、材质、粒子

- 本段定位：UV、材质、粒子。
- 知识点：增加了 使用 标签了 实力化制作 主材质是可以的 这里实力化了 所以需要放这个 放好了把数值要一次 调整一下的地方 好像数值调整也可以。
- 知识点：现在这里这样出来 这样还没有播放的形式 这种也可以称为 Sub-UA纹理 所以这里在精灵渲染中 有CV微向 有个叫图片大小的 8x8吧 输入宽高比。
- 知识点：这样就可以立即 识别 现在只获取第一阵 生命周期是1.1秒 尺寸是30 数值大约20 精灵大小纹0.5到1.1左右 这样设置 就这样开。
- 知识点：颜色先回到默认 透明度 删除后可以简单使用 只需播放即可 这里有一个 紫UV动画模块 大约 已经在播放吗 现在默认值是 0到63 可以认为是这样。
- 知识点：播放的方式 就这样尝验证效果 如果只是同样的形状会很无聊 旋转需要随机 使用 这仅仅是想展示这种方式 这里现在我们要制作 粒子的遗传参数会加一个。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`材质`、`纹理`、`粒子`、`生命周期`、`颜色`、`透明度`、`曲线`、`用户参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `M_Sequence_01` 材质图近景显示同一节点链。`Desaturation` 参数节点名称为 `Desaturation`，默认值 `0.5`；另一个 Scalar Parameter 当前名称为 `Param`，默认值 `3.0`，Sort Priority `32`，作为 `Power` 的 Exp 输入。`Texture Sample` 继续进入 `Desaturation -> Power -> Multiply`，并与 `Particle Color` 合成后输出到 `Emissive Color`，Particle Color Alpha 连接 `Opacity`。左侧 Details 正显示选中 `Param` 的默认值。该图记录序列材质中去饱和和幂指数参数的可调字段。
> 图表转写（UE-GTXT v4）
> 回到 `Ultimate_Small_Exp_02`，选中 `Glow_03001` 的 `Scale Sprite Size`。右侧 `Scale Sprite Size Mode` 为 `Uniform Curve`，`Uniform Curve Sprite Scale` 使用 Curve for Floats，曲线从约 `0.5` 上升到约 `1.1`，`Uniform Curve Index` 为 `Particles.NormalizedAge`，`Uniform Curve Scale` 为 `1.0`。Preview 中紫色环形爆发外侧有散点火花，中间白色核心较明显。该图记录序列 Glow 层随生命周期逐渐放大的尺寸曲线。
> 图表转写（UE-GTXT v4）
> 选中 `Core_Sprite` 的 `Dynamic Material Parameters`。右侧 `Dynamic Parameter Index 0` 中 `Write Parameter Index 0` 已勾选，包含多组 Float from Curve：`Panning` 曲线随 `Particles.NormalizedAge` 从较高值逐步下降到接近 0；`Distortion` 曲线从低值逐步升高；`EdgeSty` 曲线随生命周期下降。每组 `Scale Curve` 为 `1.0`。Preview 中爆炸核心呈粉紫色喷溅形状，外侧有白色火花点。该图记录核心材质动态参数通过生命周期驱动平移、扭曲和边缘强度变化。

### 01:11:55-01:16:10 粒子

- 本段定位：粒子。
- 知识点：用户参数 用这个数值的比例 可以控制吗 所以这个模块需要大小调整 让各自放一个 火花是以速度移动的粒子。
- 知识点：不需要 如果想控制到这个部分 可以在这个形状位置 再加一个成法使用 在半径上 所以看到这里热量部分 这里有均匀的东西 首先就是在应用前看一下。
- 知识点：调整一下 大小似乎还不错 有点大 似乎有点大的感觉 以后 什么都没有 缩小就好了 我现在明白了 时机合适的反应效果也已设置好 你们会看到这里的彩带轨迹显示黑色。
- 知识点：有一种被遮住的感觉 现在在我放置的七流之间 有像2米设置的 这里可以设置半透明 选项的优先几 需要把这两个都往前拉 这里会先被绘制 是的,我觉得不错。
- 知识点：其实似乎可以直接使用 用移植也不会太差 我先用移植放着 你现在好些了吧 这种方式 第二次时间是 就是这部分制作过的 注意加了特雷尔那边的 这次视力本身就是这样。
- 复现要点：User Parameter 与 Dynamic Material Parameter 负责跨 Niagara、蓝图和材质传值，命名和类型必须稳定。
- 核对对象：`粒子`、`速度`、`用户参数`。

**关键画面：**

> 图表转写（UE-GTXT v4）
> `Ultimate_Small_Exp_02` 中选中 `Core_Sprite` 的 `Scale Sprite Size` 模块。右侧 `Scale Sprite Size Mode` 为 `Uniform`，`Uniform Scale Factor` 为 `1.0`。Preview 区域正在 `Compiling...`，左上日志显示正在编译 `Core_Sprite_0`、`Glow_01_7`、`Glow_03_7`、`Spark_02_19`、`Glow_03001_1` 等发射器。System Overview 中 `Core_Sprite`、`Glow_01`、`Glow_03`、`Glow_03001` 与 `Spark_02` 保持在同一小爆炸系统内。该图记录核心精灵尺寸缩放回到统一系数 1，并处于编译检查状态。
> 图表转写（UE-GTXT v4）
> Level Sequencer `Ex_Ultimate_01` 打开，Viewport 通过 Cine Camera Actor 视角显示角色附近的两团白粉色爆发光和周围散点。Sequencer 当前约 `0018` 帧，`Trails_02` 分组展开，内部包含 `Ultimate Center Projectile_01`、`NiagaraComponent0`、`Ultimate Hit Exp 01` 和 `Ultimate Hit Exp 02`。三个粒子对象均可见 `Spawned`/`Transform` 或 `FX System` 轨道，时间轴上起始段附近有关键点，当前画面用于检查两次爆炸与第二段轨迹的相对时机。底部还浮动着 `Ultimate_Small_Exp_02` Niagara 窗口，选中 `Spark_02`。该图记录收尾阶段在 Sequencer 中检查两次 Hit Exp 与轨迹的叠加。
> 图表转写（UE-GTXT v4）
> Sequencer 当前约 `0107` 帧，Viewport 中角色手部附近出现向上延伸的白粉色光束/拖尾，周围仍有少量火花。`Trails_02` 下展开 `Ultimate Center Projectile_01`，其中 `NiagaraComponent0` 的 `FX System` 为 `Activate`，`Spawned` 已勾选；`Ultimate Hit Exp 01` 和 `Ultimate Hit Exp 02` 的 `Spawned` 也处于勾选状态。时间轴中对应轨道的绿色区间延续，当前帧位于轨迹播放中段。该图记录第二段轨迹、中心投射物和两次爆炸在后续帧的最终组合效果。

## 补充视觉证据

### S01 00:03:05

> 图表转写（UE-GTXT v4）
> 补充截图来自 `Ex_Ultimate_01` Sequencer 早期检查，当前约 `0065` 帧。Viewport 中显示两个角色、绿色移动/位置 Gizmo 和两个白色目标点；Content Browser 位于 `/Content/Tutorial/Particle/Ex_04`，选中 `Ultimate Projectile...` 资源。Sequencer 中 `Camera Cuts` 轨道带有多段相机缩略图，`Cine Camera Actor` 下方为相机参数轨道，`Trails_02` 分组只展开 `Ultimate Center Projectile_01`，其 `Spawned` 已勾选并带有 `Transform` 轨道。该图作为补充视觉证据，记录第二段轨迹中心投射物在早期位置调整时的 Sequencer 状态。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。

