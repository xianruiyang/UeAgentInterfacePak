# DPI 缩放

---
title: "DPI 缩放"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dpi-scaling-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "UMG编辑器参考", "DPI 缩放"]
---

# DPI 缩放

> 路径：虚幻引擎5.7文档 / 创建用户界面 / UMG编辑器参考 / DPI 缩放

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dpi-scaling-in-unreal-engine

**UMG** 支持与分辨率无关的 UI 进行自动缩放。在 **用户界面** 部分下的 **项目设置** 菜单中，提供了应用于每个项目的默认 DPI 缩放规则，这些规则您可以根据具体需求自行配置。你可以通过输入框调整 **应用比例（Application Scale）**，你可以选择 **DPI比例规则**，以及调整 **DPI曲线**。

关于 **DPI 缩放规则**，您可以将其设为以下四个选项中的一个：

- 最短边

  ：该选项将基于窗口的最短边来评估缩放曲线（最常用的设置）。
- 最长边

  ：基于窗口的最长边来评估缩放曲线。
- 水平

  ：基于窗口的 X 轴来评估缩放曲线。
- 垂直

  ：基于窗口的 Y 轴来评估缩放曲线。

你可以右键单击DPI曲线图，选择 **添加键** 选项，在曲线上添加点。之后，你可以通过输入框来设置分辨率及其相应的缩放值。此外，对于曲线，还可通过展开 **DPI 曲线** 选项，提供外部的 **浮点曲线**，或根据当前应用的设置来创建浮点曲线。

