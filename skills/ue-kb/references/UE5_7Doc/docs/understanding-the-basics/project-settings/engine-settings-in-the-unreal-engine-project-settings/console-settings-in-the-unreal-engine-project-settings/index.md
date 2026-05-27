---
title: "控制台"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/console-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "控制台"]
---

# 控制台

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 控制台

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/console-settings-in-the-unreal-engine-project-settings

> [!NOTE]
> 本页面介绍虚幻引擎中控制台输入的项目设置。不要与游戏主机（平台）支持混淆。

## 控制台

### 通用

| **分段** | **说明** |
| --- | --- |
| **最大回滚大小（Max Scrollback Size）** | 之前输入的命令的历史记录大小。 |

### 自动完成

| **分段** | **说明** |
| --- | --- |
| **手动自动完成列表（Manual Auto-Complete List）** | `BaseInput.ini`（位于引擎安装目录中的 `Engine/Config` 文件夹中）中指定的自动完成命令和信息的手动列表。 |
| **自动完成地图路径（Auto Complete Map Paths）** | 相对路径列表（例如，' Content/Maps '），用于搜索供自动完成使用的地图名称。 在 `BaseInput.ini`（位于引擎安装目录中的 `Engine/Config` 文件夹中）中指定。 |
| **从上到下排序（Order Top to Bottom）** | 定义控制台命令是采用从下到上排序（旧版行为）还是从上到下排序。 |
| **在自动完成中显示帮助（Display Help in Auto-Complete）** | 如果启用，将在说明不可用时，在自动完成窗口中显示可用帮助文本的第一行。 |

### 颜色

| **分段** | **说明** |
| --- | --- |
| **背景不透明度百分比（Background Opacity Percentage）** | 控制台背景的透明程度。 |
| **输入颜色（Input Color）** | 用于文本输入的颜色。 |
| **历史记录颜色（History Color）** | 用于之前输入的命令历史记录的颜色。 |
| **自动完成命令颜色（Auto-Complete Command Color）** | 用于可执行命令的自动完成颜色。 |
| **自动完成控制台变量颜色（Auto-Complete CVar Color）** | 用于可变控制台变量（CVar）的自动完成颜色。 |
| **自动完成消退颜色（Auto-Complete Faded Color）** | 用于命令说明和只读控制台变量的自动完成颜色。 |
