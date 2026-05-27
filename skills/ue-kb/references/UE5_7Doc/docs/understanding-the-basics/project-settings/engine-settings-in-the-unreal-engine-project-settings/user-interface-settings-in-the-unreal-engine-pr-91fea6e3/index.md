---
title: "用户界面"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/user-interface-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "用户界面"]
---

# 用户界面

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 用户界面

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/user-interface-settings-in-the-unreal-engine-project-settings

## 用户界面

### 焦点

| **分段** | **说明** |
| --- | --- |
| **渲染焦点规则（Render Focus Rule）** | 该规则确定引擎是否应该为获得用户焦点的控件渲染焦点笔刷。 你可以选择以下选项： **总是（Always）：** 总是为获得用户焦点的控件渲染焦点笔刷。 **非指针（Non-Pointer）：** 为获得未基于指针原因设置的用户焦点的控件渲染焦点笔刷。 **仅寻路（Navigation Only）：** 仅当焦点通过寻路设置时，为获得用户焦点的控件渲染焦点笔刷。 **从不（Never）：** 不渲染焦点笔刷。 |

### 硬件光标

| **分段** | **说明** |
| --- | --- |
| **硬件光标（Hardware Cursors）** | 此设置使用你指定的原始图像文件覆盖操作系统提供的默认光标。 |

### 软件光标

| **分段** | **说明** |
| --- | --- |
| **软件光标（Software Cursors）** | 此设置使用你指定的虚幻示意图形控件覆盖硬件光标。 |

### DPI缩放

| **分段** | **说明** |
| --- | --- |
| **应用程序缩放（Application Scale）** | （可选）在自定义缩放规则基础之上要应用的应用程序缩放。 例如，如果你想在游戏中公开一个属性，可以修改此底层值，缩放整个UI。 |
| **DPI缩放规则（DPI Scale Rule）** | 在决定要应用哪种缩放时使用的规则。 你可以选择以下选项： **最短侧（Shortest Side）：** 基于视口的最短侧对缩放曲线求值。 **最长侧（Longest Side）：** 基于视口的最长侧对缩放曲线求值。 **水平（Horizontal）：** 基于视口的X轴对缩放曲线求值。 **垂直（Vertical）：** 基于视口的Y轴对缩放曲线求值。 **缩放以适应（Scale to Fit）：** 不使用缩放曲线。使用 `DesignScreenSize` 并相对于它缩放内容，模仿缩放盒体的行为。 **自定义（Custom）：** 允许自定义规则解译。 |
| **自定义缩放规则类（Custom Scaling Rule Class）** | 如果将 **DPI缩放规则（DPI Scale Rule）** 设置为 **自定义（Custom）**，将xuanze 使用此类而不是内置规则。 |
| **DPI曲线（DPI Curve）** | 控制如何基于 **DPI缩放规则（DPI Scale Rule）** 在不同分辨率下缩放UI。 |
| **DPI曲线（外部曲线）（DPI Curve (External Curve)）** | 从内容浏览器中选择的曲线资产，用于代替基础DPI曲线设置。 |
| **在游戏模式中允许高DPI（Allow High DPI in Game Mode）** | 如果启用，建台式机平台上的游戏窗口将启用高DPI感知度。 推荐仅当游戏UI允许用户修改3D分辨率缩放时启用。 |
| **设计屏幕大小（Design Screen Size）** | 仅用于 **DPI缩放规则（DPI Scale Rule）** 选项中的 **Scale to Fit** 缩放规则。 定义为其创建源UI纹理的原生分辨率。 DPI缩放在此屏幕分辨率下将被设为1.0。 |

### 控件

| **分段** | **说明** |
| --- | --- |
| **在专用服务器上加载控件（Load Widgets on Dedicated Server）** | 如果禁用，控件引用将在服务器版本的烘焙期间剥离，而不在运行时加载。 |
