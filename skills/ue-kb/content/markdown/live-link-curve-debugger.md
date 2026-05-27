# Live Link Curve Debugger

---
title: "Live Link Curve Debugger"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/live-link-curve-debugger-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "Live Link Curve Debugger"]
---

# Live Link Curve Debugger

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / Live Link Curve Debugger

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/live-link-curve-debugger-in-unreal-engine

在使用[Live Link](../index.md)插件将内容流送到虚幻引擎时，你可能需要查看各种活跃曲线和值。**Live Link Curve Debugger** 工具让你能够以一种易于调试的方式查看各种Live Link曲线的输出。

## 启用Live Link Curve Debugger

为了使用Live Link Curve Debugger，你首先需要从 **插件（Plugins）** 菜单启用它：

1. 从 **编辑（Edit）** 菜单，选择 **插件（Plugins）**。

   ![01_PluginMenu.png](../../../../../assets/images/38/38dca159d5cbead4ca1d3b5ee63708573caa9abdeab670317ba40dbd70805209.jpg)
2. 在 **插件（Plugins）** 菜单的 **动画（Animation）** 下面，启用 **Live Link** 和 **Live Link Curve Debug UI** 选项，并重启编辑器。

   ![02_EnableLiveLinkOptions.png](../../../../../assets/images/c8/c8c701cee9200d2e09777803346ac1279825fa20212f59437c68521e8125f8d5.png)
3. 从 **窗口（Window）** 选项，在 **开发者工具（Developer Tools）** 下面，选择 **Live Link Curve Debugger**。

   ![03_DebuggerWindow.png](../../../../../assets/images/29/296658480f5cb58ad3ae87bfe61795359788678c471a8739ba23e6b35b770266.jpg)

   **Live Link Curve Debugger** 窗口将会打开。

   ![04_DebuggerWindowOpen.png](../../../../../assets/images/58/5877b5e53372e1ee64a5595a36740903fc8f34a29af93322bab80970b0057cba.png)

## 使用Live Link Curve Debugger

与[Maya with Live Link](https://dev.epicgames.com/documentation/404)或[Motion Builder with Live Link](../live-link-stream-motionbuilder-to/index.md)连接后，你就可以在UE中访问该应用程序中的内容，包括任何动画曲线。通过Live Link Curve Debugger，你可以查看当前所选 **主题名称** 的所有曲线和曲线值的列表，单击 **Live Link主题名称（Live Link Subject Name）** 下拉菜单并选择"主题（Subject）"可以定义主题名称。

![DebuggerWindowSubject.png](../../../../../assets/images/19/19fce6f0d160d36b1952b9fc85c1ff7dba0882e172ced44a0eb6fe4559de12fd.png)

选择主题后，将在窗口中显示任何曲线及其值。

![undefined](../../../../../assets/images/6c/6c8a0621c7ef0a80e90ea60908e6436afa451ac9cdfae44b641fae21b7f05021.jpg)

单击查看大图。

> [!NOTE]
> 如果尚未指定主题名称，当某个主题与部分曲线相连后，调试器将切换到该主题。你可以单击 **Live Link主题名称（Live Link Subject Name）** 下拉菜单（在编辑器或桌面构建中），或在命令行中输入 **LiveLinkDebugger Next** 来循环浏览不同的主题名称（在其他客户端构建上），从而更改该选择

在客户端内部，还可以使用命令行，通过以下命令显示Live Link Debugger：**LiveLinkDebugger Show**

> [!TIP]
> 你可以选择在命令行中使用命令 **LiveLinkDebugger Show** *SubjectName*（主题名称）来指定要使用的Live Link主题名称。

