---
title: "虚幻引擎多用户编辑"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/multi-user-editing-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "虚幻引擎多用户编辑"]
---

# 虚幻引擎多用户编辑

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 虚幻引擎多用户编辑

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/multi-user-editing-in-unreal-engine

通过多用户编辑，您可以将虚幻编辑器的多个实例连接起来，以在共享编辑会话中展开协作，与您的团队成员和同事实时构建一个虚拟世界。

> [!TIP]
> 多用户编辑已在大规模虚拟影视制作团队中进行设计和测试，在实时拍摄期间，可能会有数十位操作员在现场协作。这些操作员使用虚幻引擎设计、搭建和点亮虚拟场景，模拟剧组搭建实体布景的方式。这有助于导演、演员和剧组人员在排练和拍摄实景镜头时，看到将实景和CG内容结合在一起的效果，而不必等待后期制作。
>
> 要查看多用户编辑的实际操作，请观看 [SIGGRAPH 2018 实时虚拟制作演示](https://www.unrealengine.com/en-US/blog/multi-user-collaboration-and-unreal-engine-real-time-production)。
>
> ![Reflections](../../../assets/images/b6/b6cec6ee6437efab9151d0341058b5035b92449be5d14a4488bb211fe416bcd6.jpg)

虽然多用户编辑是在虚拟影视制作背景下开发的，但同类实时协作对于有多个用户需要处理同一内容的任何场景可能都有用。任何虚幻引擎开发项目都能够使用多用户编辑来缩短迭代时间，获取对更改的即时反馈并提高团队的创造力。

## 入门

- [多用户编辑概述](multi-user-editing-overview/index.md) - 关于多用户编辑系统工作方式的概念概述。

- [多用户编辑入门](getting-started-with-multi-user-editing/index.md) - 指导每步操作，帮助用户在项目中启用并运行多用户编辑。

- [多用户服务器用户界面](multi-user-server-user-interface/index.md) - 多用户服务器用户界面的详细讲解。

## 镜头试拍录制器

- [多用户镜头录制器](multi-user-take-recorder/index.md) - 如何在多用户编辑会话中启用镜头试拍录制。

## 教程

- [会话档案的保存和恢复](saving-and-restoring-session-archives/index.md) - 在档案中保存会话更改，以便随时恢复。

- [高级多用户联网功能](advanced-multi-user-networking/index.md) - 无法连接多用户编辑服务器时的可用解决方案。

## 参考

- [多用户编辑参考](multi-user-editing-reference/index.md) - 包含多用户编辑中涉及的项目设置、控制台命令和命令行参数的参考信息。
