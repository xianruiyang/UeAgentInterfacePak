# 01 Introduction In Unreal Engine

# 01 Introduction In Unreal Engine

## 关键术语

- `WPO`、`Blueprint`、`Static Mesh`、`Substance`、`Substance Designer`、`Blender`、`PS`、`SD`、`Mesh`、`C++`、`速度`、`Niagara`、`Material`、`系统`、`颜色`、`Niagara System`、`Emitter`、`Particle`

## 分段知识

### 00:00:06-00:03:43 WPO、Blueprint、Substance

- 本段定位：WPO、Blueprint、Substance。
- 知识点：開發了! 首先,需要說一下Unreal Engine的基本上是什么 它是一个游戏機 可以输入3D物品,创建的質料 例如一些聲音檔案,类似的。
- 知识点：可以输入游戏機,这就是魔法 可以调整光线,输入3D物品 创建物品,特效 这也是我们创建的地方 这是我们歡迎的窗口 我们進入Unreal。
- 知识点：Engine 这里有很多窗口,但我们只關注游戏 而游戏中,我们被準備了很多的預設 这都是由Epic Games的Unreal Engine创建的。
- 知识点：他們给了我们什么? 这里有一个描述 他們给了我们创建的邪惡,和创建的邪惡 可以选择不同的物品,让我们的生活更容易 这里的角色已经是由第一个人创建的。
- 知识点：是第三个人创建的 这里有一个從上方的景觀 其他物品也不适合我们 因为这是Virtual Reality和Augmented Reality。
- 知识点：我通常用3rd party 但这全都視乎你的需要 需要從第三个人创建的 这里我们也有设置 我们选择Blueprint或C++。
- 知识点：这是我们选择的方式 如何跟这个文件互动 Blueprint的视觉文件與Substance。
- 复现要点：蓝图、Sequencer 或 Montage 触发 Niagara 时，要确认生成位置、生命周期和销毁时机。
- 核对对象：`Blueprint`、`Substance Designer`、`速度`。

**关键画面：**

这张图展示 Unreal Engine 的 `Unreal Project Browser` 新建项目界面。教程在这里说明先从预设模板创建工程，并强调常见选择是 `Blueprint` 而不是 `C++`，以便后续用可视化方式搭建 Niagara、材质和其他内容。

当前可确认信息：
- 左侧分类栏包含：
  - `RECENT PROJECTS`
  - `GAMES`
  - `FILM / VIDEO & LIVE EVENTS`
  - `ARCHITECTURE`
  - `AUTOMOTIVE PRODUCT DESIGN & MANUFACTURING`
  - `SIMULATION`
- 顶部模板行可见：
  - `Blank`
  - `First Person`
  - `Third Person`
  - `Top Down`
  - `Handheld AR`
  - `Virtual Reality`
  - `Vehicle`
- 当前选中模板是 `Blank`。
- 右侧说明面板标题为 `Blank`，描述为“一个无代码的干净空项目”。
- `Project Defaults` 区域当前设置为：
  - `BLUEPRINT`
  - `Desktop`
  - `Maximum`
  - `Starter Content` 已勾选
  - `Raytracing` 未勾选
- 底部栏可见：
  - `Project Location = D:\\Unreal Projects`
  - `Project Name = MyProject`
  - 右下角按钮为 `Create` 与 `Cancel`

输出/预览：
- 这一步的作用是从 Unreal 的官方模板中创建一个基础工程，为后续 Niagara VFX 教程提供空白项目起点。
- 当前截图最关键的选择是：使用 `Blank` 模板、`Blueprint` 项目类型，并保留 `Starter Content`。
这张图继续停留在 `Unreal Project Browser`，但顶部模板已切换到 `Third Person`。教程此时是在说明：工程模板可以按需要选，但与工程交互方式主要取决于右侧的 `Blueprint` 或 `C++` 选项。

当前可确认信息：
- 当前选中模板从 `Blank` 变为 `Third Person`。
- 右侧说明面板标题为 `Third Person`，文字说明这是一个带第三人称角色与跟随相机的模板，适合动作或冒险类场景起步。
- `Project Defaults` 区域仍可见：
  - `BLUEPRINT`
  - `C++`
  - `Desktop`
  - `Maximum`
  - `Starter Content`
  - `Raytracing`
- 当前画面中：
  - `BLUEPRINT` 处于选中状态
  - `Desktop` 与 `Maximum` 仍保持选中
  - `Starter Content` 未勾选
  - `Raytracing` 未勾选
- 底部仍可见：
  - `Project Location = D:\\Unreal Projects`
  - `Project Name = MyProject`
  - `Create` 与 `Cancel` 按钮

输出/预览：
- 这一步强调模板只是项目起点，教程更关心的是创建项目时使用 `Blueprint` 还是 `C++` 作为主要工作方式。
- 当前截图也说明第三人称模板是可选起点之一，适合需要角色和基础场景演示的项目。
这张图展示已经进入 Unreal Editor 的第三人称默认关卡 `ThirdPersonMap`。教程此时是在说明：创建工程后就会进入一个带基础场景和默认面板布局的编辑器环境，后续所有 Niagara、材质和蓝图工作都会从这里展开。

当前可确认信息：
- 顶部标签显示当前关卡为 `ThirdPersonMap`。
- 视口模式区域可见：
  - `Perspective`
  - `Lit`
  - `Show`
- 顶部工具栏可见常用控制：
  - `Selection Mode`
  - `Platforms`
  - `Settings`
- 中央视口显示第三人称模板自带的测试场景：
  - 白色网格地面与墙面
  - 一个圆柱形平台
  - 蓝天背景
- 右侧 `Outliner` 中可见当前世界 `ThirdPersonMap (Editor)` 下的对象层级，能辨认的项目包括：
  - `Block01`
  - `Block02`
  - `Block03`
  - `Cylinder`
  - `Lighting`
  - `Playground`
- `Lighting` 文件夹内可见典型默认光照对象：
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `PostProcessVolume`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- `Details` 面板当前为空，提示“选择一个对象以查看细节”。
- 底部栏可见：
  - `Content Drawer`
  - `Output Log`
  - `Cmd`
  - 控制台输入框 `Enter Console Command`
- 画面右下角叠加了 `W A S D` 键位提示，说明正在演示视口移动或基础导航。

输出/预览：
- 这一步的作用是确认项目已成功创建并加载到默认关卡。
- 对读者而言，最关键的是识别编辑器的基本工作区：中央视口、右侧 `Outliner/Details`、底部 `Content Drawer/Output Log`，因为后续教程都会围绕这些面板操作。

### 00:03:51-00:06:42 关键流程 02

- 本段定位：关键流程 02。
- 知识点：轉圈中心,我按Alt然后移动 我们就开始了 我们看到这里 可以在新的关卡或开启关卡的圖表上創作一张新的游戏 創作新的項目 在創作中,可以,例如,創作、刷、創、刷。
- 知识点：我们也有不同的设置 我们可观察到这里有很多不同的设置 窗戶,我们可观察到不同的開關 我们也可以移动它们 但它们并不是全部在这里 例如,我们點在这里,點擊,然后内容圖表开启。
- 知识点：这是什么?这是我们的檔案 后续会更詳細地解釋我们的項目的構成 这是我们存在的檔案 3D物品、质感和其他游戏物品 这是可以移动的。
- 知识点：后续会關掉它们,以免它们打擾我们 如果按Ctrl和Space,它会这樣开启 但如果我们按左邊的按鈕,它会關掉 所以我通常会这樣按。
- 知识点：可以开启其他东西,例如,細節 这就足夠了 例如,可以开启另一个景觀 可以從不同的角度来看 只要我留下一个,第二个就不需要了 接下来需要去按鈕的建設,工具。

**关键画面：**

这张图展示 `ThirdPersonMap` 在 Unreal Editor 中的俯视总览。教程此时开始介绍编辑器基础操作，例如视口导航、场景观察和默认关卡里有哪些测试物体。

当前可确认信息：
- 当前仍在 `ThirdPersonMap` 关卡，视口模式是 `Perspective / Lit`。
- 摄像机已拉远到较高位置，能完整看到整个第三人称模板的白色围墙测试场地。
- 场地内可见的典型几何体包括：
  - 左上圆柱平台
  - 中部台阶和斜坡结构
  - 右侧长方体台阶
  - 数个蓝色小方块
  - 地面文字 `Third Person Template`
- 左下角能看到世界坐标轴指示。
- 右侧 `Outliner` 仍显示 `ThirdPersonMap (Editor)` 的对象层级，`Details` 面板为空。
- 底部保留：
  - `Content Drawer`
  - `Output Log`
  - `Cmd`
  - 控制台输入框
- 右下角键位提示显示 `A S D`，说明教程正在演示视口移动或旋转的基础输入。

输出/预览：
- 这一步的重点是认识默认模板关卡的整体布局，而不是修改任何对象。
- 对后续教程而言，先学会在视口里移动、缩放和观察场景，是继续进入 Niagara 与材质制作前的基础操作。
这张图展示编辑器中同时打开 `Content Browser`、`Outliner` 和 `Details` 面板后的默认工作布局。教程此时在讲：项目里的资源、场景对象以及对象属性分别在哪里查看和操作。

当前可确认信息：
- 中央视口仍是 `ThirdPersonMap` 的俯视总览。
- 底部 `Content Browser` 已展开，当前位置是 `Content` 根目录。
- `Content Browser` 左侧目录树可见：
  - `Characters`
  - `Developers`
  - `LevelPrototyping`
  - `StarterContent`
  - `ThirdPerson`
  - `Engine`
- 右侧资源缩略图区在 `Content` 根下显示 5 个文件夹：
  - `Characters`
  - `Developers`
  - `Level Prototyping`
  - `StarterContent`
  - `ThirdPerson`
- 顶部创建资源快捷按钮可见多种类型：
  - `Niagara System`
  - `Blueprint Class`
  - `Animation Sequence`
  - `Material`
  - `Material Instance`
  - `Skeletal Mesh`
  - `Static Mesh`
  - `Texture`
- 右侧 `Outliner` 中当前选中对象为 `SM_SkySphere`。
- `Details` 面板同步显示 `SM_SkySphere (Instance)` 的属性，当前能可靠辨认：
  - `Transform`
  - `Location = 0, 0, 0`
  - `Rotation = 0, 0, 0`
  - `Scale = 400, 400, 400`
  - `Mobility = Static`
  - `Static Mesh = SM_SkySphere`
- 底部状态栏仍可见 `Content Drawer`、`Output Log`、`Cmd`。

输出/预览：
- 这一步的重点是建立三个核心区域的对应关系：
  - `Content Browser` 管资源文件
  - `Outliner` 管场景中的 Actor/对象
  - `Details` 管当前选中对象的具体参数
- 这也是后续创建 Niagara 系统、材质和蓝图时必须频繁使用的基础界面结构。
这张图展示 Unreal Editor 顶部菜单里的 `Build` 下拉菜单。教程在这里说明：编辑器里除了看场景和资源，还能通过 `Build` 菜单执行光照、几何体、导航和纹理等不同类型的构建操作。

当前可确认信息：
- 视口仍停留在 `ThirdPersonMap` 的俯视场景。
- `Outliner` 中当前仍选中 `SM_SkySphere`，`Details` 面板继续显示该对象属性。
- 顶部主菜单已展开 `Build`。
- `Build` 菜单中可可靠辨认的选项包括：
  - `Build All Levels`
  - `Build Lighting Only`
  - `Lighting Quality`
  - `Lighting Info`
  - `Use Error Coloring`
  - `Show Lighting Stats`
  - `Build Reflection Captures`
  - `Precompute Static Visibility`
  - `Build Geometry`
  - `Build Geometry (Current Level)`
  - `Build Paths`
  - `Build HLODs`
  - `Build World Partition Editor Minimap`
  - `Build Texture Streaming`
  - `Build Virtual Textures`
  - `Build Landscape`
  - `Build Grass Maps Only`
  - `Build Physical Material Only`
  - `Build Nanite Only`
  - `Build and Submit...`
  - `Map Check`
  - `Pack Level Actors`

输出/预览：
- 这一步的意义是让读者知道 `Build` 不是单一按钮，而是一组针对不同系统的构建命令集合。
- 对后续实际制作来说，常见关注点通常是 `Build All Levels`、光照构建、路径构建，以及地图检查 `Map Check`。

### 00:06:47-00:09:39 Static Mesh、Mesh

- 本段定位：Static Mesh、Mesh。
- 知识点：例如,重新改名、躲避、改变它的位置 这通常都不使用 我们看到出線器,出線器是什么? 出線器显示所有物品在我们的景觀上 可以按下按鈕,可以创建这樣的一个文件。
- 知识点：这是我们的層次 这是眼睛,这是反射 我现在完全关闭了整个層次 可以在聊天室打開它 可以也設立一个文件 以让它更方便的存放各种游戏物品。
- 知识点：例如,这里有一个文件 我按下按鈕,它显示 它们在我们的景觀上 我们可观察到它们 如果我按下按鈕,它会变成 这里,例如 需要按下各种物品,它会显示给我们。
- 知识点：各种游戏物品都在这里 当我们按下对应的游戏物品 它们的设置会开启 这里可以移动 改变規格和其他设置 这里可以调整物理 改变物品 3D物品它们自己。
- 知识点：它们都不一樣 这是我们目前选择的3D物品 Static Mesh 例如 如果我们去到光的 folder 它们有不同的设置 在景觀上 可以按下这兩个物品。

**关键画面：**

这张图展示 Unreal Editor 顶部 `Actor` 菜单中的对象操作项。教程此时开始说明：在 `Outliner` 里选中某个场景对象后，可以通过 `Actor` 菜单对它执行编辑、显示、变换、吸附、分组等操作。

当前可确认信息：
- 视口仍是 `ThirdPersonMap` 的俯视场景。
- `Outliner` 当前选中对象为 `ExponentialHeightFog`。
- `Details` 面板显示 `ExponentialHeightFog (Instance)` 属性，当前能可靠辨认：
  - `Location = -5600, -50, -6050`
  - `Rotation = 0, 0, 0`
  - `Scale = 1, 1, 1`
  - `Fog Density = 0.0436`
  - `Fog Height Falloff = 0.2`
  - `Second Fog Data` 下：
    - `Fog Density = 0.0`
    - `Fog Height Falloff = 0.2`
    - `Fog Height Offset = 0.0`
- 顶部主菜单已展开 `Actor`，其中可辨认的主项包括：
  - `Browse to Asset`
  - `Edit Asset`
  - `Asset Tools`
  - `Convert "ExponentialHeightFog" To Static Mesh`
  - `Copy Selected Actor(s) File Path`
  - `Save Selected Actor(s)`
  - `Place Actor`
  - `Replace Selected Actors with`
  - `Edit`
  - `Visibility`
  - `Transform`
  - `Snapping`
  - `Pivot`
  - `Group`
  - `Attach To`
  - `Detach`
  - `Add Event`
  - `Jump to Event`
  - `Validate`
  - `Merge Actors (1)`
  - `Level`
- `Transform` 子菜单已展开，可辨认：
  - `Delta Transform`
  - `Mirror X`
  - `Mirror Y`
  - `Mirror Z`
  - `Lock Actor Movement`

输出/预览：
- 这一步的重点是让读者知道：对象的常见操作既能在 `Details` 中改数值，也能在顶部 `Actor` 菜单中用现成命令处理。
- 对学习编辑器的人来说，`Transform`、`Visibility`、`Snapping` 和 `Group` 是最常用的一批对象级操作入口。
这张图展示在视口中点击一个场景里的 `Static Mesh` 后，`Outliner` 和 `Details` 如何同步定位到该对象。教程此时在说明：只要选中对应游戏对象，它的具体设置就会在右侧打开。

当前可确认信息：
- 视口镜头已经推近到场景中央的斜坡与平台区域。
- 当前选中物体的边缘以黄色轮廓显示。
- `Outliner` 中高亮的对象是 `SM_Cube9`，位于 `Block01` 文件夹下。
- 同一文件夹下还能看到一组相关静态网格：
  - `SM_Cube4`
  - `SM_Cube7`
  - `SM_Cube9`
  - `SM_Cube10`
  - `SM_QuarterCylinder3`
  - `SM_QuarterCylinder6`
  - `SM_Ramp2`
  - `SM_Ramp3`
- `Details` 面板标题为 `SM_Cube9`，显示 `SM_Cube9 (Instance)`。
- 在 `Transform` 区域可可靠辨认：
  - `Location = 1800, 1500, 0`
  - `Rotation = -0, 0, 0`
  - `Scale = 2.0, 7.0, 1.0`
  - `Mobility = Static`
- `Static Mesh` 区域中可见当前资源名为 `SM_Cube`。
- 底部状态栏显示 `1 Unsaved`，说明当前工程存在未保存修改。

输出/预览：
- 这一步的关键认知是：选中场景对象后，右侧 `Details` 会直接给出它的变换、静态网格和其他属性。
- 对后续实际制作来说，移动位置、改缩放、替换网格或查看对象类型，都要先经历这一步“选中对象 -> 查看 Details”。
这张图继续说明“选中不同对象会打开不同设置”。视口里当前选中的是一个蓝色方块，`Outliner` 与 `Details` 已同步切换到该对象的属性面板，右侧也出现了材质和物理参数。

当前可确认信息：
- 当前选中对象在 `Outliner` 中显示为 `SM_ChamferCube`，位于 `Playground` 文件夹下。
- 视口中该对象以黄色轮廓高亮，且显示了三轴移动 gizmo。
- `Details` 面板标题为 `SM_ChamferCube`，显示 `SM_ChamferCube (Instance)`。
- 在 `Transform` 区域可可靠辨认：
  - `Location = 1150, 2050, 50.01`
  - `Rotation = 0, 0, 0`
  - `Scale = 1.0, 1.0, 1.0`
  - `Mobility = Static`
- `Static Mesh` 区域中当前资源名显示为 `SM_Char...`，完整名称在截图中未完全展开。
- `Materials` 区域中可见：
  - `Element 0`
  - 材质名 `M_Solid_Blue`
- `Physics` 区域中可辨认：
  - `Simulate Physics` 已勾选
  - `Mass (kg) = 35.0`
  - `Linear Damping = 0.1`
  - `Angular Damping = 1.0`
- 右下角叠加键位提示为 `W`、`D`，说明正在演示视口移动或对象观察操作。

输出/预览：
- 这一步强调：不同类型或不同用途的场景物体，其 `Details` 中会暴露不同类别的参数。
- 与上一张只看到基础变换相比，这里已经能看到材质和物理选项，说明教程在引导读者理解“对象属性会随对象类型变化”。

### 00:09:43-00:12:38 关键流程 04

- 本段定位：关键流程 04。
- 知识点：Q鍵是一个选择 如果我们按W鍵 我们可观察到物体 可以移动它们在不同的X,Y,Z角度 Z是上下 我们可观察到它们有一个位置 在物体的设置中。
- 知识点：X是向後向後 Y是左向右 例如可以移动兩條線 然后可以移动像这樣 或是 这里有兩條線 可以移动Z和Y的兩條線 按E鍵 可以轉動。
- 知识点：也能够移动到角度 如果我按这里 可以把设置设置设置 设置成这樣 我们看到如果我们轉動Z 它会在这里和这里轉向左邊 这就是可以轉動的方式。
- 知识点：或是在这里的細節中 可以选择移动像这樣 按左鍵来调整 或是按下 然后我们需要的一些物体 55,25,15 另外如果我们按R鍵 可以分開地測量。
- 知识点：例如我现在測量在Z和X的角度 现在測量在Y和X的角度 如果需要測量在所有的角度 我需要在中间點擊 它会測量 或是可以在这里改变 按左鍵按下左鍵。

**关键画面：**

这张图展示 Unreal Editor 中按 `W` 进入移动工具后的对象操作方式。教程此时在讲：选中一个物体后，会出现三轴移动 gizmo，可以沿 `X / Y / Z` 三个方向单独拖动对象。

当前可确认信息：
- 当前选中对象是一个蓝色方块 `SM_ChamferCube`，在视口中以黄色轮廓高亮。
- 物体中心显示移动 gizmo：
  - 红色轴
  - 绿色轴
  - 蓝色轴
- 字幕明确说明：按 `W` 后，可以在不同的 `X`、`Y`、`Z` 轴上移动对象。
- `Outliner` 中当前选中项为 `SM_ChamferCube`。
- `Details` 面板里该对象的 `Transform` 当前可辨认：
  - `Location = 1010, 2060, 50.01`
  - `Rotation = 0, 0, 0`
  - `Scale = 1.0, 1.0, 1.0`
- `Materials` 中仍可见 `M_Solid_Blue`，`Physics` 中仍可见：
  - `Mass (kg) = 35.0`
  - `Linear Damping = 0.1`
  - `Angular Damping = 1.0`
- 右下角键位提示高亮 `W`，与当前移动模式相对应。
- 底部状态栏显示 `2 Unsaved`，说明已有未保存改动。

输出/预览：
- 这一步的核心是认识 `W = Move` 工具，以及三轴 gizmo 对应的位移方向控制。
- 对后续搭场景或摆放 Niagara 相关对象来说，先学会沿单轴移动是最基础的编辑器操作之一。
这张图展示同一个蓝色方块切换到旋转相关操作后的状态。视口中的 gizmo 不再是直线箭头，而是覆盖在物体表面的弧形旋转环；右侧 `Details` 里的 `Location` 与 `Rotation` 数值也同步发生了变化。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 视口中方块已经被抬高并靠近平台边缘，中心显示的是旋转圆弧 gizmo，而不是上一张的移动三轴箭头。
- 当前视角接近俯视，便于观察对象绕平面方向的旋转。
- `Details` 面板中的 `Transform` 当前可辨认：
  - `Location = 1050, 1910, 220.0`
  - `Rotation = 0, 0, -40.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Static Mesh` 仍是同一蓝色方块资源，`Materials` 仍可见 `M_Solid_Blue`。
- 字幕提到“点击这里可以重置这些设置，使其恢复原状”，说明教程正在说明可通过界面命令把当前变换恢复到原始值。
- 底部状态栏仍显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是让读者理解：对象的变换不只包括位移，还包括旋转；旋转后会直接体现在 `Details > Transform > Rotation` 数值上。
- 从当前画面能确认，教程已经把该方块移到空中并旋转了约 `-40` 度，用作演示变换参数会如何被记录和重置。
这张图继续演示对象变换，但重点已经从单纯位移/旋转转到组合变换与数值输入。蓝色方块被明显放大并倾斜摆放，右侧 `Details > Transform` 中的旋转和缩放值都被改成了非默认参数。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 视口中该蓝色方块已经大幅放大，并以斜靠姿态压在中间平台边缘。
- 物体中心仍显示三轴 gizmo，说明当前仍在对象变换上下文中。
- `Details` 面板里的 `Transform` 当前可可靠辨认：
  - `Location = 1050, 1910, 220.0`
  - `Rotation = 55.0, 25.0, 15.0`
  - `Scale = 5.0, 2.5, 2.5`
- 当前画面表明对象不再保持等比缩放，而是至少在 `X` 方向被放大到 `5.0`，`Y/Z` 为 `2.5`。
- `Static Mesh` 仍是同一蓝色方块资源，`Materials` 中仍可见 `M_Solid_Blue`，`Physics` 中仍保留前面可见的参数区。
- 右下角键位提示显示回车相关提示，结合正文上下文可知此段在讲通过数值和工具配合修改变换结果。

输出/预览：
- 这一步的重点是让读者看到：除了拖拽 gizmo，也可以直接在 `Details > Transform` 中输入具体数值控制对象的位置、旋转和缩放。
- 当前截图最直观地展示了非均匀缩放与多轴旋转叠加后的结果，有助于理解 `Transform` 三组参数如何共同决定物体姿态。

### 00:12:46-00:15:46 关键流程 05

- 本段定位：关键流程 05。
- 知识点：有时候是有用的 这里有更多的斜向 斜向是什么? 让我把所有物体都重新设置为0 物体已经移动到0的角度 什么是角度? 我们有三个角度 X和Y和每个物体。
- 知识点：游戏世界有它们的角度 空间位置 这里开始計算世界角度 它可以移动在世界角度 每个物体都有自己的角度 與中间相關 现在我移动到旁邊 其他都0。
- 知识点：與中间相關 物体会有它们的角度 也有地區角度 稍後需要展示差別 这里有更多的斜向 它可以被關掉 但现在需要展示它的意思 这里是斜向 需要把它改为100。
- 知识点：当我开始移动在任何角度 它移动到100 可以放500 如果按G 可以避開或透露地面 它现在移动了500个物体 可以移动5个物体 同樣地。
- 知识点：10个物体会轉動 以便利的物体管理 如果按R 它会移动整个数字 它会移动到0.25 如果我们需要 非常精確地去做一些修正 或者改变角度 可以把它们關掉。

**关键画面：**

这张图继续以 `SM_ChamferCube` 为例讲解编辑器中的吸附与重置思路。字幕明确提到“这里有更多的吸附功能”，而右侧 `Transform` 数值已经恢复到标准默认值，说明教程正在从前一段的位移/旋转/缩放示例回到初始状态，准备演示吸附步进等功能。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`，位于 `Playground` 文件夹下。
- 视口中该物体已经恢复成与周围平台同类的灰色几何体外观，不再呈现前面被抬高、旋转、放大的蓝色演示状态。
- `Details > Transform` 当前可可靠辨认：
  - `Location = 0.0, 0.0, 0.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Static Mesh` 仍是同一 `SM_Char...` 资源，`Materials` 中可见 `M_Solid_Blue`。
- `Physics` 中仍可辨认：
  - `Mass (kg) = 35.0`
  - `Linear Damping = 0.1`
  - `Angular Damping = 1.0`
- 字幕说明当前话题已经转到 `snapping`。
- 底部状态栏仍显示 `2 Unsaved`。

输出/预览：
- 这一步的关键是让读者知道：在继续讲吸附规则前，教程先把示例对象的变换值重置回默认状态。
- 对后续理解网格吸附、角度吸附和缩放吸附来说，这样的“归零后再演示”能避免前一段变换结果干扰观察。
这张图继续演示对象吸附。蓝色方块被拖到第三人称模板场地边界之外，视口里能清楚看到它沿世界网格对齐；顶部工具栏中的吸附相关按钮和步进数值也比前面更醒目，正对应字幕所说“这个功能可以被关闭，但现在先展示它的意义”。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 该方块位于场地外墙左下侧，紧贴世界网格线，显示移动 gizmo。
- `Details > Transform` 仍保持默认值：
  - `Location = 0.0, 0.0, 0.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- 顶部视口工具栏中，吸附相关数值可辨认：
  - 平移吸附步进显示为 `100`
  - 旋转吸附步进显示为 `10°`
  - 缩放吸附步进显示为 `0.25`
- 右下角键位提示为 `A`、`S`，说明教程正在配合视口移动演示该吸附效果。
- `Static Mesh`、`Materials`、`Physics` 区域仍显示与该方块对应的资源和参数，底部状态栏仍是 `2 Unsaved`。

输出/预览：
- 这一步的核心是让读者知道：编辑器顶栏的吸附可以控制对象移动、旋转和缩放时的步进。
- 当前画面最直观的信息是平移吸附已设为 `100`，因此对象在拖动时会按固定距离跳格，而不是连续自由移动。
这张图继续演示吸附步进对对象变换结果的影响。蓝色方块已经被拖到远离模板场地的位置，并带有明显旋转和非均匀缩放；顶部吸附栏中的步进值也切换成了更粗的设置，用来说明对象会按固定增量跳变，而不是连续变化。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 视口中方块悬浮在场地外侧远处，只剩右边一小段关卡外墙作为参照物。
- 对象中心显示移动 gizmo，说明仍在变换操作上下文中。
- 顶部吸附相关步进值当前可辨认：
  - 平移吸附步进为 `5`
  - 旋转吸附步进为 `45°`
  - 缩放吸附步进为 `1`
- `Details > Transform` 当前可可靠辨认：
  - `Location = 0.0, -920.0, 417.0`
  - `Rotation = 124.9, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 2.0`
- `Materials` 中仍可见 `M_Solid_Blue`，`Physics` 中仍保留：
  - `Mass (kg) = 35.0`
  - `Linear Damping = 0.1`
  - `Angular Damping = 1.0`
- 底部状态栏仍显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是让读者理解：吸附设置不仅影响平移，也影响旋转和缩放时每次变化的增量。
- 当前画面用极端位置和姿态展示了这一点：对象旋转被限制到较大的角度步进，缩放也按离散值变化，而不是细微连续调整。

### 00:15:51-00:20:46 PS

- 本段定位：PS。
- 知识点：如果我们需要移动物体 可以把它關掉 我现在把位置關掉了 可以把角度改变角度 也把它關掉 当然也要改变角度 我们来看看它的角度 这里也有一个圖案。
- 知识点：它会做什么 我按它 它会改变 这里可观察到它改变了 我现在将物体设置为0 所有物体都设置为0 当然了 位置可以留下 但也好 我现在把它轉動 我们把它轉为5°-55°。
- 知识点：在X 现在看 我正在按W 它叫做轉变 移动 现在看看Z在哪里 它现在轉向了 我们轉向的方向 我现在轉動 它轉向了位置 它显示了方向 这是现在的位置檔案。
- 知识点：Z轉向了位置 到这个位置 它是全球的 它总是不改变的 我现在将它轉動 如果它显示了 它总是全球的 不管我怎麼轉 Z总是会上下的 X总是会在这个方向。
- 知识点：Y总是会在这个方向 这通常是用作方便的操作 有时候我们需要轉動它 需要把它移动在这个方向 在Z的方向面对 但要怎麼做 这是我这樣做的 这次是Y。
- 知识点：它会变成这樣 或者是这个方向 我轉動它 它会变成这个方向 这类操作方便的 如果需要它在上面显示 需要改变它 它会变成这个方向 它会飛離我 Ctrl。
- 知识点：Z可以取消 我们記得了 这是在所有程式中 Ctrl Z的基本法 Ctrl Shift Z可以回到原位 如果我按F 它会显示这个方向 如果我移动到某个位置。

**关键画面：**

这张图展示切换到 `E` 旋转工具后的对象操作。视口里蓝色方块周围出现了旋转圆环 gizmo，字幕也在讲“这里有一个图案，按它会改变”，对应对象绕某一轴旋转时的交互方式。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 视口中的方块位于模板场地外侧空中，靠近右侧围墙外边。
- 物体表面叠加了一个圆环形旋转 gizmo，并出现当前旋转角度的浮动读数，能辨认到约 `-78.50`。
- 右下角键位提示高亮 `E`，对应旋转工具。
- 顶部吸附栏仍可见：
  - 平移步进 `5`
  - 旋转步进 `45°`
  - 缩放步进 `1`
- `Details > Transform` 当前可可靠辨认：
  - `Location = -0.0, -926..., 425.5`
  - `Rotation = 50.70, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 2.0`
- `Materials` 中仍可见 `M_Solid_Blue`，`Physics` 中仍保留质量与阻尼参数。
- 底部状态栏仍显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：按 `E` 可以切换到旋转模式，通过圆环 gizmo 沿指定轴旋转对象。
- 当前截图同时说明，旋转结果既会体现在视口角度读数上，也会同步写入 `Details > Transform > Rotation`。
这张图继续说明“物体旋转后，本地坐标方向也会跟着变化”。蓝色方块悬浮在第三人称模板场地上方，已经绕多个轴转向；字幕明确说明“相对于我如何旋转它，它会改变其坐标方向”，对应局部坐标系随对象姿态变化的概念。

当前可确认信息：
- 当前选中对象仍为 `SM_ChamferCube`。
- 视口中该方块悬浮在模板场地外侧上空，已经明显发生了多轴旋转。
- 对象中心显示的 gizmo 方向不再和世界水平垂直方向完全重合，说明当前正在观察局部轴向变化。
- 顶部吸附栏中的步进值当前可辨认：
  - 平移步进 `5`
  - 旋转步进 `5°`
  - 缩放步进 `1`
- `Details > Transform` 当前可可靠辨认：
  - `Location = -1049, -81.7, 711.6`
  - `Rotation = -149..., -18.2, -225...`
  - `Scale = 1.0, 1.0, 1.0`
- `Materials` 中仍可见 `M_Solid_Blue`，`Physics` 区域仍显示该对象的质量与阻尼设置。
- 右下角键位提示显示 `S`，说明教程在配合视口导航观察旋转后的坐标方向。
- 底部状态栏仍显示 `2 Unsaved`。

输出/预览：
- 这一步的重点不是再讲某个快捷键，而是让读者理解“世界坐标轴”和“物体自身局部坐标轴”并不总是同一个方向。
- 当前截图通过把物体旋转到复杂姿态，直观展示了局部轴会随对象一起转向，这对后续精确移动和对齐物体很重要。
这张图切换到视口显示设置，重点不再是单个物体的旋转，而是 `Viewport Options` 里的 `Screen Percentage`。教程在这里讲视口清晰度与渲染分辨率的关系，并说明这个数值可以调高或调低来改变当前编辑器视口的显示精度。

当前可确认信息：
- 左上角 `Perspective / Lit / Show` 旁边的视口菜单已展开。
- 一级菜单中高亮的是 `Screen Percentage`，右侧子菜单展示当前视口分辨率缩放信息。
- `Screen Percentage` 子菜单可可靠辨认：
  - `Current Screen Percentage: 53.0`
  - `Resolution: 1681x1015 -> 3170x1915`
  - `Active Viewport: Desktop Rendered`
  - `Set From: Viewport Override`
  - `Setting: Manual`
  - `Custom Override` 已勾选
  - `Screen Percentage = 100`
- 左侧菜单中还能辨认的相关项包括：
  - `Realtime`
  - `Show FPS`
  - `Show Stats`
  - `Stat`
  - `Show Toolbar`
  - `Field of View (H) = 90.0`
  - `Far View Plane = 0.0`
  - `Game View`
  - `Immersive Mode`
  - `Allow Camera Shakes`
  - `Bookmarks`
  - `Create Camera Here`
  - `High Resolution Screenshot...`
  - `Advanced Settings...`
- 当前 `Outliner` 中选中对象已变为 `SM_Cube4`，`Details` 面板显示 `SM_Cube4 (Instance)`。
- `Transform` 当前可辨认：
  - `Location = 1200, 1700, 0.0`
  - `Rotation = 0.0, 0.0, -0.0`
  - `Scale = 6.0, 5.0, 2.0`
- `Materials` 中可见 `M_PrototypeG...`，`Physics` 区域可见不同于前面蓝色方块的一组参数。
- 底部状态栏显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是告诉读者：如果需要更清晰地预览效果，可以调整视口 `Screen Percentage`，而不是只盯着对象本身的变换。
- 对后续检查 Niagara、材质或建模细节时，理解 `Screen Percentage` 非常有用，因为它直接影响编辑器视口里的清晰度和性能开销。

### 00:20:46-00:25:42 Blender

- 本段定位：Blender。
- 知识点：是一个很大的延伸 如果按100 画面会更清晰 当你完成了你的效果 需要展示给你 結果会非常清晰 即使是10% 通常50%会在这里设置 因为如果按10。
- 知识点：画面会变得很清晰 这是为了保留效果 以免画面太多 而在基本上 这里没有什么更有趣的 当我们设置相機 这里通常会是 我们选择的 我们按No 视觉角度是從上方。
- 知识点：或從側面 哦 哦 啊 我选择了天空 它是非常大的 我按了它 因为它非常大 它让我们遠離了 按着小圖 来回復小的某个物体 视觉模式 LED是当我们的物体。
- 知识点：显示出来 在游戏中 在刷新时刻显示出来的 这是光學模式 当所有东西都完美地 光學模式 当我们的物体都亮起了 然后所有东西都完美了 我们通常都在LED。
- 知识点：LED是当我们没有光學物体 光學模式已经消失了 当我们的物体都没有亮起了 它就不太好 感覺像2000画面一樣 Wireframe Polygons都显示在3D物体上。
- 知识点：我们看到了一些很像的东西 在Blender 我们可观察到3D的物体 有多少Polygons或Vertices 这是光學模式 这是各种改善。
- 知识点：可观察到 我们显示的光學模式 在显示中 我们把所有东西都放在標準上 我们没有改变任何东西 这里可观察到 我们想显示的物体 我们有滑動 这是物体的滑動。
- 核对对象：`Blender`。

**关键画面：**

这张图延续 Unreal Editor 基础界面讲解，当前选中的是 `Block01` 文件夹中的 `SM_Cube4`。教程刚结束视口清晰度相关说明，这里回到场景本身，继续用模板里的几何体说明编辑器观察和对象选择。

当前可确认信息：
- 当前关卡仍为 `ThirdPersonMap`。
- 视口镜头从上方向下观察平台区域，左侧可见一部分被黄色轮廓选中的几何体边缘。
- `Outliner` 中当前选中对象为 `SM_Cube4`，位于 `Block01` 文件夹下。
- `Details` 面板显示 `SM_Cube4 (Instance)`，当前 `Transform` 可可靠辨认：
  - `Location = 1200, 1700, 0.0`
  - `Rotation = 0.0, 0.0, -0.0`
  - `Scale = 6.0, 5.0, 2.0`
- `Static Mesh` 区域显示资源名以 `SM_Cub...` 开头。
- `Materials` 中可见 `M_PrototypeG...`。
- `Physics` 区域仍显示该对象的物理相关参数区。
- 右下角键位提示为 `S`，底部状态栏显示 `1 Unsaved`。

输出/预览：
- 这一步的作用是继续用默认模板里的平台几何体演示对象选择与参数读取，而不是引入新的系统。
- 对读者而言，关键是知道：无论是蓝色方块还是灰色平台块，只要在 `Outliner` 或视口中选中，右侧 `Details` 都会给出同样结构的对象信息入口。
这张图展示把视口模式切换到 `Wireframe` 之后的效果。教程在这里把 Unreal 的线框显示方式类比到 Blender，用来说明 3D 物体的 `polygons / vertices` 可以通过线框模式直接观察。

当前可确认信息：
- 左上角视口模式显示为 `Perspective` 与 `Wireframe`，说明当前不再是前面的 `Lit` 着色模式。
- 主视口背景变成黑底，场景几何体以浅色线框显示。
- 线框中能清楚看到大量三角面分割与顶点汇聚结构，中心区域出现多个亮黄色的顶点/节点汇聚点。
- 当前 `Outliner` 中选中对象仍为 `SM_Cube4`，`Details` 面板仍显示 `SM_Cube4 (Instance)`。
- `Transform` 数值保持：
  - `Location = 1200, 1700, 0.0`
  - `Rotation = 0.0, 0.0, -0.0`
  - `Scale = 6.0, 5.0, 2.0`
- `Materials` 中仍可见 `M_PrototypeG...`，底部状态栏仍显示 `1 Unsaved`。
- 右下角键位提示显示 `W`，说明教程仍在配合视口导航或对象操作进行讲解。

输出/预览：
- 这一步的重点是让读者认识 `Wireframe` 视图的用途：它不是为了看材质，而是为了直接观察模型的面片分布、边线结构和顶点密度。
- 对后续涉及建模、Mesh 优化或导入检查的内容来说，线框视图是非常基础的诊断方式。
这张图展示切换到 `Play In Editor` 之后的第三人称模板运行状态。教程此时在说明：编辑模式和游戏运行模式不同，进入播放后，项目里的角色控制、逻辑和交互会按游戏方式实际运行。

当前可确认信息：
- 主视口已从普通编辑状态切换到游戏运行画面，屏幕中央出现第三人称模板的人形角色。
- 顶部工具栏中可见播放中的控制按钮：
  - 暂停
  - 单步/继续
  - 停止
- 左上角提示 `Shift+F1 for Mouse Cursor`，这是 Unreal 在 PIE 模式下释放鼠标的常见提示。
- `Outliner` 顶部世界名已变成 `ThirdPersonMap (Play In World)`，说明当前确实在运行中的游戏世界，而非单纯编辑视图。
- `Outliner` 中对象数量显示为 `47 actors (47 loaded)`。
- `Details` 面板当前为空，提示选择对象后查看详情。
- 右下角键位提示显示：
  - `W`
  - `space`
  - `D`
  说明教程正在演示角色移动与跳跃等基础输入。
- 场景本身仍是默认第三人称测试关卡：网格地面、圆台、斜坡和围墙都保持可见。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者区分两种状态：
  - 编辑模式：主要用于摆放物体、改参数
  - 游戏运行模式：用于实际测试角色控制、逻辑和效果表现
- 对后续 Niagara 教程来说，很多特效只有在播放状态下才能完整验证，因此学会进入和退出 `Play In Editor` 很关键。

### 00:25:42-00:30:34 关键流程 08

- 本段定位：关键流程 08。
- 知识点：它会啟動視角 这会开启新的窗戶 很方便 例如 如果你想要編輯和看什么 它会從旁邊开启 这只是一个游戏 它会生成一个不同的游戏 我们还没有碰到瀏覽者。
- 知识点：我们通常会选择瀏覽視角 通常在作用效果的时候 我们不会把画面關掉 还有兩个玩游戏模式 还有一个編輯模式 现在在編輯模式 在編輯模式的时候。
- 知识点：我们没有游戏的 但这里有玩游戏模式 我们點擊 然后游戏开始玩 所有邏輯都应该運作得相同 納格拉是一个磁石系统 我们的材料 可以在編輯模式里看到。
- 知识点：我们来談談这些物品的种类 这些圖案 我们还没有碰到 它们是设置的 这是一个重要的设置 需要考慮在創作效果上 但我们还不需要 这是我们需要快速加到作品。
- 知识点：这是什么? 可以理解 这是一个快速加到作品的东西 这里可以在 Unreal Marketplace 從这里输入資料 这是一个開發商店 可以買。
- 知识点：加上各种游戏物品 鑑購開的 或者像我剛才所說的 可以把它加上 所有我们的資料 都可以在这里存放在文件里 这里已经有很多 基本的角色、角色、點光。
- 知识点：只要我们不需要它 这里可以创建一个角色 例如說 用邏輯的話 它们可以被创建 现在需要把光线斷掉 但需要想创建一个空氣層 因为它是一个邏輯層。
- 核对对象：`系统`。

**关键画面：**

这张图展示 Unreal Editor 顶部 `Play` 按钮的下拉菜单。教程此时在说明：除了直接在当前视口播放，还可以选择在新窗口、独立进程或模拟模式中运行关卡，以便一边编辑一边观察结果。

当前可确认信息：
- 主视口仍处于编辑模式，当前选中对象为 `SM_Cube4`。
- 顶部 `Play` 菜单已展开，`Modes` 区域可辨认：
  - `Selected Viewport`
  - `New Editor Window (PIE)`
  - `VR Preview`
  - `Standalone Game Mobile`
  - `Standalone Game`
  - `Simulate`
- 当前高亮项为 `Standalone Game`。
- 右侧提示文本说明：`Play this level in a new window that runs in its own process`，用于解释独立运行模式。
- `Quick Launch` 区域可见目标设备名 `DESKTOP-JVQ0GFS`。
- `Spawn Player At...` 区域可见：
  - `Current Camera Location`
  - `Default Player Start`
- `Multiplayer Options` 区域可见：
  - `Number of Players = 1`
  - `Net Mode`
  - `Advanced Settings...`
- `Outliner` 中仍显示 `SM_Cube4` 被选中，`Details` 面板中其 `Transform` 仍是：
  - `Location = 1200, 1700, 0.0`
  - `Rotation = 0.0, 0.0, -0.0`
  - `Scale = 6.0, 5.0, 2.0`

输出/预览：
- 这一步的重点是让读者知道 `Play` 不是单一按钮，而是一个包含多种运行模式的入口。
- 对后续做 Niagara 或材质效果测试时，`New Editor Window (PIE)`、`Standalone Game` 和 `Simulate` 各有不同用途：前者方便并排观察，后者更接近独立运行，`Simulate` 则适合只验证场景逻辑。
这张图展示 Unreal Editor 顶部 `+ Add` 菜单。教程此时开始说明如何快速往关卡里添加内容，或者从编辑器入口跳到资源浏览、Marketplace 和常用 Actor 分类。

当前可确认信息：
- 主视口仍是第三人称模板场地的俯视图。
- 左上工具栏 `+ Add` 菜单已展开。
- `Get Content` 区域可辨认：
  - `Import Content...`
  - `Quixel Bridge`
  - `Unreal Marketplace`
  - `Content Browser`
- `Place Actors` 区域可辨认分类：
  - `Basic`
  - `Lights`
  - `Shapes`
  - `Cinematic`
  - `Media Plate`
  - `Visual Effects`
  - `Volumes`
  - `All Classes`
  - `Place Actors Panel`
- 当前高亮的是 `Lights`，其子菜单可辨认：
  - `Directional Light`
  - `Point Light`
  - `Spot Light`
  - `Rect Light`
  - `Sky Light`
- `Recently Placed` 区域可见：
  - `Cone`
  - `Cube`
- 右侧 `Outliner` 仍选中 `SM_Cube4`，`Details` 中的 `Transform` 仍保持：
  - `Location = 1200, 1700, 0.0`
  - `Rotation = 0.0, 0.0, -0.0`
  - `Scale = 6.0, 5.0, 2.0`
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：往场景里加内容并不一定要先找资源文件，也可以直接用 `+ Add` 菜单按类型快速创建或放置 Actor。
- 当前截图最直观展示的是 `Lights` 分类，因此读者可以据此知道如何快速添加常见灯光对象。
这张图展示已经切换到一个新的空关卡，并在其中选中了 `PointLight`。教程此时开始强调：为做效果测试，通常会建立更干净的逻辑关卡，然后在里面单独添加和调节需要的灯光或其他基础对象。

当前可确认信息：
- 左上关卡名已变为 `Untitled*`，说明当前不是原来的 `ThirdPersonMap`，而是一个未保存的新关卡。
- 主视口只保留了简化环境：
  - 棋盘格地面
  - 蓝色天空背景
  - 一个 `PointLight` 的影响范围可视化球体
  - 地面上一块浅绿色发光区域，说明灯光颜色已被改成偏绿色
- `Outliner` 顶部世界名为 `Untitled (Editor)`。
- 当前场景对象总数显示为 `9 actors (1 selected)`。
- `Outliner` 中可辨认对象包括：
  - `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
  - `Floor`
  - `PlayerStart`
  - `PointLight`
- 当前选中对象是 `PointLight`，`Details` 面板标题也显示 `PointLight` / `PointLight (Instance)`。
- 右下角打开了 `Color Picker`：
  - `sRGB Preview` 已勾选
  - 右侧 `Old / New` 对比块显示当前颜色已调整为浅绿色
  - 可辨认参数包括：
    - `H = 133.372345`
    - `S = 1.0`
    - `V = 1.0`
    - `Hex Linear = 00FF39FF`
    - `Hex sRGB = 00FF82FF`
- `Intensity` 区域右上能看到 `500.0` 之类的数值输入框，但完整属性名在当前截图中未完全展开。

输出/预览：
- 这一步的重点是让读者知道：为了专注测试效果，完全可以新建一个空关卡，再逐个加入最基本的光照和辅助对象。
- 当前截图最直接的操作结果是：新关卡中加入了 `PointLight`，并通过颜色选择器把它改成了绿色光。

### 00:30:34-00:35:32 关键流程 09

- 本段定位：关键流程 09。
- 知识点：这或那个 通常是用在我们的世界上 将光线調校到 我们需要将光线調校到这个位置嗎? 这里可以有些3D物品 现在需要把它提前調校 需要在这里创建。
- 知识点：方向光是我们的陽光 它是我们的通常光 例如在这些加強的地方 它可以是一些光线 等等 这里可观察到 它是如何创建的光 你看到它们有不同的设置。
- 知识点：標籤是这樣的 这是我们的设置 例如这里有一个標籤 是我们的光线 量是后续会光线調校到的量 这是什么意思? 这里有一个範圍 光线範圍的範圍 会增加或降低。
- 知识点：这是光线在这个範圍的光线 这里有一个圖案 这里可以調校 例如 調校點擊这里 它会做到 但我们有一个開關 Ctrl D 它是为了調校这个物品 我这里調校了。
- 知识点：现在我把它推開 把它推90度 现在需要它移动 我们可观察到它现在光着一邊 Ctrl C是为了创建 Ctrl V是为了删除 可以创建另一个 只要在画面中选择任何物品。
- 知识点：按Alt 我们把它移动 它立刻创建一个新物品 可以立刻移动 如果我不按Alt 它就移动了 抱歉,我选择了它们 并且删除了它们 显示了我们不需要的东西。
- 知识点：我们要做什么? 可观察到这點光 这很清楚 光线像一盞藍灯 显示了它的範圍 可以調校它的重量 需要調校它的颜色。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`颜色`。

**关键画面：**

这张图展示在空关卡中继续调整 `PointLight` 参数。教程此时重点讨论的是：这个点光是否需要对物体投射阴影，因此右侧 `Details` 面板已经滚动到 `Rendering` 与光照参数区域。

当前可确认信息：
- 当前关卡仍为未保存的新关卡 `Untitled*`。
- `Outliner` 中选中对象为 `PointLight`，对象总数显示为 `9 actors (1 selected)`。
- 主视口里可见：
  - 点光源影响范围的白色球形线框
  - 地面上的高亮白色光斑
  - 点光源位置的三轴 gizmo
- `Details` 面板当前可可靠辨认的 `PointLight` 参数包括：
  - `Intensity Units = Candelas`
  - `Light Color`
  - `Attenuation Radius = 1000.0`
  - `Source Radius = 0.0`
  - `Soft Source Radius = 0.0`
  - `Source Length = 0.0`
  - `Use Temperature`
  - `Temperature = 6500.0`
  - `Affects World` 已勾选
  - `Cast Shadows` 当前处于关闭状态，提示浮层显示 `False`
  - `Indirect Lighting Intensity`
  - `Volumetric Scattering Intensity = 1.0`
- `Rendering` 区域中还能看到：
  - `Visible` 已勾选
  - `Actor Hidden In Game`
  - `Editor Billboard Scale = 1.0`
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：灯光不只是调颜色和范围，还要根据效果需求决定是否投射阴影。
- 当前截图最重要的操作点是 `Cast Shadows` 被显式切到 `False`，说明教程在演示如何让点光只提供照明而不增加阴影开销或干扰效果。
这张图展示在空关卡中摆放一个基础 `Cube` 物体。教程此时从灯光延伸到“场景里任何物品都可以继续创建、复制和移动”，因此当前镜头对准了墙角处新放置的立方体。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象变成了 `Cube`，对象总数显示为 `12 actors (1 selected)`。
- `Outliner` 还能看到：
  - `Lighting`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
  - `Floor`
  - `Floor2`
  - `Floor3`
  - `PlayerStart`
- 视口中可见一个浅灰色小立方体被摆放在地面靠墙的位置，物体上显示移动 gizmo。
- 立方体附近还能看到一个光源图标，地面与墙面形成明显的受光亮区。
- `Details` 面板标题为 `Cube` / `Cube (Instance)`，`Transform` 当前可可靠辨认：
  - `Location = -645..., -5.0, 195.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Static Mesh` 区域中资源名直接显示为 `Cube`。
- `Materials` 中可见 `BasicShapeMa...`。
- 右下角键位提示高亮 `alt`，结合本段讲解，可用于辅助理解复制/拖拽相关操作。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：在空关卡里可以快速加入基础几何体作为测试参照物。
- 当前截图也说明，新增物体后依然通过同样的 `Outliner + Details + gizmo` 工作流来定位、移动和调整它。
这张图展示在空关卡中添加并调整 `SpotLight`。教程此时已经从点光扩展到聚光灯，重点变成聚光范围、颜色和阴影等更适合营造定向效果的光照参数。

当前可确认信息：
- 当前关卡仍为 `Untitled*`，`Outliner` 中场景对象数显示为 `12 actors (1 selected)`。
- 当前选中对象是 `SpotLight`，`Details` 面板标题显示 `SpotLight` / `SpotLight (Instance)`。
- 主视口中可以看到：
  - 聚光灯位置附近的旋转/移动 gizmo
  - 一个向前展开的圆锥形照射范围线框
  - 地面上一块偏粉色的受光区域
- 右下角打开了 `Color Picker`，当前颜色是偏洋红/紫粉色，能可靠辨认：
  - `sRGB Preview` 已勾选
  - `Old / New` 对比块均为紫粉色系
  - `H = 309.31839`
  - `S = 1.0`
  - `V = 1.0`
  - `Hex Linear = FF00D7FF`
  - `Hex sRGB = FF00EDFF`
- `Details` 面板中 `SpotLight` 参数可可靠辨认：
  - `Intensity = 500.0 cd`
  - `Intensity Units = Candelas`
  - `Light Color` 为紫粉色
  - `Attenuation Radius = 718.036926`
  - `Inner Cone Angle = 27.002291`
  - `Outer Cone Angle = 48.309731`
  - `Source Radius = 0.0`
  - `Soft Source Radius = 0.0`
  - `Source Length = 0.0`
  - `Use Temperature` 已勾选
  - `Temperature = 2027.314209`
  - `Affects World` 已勾选
  - `Cast Shadows` 已勾选
  - `Indirect Lighting Intensity = 1.0`
  - `Volumetric Scattering Intensity = 1.0`
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者理解：`SpotLight` 比 `PointLight` 多了明显的方向性和锥形范围，因此更适合做聚焦照明或舞台式效果。
- 当前截图最直接的结果是：教程把聚光灯调成了紫粉色，并同时设置了锥角、范围和阴影选项，以便更精确地控制光斑表现。

### 00:35:32-00:37:44 关键流程 10

- 本段定位：关键流程 10。
- 知识点：哦!这里没有效 只能用在你用的材料上 稍後需要展示给你 我们用的材料上的效果 我把白色放在这里 但溫度改变了 如果我把溫度調到左邊 它会更熱。
- 知识点：如果我选择大小的價值 溫度就会变得更熱 需要怎麼做呢 綠灯 它是一條圆圆的 这是它的溫度 这光线的範圍 可以在一樣的方式 增加它的光线的高度。
- 知识点：我不会說它是常常用的 通常 光线 點光线 和方向光 方向光是最重要的 这里我可以把 在鏡頭上的方向光轉掉 就像是陽光 亮起整个鏡頭 陽光是從天空来的。
- 知识点：我们有个天空 还有雲霧 可以被轉掉 这里是我们的陽光 如果我把它轉掉 它会影响它的高度 我们也可以在这里。

**关键画面：**

这张图继续在空关卡里调整 `SpotLight`。与上一段相比，颜色选择器已基本收起，重点转到直接观察聚光灯在场景里的照射范围、颜色结果和右侧 `Details` 面板中的核心参数。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `SpotLight`，对象数量显示为 `12 actors (1 selected)`。
- 主视口中可见：
  - 聚光灯的圆锥形照射范围线框
  - 墙角处的灯光 gizmo
  - 地面上的粉色光斑
- `Details` 面板中当前可可靠辨认的 `SpotLight` 参数包括：
  - `Intensity = 500.0 cd`
  - `Intensity Units = Candelas`
  - `Light Color` 为紫粉色
  - `Attenuation Radius = 718.036926`
  - `Inner Cone Angle = 27.002291`
  - `Outer Cone Angle = 48.309731`
  - `Source Radius = 0.0`
  - `Soft Source Radius = 0.0`
  - `Source Length = 0.0`
  - `Use Temperature` 已勾选
  - `Affects World` 已勾选
  - `Cast Shadows` 已勾选
  - `Indirect Lighting Intensity = 1.0`
  - `Volumetric Scattering Intensity = 1.0`
- 右下角仍能看到颜色调整相关浮层的一小部分，说明刚刚进行过颜色参数编辑。
- 右下角键位提示高亮 `W`，表明教程正在配合移动或观察灯光位置。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：聚光灯的最终表现由颜色、强度、衰减半径和内外锥角共同决定。
- 当前截图最直观的结果是一个带粉色调的定向光斑，说明教程正在用 `SpotLight` 搭建更可控的效果测试灯光。
这张图展示在空关卡中切换到 `RectLight`。教程此时从点光、聚光继续扩展到矩形灯光，强调不同光源类型会暴露不同的专属参数，例如矩形光的宽高和遮光门设置。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `RectLight`，对象数量显示为 `12 actors (1 selected)`。
- 主视口里可见：
  - 一个细长的黄色矩形线框，表示 `RectLight` 的发光面范围
  - 地面上的白色矩形/椭圆形高亮受光区域
  - 光源中心的三轴 gizmo
- `Details` 面板中当前可可靠辨认的 `RectLight` 参数包括：
  - `Intensity = 160.0 cd`
  - `Intensity Units = Candelas`
  - `Light Color`
  - `Attenuation Radius = 1217.537964`
  - `Source Width = 576.000244`
  - `Source Height = 64.0`
  - `Barn Door Angle = 88.0`
  - `Barn Door Length = 20.0`
  - `Source Texture = None`
  - `Use Temperature`
  - `Temperature = 6500.0`
  - `Affects World` 已勾选
  - `Cast Shadows` 已勾选
- `Transform` 区域当前处于折叠状态，但能看到 `Rotation / Scale / Mobility` 行存在。
- 右下角键位提示为 `D`，底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者理解：`RectLight` 的核心不是锥角，而是发光面的尺寸与遮光门控制，因此更适合做面状补光或柔和条形光。
- 当前截图最直接的结果是：教程已经把矩形灯放在地面附近，并通过宽高参数形成了一块更扁、更均匀的受光区域。
这张图切换到空关卡里的环境对象设置，当前选中的是 `VolumetricCloud`。教程此时从“直接加灯光”转向“默认天空、云层与环境组件也会影响画面”，因此开始查看这些环境 Actor 的开关和参数。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `VolumetricCloud`，场景对象数显示为 `11 actors (1 selected)`。
- `Outliner` 还能看到当前环境相关对象：
  - `Lighting`
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
  - `Cube`
  - `Floor`
  - `Floor2`
- 左侧对象列表旁的“眼睛”可见性图标清楚显示在 `SM_SkySphere` 与 `VolumetricCloud` 行附近，说明教程正在演示这些环境对象可以被显示/隐藏。
- `Details` 面板中 `VolumetricCloud (Instance)` 当前可可靠辨认：
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
  - `Layer Bottom Altitude = 5.0`
  - `Layer Height = 10.0`
  - `Tracing Start Max Distance = 350.0`
  - `Tracing Max Distance Mode = Distance from Cloud`
  - `Tracing Max Distance = 50.0`
  - `Planet Radius = 6360.0`
  - `Ground Albedo`
  - `Cloud Material` 区域中 `Material = m_Simpl...`
  - `Cloud Tracing` 区域可见，`Sky Light Cloud Bottom Occl... = 0.5`
- 主视口里当前只保留空关卡地面、墙面和几个基础物体，天空区域相对简单，符合正在调环境组件开关的场景。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的重点是让读者知道：除了手动加灯，环境系统里的 `SkyLight`、`SkyAtmosphere`、`VolumetricCloud` 也会显著影响最终画面。
- 当前截图最直接传达的是：这些对象既能在 `Outliner` 中开关可见性，也能在 `Details` 中调节云层高度、追踪距离和云材质。

### 00:39:02-00:43:57 关键流程 11

- 本段定位：关键流程 11。
- 知识点：它们并不是用来做效果 它们只是为了阻擋 为了创建高度 我们不碰觸其他东西 我会创建一塊 这里我们可观察到我们的動作 看看Transform。
- 知识点：到我们的位置 位置 轉向 高度 我把它高度 噢 我重新控制它 这是我把它伸直 改变了它的位置 这是它在世界的位置 和它的指定 这里有一个文件 記得我說。
- 知识点：可以把物体雙倍 现在需要把高度降到1 这是一个普通的物体 这里有一个圖案 可以把一个物体放在另一个 把这个物体放在另一个 可以把这个物体放在这个。
- 知识点：例如 如果需要把所有这些物体都移动 它们都被連接到主体 它们都被連接到圖案 需要它们全部取消 需要只留下一个物体 它会被依靠 我们可观察到結果。
- 知识点：也有关于这个物体的高度 这里有一个點 这里有个5和3和4的高度 我们記得我们把1和1和1放在这个物体 但现在它的高度已经改变了 我正在创建另一个圖案。

**关键画面：**

这张图开始演示把普通静态网格体当作“观察动作和高度变化的参照物”。当前选中对象是 `Cylinder`，教程重点不是继续调灯，而是通过改物体自身 `Transform` 来观察位置、缩放和遮挡结果。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Cylinder`，场景对象数显示为 `15 actors (1 selected)`。
- 场景中可见一个被拉高的白色圆柱体，边缘有黄色选中描边，圆柱前方和右侧地面上能看到明显阴影。
- 圆柱中心显示三轴移动 gizmo，说明当前在移动模式下观察该物体。
- `Details` 面板显示的是 `Cylinder (Instance)`，其 `Transform` 区域当前可可靠辨认为：
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = -1.0, 4.0, 6.0`
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `Cylinder`。
- `Materials` 区域可见 `Element 0`，材质槽使用的是基础白色材质球。
- 右下角状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步最直接传达的是：教程把 `Cylinder` 拉成了一个高而扁的立面，用它作为后续观察位置、高度和父子跟随关系的参照。
- 从当前画面可见，缩放后的圆柱已经成为场景里最主要的遮挡体，阴影结果也会随着它的尺寸变化而改变。
这张图继续讲普通物体的 `Transform`。当前选中对象切换为 `Cube`，重点是通过位置、旋转和缩放，让一个简单立方体变成更容易观察跟随关系和世界/局部变换差异的参照体。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Cube`，场景对象数显示为 `12 actors (1 selected)`。
- 主视口中可见一个放大的白色立方体，边缘带黄色选中描边，立方体前方另有一个较小白色方块与两块阴影投射到地面。
- 立方体中心显示三轴移动 gizmo，说明教程仍在直接观察该对象的空间变换。
- `Details` 面板显示的是 `Cube (Instance)`，其 `Transform` 区域当前可可靠辨认为：
  - `Rotation = 15.0, 0.0, 0.0`
  - `Scale = 5.0, 3.0, 4.0`
- `Location` 一行可见，但数值分辨率不足，不在此强行转写。
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `Cube`。
- `Materials` 区域可见 `Element 0`，材质槽使用基础白色材质。
- 右下角出现 `R` 键位提示，说明当前教程在强调旋转相关操作。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步最直观的结果是：教程把一个普通 `Cube` 拉成了更大的体块，并加入了轻微旋转，用来观察旋转后阴影和相对位置的变化。
- 结合字幕与当前面板，可以把这张图理解为“先建立一个明确的空间参照物，再继续讲世界空间和局部空间下的移动/旋转差异”。
这张图把重点推进到“相对于父对象的位置显示”。当前选中对象是 `Cube2`，字幕也明确说明：当它切回某种跟随状态后，当前位置会按父对象的相对位置来显示。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Cube2`，场景对象数显示为 `13 actors (1 selected)`。
- 主视口中可见三个主要参照体：
  - 左侧一个放大且倾斜的白色方块/长方体
  - 中间一个被选中的细长白色条状物体，带黄色描边
  - 右侧一个较小的白色立方体
- 被选中的 `Cube2` 中心显示三轴移动 gizmo，右下角键位提示为 `W`，表明此时正在观察平移结果。
- `Details` 面板显示的是 `Cube2 (Instance)`，其 `Transform` 区域当前可可靠辨认为：
  - `Rotation = 15.0, 0.0, 0.0`
  - `Scale = 20.0, 1.0, 1.0`
- `Location` 一行能看出 3 个数值框，但具体数字不适合在当前清晰度下强行转写。
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `Cube`，说明 `Cube2` 是以立方体网格拉伸形成的细长条。
- `Materials` 区域可见 `Element 0`，材质槽仍为基础白色材质。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步最核心的信息是：教程正在用多个简单几何体讲解父子层级下的相对位移概念，而不是单纯讲物体绝对坐标。
- 从当前画面可以直接复现的做法是：保留一个较大的主参照体，再创建一个细长子物体，并通过修改其旋转与极端长宽比缩放，观察它在父对象体系下的位置变化。

### 00:43:57-00:48:08 关键流程 12

- 本段定位：关键流程 12。
- 知识点：如果我把它調到0 它会在这个物体中心 现在我可以把它移动跟这个物体相關的 我们稱之为地球指定圖案 跟这个物体相關的 所以它是轉動的。
- 知识点：我可以把它轉動 例如說 我仍然在这个物体上轉動 如果我把它取消 它现在变成了 它们的指定圖案 是跟这个物体相關的 这就是它们的指定圖案 地球指定圖案是跟这个物体相關的。
- 知识点：它们的指定圖案是跟这个物体相關的 它们的指定圖案是跟这个物体相關的 同时也有轉動 这里是世界 这里是相關的 如果我选择一个 我选择了一个孩子物体。
- 知识点：它们的指定圖案 目标是它能够看到 比如說 它的位置 或者让它们不再影响到这个物体 例如說 如果目标是它们的位置 不再影响到这个物体 需要把它轉到獨立的位置。
- 知识点：第一个指定圖案改变了 如果我把它取消 或者把它轉回来 它们的指定圖案会继续一樣 比如說 当我移动它 它仍然依然依靠这个物体 但它并不移动 因为我设置了这个物体的獨立位置。
- 知识点：同樣的事情可以做到轉動或是測量 它馬上改变了指定圖案 它现在变成獨立 它只要拿那四个指定圖案 再次分成三个 它就会变成12个 它取消12个。
- 知识点：它是增加了这个物体的測量 如果我不想它獨立 需要點擊世界 然后需要測量这个物体 这个物体是獨立的 我把它变成獨立 这些是地區和世界的指定圖案。

**关键画面：**

这张图明确切到“相对于父对象的本地坐标”说明。当前选中对象仍是 `Cube2`，教程通过一个被拉成长条的子物体，演示它的 `Location` 数值如何在父对象参考系下显示。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Cube2`，场景对象数显示为 `13 actors (1 selected)`。
- 主视口里可见：
  - 左侧一个较大的倾斜白色方块，作为父级/主参照体
  - 中间一个被选中的细长白色条状物体，带黄色描边
  - 右侧一个未选中的白色方块
- 被选中的长条物体中心显示三轴移动 gizmo，说明正在观察平移坐标。
- `Details` 面板显示 `Cube2 (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = 0.0, 209.9, 103.0`
  - `Rotation = -0.0, 0.0, 0.0`
  - `Scale = 4.0, 0.333, 0.25`
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `Cube`，说明该长条是由立方体拉伸得到。
- `Materials` 区域可见 `Element 0`，材质槽仍为基础白色材质。
- 底部字幕直接说明这是“relative to the parent object”的 local coordinates，对应当前 `Location` 的读法。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的关键不是物体外观，而是坐标解释方式：同样一个 `Location`，当前应理解为相对父对象的本地位移，而不是世界绝对位置。
- 读者若要复现，可先准备一个主方块，再创建一个拉长的子方块并保持选中，此时在 `Details > Transform` 中观察其本地 `Location` 数值变化。
这张图展示把同一个子物体切换到“绝对变换”视图后的状态。当前选中对象仍是 `Cube2`，但 `Transform` 区域的字段名已经从普通 `Location/Rotation/Scale` 变成 `Absolute Location/Rotation/Scale`，用于说明现在读到的是世界级绝对值。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Cube2`，场景对象数显示为 `13 actors (1 selected)`。
- 主视口中可见：
  - 中间一个被选中的细长白色条状物体，带黄色描边
  - 左后方一个靠墙倾斜的白色长方体
  - 地面上多个由这些物体投下的阴影
- 被选中的 `Cube2` 中心显示三轴移动 gizmo，说明此时仍在比较平移结果。
- `Details` 面板中的 `Transform` 区域当前可可靠辨认为：
  - `Absolute Location = -1840, 2080, 1017`
  - `Absolute Rotation = 154.7, 75.59, 104.3`
  - `Absolute Scale = 4.0, 0.333, 0.25`
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `Cube`。
- `Materials` 区域可见 `Element 0`，材质仍为基础白色材质。
- 左侧主参照体已经明显移到靠墙位置，配合字幕语境，可用于对比本地坐标与绝对坐标切换后的数值意义变化。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步最关键的信息是：教程不是改了物体本身，而是改了 `Transform` 数值的解释参考系，所以字段名前缀变成了 `Absolute`。
- 读者复现时应重点观察：同一个 `Cube2` 在保持当前场景关系不变时，切换到绝对模式后，面板里会直接显示世界位置、世界旋转和世界缩放。
这张图从子物体切回场景基底对象，当前选中的是 `Floor`。教程在这里开始强调：除了看子物体本身，也可以切到场景里其他对象，比较它们在当前层级关系中的变换和资源属性。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Floor`，场景对象数显示为 `13 actors (1 selected)`。
- `Outliner` 可见当前场景对象包括 `Cube`、`Cube2`、`Cube3`、`Floor`、`Floor2`、`Floor3`、`PlayerStart`，以及 `Lighting` 文件夹下的环境项。
- 主视口中可见：
  - 左下一个较大的倾斜白色方块
  - 中间一根细长白色条状体
  - 棋盘格大地面与多个投影阴影
- `Details` 面板显示 `Floor (Instance)`，其 `Transform` 区域当前可可靠辨认为：
  - `Location = 0.0, 0.0, -0.5`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 8.0, 8.0, 8.0`
- `Mobility` 行可见，当前高亮的是 `Static`。
- `Static Mesh` 区域的资源为 `SM_Template_Map_Floor`。
- `Materials` 区域中 `Element 0` 使用的材质为 `MI_ProcGrid`。
- `Physics` 区域可见，`Enable Gravity` 处于勾选状态。
- 底部状态栏仍显示 `1 Unsaved`。

输出/预览：
- 这一步的核心是把注意力从父子子物体关系拉回到“整个场景里的普通静态对象也有同样的 Transform/资源面板结构”。
- 读者若要复现当前画面，可选中地面 `Floor`，确认其是模板地板网格、使用网格材质，并借此和旁边几个被拉伸的 `Cube` 系列对象做对照。

### 00:48:41-00:53:34 关键流程 13

- 本段定位：关键流程 13。
- 知识点：所以我们不需要獨立模式 也就是它们有不同的物体 是的 它是獨立的 在基本上 没關係 它们都很相似 需要回頭 也有 现在需要展示 它们也有不同的物体。
- 知识点：也就是你能够分辨 和不同的 是的 这里需要挑戰 物体 Op 獨立物体 然后需要看到 需要告訴你 更多的詳細 你看到的 是的 可以直接拿它 然后拉它。
- 知识点：Op 或者扔掉 或者 其他有趣的东西 我可以选择一些物体 这东西可以做什么 这是我们文件中的选择器 它是 如果按下去 它会移动到这里 是的 需要改变Ctrl。
- 知识点：Z 这樣所有东西都会是標準的 这里是F 如果你按下去 它会开启 可以找到 如果你按下去 它会开启在这里 它会开启 它会搜索物体 可以简单地选择一些物体。
- 知识点：可以改变它 这樣就更方便 我们3D物体 和我们的改变是 当然 需要用到最重要的三个东西 然后是什么 物体 也就是 物体设置 光线设置 光线设置。
- 知识点：在输入的输入设置 基本上 我们还没興趣到什么东西 只是显示 这里可以把它打掉 让它完全不显示 是的 或者可以用 提前输入 只要输入不遺失 我们也可以用X。
- 知识点：Slot 这就是所需要的 目前为止 我们还没有需要 很多的物体 他們都在原本 但我们还没有需要 很多的物体 我们还没有需要 这就是 通常的输入。

**关键画面：**

这张图开始从“物体变换”转到“资源与材质查找”。当前选中对象是 `Floor`，教程把底部 `Content Drawer` 打开到 `Engine > Content > OpenWorldTemplate > LandscapeMaterial`，并准备把一个资源拖到当前地面相关位置。

当前可确认信息：
- 当前关卡仍为 `Untitled (Editor)`。
- `Outliner` 中当前选中对象为 `Floor`，场景对象数显示为 `13 actors (1 selected)`。
- `Details` 面板显示 `Floor (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = 0.0, 3005.0, -0.5`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 8.0, 8.0, 8.0`
- 主视口中当前主要显示一大片棋盘格地面和天空背景，说明教程把注意力放到地面资源而不是其他几何体。
- 底部 `Content Drawer` 当前路径为 `Engine > Content > OpenWorldTemplate > LandscapeMaterial`。
- 资源列表中当前可辨认的条目包括：
  - `M_ProcGrid`
  - `MF_ProcGrid`
  - `MF_RSquareGradient`
  - `MI_ProcGrid`
  - `T_GridChecker...`（文件名尾部未完全显示）
- 当前右键/拖放菜单显示：
  - `Move Here`
  - `Copy Here`
  - `Advanced Copy Here`
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是告诉读者：除了在 `Details` 里改对象，还可以直接在内容浏览器中定位引擎自带材质资源，并对其执行拖放复制。
- 从当前画面可以直接复现的操作是：选中 `Floor`，打开 `Content Drawer` 到 `LandscapeMaterial` 目录，再对网格/材质资源执行拖放并选择复制方式。
这张图继续停留在 `Floor` 对象上，但不再展开内容浏览器，而是强调 `Details` 面板本身就能暴露对象类型、材质槽和分类区块。字幕提到动画资源时，也是在说明不同资源/对象类型会显示不同面板内容。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `Floor`，场景对象数显示为 `13 actors (1 selected)`。
- `Outliner` 可见 `Lighting` 文件夹及其环境对象：
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
- 主视口中可见棋盘格地面、左侧靠墙的几个白色几何体，以及场景中心附近的移动 gizmo。
- `Details` 面板显示 `Floor (Instance)`，当前可可靠辨认：
  - `Location = 0.0, 3510.0, -0.5`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 8.0, 8.0, 8.0`
  - `Static Mesh = SM_Template_Map_Floor`
  - `Materials > Element 0 = MI_ProcGrid`
- `Details` 面板下方还能清楚看到多个分类区块：
  - `Physics`
  - `Collision`
  - `Lighting`
  - `Rendering`
  - `HLOD`
  - `Path Tracing`
- 右下角键位提示为 `S`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是让读者理解：当选中的对象不同，`Details` 中出现的分类、插槽和资源引用也会不同，因此可以直接用面板识别当前对象能改什么。
- 以当前 `Floor` 为例，最容易复现的是先确认它使用 `SM_Template_Map_Floor` 网格和 `MI_ProcGrid` 材质，再向下查看碰撞、渲染、路径追踪等分类区块。
这张图把对象切换到环境雾组件，当前选中的是 `ExponentialHeightFog`。教程此时开始说明：除了网格体和材质，环境 Actor 也有自己独立的参数面板，可以直接影响场景空气感和可见距离。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `ExponentialHeightFog`，场景对象数显示为 `8 actors (1 selected)`。
- `Outliner` 中可见的环境对象包括：
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
  - `Floor`
  - `PlayerStart`
- 主视口中主要看到大面积棋盘格地面与远处天空，说明教程正在观察全局环境效果，而不是局部几何体。
- `Details` 面板显示 `ExponentialHeightFog (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = -5600.0, -50.0, -6850.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Exponential Height Fog Component` 区域当前可可靠辨认：
  - `Fog Density = 0.001314`
  - `Fog Height Falloff = 0.2`
- `Second Fog Data` 区域可见并能辨认：
  - `Fog Density = 0.0`
  - `Fog Height Falloff = 0.2`
  - `Fog Height Offset = 0.0`
- 更下方还能看到这些参数项名称：
  - `Fog Inscattering Color`
  - `Sky Atmosphere Ambient Contribution Color Scale`
  - `Fog Max Opacity`
  - `Start Distance`
  - `Fog Cutoff Distance`
  - `Inscattering Texture`
- 右下角键位提示显示 `W`、`D`、`S`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的核心是让读者知道：环境雾效果并不是抽象概念，而是由 `ExponentialHeightFog` 里的密度、高度衰减等参数直接控制。
- 若要复现当前步骤，可在空关卡中选中 `ExponentialHeightFog`，先从 `Fog Density` 与 `Fog Height Falloff` 入手，再观察远处地面与天空交界处的空气透视变化。

### 00:53:37-00:58:36 速度、颜色

- 本段定位：速度、颜色。
- 知识点：按下 Cmd 它能够 这樣转换多久 哦 是的 需要 偶爾做一些事 所以需要 把大量的物体 转换回 这樣 这里 就这樣 所以 把它这樣 转换 这就是 它会 接收 物体。
- 知识点：的電量 例如 俄羅斯 可以把它改变 需要改变颜色 就像 那是 那是 那是 这天空 可以 控制 这里的污染 然后 可以 把它剪掉 因为它没有开始 但距離可以设置。
- 知识点：我们移动 我设置了 攝影機的速度 8秒 这就是 这里的 大量的 物体 它可以 转换 大量的 物体 但你 可以 把它 转换 我可以 它就会 转换 就像 那是 你 可以。
- 知识点：转换 它能够 转换多久 所以 我可以 把它 转换 嗯 和多少 在这里,如果是有不同的位置 和距离 也可能可以切掉 在这种计算器上,可以把最开始的距离。
- 知识点：可以删掉 如果您想删掉某个计算器 而它不在这里 您不想找它 您可以这样按下这个 我们就知道它是什么叫的 这里有很多 当然,不是所有的都需要。
- 知识点：就是,这里是天空和我们的天空 就是,这是发明者做的这么一个 实际的,如果是適当的適应 我们有天空 这是天空 这是天空,它从天空中收集的。
- 知识点：就是,这些只是两个物件 这些,按照规则,都是需要的 但只是为了能够正确地描绘它 一切都很好 这里也有很多的计算 这里可以改变世界 什么气氛,什么计算机,对吗。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 核对对象：`速度`、`颜色`。

**关键画面：**

这张图继续调整 `ExponentialHeightFog`，并且已经把雾参数调到明显更强的状态。字幕说明“把一些值恢复到较大的数值”，画面上也能直接看到远景被蓝白色雾层大幅覆盖。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `ExponentialHeightFog`，场景对象数显示为 `8 actors (1 selected)`。
- 主视口中地面远处和天空交界已经被浓雾显著洗淡，只在近景保留部分棋盘格纹理。
- `Details` 面板显示 `ExponentialHeightFog (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = -5600.0, -50.0, -6850.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Exponential Height Fog Component` 区域当前可可靠辨认：
  - `Fog Density = 0.05`
  - `Fog Height Falloff = 0.14517`
- `Second Fog Data` 区域当前可可靠辨认：
  - `Fog Density = 0.05`
  - `Fog Height Falloff = 0.008096`
  - `Fog Height Offset = 500000.0`
- 更下方还能看到：
  - `Fog Inscattering Color`
  - `Sky Atmosphere Ambient Contribution Color Scale`
  - `Fog Max Opacity = 1.0`
  - `Start Distance = 0.0`
  - `Fog Cutoff Distance = 0.0`
  - `Inscattering Texture`
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的核心是演示：只要提高 `Fog Density` 并配合调整高度衰减与第二层雾数据，整个场景的能见度和空气透视会立刻大幅变化。
- 读者复现时，可先从 `Fog Density = 0.05` 开始，再观察地面网格在远处被雾吞没的程度。
这张图演示如果场景里没有目标环境对象，可以直接通过顶部添加菜单重新放入。当前在左上角搜索框中输入了 `ex`，并在 `Visual Effects` / `All Classes` 结果里筛出 `Exponential Height Fog`。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- 当前没有对象被选中，右侧 `Details` 面板显示 `Select an object to view details.`。
- `Outliner` 中当前场景对象数显示为 `7 actors`，列表可见：
  - `DirectionalLight`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `VolumetricCloud`
  - `Floor`
  - `PlayerStart`
- 与上一张相比，`ExponentialHeightFog` 已不在当前 `Outliner` 列表中，说明教程正在演示如何重新添加它。
- 左上角添加菜单已展开，搜索词为 `ex`。
- 搜索结果中当前可辨认的条目包括：
  - `Visual Effects > Exponential Height Fog`
  - `Volumes > Runtime Virtual Texture Volume`
  - `All Classes > Exponential Height Fog`
  - `All Classes > Runtime Virtual Texture Volume`
  - `All Classes > Sparse Volume Texture Viewer`
  - `All Classes > Text Render Actor`
- 浮层说明文字可辨认：`Implements an Actor for exponential height fog`。
- 主视口中仍能看到带雾化效果的棋盘格地面和远处天空。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的核心是让读者知道：环境雾 Actor 被删掉或缺失时，不需要手动找资源文件，直接用添加菜单搜索 `Exponential Height Fog` 即可重新放回场景。
- 复现方式很直接：点击左上角 `Add`，输入 `ex`，然后从 `Visual Effects` 或 `All Classes` 结果中选择 `Exponential Height Fog`。
这张图回到 `ExponentialHeightFog` 的参数调整结果，但这次除了雾密度，还明显加入了蓝色环境散射色。画面上近景地面偏暖、远景偏冷蓝，说明教程正在把雾当作颜色氛围工具来调。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `ExponentialHeightFog`，场景对象数显示为 `7 actors (1 selected)`。
- 主视口中地面近处保持较清晰的棋盘格，远处逐渐过渡到蓝色雾层，形成明显的冷暖深度变化。
- `Details` 面板显示 `ExponentialHeightFog (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = 1765.0, 29860.0, 2845.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Exponential Height Fog Component` 区域当前可可靠辨认：
  - `Fog Density = 0.05`
  - `Fog Height Falloff = 0.2`
- `Second Fog Data` 区域当前可可靠辨认：
  - `Fog Density = 0.05`
  - `Fog Height Falloff = 0.592704`
  - `Fog Height Offset = 5000.0`
- 颜色和距离相关参数当前可可靠辨认：
  - `Sky Atmosphere Ambient Contribution Color Scale` 为亮蓝色
  - `Fog Max Opacity = 1.0`
  - `Start Distance = 5000.0`
  - `Fog Cutoff Distance = 0.0`
- `Inscattering Texture` 条目可见。
- 右下角键位提示为 `S`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步最关键的是让读者看到：雾不仅影响可见距离，还能通过散射色与起始距离控制画面的整体色调和层次。
- 复现时可先保持 `Fog Density = 0.05`，再把环境散射色调成蓝色，并适当增大 `Start Distance`，观察近景保留细节、远景偏蓝的效果。

### 00:58:36-00:58:53 关键流程 15

- 本段定位：关键流程 15。
- 知识点：让我们看看Ossetian的类型。
- 知识点：哪些类型呢? 让我们看看这个场景。
- 知识点：甚至我准备的场景。
- 知识点：对,我现在就想到这些了。

**关键画面：**

这张图从雾切到天空大气组件，当前选中的是 `SkyAtmosphere`。教程开始讲“有哪些类型”，结合当前面板，重点是在区分场景环境里不同大气/散射系统的参数类型。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `SkyAtmosphere`，场景对象数显示为 `7 actors (1 selected)`。
- 场景环境对象列表可见：
  - `DirectionalLight`
  - `ExponentialHeightFog`
  - `SkyAtmosphere`
  - `SkyLight`
  - `SM_SkySphere`
  - `Floor`
  - `PlayerStart`
- 主视口中可见明显的蓝色天空渐变和地平线附近的粉蓝过渡带，地面仍为棋盘格。
- `Details` 面板显示 `SkyAtmosphere (Instance)`，`Transform` 区域当前可可靠辨认为：
  - `Location = 0.0, 0.0, 500.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
- `Planet` 区域当前可可靠辨认：
  - `Transform Mode = Planet Top at Absolute World Origin`
  - `Ground Radius = 6360.0`
  - `Ground Albedo`
- `Atmosphere` 区域当前可可靠辨认：
  - `Atmosphere Height = 34.253899`
  - `MultiScattering = 1.0`
- `Atmosphere - Rayleigh` 区域当前可可靠辨认：
  - `Rayleigh Scattering Scale = 0.117705`
  - `Rayleigh Scattering` 为蓝色
  - `Rayleigh Exponential Distribution = 8.0`
- 更下方可见 `Atmosphere - Mie` 区域，`Mie Scattering Scale = 0.003996`。
- 右下角键位提示为 `W`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的核心是让读者知道：天空颜色和地平线过渡并不只靠雾，`SkyAtmosphere` 自身就有 `Rayleigh`、`Mie`、行星半径等成组参数。
- 复现时可先选中 `SkyAtmosphere`，观察 `Rayleigh Scattering` 的蓝色设置如何直接对应当前天空的主色调。
这张图继续停留在 `SkyAtmosphere` 的同一组设置，但镜头更强调当前大气参数已经形成的地平线色带。教程此时是在观察结果本身，而不是切换到新的环境对象。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `SkyAtmosphere`，场景对象数显示为 `7 actors (1 selected)`。
- 主视口中当前可见的结果特征更明确：
  - 天空顶部为高饱和蓝色
  - 地平线附近出现明显的蓝紫过渡带
  - 地面整体偏暖黄色
  - 棋盘格在远处被颜色散射软化
- `Details` 面板仍显示 `SkyAtmosphere (Instance)`，当前可可靠辨认：
  - `Location = 0.0, 0.0, 500.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
  - `Transform Mode = Planet Top at Absolute World Origin`
  - `Ground Radius = 6360.0`
  - `Atmosphere Height = 34.253899`
  - `MultiScattering = 1.0`
  - `Rayleigh Scattering Scale = 0.117705`
  - `Rayleigh Scattering` 为蓝色
  - `Rayleigh Exponential Distribution = 8.0`
  - `Mie Scattering Scale = 0.003996`
- 右下角键位提示仍为 `W`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步最重要的价值是把“参数表”和“实际天空分层效果”建立直接对应关系，尤其是蓝色 `Rayleigh` 散射与地平线紫蓝过渡的关系。
- 读者复现时，应一边保留当前数值，一边从视口低角度观察地面与天空交界处，这样最容易看出大气散射的色带层次。
这张图仍然是 `SkyAtmosphere` 的结果观察图，但视口拉得更完整，能更清楚地看到从地面到天空的整体颜色分布。教程在这一小段里本质上是在快速浏览场景里不同环境类型，而这张图对应的大气类型效果最完整。

当前可确认信息：
- 当前关卡仍为 `Untitled*`。
- `Outliner` 中当前选中对象为 `SkyAtmosphere`，场景对象数显示为 `7 actors (1 selected)`。
- 主视口当前可见的整体结果包括：
  - 近景为暖色棋盘格地面
  - 中远景地平线附近有一条连续的淡紫色过渡带
  - 天空上半部为高亮蓝色
  - 地面与天空之间的过渡较均匀，没有明显硬切边
- `Details` 面板仍显示 `SkyAtmosphere (Instance)`，当前可可靠辨认：
  - `Location = 0.0, 0.0, 500.0`
  - `Rotation = 0.0, 0.0, 0.0`
  - `Scale = 1.0, 1.0, 1.0`
  - `Transform Mode = Planet Top at Absolute World Origin`
  - `Ground Radius = 6360.0`
  - `Atmosphere Height = 34.253899`
  - `MultiScattering = 1.0`
  - `Rayleigh Scattering Scale = 0.117705`
  - `Rayleigh Scattering` 为蓝色
  - `Rayleigh Exponential Distribution = 8.0`
  - `Mie Scattering Scale = 0.003996`
- 左下角坐标轴 gizmo 可见，说明当前主要是在透视视口里直接观察结果。
- 右下角键位提示变为 `G`。
- 底部状态栏显示 `2 Unsaved`。

输出/预览：
- 这一步的重点是确认 `SkyAtmosphere` 这组参数已经形成一个稳定的“蓝天 + 紫色地平线 + 暖色地面”基底环境。
- 读者若要复现当前结果，应优先保持当前 `SkyAtmosphere` 参数不变，然后在透视视口中低角度查看整片地面，以确认地平线色带是否连续自然。

## 补充视觉证据

### S01 00:01:55

这张补充图不是场景调参，而是 Unreal 的新建项目界面，用来说明教程一开始选择的项目模板类型。当前高亮的是 `Third Person` 模板，字幕也明确提到“选择 Blueprint 或 C++”。

当前可确认信息：
- 当前界面为 `Unreal Project Browser`。
- 顶部模板区当前可见并能辨认的项目模板包括：
  - `Blank`
  - `First Person`
  - `Third Person`
  - `Top Down`
  - `Handheld AR`
  - `Virtual Reality`
  - `Vehicle`
- 当前被选中的模板是 `Third Person`。
- 左侧分类导航当前可见：
  - `RECENT PROJECTS`
  - `GAMES`
  - `FILM / VIDEO & LIVE EVENTS`
  - `ARCHITECTURE`
  - `AUTOMOTIVE PRODUCT DESIGN & MANUFACTURING`
  - `SIMULATION`
- 右侧说明面板展示 `Third Person` 的模板预览图和英文说明。
- `Project Defaults` 区域当前可可靠辨认：
  - `BLUEPRINT` 与 `C++` 两个实现方式选项
  - `Target Platform = Desktop`
  - `Quality Preset = Maximum`
  - `Starter Content` 复选框
  - `Raytracing` 复选框
- 底部项目信息区域当前可辨认：
  - `Project Location = D:\Unreal Projects`
  - `Project Name = MyProject`
  - 右下角有 `Create` 与 `Cancel` 按钮

输出/预览：
- 这张图的作用是补充“工程起点”而不是效果节点：教程基于 `Third Person` 模板创建项目，再决定使用 `Blueprint` 或 `C++` 方案。
- 读者复现时，可直接在 `Unreal Project Browser` 中选择 `Games > Third Person`，然后按需要选择 `Blueprint` 或 `C++`，保持 `Desktop` 与 `Maximum` 预设后创建工程。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。

