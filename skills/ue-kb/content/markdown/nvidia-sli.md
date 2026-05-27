# NVIDIA SLI交替帧渲染

---
title: "NVIDIA SLI交替帧渲染"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/nvidia-sli-alternative-frame-rendering-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "第三方渲染工具和插件", "NVIDIA SLI交替帧渲染"]
---

# NVIDIA SLI交替帧渲染

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 第三方渲染工具和插件 / NVIDIA SLI交替帧渲染

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/nvidia-sli-alternative-frame-rendering-in-unreal-engine

虚幻引擎为在NVIDIA SLI配置上运行的打包游戏提供NVIDIA的 **交替帧渲染（Alternate Frame Rendering）**（AFR）支持。交替帧渲染的工作原理是在连接的GPU之间交替渲染帧。一帧由GPU1渲染，下一帧则由GPU2 渲染，然后重复此过程。通过这种方法，在单个显示器上使用多个GPU就能提升图像质量和性能。

> [!NOTE]
> 有意愿使用交替帧渲染的项目需要直接和NVIDIA合作，测试游戏并使其在必要时自动切换使用此功能。

如需了解更多详情，请参阅NVIDIA文档[SLI 模式，特别说明交替帧渲染](https://docs.nvidia.com/gameworks/content/technologies/desktop/sli.htm)。

## 强制启用交替帧渲染

NVIDIA控制面板允许手动添加一些支持ARF强制启用SLI渲染模式的应用程序。如需将应用程序添加到NVIDIA控制面板，请按以下步骤操作：

1. 从任务托盘中打开

   NVIDIA控制面板

   ，然后找到

   管理3D设置（Manage 3D Settings）

   。
2. 点击

   项目设置（Program Settings）

   标签，然后在

   选择程序并自定义（Select a program to cumstomize）

   下拉菜单中选择要添加的程序。
3. 在

   SLI渲染模式（SLI Rendering Mode）

   的选项旁选择

   强制交替帧渲染（Force Alternate Frame Rendering）

   。

> [!NOTE]
> 此功能并不能保证能改善应用程序的质量或性能，因此尤其不推荐结合虚幻引擎编辑器使用。如果想要为开发中或已发布的项目使用此功能，请直接与NVIDIA联系，使用其提供的驱动设置此功能。

