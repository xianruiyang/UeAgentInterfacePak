---
title: "通用引擎设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/general-engine-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "通用引擎设置"]
---

# 通用引擎设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 通用引擎设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/general-engine-settings-in-the-unreal-engine-project-settings

## 通用设置

### 字体

| **分段** | **说明** |
| --- | --- |
| **微小字体（Tiny Font）** | 设置用于最小引擎文本的字体。 |
| **小字体（Small Font）** | 设置用于小引擎文本的字体，主要用于显示调试内容。 |
| **中等字体（Medium Font）** | 设置用于中等引擎文本的字体。 |
| **大字体（Large Font）** | 设置用于大引擎文本的字体。 |
| **字幕字体（Subtitle Font）** | 设置字幕管理器的默认字体。 |
| **其他字体名称（Additional Font Names）** | 设置将在启动时加载并可使用 `GetAdditionalFont()` 函数获取的其他字体。 |

### 默认类

| **分段** | **说明** |
| --- | --- |
| **控制台类（Console Class）** | 设置用于游戏控制台的类，可通过 **~** 打开。 |
| **游戏视口客户端类名（Game Viewport Client Class Name）** | 设置要用于游戏视口客户端的类，重载它可以更改游戏特有的的输入和显示行为。 |
| **本地玩家类（Local Player Class）** | 设置要用于本地玩家的类，重载它可以存储本地玩家的游戏特有信息。 |
| **世界设置类（World Settings Class）** | 设置要用于 `WorldSettings` 的类，重载它可以将游戏特有信息存储在地图/世界上。 |
| **关卡脚本Actor类（Level Script Actor Class）** | 设置关卡脚本Actor类，重载它可以在每个地图的蓝图脚本中允许游戏特有行为。 你可以从以下选项中选择： **FunctionalTestLevelScript** **LevelScriptActor** **ThirdPersonMap_C** |
| **物理碰撞处理程序类（Physics Collision Handler Class）** | 设置默认要使用的 `PhysicsCollisionHandler` 类，重载它可以更改对象使用物理碰撞时的游戏特有行为。 |
| **游戏用户设置类（Game User Settings Class）** | 设置 `GameUserSettings` 类，重载它可以支持游戏特有的图形、音效和Gameplay选项。 |
| **默认蓝图基类（Default Blueprint Base Class）** | 设置编辑器中新建的蓝图要使用的基类，可按游戏进行配置。 |
| **游戏单例类（Game Singleton Class）** | 设置在启动时生成的全局对象的类，以处理游戏特有的数据。 如果为空，则不会生成类。 |
| **资产管理器类（Asset Manager Class）** | 设置要生成为全局 `AssetManager` 的类，可按游戏进行配置。 如果为空，则不会生成类。 |

### 默认材质

| **分段** | **说明** |
| --- | --- |
| **预览阴影指示器材质（Preview Shadows Indicator Material）** | 材质路径，该材质用于渲染有关正在使用的预览阴影的消息。 |
| **可破坏物物理材质（Destructible Physics Material）** | 在没有为特定对象定义PhysicalMaterial时，要使用的PhysicalMaterial的路径。 |

### 设置

| **分段** | **说明** |
| --- | --- |
| **近裁剪平面（Near Clip Plane）** | 摄像机的近裁剪平面的距离。 |

### 字幕

| **分段** | **说明** |
| --- | --- |
| **启用字幕（Subtitles Enabled）** | 开启/关闭本地化音效的字幕显示。 |
| **字幕强制关闭（Subtitles Forced Off）** | 用于强制禁用字幕的标记。如果启用此选项，你将无法使用其他方法打开字幕。 |

### 蓝图

| **分段** | **说明** |
| --- | --- |
| **最大循环迭代数（Maximum Loop Iteration Count）** | 脚本最大循环迭代数，作为向用户警告脚本执行失控的阈值使用。 |
| **蓝图可以默认更新（Can Blueprints Tick by Default）** | 控制Actor或组件的蓝图子类是否可以默认更新。 从原生C++类派生并设置了 `bCanEverTick=true` 的蓝图将总是能够更新。 直接从 `AActor` 或 `UActorComponent` 派生的蓝图将总是能够更新。 在其他情况下，只要父类没有设置 `meta=(ChildCannotTick)` ，并且 `bCanBlueprintsTickByDefault` 为true或父类设置了 `meta=(ChildCanTick)` ，就可以更新。 |

### 动画蓝图

| **分段** | **说明** |
| --- | --- |
| **优化动画蓝图成员变量访问（Optimize Anim Blueprint Member Variable Access）** | 控制直接访问其类的成员变量的动画蓝图节点是否应该使用优化路径，以避免与蓝图VM(蓝图虚拟机)进行形实转换。 这会强制所有动画蓝图重新编译。 |
| **允许多线程动画更新（Allow Multi Threaded Animation Update）** | 控制是否默认在非游戏线程上执行动画蓝图图表更新。这样就可在动画蓝图编译器中执行一些额外的检查，并在企图执行不安全的操作时发出警告。 这会强制所有动画蓝图重新编译。 |

### 帧率

| **分段** | **说明** |
| --- | --- |
| **平滑帧率（Smooth Frame Rate）** | 指定是否启用帧率平滑。 |
| **使用固定帧率（Use Fixed Frame Rate）** | 指定是否使用固定帧率。 |
| **固定帧率（Fixed Frame Rate）** | 要使用的固定帧率。 |
| **平滑帧率范围（Smoothed Frame Rate Range）** | 将执行平滑的帧率范围。 |
| **最低理想帧率（Min Desired Frame Rate）** | 最低理想帧率设置。低于该帧率时，视觉效果细节可能会降低。 |
| **自定义时间步进（Custom TimeStep）** | 重载引擎处理帧率/时间步进的方式。 该类将负责更新应用程序的时间和增量时间。可用于将引擎与其他进程同步（gen-lock）。 |

### 时间码

| **分段** | **说明** |
| --- | --- |
| **时间码提供程序（Timecode Provider）** | 设置引擎启动时的 `TimecodeProvider` 。 |
| **生成默认时间码（Generate Default Timecode）** | 没有时间码提供程序时，从计算机时钟生成默认时间码。 在台式计算机平台上，将使用系统时间，其行为如同设置了 `USystemTimecodeProvider` 一样。 在主机平台上，将使用高性能时钟。这可能随时间推移产生偏差。 如果你想使用主机平台上的系统时间，请将时间码提供程序设置为 `USystemTimecodeProvider` 。 |
| **生成默认时间码帧率（Generate Default Timecode Frame Rate）** | 生成默认时间码（ `bGenerateDefaultTimecode` 为true并且没有设置时间码提供程序）时，设置它应按什么帧率生成（帧数）。 你可以从以下选项中选择： **12 fps（动画）** **15 fps** **24 fps（电影）** **25 fps (PAL/25)** **30 fps** **48 fps** **50 fps (PAL/50)** **60 fps** **100 fps** **120 fps** **23.976 fps (NTSC/24)** **29.97 fps (NTSC/30)** **59.94 fps (NTSC/60)** **自定义（Custom）** |
| **生成默认时间码帧延迟（Generate Default Timecode Frame Delay）** | 要从生成的默认时间码减去的帧数。 |

### 屏幕截图

| **分段** | **说明** |
| --- | --- |
| **游戏屏幕截图保存目录（Game Screenshot Save Directory）** | 新创建的屏幕截图的保存目录。 |

### 关卡流送

| **分段** | **说明** |
| --- | --- |
| **流送距离系数（Streaming Distance Factor）** | 用于调整基于距离的Mip级别确定方式的容差系数。 |

### 逐质量级别属性

| **分段** | **说明** |
| --- | --- |
| **使用每个质量级别的静态网格体最低LOD（Use Static Mesh Min LOD Per Quality Levels）** | 使用每个质量级别的静态网格体最低LOD。 |
