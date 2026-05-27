---
title: "Niagara调试器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/niagara-debugger-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "调试和优化Niagara", "Niagara调试器"]
---

# Niagara调试器

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / 调试和优化Niagara / Niagara调试器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/niagara-debugger-for-unreal-engine

## Niagara调试器

Niagara调试器为你提供了一套工具，可以帮助你查看关于当前关卡中的模拟的详细数据。有多种方式可以打开调试器：

- 从顶部菜单打开
- 通过观察发射器打开
- 通过观察参数打开

如果你从顶部菜单打开调试器，界面打开后没有预设选项。如果通过观察系统或参数打开调试器，界面打开后有预设选项，用于跟踪你选择的系统或参数。

### 如何从顶部菜单打开调试器

要从顶部菜单启用Niagara调试器，请从关卡编辑器选择 **工具（Tools）> 调试（Debug）> Niagara调试器（Niagara Debugger）** 。系统将显示一个面板，你可以将其放在你想要的位置。

![Turn On Niagara Debugger from Main Menu](../../../../assets/images/75/75fefbbafce48bcb120aa36330c0270f02738d6d03e09fe2b9f64141e5f8d55a.png)

点击查看大图。

### 如何通过观察发射器打开调试器

在Niagara编辑器中打开包含你想观察的发射器的系统。右键点击发射器，然后选择 **在Niagara调试器中观察发射器（Watch Emitter in Niagara Debugger）** 。

![Watch Emitter in Niagara Debugger](../../../../assets/images/71/716a90d3e60a90dd26ff4579fd0eb4e8a9d8a0ca125b55cb741158466f903aca.png)

点击查看大图。

### 如何通过观察参数打开调试器

在Niagara编辑器的 **参数（Parameters）** 面板中找到你想观察的参数。右键点击参数，然后选择 **在Niagara调试器中观察参数（Watch Parameter in Niagara Debugger）** 。

![Watch Parameter in Niagara Debugger](../../../../assets/images/2c/2ce819bb97c89f262b2b9904d282bf5600341c9330394f75716291afc272df32.jpg)

点击查看大图。

### Niagara调试器布局

Niagara调试器划分为以下分段：

![Niagara Debugger layout](../../../../assets/images/c6/c6929ca4375a477c3fb9e28150651a00f35446e1b58451eadd05e75bbfe90054.png)

点击查看大图。

1. Niagara调试器面板
2. 播放选项
3. 调试器选项卡
4. 调试器选项

首先，顶部有一个为你提供播放功能按钮的分段。你可以在此处选择播放、暂停、循环、步进和速度。

![Niagara调试器播放](../../../../assets/images/9a/9a449946a5acfd31c33ddad746ac0960aae6aae13f0163faba824e8c8559858d.png)

| 参数 | 说明 |
| --- | --- |
| **刷新（Refresh）** | 刷新所选设备上的设置。当某些东西不同步时使用。 |
| **播放（Play）** | 播放关卡中的所有Niagara模拟。 |
| **暂停（Pause）** | 暂停关卡中的所有Niagara模拟。 |
| **循环（Loop）** | 循环关卡中的所有Niagara模拟。当与循环时间设置配对时，可以使单发系统循环，例如爆裂。 |
| **步进（Step）** | 每点击一次，所有Niagara模拟前进一帧。 |
| **速度（Speed）** | 调整关卡中Niagara模拟的速度。这只会影响Niagara模拟的播放速度，关卡中的所有其他元素都将以正常速度播放。 |

在播放功能按钮下方，你将看到不同的选项卡。点击选项卡可以访问调试器中的不同工具。

![Niagara调试器选项卡](../../../../assets/images/1f/1fb19342d4352783a9f648c890fbcda7253f6c4ab9f52690c5610125f8e85f7c.png)

| 参数 | 说明 |
| --- | --- |
| **调试HUD（Debug HUD）** | 你可以用调试Hud打开抬头显示器，查看关卡中关于模拟的详细信息。 |
| **FX大纲视图（FX Outliner）** | 当Niagara在设备或PIE中运行时，FX大纲视图可以让你调试和分析Niagara上的数据。 |
| **性能（Performance）** | 使用各种性能测试工具分析你的Niagara模拟。 |
| **会话浏览器（Session Browser）** | 将调试选项设置到不同会话，例如控制台或PIE。 |

### 调试HUD

调试器中的第一个选项卡是 **调试HUD（Debug HUD）** 选项卡。你可以打开调试HUD，直接在关卡的视口中显示抬头显示器。然后，你可以调整选项，选择要显示的信息。

要打开调试HUD，请从 **调试HUD（Debug HUD）** 选项卡中选择 **已启用调试HUD（Debug HUD Enabled）** 选项。

![Enable the Niagara Debug HUD](../../../../assets/images/61/6188eedcdfb1f3fc727ceb38ac5f52d9bdb38ae226b68f6715100b2c8eb4e0e8.png)

点击查看大图。

启用"调试HUD"后，你将在 **视口** 中看到各种值的打印输出。

![Debug HUD in the Viewport](../../../../assets/images/2a/2acfe79ffd16b60427a8d9b9b3e2c8f5819a397b1f3c23db4b5f39979598434b.jpg)

点击查看大图。

你在"调试HUD"选项卡中选择的设置将在会话之间保存。你可以选择显示各种数据。数据分成几组。

> 图片已省略：Debug HUD options

点击查看大图。

| 参数 | 说明 |
| --- | --- |
| **调试概述（Debug Overview）** | 此分段使你能够打开调试HUD顶部的概览分段，其中包括系统总数、总可扩展性、激活发射器总数、粒子总数和总内存。 |
| **调试筛选器（Debug Filters）** | 你可以通过此分段设置筛选器，以便你仅显示与该筛选器匹配的Actor、组件、系统或发射器的信息。例如，你可以输入 `*fountain*`，显示名称中包含 *fountain* 的对象。将这些筛选器保留为(*)会包括所有资产。 请参阅[通配符搜索](#%E9%80%9A%E9%85%8D%E7%AC%A6%E6%90%9C%E7%B4%A2)，了解更多信息。 |
| **调试系统（Debug System）** | 此分段将在关卡编辑器的视口中显示每个系统的详细信息。 |
| **调试粒子（Debug Particles）** | 你可以通过此分段在视口中显示有关单个粒子的详细信息。鉴于可能有数千个粒子，你还可以将显示的数据量限制为最大粒子数。 |

#### 调试概述

点击 **已启用调试概述（Debug Overview Enabled）** ，打开 **视口（Viewport）** 中这些值的显示。

> 图片已省略：Enable the Debug Overview

点击查看大图。

这将在 **视口（Viewport）** 中显示以下信息的打印输出：

- 系统总数
- 总可扩展性
- 激活发射器总数
- 粒子总数
- 总内存

> 图片已省略：Debug HUD Overview in Viewport

点击查看大图。

点击 **概述字体（Overview Font）** 选项，你可以选择是要查看 **小（Small）** 字体还是 **正常（Normal）** 字体。你还可以使用 **概述位置（Overview Location）** 值调整 **视口（Viewport）** 中的概述位置。

#### 调试筛选器

你已激活的筛选器可帮助你控制在调试HUD中看到的打印信息。默认情况下，每个筛选器都设置为(*)，表示显示所有内容。

点击筛选器旁边的复选框可以启用相应筛选器。你可以选择筛选出 **Actor** 、 **组件（Components）** 、 **系统（Systems）** 或 **发射器（Emitters）** 。

要设置筛选器，在星号之间输入你要筛选的内容。例如，你想筛选掉名称中带有System一词的系统，请点击 **系统筛选器（System Filter）** 旁边的复选框启用它，然后在文本输入字段中输入 `*System*`。

> 图片已省略：Debug filter options

点击查看大图。

在 **调试HUD（Debug HUD）** 中，你将看到与筛选器匹配的系统以黄色高亮显示。

> 图片已省略：Filtered Systems Highlighted in Viewport

点击查看大图。

请参阅[通配符搜索](#%E9%80%9A%E9%85%8D%E7%AC%A6%E6%90%9C%E7%B4%A2)，了解更多信息。

#### 调试系统

你可以使用此分段在 **视口（Viewport）** 中为每个系统启用调试信息显示。

> [!NOTE]
> 仅当至少启用了一个筛选器并且至少一个系统通过了筛选器时，才会显示此信息。

设置以下选项，调整视口中系统信息的显示。

> 图片已省略：Debug System Options

点击查看大图。

| 参数 | 说明 |
| --- | --- |
| **系统调试冗长度（System Debug Verbosity）** | **无（None）** - 仅显示系统的边界（如果启用）以及系统的位置和方向 **基本（Basic）** - 显示系统的边界（如果启用）、系统的位置和方向，以及组件和系统名称。此外还显示系统是否因可扩展性而被剔除以及原因。 **冗长（Verbose）** - 显示系统的边界（如果启用）、系统的位置和方向，以及组件和系统名称。显示系统是否因可扩展性而被剔除以及原因。显示系统的激活状态。显示系统正在使用的内存量。显示系统是否具有 **效果类型（Effect Type）** 。 |
| **系统发射器冗长度（System Emitter Verbosity）** | **无（None）** - 不显示其他信息。 **基本（Basic）** - 显示发射器和粒子的数量。 **冗长（Verbose）** - 显示系统中找到的每个发射器、该发射器的状态以及它拥有的粒子数。 |
| **系统显示边界（System Show Bounds）** | 显示系统边界。如果系统具有固定边界，则此大小恒定。如果边界不固定，边界将动态调整大小，以便包含系统的粒子。 |
| **系统仅在世界中显示激活（System Show Active Only in World）** | 启用此选项后，你将只会看到可见系统显示的信息。 禁用后，你将看到因可扩展性而被剔除的系统的显示。被剔除的系统用黑色定位器表示。 |
| **显示系统属性（Show System Attributes）** | 只要"系统调试冗长度（System Debug Verbosity）"设置为"基本（Basic）"或"冗长（Verbose）"，你就可以使用系统属性在调试HUD中显示附加信息。例如，你可以添加一个或多个特定属性的数组，例如System.Age。你也可以使用星号来显示包含某个单词的所有属性，例如 `System.*` 或 `*.Age` 。 请参阅[通配符搜索](#%E9%80%9A%E9%85%8D%E7%AC%A6%E6%90%9C%E7%B4%A2)，了解更多信息。 |
| **系统文本选项（System Text Options）** | 使用这些选项来调整相对于系统原点的文本显示。 **字体（Font）** 可调整尺寸（小或正常）。 **水平对齐（Horizontal Alignment）** ：左、中或右与系统原点对齐。 **垂直对齐（Vertical Alignment）** ：上、中或下与系统原点对齐。 **屏幕偏移（Screen Offset）** ：使用坐标向左或向右调整。 |

**系统选项（System Options）** 根据上面设置的选项打印在每个系统原点旁边的 **视口（Viewport）** 中。

> 图片已省略：视口中的系统选项

如果你选择启用选项 **系统显示边界（System Show Bounds）** ，它将在系统边界周围绘制一个动态更新的框。

> 图片已省略：Show System Bounds Enabled in Viewport

点击查看大图。

#### 调试粒子

你可以使用 **调试HUD** 直接在视口中显示每粒子信息，以便帮助你调试场景。

> [!NOTE]
> 请记住，在使用调试粒子时，使用播放功能按钮来 **暂停（Pause）** 、**跳过（Skip）** 和 **播放（Play）** 会很有帮助。

> 图片已省略：Particle Attributes

点击查看大图。

> [!NOTE]
> 为了显示粒子属性， **系统调试冗长度（System Debug Verbosity）** 必须设置为 **基本（Basic）** 或 **冗长（Verbose）** 。

| 参数 | 说明 |
| --- | --- |
| **显示粒子属性（Show Particle Attributes）** | 启用此选项可直观显示每个粒子的属性。然后，你可以使用数组元素添加要显示的粒子属性。就像系统属性一样，你可以使用星号通过字符串筛选一系列属性，也可以键入属性的确切名称，例如颜色（Color）。 请参阅[通配符搜索](#%E9%80%9A%E9%85%8D%E7%AC%A6%E6%90%9C%E7%B4%A2)，了解更多信息。 |
| **启用GPU回读（Enable GPU Readback）** | 首先，你必须启用"显示粒子属性（Show Particle Attributes）"选项。然后，如果你启用此选项，你将看到GPU发射器的粒子属性显示。 使用此选项时，数据从GPU收集并发送回CPU进行处理，因此会有数帧延迟。 使用此选项会产生内存成本，因为我们会针对每个系统回读所有内容。 |
| **粒子属性（Particle Attributes）** | 将属性输入到数组中以便在粒子旁边的视口中打印出来。你可以输入多个属性，但你必须至少设置一个属性才能显示内容。 示例：在上面的截图中，有2个属性添加到数组中："颜色（Color）"和"位置（Position）"。 |
| **粒子文本选项（Particle Text Options）** | 选择此处的选项以便调整视口中文本的显示。默认情况下，每个粒子旁边都有单独打印的文本，文本将跟随粒子从一帧移动到下一帧。 **字体（Font）** ："小（Small）"或"正常（Normal）"。 **水平对齐（Horizontal Alignment）** ：粒子的"左（Left）"、"中（Center）"或"右（Right）"。 **垂直对齐（Vertical Alignment）** ：粒子的"上（Top）"、"中（Center）"或"下（Bottom）"。 |
| **显示系统粒子属性（Show Particle Attributes With System）** | 启用此选项会覆盖粒子文本选项的默认行为。文本并非在每个粒子旁边打印，而是附加到系统统计数据中。 |
| **使用显示的最大粒子数（Use Max Particles to Display）** | 此选项确定要在视口中显示有关信息的粒子数。 如果 **启用（Enabled）** ，将显示你在"显示的最大粒子数（Max Particles to Display）"字段中设置的粒子数。 如果 **禁用（Disabled）** ，将显示关卡中所有Niagara 系统的所有可见粒子。如果你的关卡中有数千个粒子，这可能会导致某些工作站出现性能问题和内存不足错误。 |
| **显示全局预算信息（Show Global Budget Info）** | 此选项显示带有全局预算信息的附加控件。显示信息包括全局FX时间、以毫秒为单位的预算以及时间/预算比率。 |

根据你的喜好设置选项后，你将在视口中看到每个粒子的打印输出，其中包含你在粒子属性数组中选择的属性。

> 图片已省略：Debug Particles in Viewport

点击查看大图。

### 通配符搜索

筛选时，有时你想要使用精确字符串进行筛选或搜索。在其他时候，你可能想要搜索或筛选包含某个字符串的所有项目。使用以下指南了解如何使用星号(*)进行通配符搜索。

| 语法 | 说明 |
| --- | --- |
| mystring | 返回确切的字符串mystring |
| *mystring | 返回所有以mystring结尾的项目 |
| mystring* | 返回所有以mystring开头的项目 |
| *mystring* | 返回文本中某处包含mystring的所有项目，例如WootMyStringIsGreat |
| my*string | 返回所有以my开头并以string结尾但中间包含任意内容的项目，例如MyGreatestEverString |

### 控制台命令

**调试HUD（Debug HUD）** 选项卡中的所有选项都可以使用控制台命令手动运行。

为了运行控制台命令，你需要将它们输入到输出日志的控制台中。

#### fx.Niagara.Debug.Hud

用于修改HUD的主要控制台命令（带有你可以设置的值）如下：

- `fx.Niagara.Debug.Hud` 显示可用命令的列表。
- `Enabled=1` 将启用HUD（0为禁用）。
- `ValidateSystemSimulationDataBuffers=1` 启用或禁用（0为禁用）对系统数据缓冲区的验证。
- `bValidateParticleDataBuffers=1` 启用或禁用（0为禁用）对粒子数据缓冲区的验证。
- `OverviewEnabled=1` 启用或禁用（0为禁用）主概览显示。
- `OverviewLocation=30,50` 设置HUD在编辑器视口中的位置。第一个值对应X轴，第二个值对应Y轴。
- `ShowGlobalBudgetInfo=1` 启用全局预算信息控件（0为禁用）。
- `EnableGpuParticleReadback=1` 使我们能够为粒子显示回读GPU数据（0为禁用）。
- `SystemDebugVerbosity=0` 设置系统冗长度级别。0对应"无（None）"，1对应"基本（Basic）"，2对应"冗长（Verbose）"。
- `SystemEmitterVerbosity=0` 设置世界系统发射器调试冗长度。0对应"无（None）"，1对应"基本（Basic）"，2对应"冗长（Verbose）"。
- `SystemShowBounds=1` 显示所有筛选后的系统边界（0为禁用）。
- `SystemShowActiveOnlyInWorld=1` 只会在世界显示中针对活动组件显示（0为禁用）。
- `SystemFilter=*Flop*` 为世界显示设置通配符系统筛选器，这将匹配名称中包含flop的所有内容。
- `ComponentFilter=MyComp` 将在世界显示中筛选与MyComp匹配的所有组件。
- `ShowSystemVariables=1` 启用系统变量可见性（0为禁用）。
- `SystemVariables=Position,*Color` 将显示匹配"Position"的所有变量和包含"Color"的所有变量。
- `ShowParticlesVariablesWithSystem=1` 启用时，粒子变量与系统显示一起显示，禁用时（设置为0），它会附加到世界显示中的组件。
- `MaxParticlesToDisplay=32` 会将显示限制为32个粒子，这纯粹是为了避免破坏帧率/内存。
- `ShowParticleVariables=1` 启用粒子变量可见性（0为禁用）。
- `ParticlesVariables=*Pos,Color` 将显示包含"Pos"的所有变量以及与"Color"匹配的所有变量。

#### fx.Niagara.Debug.PlaybackMode

为所有Niagara效果设置播放模式。

- `fx.Niagara.Debug.PlaybackMode 0` 将播放所有模拟。
- `fx.Niagara.Debug.PlaybackMode 1` 将暂停模拟。
- `fx.Niagara.Debug.PlaybackMode 2` 将步进单个帧，然后暂停所有模拟。

#### fx.Niagara.Debug.PlaybackRate

播放速率是所有Niagara模拟的增量时间的修饰符。

- fx.Niagara.Debug.PlaybackRate 0.5

  将以半速运行所有模拟。

#### 显示全局预算信息相关命令

- `fx.budget.enabled 1` 启用全局预算跟踪（0为禁用）。
- `fx.Budget.GameThread` 将显示仅在游戏线程上运行的所有合并FX工作的预算（以毫秒为单位）。随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。
- `fx.Budget.GameThreadConcurrent` 将显示所有合并FX工作的预算（以毫秒为单位），而这些工作在游戏线程上运行或在从游戏线程产生的并发任务上运行。随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。
- `fx.Budget.RenderThread` 将显示在渲染线程上运行的所有合并FX工作的预算（以毫秒为单位）。随着接近或超过此预算，各种FX系统将尝试越来越积极地缩减，以便保持在预算范围内。

### FX大纲视图

**FX大纲视图** 是你可以在 **Niagara调试器（Niagara Debugger）** 面板中找到的第二个选项卡。此选项卡使你能够从关卡中的Niagara模拟中捕获数据，以便你可以对其进行分析。

> [!NOTE]
> 此功能仍在开发中，并将在未来版本中继续升级。

要打开FX大纲视图，点击Niagara调试器中的选项卡。

> 图片已省略：Outliner Tab

点击查看大图。

要开始，点击 **捕获（Capture）** 按钮。FX大纲视图将等待 **延迟（Delay）** 字段中指定的帧数，然后开始运行。然后，你将在下面的分段中看到输出。

> 图片已省略：Outliner Tab Layout

点击查看大图。

#### FX大纲视图界面

FX大纲视图界面布局如下。

> 图片已省略：Outliner Interface

点击查看大图。

1. 工具栏
2. 世界行
3. 系统行
4. 系统实例行
5. 发射器行
6. 内联数据
7. 所选行的细节

你可以在FX大纲视图工具栏选择工具选项。

> 图片已省略：FX大纲视图工具栏

| 参数 | 说明 |
| --- | --- |
| **捕获（Capture）** | 点击以便在当前连接的设备上触发捕获。要更改正在使用的设备，请点击 **调试（Debugging）** 面板中的 **会话浏览器（Session Browser）** 选项卡。 |
| **Perf** | 打开或关闭此按钮以便在此捕获中捕获性能数据。 |
| **延迟（Delay）** | 设置捕获数据之前要延迟的帧数。例如，如果你需要在游戏中执行特定操作，你可能需要设置延迟。 此值还会设置捕获的时长。 |
| **视图模式（View Mode）** | 为下面的捕获区域选择哪种视图模式。视图模式有两种，"状态（State）"和"性能（Performance）"。 **状态（State）** 将显示执行状态、粒子数以及sim目标是CPU还是GPU。 **性能（Performance）** 将显示可用的性能信息。目前，性能是在系统和系统实例级别收集的。发射器只显示状态数据。 |
| **筛选器（Filters）** | 点击此按钮，你可以为捕获数据选择各种筛选选项。 **系统执行状态（System Execution State）** ：仅显示激活/不激活/不激活清除/已完成的系统。 **发射器执行状态（Emitter Execution State）** ：仅显示激活/不激活/不激活清除/已完成的系统。 **激活系统和/或发射器（Active systems and/or emitters）** 将运行所有脚本并支持生成。 **不激活系统和/或发射器（Inactive systems and/or emitters）** 将运行所有脚本但不支持生成。 **不激活清除系统和/或发射器（Inactive Clear systems and/or emitters）** 将清除所有现有粒子并移至不激活状态。 **已完成（Complete）** 是指系统和/或发射器完成执行时。 **发射器Sim目标（Emitter Sim Target）** 可以按CPU或GPU进行筛选。 **系统剔除状态（System Cull State）** 仅显示已经或没有因可扩展性而被剔除的系统。 你还可以使用搜索框按字符串筛选。 |
| **降序（Descending）** | 切换 **升序（Ascending）** 或 **降序（Descending）** ，根据 **排序模式（Sort Mode）** 的值更改条目的排序方式。 |
| **排序模式（Sort Mode）** | 设置条目的排序方式。 **自动（Auto）** 将为当前视图模式选择默认模式。如果你处于"状态视图（State View）"中，这将按与当前筛选器匹配的条目数进行排序。在"性能视图（Performance View）"中，它将按平均游戏线程时间排序。 **筛选匹配（Filter Matches）** 将按与筛选条件匹配的条目数进行排序。 **平均时间（Average Time）** 将按平均游戏线程时间排序。 **最大时间（Max Time）** 将按最大游戏线程时间排序。 |
| **单位（Units）** | 在性能模式下以微秒、毫秒或秒为单位查看时间值。默认值为微秒。 |

#### 状态视图

状态视图将显示有关行项目状态的数据。根据该行是代表世界、系统、系统实例还是发射器，显示的数据类型会有所不同。

> 图片已省略：State View Mode

点击查看大图。

1. 世界
2. 系统
3. 系统实例
4. 发射器

##### 世界

| 参数 | 说明 |
| --- | --- |
| **世界类型（World Type）** | 显示数据源。示例：编辑器、游戏、PIE。 |
| **网络模式（Net Mode）** | 显示这是客户端、专用服务器还是独立服务器。 |
| **已开始运行（Has Begun Play）** | 返回True或False。 |
| **系统数（Number of Systems）** | 指世界中与当前搜索筛选器匹配的系统数量。 |

##### 系统

系统当前仅输出与当前搜索筛选器匹配的系统实例数。

##### 系统实例

| 参数 | 说明 |
| --- | --- |
| **池化方法（Pooling Method）** | 返回None、InUse或FreeInPool之一。 |
| **执行状态（Execution State）** | 显示整个系统是"激活（Active）"、"不激活（Inactive）"还是"已完成（Complete）"。 |
| **发射器数（Number of Emitters）** | 显示此系统实例中与当前搜索筛选器匹配的发射器数量。 |
| **未初始化（Uninitialized）** | 如果组件已创建但尚未完全初始化，它将显示"未初始化（Uninitialized）"。 |

##### 发射器

| 参数 | 说明 |
| --- | --- |
| **执行状态（Execution State）** | 显示发射器的当前状态，即"激活（Active）"、"不激活（Inactive）"或"已完成（Complete）"。 |
| **Sim目标（Sim Target）** | 显示此发射器是CPU发射器还是GPU发射器。 |
| **粒子数（Number of Particles）** | 显示粒子数。 |

#### 性能视图

**性能视图（Performance View）** 将显示捕获的所有性能数据。数字以选定的单位显示，默认为微秒。

> 图片已省略：Performance View Mode

点击查看大图。

每个数字块被分成两部分。你会在左边看到游戏线程成本，在右边看到渲染线程成本。

所有值均在由 **延迟（Delay）** 值设置的捕获时间内计算得出。

1. 所有效果的平均总帧时间。
2. 所有效果的最大总帧时间。
3. 此系统的平均每实例成本。
4. 此系统的最大每实例成本。
5. 此系统所有实例的平均总成本。
6. 此系统所有实例的最大总成本。
7. 此实例的平均成本。
8. 此实例的最大成本。

不会在单个发射器上捕获信息，因此你只会看到发射器的状态数据。

### 性能

> [!WARNING]
> 该工具的此分段具有高度试验性，可能会发生变化。

> 图片已省略：Performance Tab

点击查看大图。

| 参数 | 说明 |
| --- | --- |
| **切换ParticlePerf（Toggle ParticlePerf）** | 此选项会在运行性能测试时打开CPU成本。 |
| **运行性能测试（Run Performance Test）** | 点击它将在指定的帧时长内运行性能测试。测试运行后，输出将以文本格式粘贴到输出日志中。数据采用 `.csv` 格式，如果需要，可以从输出日志复制粘贴到电子表格中以供进一步分析。 |
| **切换基线（Toggle Baseline）** | 每种效果类型都有在Niagara系统的系统属性中设置的基线。启用后，在运行性能测试时，它将根据该效果类型的基线成本来衡量关卡中的系统成本。 |
| **启用异步模拟（Enable Async Simulation）** | 点击可以启用关卡中的所有Niagara模拟。快速启用或禁用此设置有助于确定你遇到的问题是否与此设置有关。 |
| **禁用异步模拟（Disable Async Simulation）** | 点击可以禁用关卡中的所有Niagara模拟。快速启用或禁用此设置有助于确定你遇到的问题是否与此设置有关。 |

### 会话浏览器

Niagara调试器中的第四个选项卡是 **会话浏览器（Session Browser）** 。

> 图片已省略：Session Browser

点击查看大图。

会话浏览器将驱动所有测试在Niagara调试器的其他选项卡上运行。在会话浏览器中，你将看到当前处于激活状态的所有会话。在此截图中，唯一可用的会话是在本地设备上运行的应用程序上。

如果你有会话在控制台或其他设备上运行，你可以在会话浏览器中选择Niagara调试器信息，将它们输出到这些设备上。

然后你可以返回到"调试HUD（Debug HUD）"选项卡来调整显示设置。

### 调试生成

> [!WARNING]
> 该工具的此分段具有高度试验性，可能会发生变化。

> 图片已省略：Debug Spawn

点击查看大图。
