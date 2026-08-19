# 03Sequencer工具UI介绍

# 03Sequencer工具UI介绍

## 关键术语

- `Sequencer`、`After Effects`、`PS`、`蓝图`、`材质`、`速度`、`曲线`、`Niagara`、`Normalized Age`、`Blueprint`、`系统`、`序列`、`生命周期`、`颜色`、`用户参数`、`Niagara System`、`Emitter`、`Spawn Rate`

## 分段知识

### 00:00:05-00:05:01 Sequencer、After Effects

- 本段定位：Sequencer、After Effects。
- 知识点：这次我们简单看一下这个序列器工具的界面。
- 知识点：保存的时候会出现这种新序列器窗口。
- 知识点：在这个窗口我们这次主要了解一下可观察到的图标功能。
- 知识点：在虚幻影情内制作电影视频或相关演出的视频。
- 知识点：在虚幻影情里面可以想象在做视频工作。
- 知识点：其他3D工具也就是现在可以创建3D物体。
- 知识点：通过渲染的过程变成我们看的电影或广告这种影像。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`序列`。

**关键画面：**

这张图是本讲 `Sequencer` UI 介绍的工程入口画面。当前还没有打开时间线窗口，而是先在 `Content Browser` 中定位本讲对应的内容目录，说明课程会从项目目录结构进入序列器相关资产。

当前图中可直接确认的界面与路径：
- 左侧 `Content Browser` 当前路径：
  - `Content > Signature > Course_03`
- `Course_03` 目录下当前可见两个子文件夹：
  - `Level`
  - `Material`
- 左侧树形目录还能看到同级或相关目录：
  - `Course_01`
  - `Course_02`
  - `Course_03`
  - `ParagonPhase`
  - `Signature`
  - `ThirdPerson`

当前场景上下文：
- 右侧视口是基础关卡与天空背景
- `Outliner` 中包含基础场景对象与体积类对象，说明当前工程已处于可继续编辑状态

输出/预览：
- 这一步说明讲解 `Sequencer` 之前，先要知道本讲资产所在的项目目录位置
- 复现时可以先在内容浏览器定位到 `Course_03` 下的关卡或材质资源，再从对应关卡中打开 `Sequencer`
这张图已经正式打开 `Sequencer` 面板。当前重点不是轨道内容本身，而是让读者先认识 `Sequencer` 在编辑器里的停靠位置与基本入口形态。

当前图中可直接确认的界面与对象：
- 底部已打开 `Sequencer*` 标签页
- Sequencer 工具栏左侧可见：
  - `+ Add`
  - `Search Tracks`
  - 若干用于创建镜头、渲染、动作或工具配置的图标按钮
- 时间轴区域已经可见刻度与时间线
- 右侧 `Outliner` 搜索框中输入了 `Sequencer`
- `Outliner` 列表中可见一个 `NewLevelSe...` 命名的 `LevelSequence` 资产/对象
- 场景视口中央还能看到场记板样式的图标，表明当前关卡里已经放入或激活了序列器相关对象

输出/预览：
- 这一步说明课程会把 `Sequencer` 作为与普通关卡视口并行的底部面板来使用
- 复现时如果找不到时间线界面，可以先确认是否已创建/选中 `Level Sequence`，并让 `Sequencer` 面板停靠到底部
这张图把 `Sequencer` 窗口放大到主要视区，适合作为本讲 UI 结构总览。它展示的是一个新建但尚未添加轨道内容的 `Level Sequence` 编辑界面。

当前图中可直接确认的 `Sequencer` 界面结构：

```text
Window
- Sequence name = NewLevelSequence*
- 左侧为轨道/层级列表区
- 右侧为时间轴区
```

```text
Toolbar
- + Add
- Search Tracks
- 可见多组工具按钮：相机/镜头、关键帧、吸附、显示、渲染或工具设置相关图标
- 帧率下拉框 = 30 fps
- 磁铁吸附按钮处于可见状态
```

```text
Timeline
- 时间轴上方已有帧刻度
- 当前播放头位于 0062 附近
- 底部可见播放控制按钮组
```

当前窗口状态：
- 左侧轨道区暂时为空，说明课程此时在先讲界面功能，而不是具体轨道内容
- 右侧 `Outliner` 中依旧能看到 `NewLevelSe...` 的 `LevelSequence` 条目

输出/预览：
- 这张图明确了 Sequencer 的三个核心区域：工具栏、轨道区、时间轴区
- 复现时如果后续要接 Niagara、蓝图或相机动画，都是从当前这个空序列界面开始逐步往左侧轨道区添加对象和轨道

### 00:05:02-00:09:45 Niagara、Sequencer、蓝图

- 本段定位：Niagara、Sequencer、蓝图。
- 知识点：是这部分我们常见内容浏览器自动找到这个序列文件的位置。
- 知识点：还有什么Grace这种活动也会给你绘制。
- 知识点：这种相机的细节使用方法等可能下次再说。
- 知识点：可以通过蓝图客家自定义来使用。
- 知识点：是连接蓝图的图标。
- 知识点：可以调节这个速度。
- 知识点：或者以这个速度播放。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Sequencer`、`蓝图`、`序列`、`速度`、`曲线`。

**关键画面：**

这张图聚焦在 `Sequencer` 工具栏左侧的放大镜按钮，用来说明如何从当前打开的序列界面反向定位到内容浏览器中的序列文件。

当前图中可直接确认的 `Sequencer` UI 信息：

```text
Sequencer
- Sequence name = NewLevelSequence
- 左侧轨道区仍为空
- 时间轴当前播放头在 0062 附近
```

```text
Toolbar
- 放大镜按钮的 tooltip = Find the viewed sequence asset in the content browser
```

与正文和字幕可确认的功能含义：
- 这是“内容浏览器里自动找到这个序列文件位置”的按钮
- 当正在查看某个 `Level Sequence` 时，可通过它快速在 `Content Browser` 中定位该资源

输出/预览：
- 这一步说明 `Sequencer` 不只是时间轴本身，还提供了与项目资源目录联动的快捷入口
- 复现时如果不知道当前序列资产存放在哪个目录，可以直接点这个放大镜，从时间线界面跳回内容浏览器定位文件
这张图聚焦在 `Sequencer` 工具栏中用于连接蓝图的按钮。当前 tooltip 已明确指出该按钮会打开当前序列对应的导演蓝图。

当前图中可直接确认的 `Sequencer` UI 信息：

```text
Sequencer
- Sequence name = NewLevelSequence*
- 左侧轨道区已出现 Camera Cuts 轨道
- 当前播放头在 0069 附近
```

```text
Toolbar
- 当前高亮按钮的 tooltip = Opens the director blueprint for this sequence.
```

与正文和字幕可确认的功能含义：
- 这是“连接蓝图的图标”
- 功能是打开当前 `Level Sequence` 的 `Director Blueprint`
- 字幕说明这部分更偏开发侧使用，符合导演蓝图通常承担序列逻辑控制、事件分发或更复杂联动的角色

输出/预览：
- 这一步说明 `Sequencer` 可以直接与蓝图逻辑衔接，而不只是做纯时间线排布
- 复现时如果需要在序列播放过程中触发 Niagara、参数变化或事件回调，可以从这里进入 `Director Blueprint` 做进一步控制
这张图展示 `Sequencer` 工具栏中的关键帧与插值下拉菜单。它对应正文里“可以调节这个速度，或者以这个速度播放”的延伸说明，强调序列器不只是放片，还能控制关键帧生成与默认插值方式。

当前图中可直接确认的 `Sequencer` 菜单内容：

```text
Key Options
- Key All
- Key Group
- Key Changed
```

```text
Default Key Interpolation
- Cubic (Smart Auto)
- Cubic (Auto)
- Cubic (User)
- Cubic (Break)
- Linear
- Constant
```

当前界面上下文：
- 序列名仍为 `NewLevelSequence*`
- 左侧轨道区保留 `Camera Cuts`
- 当前播放头在 0061 附近

输出/预览：
- 这张图说明在 `Sequencer` 里不仅能加关键帧，还能提前规定关键帧的默认插值风格
- 复现时如果希望参数变化是平滑过渡、线性变化或阶梯跳变，可以在这里先设默认插值，再去打关键帧；这和 Niagara 曲线编辑的思路是相通的

### 00:09:45-00:14:31 Niagara、PS、曲线

- 本段定位：Niagara、PS、曲线。
- 知识点：但是在这里看起来不会是那样的图表。
- 知识点：在这个时间调整只能确认有键的存在。
- 知识点：比如说我这里先做一个框。
- 知识点：先把中心值带过去。
- 知识点：可观察到这样生成键值。
- 知识点：在这样生成键值时。
- 知识点：和在尼亚加拉曲线看到的几乎一样。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`Niagara`、`曲线`。

**关键画面：**

这张图继续停留在 `Sequencer` 时间线主视图，用来说明：在默认时间线界面里，通常只能先确认“某个轨道上已经存在关键帧”，但还看不到像 Niagara 曲线编辑器那样直观的曲线形状。

当前图中可直接确认的 `Sequencer` 状态：

```text
Sequencer
- Sequence name = NewLevelSequence*
- 左侧轨道区当前只有 Camera Cuts
- 时间线主区可见帧刻度
- 当前播放头在 0056 附近
```

当前图与字幕可确认的要点：
- 这张图强调的是“在这个时间轴上只能确认有键的存在”
- 说明本讲接下来会把 Sequencer 的时间轴表现，与 Niagara 或其他曲线编辑方式做对比

输出/预览：
- 这一步帮助读者理解：Sequencer 默认视图更偏时间排布，不像专门的曲线编辑器那样直接展示数值曲线走势
- 复现时如果只在当前主时间线界面里操作，能先知道哪里有关键帧；若要精细调插值或趋势，通常还要进一步切到曲线相关视图
这张图展示在 `Sequencer` 中展开对象轨道后的时间线视图。相比上一张只看到“有没有键”，现在已经能直接看到某个对象在多个通道上的关键帧分布。

当前图中可直接确认的 `Sequencer` 结构与数据：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
      - X = 500.0
      - Y = 0.0
      - Z = 500.0
    - Rotation
    - Scale
```

```text
Timeline
- 当前播放头在 0082 附近
- Location/Rotation/Scale 相关通道上已存在多个粉色关键帧
- 多个关键帧在同一时间范围内对齐，表明对象的多个属性会同步变化
```

当前界面上下文：
- 右侧 `Outliner` 中可见 `Cube` 与 `NewLevelSequence`
- 视口左上区域能看到一个黑色方块/平面对象，和当前 `Cube` 轨道相互对应

输出/预览：
- 这一步说明一旦把具体对象轨道展开，Sequencer 就能清楚显示多通道关键帧的时间分布
- 复现时如果要像 Niagara 曲线那样理解数值变化，至少要先展开到 `Transform` 或更细分的属性通道，否则只能停留在最外层轨道视图
这张图展示 `Sequencer` 顶部 `fps` 菜单，用来说明序列播放与编辑时采用的帧率基准。它属于 `Sequencer` UI 介绍中的重要基础设置，因为帧率会直接影响时间轴刻度、播放速度理解和关键帧时间感知。

当前图中可直接确认的 `fps` 菜单内容：

```text
Current frame rate
- 30 fps
```

```text
Selectable frame rates
- 12 fps (animation)
- 15 fps
- 23.976 (NTSC/24)
- 24 fps (film)
- 25 fps (PAL/25)
- 30 fps
- 48 fps
- 50 fps (PAL/50)
- 60 fps
- 100 fps
- 120 fps
- 240 fps
- Custom
```

```text
Other options
- Incompatible Rates
- Show Time As
- Clock Source
- Lock to Display Rate at Runtime
- Advanced Options
```

当前界面上下文：
- 左侧轨道区仍展开到 `Cube -> Transform -> Location`
- 时间线中仍可见多个关键帧

输出/预览：
- 这一步说明 `Sequencer` 的时间不是抽象的，背后始终依附于一个明确的帧率基准
- 复现时如果要对齐影视常用节奏、游戏内播放速度或 Niagara 事件触发时机，必须先确认当前序列使用的 `fps`，否则对关键帧时间位置的理解会偏差

### 00:14:31-00:19:17 Niagara、Sequencer

- 本段定位：Niagara、Sequencer。
- 知识点：通常不会有大变化。
- 知识点：如果不是故意的那种。
- 知识点：超高速拍摄那种感觉的话。
- 知识点：是刚才提到的图表。
- 知识点：图表试图这样调整。
- 知识点：右键点击这样移动。
- 知识点：就可以一次选择多个键。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Niagara`、`Sequencer`、`序列`。

**关键画面：**

这张图继续展开 `Sequencer` 顶部的时间设置菜单，这次重点是 `Clock Source` 子菜单。它说明序列播放不只受 `fps` 影响，还可以指定时间推进使用哪种时钟来源。

当前图中可直接确认的菜单结构：

```text
Frame rate menu
- Current = 30 fps
- Show Time As
- Clock Source
- Lock to Display Rate at Runtime
- Advanced Options
```

```text
Clock Source options
- Tick
- Platform
- Audio
- Relative Timecode
- Timecode
- Play Every Frame
- Custom
```

当前界面上下文：
- 左侧轨道仍展开到 `Cube -> Transform -> Location`
- 右侧时间线中保留多组关键帧

输出/预览：
- 这一步说明 `Sequencer` 的时间推进可以基于不同的时钟来源，而不是固定一种播放机制
- 复现时如果序列播放速度、同步方式或与系统运行节奏的关系需要更精确控制，应先检查 `Clock Source` 设定，而不只是关注帧率数值
这张图展示 `Sequencer` 中对一段关键帧区域进行框选后的状态。它对应正文里“图表视图这样调整”“可以一次选择多个键”的讲解，说明在时间线里可以批量处理同一时间范围内的多个关键帧。

当前图中可直接确认的 `Sequencer` 状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
    - Rotation
    - Scale
```

```text
Timeline
- 当前播放头在 0084 附近
- 时间线上有一个带红色边界的绿色半透明选区
- 选区覆盖了多条属性通道上的关键帧
- 选区内部能看到多组粉色关键帧，且有些关键帧以横向成组对齐
```

当前图的可确认操作含义：
- 这不是单独选择一个键，而是通过拖拽形成一个范围框，批量选中了同一时间段内的多个关键帧
- 适合统一移动、统一调整或整体检查一段动画区间

输出/预览：
- 这一步说明 `Sequencer` 可以像做剪辑或做曲线编辑那样，对一段时间范围内的键进行组操作
- 复现时如果需要整体平移一组关键帧、检查某段变化是否对齐，先框出范围再操作会比逐个点键更高效
这张图进一步展示 `Sequencer` 中多对象轨道与关键帧范围的协同查看。相比上一张只看 `Cube`，当前已经能看到 `Cube2` 也被加入同一序列，并且轨道选中状态与右侧对象详情联动。

当前图中可直接确认的 `Sequencer` 与对象状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
    - Rotation
    - Scale
- Cube2
  - Transform
```

```text
Selection / Timeline
- Cube2 轨道整行呈蓝色高亮，说明当前选中对象是 Cube2
- 时间线上同时可见多组粉色关键帧
- 当前播放头在 0039 附近
- 同一序列中已经存在不止一个对象轨道
```

```text
Details -> Cube2 (Instance)
- 右侧细节面板已切换到 Cube2
- Transform 可见当前值：
  - Location 约为 (67.5, 10.0, 67.5)
  - Rotation = (0.0, 0.0, 0.0)
  - Scale = (1.0, 1.0, 1.0)
```

输出/预览：
- 这一步说明 Sequencer 不只是操作单个对象，而是可以在一个时间轴里并排管理多个对象及其关键帧
- 复现时如果需要比较多个对象在同一时间段内的运动、触发或参数变化，应像当前图这样同时保留对象轨道与 Details 联动查看

### 00:19:17-00:24:16 关键流程 05

- 本段定位：关键流程 05。
- 知识点：可以进行这种建操作。
- 知识点：还有这里的结束针。
- 知识点：这里是叫做广播头的。
- 知识点：完成被黑色线条标记的部分。
- 知识点：似乎只是把这个鼠标点当做与播放头无关的点。
- 知识点：还有可以再加一个范围设置好这个部分。
- 知识点：我们可观察到这个部分会用蓝色标记。

**关键画面：**

这张图把场景视口中的对象状态与底部 `Sequencer` 时间线同时放在一个画面里，用来说明当前播放头位置会直接对应到场景对象的空间状态。它是进入“关键流程 05”后，理解播放头、时间位置和对象变化关系的起点。

当前图中可直接确认的界面与对象状态：

```text
Viewport
- 场景中可见上下堆叠的两个立方体
- 下方立方体处于选中状态，带黄色描边与变换 gizmo
- 视口中同时可见手柄图标与场记板图标，说明关卡里保留了与玩家/序列相关的辅助对象
```

```text
Sequencer
- 底部已打开 Sequencer*
- 可见轨道：
  - Camera Cuts
  - Cube
    - Transform
      - Location
- 当前播放头在 0047 附近
```

与上下文可确认的操作含义：
- 这张图强调的是“播放头所在时间点”和“场景里对象此刻的实际位置/姿态”之间的一一对应
- 后续讲的结束针、蓝色范围或播放控制，都是建立在这个时间对应关系之上

输出/预览：
- 复现时如果想判断某个关键帧是否真的生效，不要只看时间线；应像当前图这样同时观察视口中对象的实时状态
- 这一步也说明 Sequencer 很适合做空间位置、时序和对象状态的联动验证
这张图重点展示 `Sequencer` 中的时间范围与播放头标记。正文提到“可以再加一个范围设置好这个部分，我们可观察到这个部分会用蓝色标记”，当前截图正对应这类范围可视化。

当前图中可直接确认的 `Sequencer` 结构与状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
      - X = 500.0
      - Y = 0.0
      - Z = 500.0
- Cube2
  - Transform
    - Location
      - X = 500.0
      - Y = 0.0
      - Z = 200.0
```

```text
Timeline
- 当前播放头为一条蓝色竖线，位置在 0070 附近
- 时间线上可见两组对象各自的关键帧序列
- 多条轨道区域被蓝绿色半透明条带覆盖，表示被设置或高亮的时间范围
- 顶部还有一段灰色条状区间，表示该对象轨道/片段在当前时间轴上的有效区段
```

输出/预览：
- 这一步说明除了单个关键帧，Sequencer 还能通过颜色和区段条直观标出一整段相关时间范围
- 复现时如果要讲解、检查或限制某一段动画区间，先设置并观察这种范围标记，会比只盯着单个关键帧更清楚
这张图继续说明 `Sequencer` 的范围控制，但比上一张更明确地展示了一个完整区间的起止边界。字幕“这样这里就结束了”与画面中的范围终点完全对应，说明作者在讲如何定义并观察某段播放区间的结束位置。

当前图中可直接确认的 `Sequencer` 状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
- Cube2
  - Transform
    - Location
```

```text
Timeline
- 当前播放头在 0043 附近
- 两条蓝色竖线共同构成一个明确的时间范围边界
- 关键帧集中分布在这两条边界之间
- Cube 与 Cube2 的轨道区间条都覆盖在同一主要时间段内
- 区间外侧仍可见绿色/青色的背景分区，用于辅助判断当前区段与整体时间线的关系
```

输出/预览：
- 这一步说明 `Sequencer` 不只是给关键帧打点，还能清楚定义“这一段从哪里开始，到哪里结束”
- 复现时如果一组动画、材质变化或 Niagara 触发只想在某个时间窗内生效，可以像当前图这样先确定区间边界，再在区间内组织关键帧

### 00:24:16-00:28:20 Sequencer、材质

- 本段定位：Sequencer、材质。
- 知识点：可以不断重复观看。
- 知识点：我们是反复观看的工作吧。
- 知识点：还有这个是每次移动一个框架的图标。
- 知识点：相反这个显然是正常方向播放的按钮。
- 知识点：而且我们几乎可以通过序列器控制所有演员的方法。
- 知识点：的演员的选项是什么呢? 大部分都可以控制。
- 知识点：材质里的参数也可以控制。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Sequencer`、`材质`、`序列`。

**关键画面：**

这张图继续展示 `Sequencer` 中多个对象轨道与时间区段的关系，强调这种布局就是课程中常用、也最容易反复看到的工作方式。相比上一批，当前画面更突出同一时间窗内多个对象轨道的并行排布。

当前图中可直接确认的 `Sequencer` 状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
      - X = 0.0
      - Y = 0.0
      - Z = 0.0
- Cube2
  - Transform
    - Location
      - X = 0.0
      - Y = 0.0
      - Z = 0.0
```

```text
Timeline
- 顶部时间区间可见多个标线，当前区域中心在 0020 到 0060 附近
- Cube 与 Cube2 轨道上都存在灰色区间条
- 两组对象都拥有多条对齐的粉色关键帧
- 轨道背景存在大块绿色/青色范围区，表明当前时间段被整体关注或限制
```

输出/预览：
- 这一步说明 Sequencer 中常见的工作方式，是把多个对象的动画区段放在同一时间窗内并排比较
- 复现时如果要同时控制多个演员、网格或材质变化，建议像当前图一样在统一时间段内布置轨道与关键帧，便于对齐时序
这张图把 `Sequencer` 时间线和视口预览结果放到同一画面中，直接说明：时间线上同一时间点的关键帧配置，会在视口里表现为两个方块对象的当前空间关系。

当前图中可直接确认的视口与时间线对应关系：

```text
Viewport
- 视口中可见上下分离的两个白色立方体
- 下方立方体接近地面并投下阴影
- 上方立方体悬浮在更高位置
```

```text
Sequencer
- 底部已打开 Sequencer
- 顶部时间线上当前播放头在 0052 附近
- Cube 的 Transform -> Location 通道已展开
- 该时间段内存在一组关键帧
- 轨道顶部仍可见灰色区间条与绿色/青色范围底色
```

与上下文可确认的操作含义：
- 当前图不是在介绍新按钮，而是在验证前面讲解的时间线、范围和关键帧设置，已经能稳定驱动场景对象的空间变化
- 这也呼应“Sequencer 几乎可以控制所有演员的方法”，因为视口里的对象状态完全跟随时间线变化

输出/预览：
- 复现时不要把 Sequencer 只当成抽象时间轴；应不断像当前图这样对照视口结果，看对象是否在预期时间点到达预期位置
- 这一步也说明 Sequencer 可直接用于驱动场景对象的位移、进而扩展到材质参数或 Niagara 触发
这张图可以视为本讲 `Sequencer` UI 介绍阶段的收束画面。它保留了 `Cube` 与 `Cube2` 的双对象轨道、范围条和关键帧分布，同时在左侧数值栏直接展示了当前时间点下对象的位置数值。

当前图中可直接确认的 `Sequencer` 状态：

```text
Track Hierarchy
- Camera Cuts
- Cube
  - Transform
    - Location
      - X ≈ 202.186486
      - Y = 0.0
      - Z ≈ 202.186486
- Cube2
  - Transform
    - Location
      - X ≈ 202.186486
      - Y = 0.0
      - Z ≈ 80.874594
```

```text
Timeline
- 当前播放头在 0047 附近
- Cube 与 Cube2 各自都有成组关键帧
- 两个对象轨道都带有灰色区间条
- 时间轴中仍保留蓝色边界线和绿色/青色范围背景
```

与字幕和上下文可确认的含义：
- 字幕说明本节已经基本介绍完 `Sequencer` 的简单 UI 与用户界面
- 也就是说，前面依次讲过的资源定位、导演蓝图、关键帧、插值、fps、时钟来源、范围框选和多对象轨道，构成了这一讲的核心界面知识

输出/预览：
- 当前图把“对象列表 + 当前数值 + 区间 + 关键帧”同时放在一个界面里，适合作为 Sequencer 基础工作流的总览参考
- 复现时如果要检查序列界面是否理解到位，可对照当前图确认自己是否已经会看对象轨道、时间范围、关键帧和当前属性值

## 补充视觉证据

### S02 00:07:25

这张补充图是 `S02` 段里 `Sequencer` 工具栏开发向按钮的补证。画面重新回到一个较空的 `Level Sequence`，用来强调：当前按钮区域并不只是给普通时间线用户使用，其中有一部分是偏开发或逻辑控制用途的功能入口。

当前图中可直接确认的 `Sequencer` 界面状态：

```text
Sequencer
- Sequence name = NewLevelSequence*
- 左侧轨道区仅保留 Camera Cuts
- 当前播放头在 0069 附近
- 时间轴主区为空白，没有展开对象属性曲线
```

```text
Toolbar
- 被指示的位置位于工具栏中部偏左
- 对应的是前面讲到的开发向按钮区域
- 该区域与导演蓝图/开发控制类功能相关，而不是普通播放按钮
```

与正文和字幕可确认的要点：
- 字幕明确说明“这一部分其实是开发方面用的”
- 结合前文对 `Director Blueprint` 按钮的介绍，可以确认这张图是在补证：`Sequencer` 里确实存在偏开发侧、用于更深层逻辑控制的入口

输出/预览：
- 这张图的作用不是给出新参数，而是把 `Sequencer` 的“普通时间线操作”与“开发向控制入口”区分开
- 复现时如果只是做基础排镜、关键帧和区间控制，可以先不碰这类按钮；当需要蓝图、事件或更复杂联动时，再回到这一区域处理

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

