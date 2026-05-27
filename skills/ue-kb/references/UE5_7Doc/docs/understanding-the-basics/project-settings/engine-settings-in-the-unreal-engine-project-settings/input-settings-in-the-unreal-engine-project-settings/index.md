---
title: "输入设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/input-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "输入设置"]
---

# 输入设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 输入设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/input-settings-in-the-unreal-engine-project-settings

## 输入

### 绑定

操作和轴映射提供了一种机制，可以方便地将键和轴映射到输入行为和引起该行为的键。

| **分段** | **说明** |
| --- | --- |
| **语音映射（Speech Mappings）** | 语音映射的列表。 |
| **操作映射（Action Mappings）** | 按下和松开键的操作映射列表。 |
| **轴映射（Axis Mappings）** | 允许具有连续范围的输入的轴映射列表。 |
| **轴配置（Axis Config）** | 轴属性的列表。 |
| **Alt+Enter切换全屏（Alt+Enter Toggles Fullscreen）** | 如果启用，你可以在运行时使用 **Alt** + **Enter** 切换全屏。 |
| **F11切换全屏（F11 Toggles Fullscreen）** | 如果启用，你可以在运行时使用 **F11** 切换全屏。 |

### 视口属性

| **分段** | **说明** |
| --- | --- |
| **在启动时捕获鼠标（Capture Mouse on Launch）** | 控制视口是否将在应用程序启动时捕获鼠标。 |
| **默认视口鼠标捕获模式（Default Viewport Mouse Capture Mode）** | 游戏视口的默认鼠标捕获模式。 你可以从以下选项中选择： **无捕获（No Capture）** **永久捕获（Capture Permanently）** **永久捕获包括鼠标首次按下（Capture Permanently Including Initial Mouse Down）** **鼠标按下期间捕获（Capture During Mouse Down）** **鼠标右键按下期间捕获（Capture During Right Mouse Down）** |
| **默认视口鼠标锁定模式（Default Viewport Mouse Lock Mode）** | 视口获取捕获时的默认的鼠标锁定状态行为。 你可以从以下选项中选择： **不锁定（Do Not Lock）** **捕获时锁定（Lock on Capture）** **总是锁定（Lock Always）** **全屏时锁定（Lock in Fullscreen）** |

### 输入

| **分段** | **说明** |
| --- | --- |
| **启用旧版输入比例（Enable Legacy Input Scales）** | 在玩家控制器上启用旧版输入比例（ `InputYawScale` 、 `InputPitchScale` 和 `InputRollScale` ）。 |

### 移动设备

| **分段** | **说明** |
| --- | --- |
| **总是显示触摸界面（Always Show Touch Interface）** | 指定触摸输入界面是应该总是显示，还是仅当平台有触摸屏时才显示。 |
| **在四指点击时显示控制台（Show Console on Four-Finger Tap）** | 指定是否在四指点击时在移动平台上显示控制台。 |
| **启用手势识别器（Enable Gesture Recognizer）** | 指定是否使用手势识别系统将触摸转换为可以绑定并查询的手势。 |
| **默认触摸界面（Default Touch Interface）** | 游戏的默认屏幕触摸输入界面（可以为 `null` ，以禁用屏幕界面）。 |

### 虚拟键盘（移动端）

| **分段** | **说明** |
| --- | --- |
| **使用自动更正（Use Autocorrect）** | 如果启用，虚拟键盘将启用自动更正。 目前仅支持移动设备。 |
| **排除自动更正操作系统（Excluded Autocorrect OS）** | 为这些操作系统禁用自动更正，即使启用了自动更正也不例外。 使用 `[platform] [OSversion]` 格式（例如，“iOS 11.2”或“Android 6”）。 更具体的版本号将缩小禁用自动更正的设备范围（使用“iOS 11”时将为运行iOS 11的所有设备禁用自动更正，但使用“iOS 11.2.2”时将不会为运行11.2.1的设备禁用自动更正）。 |
| **排除自动更正文化（Excluded Autocorrect Cultures）** | 为这些文化禁用自动更正，即使开启了自动更正也不例外。 这些应该是兼容ISO的语言和国家/地区代码，例如“en”或“en-US”。 |
| **排除自动更正设备型号（Excluded Autocorrect Device Models）** | 为这些设备型号禁用自动更正，即使开启了自动更正也不例外。 此处列出的型号ID与设备型号的开头机型匹配（例如，使用“SM-”时将匹配以“SM-”开头的所有设备型号ID）。 目前仅支持Android设备。 |

### 默认类

| **分段** | **说明** |
| --- | --- |
| **默认玩家输入类（Default Player Input Class）** | 玩家输入对象的默认类类型。 可以由玩家控制器重载。 |
| **默认输入组件类（Default Input Component Class）** | Pawn输入组件的默认类类型。 |

### 控制台

| **分段** | **说明** |
| --- | --- |
| **控制台键（Console Keys）** | 用于打开控制台的键盘快捷键。 |

### 鼠标属性

| **分段** | **说明** |
| --- | --- |
| **使用鼠标触摸（Use Mouse for Touch）** | 允许用鼠标进行触摸。 |
| **启用鼠标平滑（Enable Mouse Smoothing）** | 鼠标平滑控制。 |
| **启用FOVScaling（Enable FOVScaling）** | 将鼠标输入轴（包括水平轴和垂直轴）从玩家控制器的输入缩放到玩家摄像机管理器的视野。 FOV值越低，鼠标在项目中的灵敏度就越低。 |
| **FOVScale** | 要将视野乘以 `[value]` 的缩放值。 |
| **双击时间（Double Click Time）** | 如果一个键在此时间内按了两次，将被视为“双击”。 |
