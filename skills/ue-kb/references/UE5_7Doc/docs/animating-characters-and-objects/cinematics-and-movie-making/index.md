---
title: "过场动画和Sequencer"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/cinematics-and-movie-making-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer"]
---

# 过场动画和Sequencer

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/cinematics-and-movie-making-in-unreal-engine

虚幻引擎包含许多强大的过场动画工具，允许你创建动画和动画序列。 你可以操纵摄像机来创建关卡飞越漫游视图，对光源进行动画处理，移动对象，对角色进行动画处理，渲染输出序列等等。 所有这些流程的核心都是**Sequencer**，这是一款强大的非线性编辑工具。 Sequencer是你在虚幻引擎中创建过场动画内容时使用的主要工具。

本文罗列了虚幻引擎过场动画工具相关的文档链接，以及相关实际使用案例。

> 图片已省略：image alt text

## 开始入门

如果你刚开始学习过场动画工具和虚幻引擎，请参考下述页面，它们涵盖了Sequencer编辑器的基础知识。 我们提供了各种简单的指南，帮助你了解创建过场动画时可能需要执行的常见操作。

- [Sequencer基础](how-to-make-movies/index.md) - 使用Sequencer创建过场动画的指南。

- [创建摄像机动画](how-to-make-movies/how-to-animate-cinematic-cameras/index.md) - 关于如何在Sequencer中创建摄像机动画的入门探索。
- [将动画应用到角色](how-to-make-movies/how-to-add-cinematic-animation-to-a-character/index.md) - 关于如何在Sequencer中添加角色动画的入门探索。
- [制作光源动画](how-to-make-movies/how-to-animate-lights/index.md) - 关于如何在Sequencer中制作光源动画的入门探索。
- [启用粒子](how-to-make-movies/how-to-trigger-cinematic-particle-effects/index.md) - 关于如何在Sequencer中启用不同类型的粒子的入门探索。

## Sequencer编辑器

下述页面介绍了Sequencer编辑器中的相关工具、功能和流程，以及与Sequencer相关的工具。

- [Sequencer概述](unreal-engine-sequencer-movie-tool-overview/index.md) - 了解关卡序列和Sequencer编辑器的主要功能。

- [曲线编辑器](unreal-engine-sequencer-movie-tool-overview/animation-curve-editor/index.md) - 使用曲线编辑器及其中的工具调整关键帧和曲线。
- [轨道](unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/index.md) - 在Sequencer中创建影响Actor的轨道。
- [序列、镜头和镜头试拍](unreal-engine-sequencer-movie-tool-overview/sequences-shots-and-takes/index.md) - 使用序列、镜头和镜头试拍，在非线性编辑器中编辑过场动画。
- [Actor Sequence组件](unreal-engine-sequencer-movie-tool-overview/sequencer-blueprint-component/index.md) - 说明如何使用 Actor 序列组件在 Actor 蓝图中嵌入序列。
- [Take Recorder](unreal-engine-sequencer-movie-tool-overview/take-recorder/index.md) - Take Recorder的录制编辑器、Gameplay和Live Link Actor。
- [关键帧](unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md) - 在Sequencer中为Object、Actor和属性设置关键帧并使用分段，以便添加动画。
- [编辑器偏好设置和项目设置](unreal-engine-sequencer-movie-tool-overview/cinematic-editor-and-project-settings/index.md) - 使用编辑器和项目设置调整Sequencer的行为。
- [渲染电影设置](unreal-engine-sequencer-movie-tool-overview/old-render-movie/index.md) - 介绍渲染过场动画序列时的可用选项。
- [导出和导入FBX文件](unreal-engine-sequencer-movie-tool-overview/import-and-export-cinematic-fbx-animations/index.md) - 介绍如何将FBX文件导出和导入Sequencer。
- [使用模板序列](unreal-engine-sequencer-movie-tool-overview/template-sequences/index.md) - 学习如何在摄像机动画中使用模板序列。
- [Sequencer标签和分组](unreal-engine-sequencer-movie-tool-overview/cinematic-tags-and-groups/index.md) - 在蓝图脚本中，使用标签来引用Sequencer Actor，并使用分组来组织轨道。
- [动态绑定](unreal-engine-sequencer-movie-tool-overview/dynamic-binding-in-sequencer/index.md) - 动态绑定提供自定义蓝图逻辑，用于选择在关卡中要持有的对象或要生成的对象。
- [Sequencer播放列表](unreal-engine-sequencer-movie-tool-overview/sequencer-playlists/index.md) - 在虚拟制片会话期间准备和触发序列。
- [Sequencer中的Python脚本](unreal-engine-sequencer-movie-tool-overview/python-scripting-in-sequencer/index.md) - 了解用于Sequencer的常见Python脚本命令和功能。
- [Sequencer Editor](unreal-engine-sequencer-movie-tool-overview/sequencer-editor/index.md) - An overview of the Sequence Editor's user interface, tools, and options.
- [Spawnables and Possessables](unreal-engine-sequencer-movie-tool-overview/spawn-temporary-actors-in-unreal-engine-cinematics/index.md) - Spawn temporary Actors, lights, and other objects in your scene by using Spawnables.

## 摄像机

下述页面介绍了在过场动画中如何设置和使用摄像机的信息。

- [Sequencer中的摄像机](movie-and-cinematic-cameras/index.md) - 了解如何在你的过场动画中使用摄像机及其功能。

- [过场动画摄像机Actor](movie-and-cinematic-cameras/cinematic-cameras/index.md) - 过场动画摄像机Actor用作在虚幻引擎中拍摄过场动画内容的主要摄像机类型。
- [摄像机绑定](movie-and-cinematic-cameras/camera-jibs-and-dollies/index.md) - 通过摄像机绑定在虚幻引擎中使用真实世界技术进行拍摄。
- [摄像机晃动](movie-and-cinematic-cameras/camera-shakes/index.md) - 在虚幻引擎中创建摄像机晃动效果。
- [过场动画视口](movie-and-cinematic-cameras/cinematic-viewport-controls/index.md) - 使用过场动画视口在视口中添加电影制作控制选项。
- [图像板](movie-and-cinematic-cameras/full-screen-movies/index.md) - 使用图像板在摄像机上播放全屏视频和图像序列。
- [Virtual Cameras](movie-and-cinematic-cameras/virtual-cameras/index.md) - Control Cameras inside Unreal Engine by using a modular component system to manipulate and output Camera data.

## 渲染

虚幻引擎的动画渲染队列（Movie Render Queue）允许你将过场动画输出为图像序列。 下述页面介绍了如何使用此工具。

- [影片渲染管线](movie-render-pipeline/index.md) - 使用影片渲染管线渲染并导出线性内容。

- [从影片渲染队列过渡到影片渲染图表](movie-render-pipeline/transitioning-to-the-movie-render-graph-from-mo-2d0283f2/index.md) - 了解虚幻引擎的影片渲染图表功能。

- [在影片渲染图表中进行渲染编程](movie-render-pipeline/programming-a-render-in-mrg/index.md) - 影片渲染图表脚本编写和概念讨论。

- [回调脚本](movie-render-pipeline/movie-render-graph-callback-scripts/index.md) - 介绍向影片渲染图表添加回调的新方法。

- [渲染通道](movie-render-pipeline/cinematic-render-passes/index.md) - 了解电影渲染队列中的不同渲染通道层。

- [静止图像渲染](movie-render-pipeline/render-multiple-camera-angle-stills/index.md) - 使用静止图像渲染工具将多个摄像机角度快速渲染到MRQ中的单个图像。

- [使用命令行渲染操作MRQ](movie-render-pipeline/using-command-line-rendering-with-move-render-queue/index.md) - 关于将命令行渲染用于电影渲染队列的概述。

- [运行时构建中的电影渲染队列](movie-render-pipeline/movie-render-queue-in-runtime/index.md) - 如何在分布式构建中使用电影渲染队列，以便在最终用户的设备上创建视频

- [渲染设置与格式](movie-render-pipeline/cinematic-render-settings-and-formats/index.md) - 使用MRQ和MRG的渲染设置和格式来自定义输出格式和视觉效果

## 工作流程指南和示例

下列指南将指导你如何创建特定的过场动画内容示例。

- [使用Sequencer创建镜头切换](cinematic-workflow-guides-and-examples/creating-camera-cuts-using-sequencer/index.md) - 了解如何在Sequencer中创建镜头切换。
- [使用动态变换创建关卡序列](cinematic-workflow-guides-and-examples/creating-level-sequences-with-dynamic-transforms/index.md) - 使用变换原点Actor动态更改Sequencer内容的位置。
- [混合Gameplay和Sequencer动画](cinematic-workflow-guides-and-examples/blend-gameplay-animation-to-cinematic-animation/index.md) - 使用动画蓝图和插槽将角色和摄像机动画从Sequencer无缝混合到Gameplay。
- [切换Sequencer中的Actor材质](cinematic-workflow-guides-and-examples/change-material-in-unreal-engine-cinematic-movie/index.md) - 变更序列中Actor材质的方式。
- [在Sequencer中引用玩家](cinematic-workflow-guides-and-examples/how-to-reference-the-player-in-unreal-engine-cinematics/index.md) - 通过使用代理替代项，然后在运行时更改绑定，在Sequencer中引用玩家。
- [渲染过场动画](cinematic-workflow-guides-and-examples/rendering-out-cinematic-movies/index.md) - 展示如何将过场动画序列渲染成视频文件并保存在电脑上。
- [从多个摄像机角度渲染](cinematic-workflow-guides-and-examples/rendering-from-multiple-camera-angles/index.md) - 学习如何不创建额外的镜头或镜头试拍即可在同一序列内从多台过场动画摄像机渲染。
- [通过Sequencer调用事件](cinematic-workflow-guides-and-examples/fire-blueprint-events-during-cinematics/index.md) - 关于Sequencer的事件轨迹在蓝图中触发事件的方式的范例。
- [从Sequencer触发关卡蓝图事件](cinematic-workflow-guides-and-examples/trigger-level-blueprint-events-from-sequencer/index.md) - 使用蓝图接口可将Sequencer的事件轨道传递到关卡蓝图
- [使用镜头试拍录制器](cinematic-workflow-guides-and-examples/record-gameplay/index.md) - 使用镜头试拍录制器和动作捕捉录制序列。
- [用Sequencer在蓝图中重新绑定Actor](cinematic-workflow-guides-and-examples/change-cinematic-track-bindings/index.md) - 此例说明如何在运行时将序列应用到动态对象（此对象与序列中原始拥有的对象不同）。
- [应用烧入内容](cinematic-workflow-guides-and-examples/applying-burn-ins-to-your-movie/index.md) - 说明如何将覆层从 UMG 应用到 Sequencer 渲染影片。
- [使用Sequencer控制动画实例](cinematic-workflow-guides-and-examples/control-animation-blueprint-parameters-from-sequencer/index.md) - 展示如何通过可占据项为动画实例上的变量设置动画
- [导入和导出编辑决策表（EDL）](cinematic-workflow-guides-and-examples/import-and-export-edl/index.md) - 演示如何导入和导出EDL以用于外部视频编辑软件应用程序。
- [在Gameplay中触发序列](cinematic-workflow-guides-and-examples/play-cinematics-from-blueprints/index.md) - 说明如何在游戏事件中触发序列。
- [保留或存储通过 Sequencer 进行的修改](cinematic-workflow-guides-and-examples/what-happens-when-my-cinematic-ends/index.md) - 说明如何保存通过 Sequencer 进行的修改，以及如何将修改复原回初始状态。
- [通过Sequencer混合动画蓝图](cinematic-workflow-guides-and-examples/blending-animation-blueprints-with-sequencer/index.md) - 说明如何从动画蓝图获取姿势，并将它与关卡序列中定义的动画混合起来。

## 实用技巧和流程快捷键

本文介绍了一些实用技巧、快捷键和其他高效工作技巧。

- [过场动画快捷方式和提示](cinematic-workflow-tips-for-sequencer/index.md) - 过场动画工作流程的提示、技巧和快捷方式。

- [Sequencer热键](sequencer-hotkeys/index.md) - 介绍Sequencer中的主要热键。

## 过场动画示例

你还可以浏览和下载一些现有项目，了解它们是如何用Sequencer制作的。

- [汽车配置器示例](../../samples-and-tutorials/engine-feature-examples/automotive-configurator-sample/index.md) - 如何设置汽车配置器示例项目，使用影片渲染队列渲染商业级宣传片，以及使用变体管理器进行编辑。
- [Meerkat演示](../../samples-and-tutorials/engine-feature-examples/meerkat-sample-project/index.md) - 如何设置Meerkat演示，使用影片渲染队列对其进行渲染，以及探索其动画和优化功能
- [Slay](../../samples-and-tutorials/engine-feature-examples/slay-sample-project/index.md) - 通过借鉴Slay中的过场动画技巧，学会在虚幻引擎中实现你自己的虚拟制片工作流。
