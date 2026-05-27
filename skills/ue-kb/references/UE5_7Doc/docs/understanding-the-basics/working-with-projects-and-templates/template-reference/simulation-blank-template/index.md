---
title: "模拟空白模板"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/simulation-blank-template-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "使用项目和模板", "模板参考", "模拟空白模板"]
---

# 模拟空白模板

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 使用项目和模板 / 模板参考 / 模拟空白模板

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/simulation-blank-template-in-unreal-engine

**模拟空白（Simulation Blank）** 模板是一种 **空世界（Empty World）** 关卡模板，内附特定于模拟的设置和功能。它由带有以下功能和特征的空环境组成：

- 作为地面/地板的扁平静态网格体。
- 带有特定于地球的设置的[SunSky](../../../../building-virtual-worlds/lighting-the-environment/lighting-tools-and-plugins/geographically-accurate-sun-positioning-tool/index.md)系统：

  - 与地理配准插件规范兼容的北偏移。
  - 带有逼真太阳属性（ **强度（Intensity）** 、 **源角度（Source Angle）** ）的定向光源，投射利用[虚拟阴影贴图](https://dev.epicgames.com/documentation/404)系统的远阴影（需要在 **项目设置（Project Settings）> 平台 - Windows（Platforms - Windows）** 下启用 **DirectX 12（SM6试验性）（DirectX 12 (SM6.Experimental)）** 选项，还需要兼容的显卡）。
- [体积云](../../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)，带有外观自然的材质。
- [指数高度雾](../../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/exponential-height-fog/index.md)。
- 星星（请注意，这些仅用于美化目的，并不能准确表示给定现实世界位置的真实星星定位）。
- 带有对应人眼视觉的 **曝光（Exposure）** 设置的全局后期处理体积。
- [地理配准](../../../../building-virtual-worlds/georeferencing-a-level/index.md)Actor，用于定位地球上的环境。

> [!NOTE]
> SunSky和地理配准Actor中UE原点的地理位置已设置为73W, 45N。你必须根据实际环境位置酌情调整。

该模板还随附自定义 `BP_SimGameMode` 蓝图，它定义了特定 `BP_SimPlayerController` 和 `BP_SimfloatingPawn` 。这些蓝图示例说明了如何增强Controller和Pawn基类的默认功能，详见下文。

## 模拟玩家控制器（BP_SimPlayerController）

该控制器随附一些快捷键，用于在运行时允许以下玩家操作：

- 使用运行之时生成的浮动Pawn自由寻路（ `BP_SimfloatingPawn` ）。
- 在此浮动Pawn和关卡中已存在的Pawn之间交替。
- 控制当日时间。
- 显示分析和统计数据控件。
- 显示地理空间位置状态栏。

以下键盘快捷键可供使用：

| **键** | **操作** |
| --- | --- |
| Pawn功能按钮 |  |
| **Enter** | 在浮动Pawn和预先存在的关卡Pawn之间交替。 |
| **Tab** | 控制关卡Pawn时，切换到下一个可控制的Pawn。 |
| **Shift + Tab** | 控制关卡Pawn时，切换到上一个可控制的Pawn。 |
| **1 - 6** | 用于控制特定关卡Pawn的直接快捷键。如果数量超过6个，请使用 **Tab** 键。 |
| 当日时间功能按钮 |  |
| **End** | 减少当前的当日时间。 |
| **Page Down** | 增加当前的当日时间。 |
| **Insert** | 将当日时间平滑过渡到黎明值。 |
| **Home** | 将当日时间平滑过渡到中午值。 |
| **Page Up** | 将当日时间平滑过渡到傍晚值。 |
| 控件功能按钮 |  |
| **P** | 显示/隐藏分析控件。 |
| **G** | 显示/隐藏地理空间控件。 |

### 地理空间控件

![Geospatial Widget](../../../../../assets/images/a8/a87d7d9c5ec9257bc97c286cf049359515997daf6484edaca9996f1791313c8c.jpg)

点击查看大图。

**地理空间控件（Geospatial Widget）** 是在不同坐标系中显示你在地球上的当前位置的状态栏：

- 投影CRS。
- 地理CRS（纬度/经度）。
- 地心（ECEF）。

如需更多信息，请参阅[关卡地理配准](../../../../building-virtual-worlds/georeferencing-a-level/index.md)页面。

### 分析控件

![分析控件](../../../../../assets/images/7d/7df339eb7e3cbb5746f52b1fc18dd250017b8d07d9933ae54df9a2a43e18b049.jpg)

点击查看大图。

**分析控件（Profiling Widget）** 是用于分析应用程序性能的调试工具。

左侧按钮堆栈将显示或隐藏不同的性能计数器，你也可以通过关联的 `stat counterName` 控制台命令访问这些计数器。控件显示了最常见、最有用的计数器：

- FPS
- Unit
- Engine
- SceneRendering
- Game
- GPU

由于分析与每秒帧数（FPS）密切相关，你可以在第二列按钮中启用或禁用垂直同步（VSync），或根据需要将FPS限制为30或60FPS。

## 模拟浮动Pawn（BP_SimfloatingPawn）

模拟浮动Pawn是虚幻引擎默认Pawn的改进版本，增加了使用 **鼠标滚轮** 控制最大寻路速度的功能。这有助于处理大型环境。

**点击** 鼠标滚轮将重置为默认速度。
