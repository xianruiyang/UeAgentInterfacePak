# 为游戏动画示例项目添加MetaHuman

---
title: "为游戏动画示例项目添加MetaHuman"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/adding-a-metahuman-to-the-game-animation-sample-project-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "游戏动画示例项目", "为游戏动画示例项目添加MetaHuman"]
---

# 为游戏动画示例项目添加MetaHuman

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / 游戏动画示例项目 / 为游戏动画示例项目添加MetaHuman

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/adding-a-metahuman-to-the-game-animation-sample-project-in-unreal-engine

[游戏动画示例项目](../index.md)是一个示例项目，下载该项目后你将可以访问一套动作捕获动画，并了解如何在虚幻引擎中使用运动匹配。 该项目包含一个示例MetaHuman，其中附带所有MetaHuman体型的预览网格体，你可以在游戏工具控件中启用它，以观察使用MetaHuman角色时系统是如何工作的。 该示例项目是使用MetaHuman作为玩家角色并使用高保真动画系统的典型示例。

我们还建议你尝试添加并实现自己的MetaHuman角色，以观察系统使用你自己的角色运行的情况。 如需了解如何为游戏动画示例项目添加并实现自己的MetaHuman角色，请参阅下列文档。

#### 先决条件

- 你已下载并使用游戏动画示例项目模板创建了一个新项目。 如需详细了解如何首次设置游戏动画示例项目，请参阅[游戏动画示例项目](../index.md)文档。
- 你有一个想要在游戏动画示例项目中实现的MetaHuman角色。 如需详细了解如何为虚幻引擎项目创建并添加MetaHuman，请参阅以下文档：

  - [MetaHuman Creator](https://dev.epicgames.com/documentation/metahuman/metahuman-creator?application_version=5.6)
  - [MetaHuman Animator](https://dev.epicgames.com/documentation/metahuman/metahuman-animator?application_version=5.6)
  - [动画](https://dev.epicgames.com/documentation/metahuman/animation?application_version=5.6)

## 实现你的MetaHuman

1. 在内容浏览器中找到`Content/Blueprints/RetargetedCharacters`。

![ImageAltText](../../../../../assets/images/b6/b6366216c73b77a9396b89d9c9b45d02f0764ae328a7845a8d5d5dab3842b4a8.jpg)

1. 找到角色蓝图`CBP_SandboxCharacter_Metahuman_Kellan`，右键点击该资产并找到上下文菜单中的"复制（Duplicate）"选项，复制该资产。

![ImageAltText](../../../../../assets/images/d1/d11c40ceb89572084a32334245642c257aabf6d3d68c3779e7975ebde7101997.jpg)

1. 打开新复制的角色蓝图。
2. 在蓝图编辑器的组件面板中，选择**身体（Body）**骨架网格体组件及其所有子组件以及**LODSync**组件，然后使用删除键将其删除，或右键点击所选组件然后从上下文菜单中选择**删除（Delete）**。

![ImageAltText](../../../../../assets/images/09/09d4ff9f06e664d2dbeeba570e04b3ddb6e856aef1e5168310a7ee0b84cb590e.jpg)

1. 打开你想要在游戏动画示例项目中作为玩家添加的MetaHuman蓝图。 本例使用Danielle工作流程。
2. 再次选择身体，包括子组件和LODSync组件，右键点击所选组件，然后从上下文菜单中选择**复制（Copy）**。

![ImageAltText](../../../../../assets/images/87/8750699654c73d560049b6c36d637ffaa685a79ecbba0b3384963e2e37f8cf77.jpg)

1. 返回角色蓝图，选择并右键点击该网格体组件，然后在上下文菜单中选择**粘贴（Paste）**选项，从而将组件粘贴到现有的网格体组件上。

![ImageAltText](../../../../../assets/images/3d/3d8bf4398cad7ef5994ecd39c5643bf8b6d64ee69a82e5dbd3006724fe5abc9d.jpg)

1. 在**组件（Components）**面板中，选择身体并将其拖至网格体，即可将身体网格体组件重设为蓝图网格体组件的子级。

![ImageAltText](../../../../../assets/images/b6/b669c4dafc04c9d930e1c8d4296990f95150527290f1e22454e553edafb8e08d.jpg)

1. 选择身体组件以打开其**细节（Details）**面板，然后找到**动画类（Anim Class）**属性并选择`ABP_GenericRetarget AnimBP`动画蓝图。

![ImageAltText](../../../../../assets/images/40/40bc794df397278f2f5491fc6ac0a70da00d520102735b04a1a9ae50b42738a1.jpg)

1. 此外，你需要向身体网格组件添加标签，让Retarget AnimBP知道新的身体类型。 在**细节（Details）**面板中，找到组件标签（Component tags）属性，并使用**添加**（**+**）功能为数组添加新元素。 然后，使用数组的文本字段输入以下标签：

`RTG_UEFN_to_Metahuman_nrw`

![ImageAltText](../../../../../assets/images/01/0125123261a40d923f35648c9634ed96676d9bc279bfafefe6f0c48c25f28f93.jpg)

1. 打开蓝图编辑器中的**视口（Viewport）**面板。

> 图片已省略：ImageAltText

1. 选择身体组件并向下变换网格体，将MetaHumans网格体与胶囊体组件对齐，使其双脚与胶囊体的按钮匹配，旋转MetaHuman，使其面向朝前的箭头。

> 图片已省略：ImageAltText

1. 接下来，你需要修复构造脚本。 在**我的蓝图（My Blueprint）**面板中选择构造脚本，打开该构造脚本，然后将每个组件拖到图表中，以重新添加双脚（Feet）、双腿（Legs）和躯干（Torso）的get引用变量，从而让所有Enable Master Pose节点都有一个定义。

> 图片已省略：ImageAltText

1. 然后在**我的蓝图（My Blueprint）**面板中打开`EnableMasterPose`函数，重新绑定Body引用变量。 将**身体（Body）**网格体组件拖到图表中，将其输出引脚连接至现有**Set Leader Pose Component**节点的**Ne****w Leader Bone Component**引脚。

> 图片已省略：ImageAltText

1. 设置并连接Skeletal Mesh Component引用变量后，**保存（Save）**并**编译（Compile）**你的角色蓝图。

## 将你的角色添加到游戏动画控件

1. 打开游戏动画控件资产，你可以在**Content** > **Widgets**文件夹路径下找到该资产。
2. 在控件编辑器的**设计器（Designer）**面板中，复制任一角色图块，并将其粘贴到右边最后一个角色图块旁边。

> 图片已省略：ImageAltText

1. 选择你的新图块以打开其**细节（Details）**面板，然后在对象（Object）属性中，选择你使用资产选择菜单创建的**角色蓝图**。

> 图片已省略：ImageAltText

1. 最后，**保存**并**编译**游戏动画控件。

现在，你可以使用PIE播放项目，同时使用游戏动画控件中的新按钮，以使用项目的动画系统将玩家转换为新的MetaHuman角色。

