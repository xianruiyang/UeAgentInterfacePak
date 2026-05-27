# MRG的重载和变量

---
title: "MRG的重载和变量"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mrg-overrides-and-variables-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "渲染设置与格式", "MRG的重载和变量"]
---

# MRG的重载和变量

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 渲染设置与格式 / MRG的重载和变量

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mrg-overrides-and-variables-in-unreal-engine

## 设置项的重载

每个节点都有自己的一套适用参数。

![ImageAltText](../../../../../../assets/images/90/90c90070c6ffb4c58aa45ee48175cb2e3ae17dc410819f05b68862b8d30b64a9.jpg)

要更改或重载默认设置，勾选复选框并更新所需的值即可。被重载的参数旁有返回箭头，可将参数重置为类的默认值，这一点与引擎其余部分的工作方式一致。

![ImageAltText](../../../../../../assets/images/a4/a4aa6babcd24688bcff5e29f4ffb92afeff9b6fb7d5f951bb20898f25c387890.jpg)

你可以在渲染图表中轻松覆盖并重新声明完整的节点。请记住图表的求值从输出流回输入，或从右到左的方式。这意味着在图表更靠后的步骤中，也可以重新声明整个节点。

在下方的简单例子中，我们使用默认的Warm Up Settings节点。对图表求值即可看到最终效果。

![ImageAltText](../../../../../../assets/images/f3/f3fcc235979ec03985dd5af7dc5f418b7b4f94b6c65dacf31f79fc5a422f94a5.jpg)

如果在下游添加第二个Warmup Settings节点并设定不同的值，我们会发现这些值已在图表求值调试中进行了完全的重新声明。

![ImageAltText](../../../../../../assets/images/ac/ace5ce734b1d1872cda65abc8e57640d9af792964d43b79a3bcdcd2c61733c40.jpg)

这也能够"按链路"生效。

同时也适用于子图表。在此示例中，默认的Warm Up节点位于子图表中。对图表求值后，我们发现父节点图表会从子图表继承预热设置。

![ImageAltText](../../../../../../assets/images/ad/adb562e54d6599d6228895a717470a043c10823cf0965f8bf8dfdf5ccb078a24.jpg)

但我们可以在下游将其重载。

![ImageAltText](../../../../../../assets/images/7f/7f35de5801d4afa6738af1a81d738aa8dc2615bf995bb5ed5908b409c6ded522.jpg)

你甚至可以逐链重新声明集合的成员身份。

![ImageAltText](../../../../../../assets/images/f6/f6e4267b717c420e53fb1c014e27ca5877925e863f7ee469b1bf96ca5851a32f.jpg)

你还可以创建新集合，更改渲染器并重新声明修饰符，使该图表流的求值变得极易编辑且灵活。

![ImageAltText](../../../../../../assets/images/3d/3d576aa9d8e57d3ae7a91ca79b3480c80f2d46ea1b7a0a3be51c3e1596267c31.jpg)

## 公开参数和变量

右键点击节点即可查看可作为变量公开的项目。

> 图片已省略：ImageAltText

选择属性就会公开其引脚。

> 图片已省略：ImageAltText

将鼠标悬停在引脚上，即可查看其数据类型。

> 图片已省略：ImageAltText

打开点击"成员（Members）"选项卡，找到"变量（Variables）"分段，点击加号图标，即可创建你自己的变量。然后请设置变量的名称、类型和默认值。

> 图片已省略：ImageAltText

然后即可直接将变量拖入图表内，并将其连接到适用的引脚上。

> 图片已省略：ImageAltText

也可以右键点击所需的引脚，选择"提升为变量（Promote to Variable）"。

> 图片已省略：ImageAltText

如此即可创建具有正确数据类型的变量并成功连接。然后就可以在细节面板中编辑其名称和默认值。

> 图片已省略：ImageAltText

有了公开的变量后，在分配图表时，如有必要，你就可以从影片渲染队列的作业级别上设置这些参数。

> 图片已省略：ImageAltText

和图表节点的做法类似，要重载MRQ作业级别上的参数，勾选复选框并设定所需的参数设置即可。

> 图片已省略：ImageAltText

