---
title: "Using 宏库"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-macro-libraries-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "蓝图可视化脚本", "蓝图工作流程", "创建宏", "Using 宏库"]
---

# Using 宏库

> 路径：虚幻引擎5.7文档 / 蓝图可视化脚本 / 蓝图工作流程 / 创建宏 / Using 宏库

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-macro-libraries-in-unreal-engine

**宏库（Macro Library）** 用于存放大量宏或自含式图表（可作为节点放置到其他蓝图中）。它们会保存常用的节点序列（包括执行和数据传输的输入和输出），因此可有效节约时间。

> [!NOTE]
> 蓝图宏库不能包含变量，不能从其它蓝图中继承，也不能直接放置在关卡中。对蓝图宏库中的宏做出修改后只有在客户端蓝图重新编译后才会生效。

## 创建宏库

在该示例中我们创建由两个宏组成的宏库，一个用于添加 "生命值" 变量，另一个用于调整指定 Actor 的大小。

> [!NOTE]
> 在该示例中我们使用的是启用了 **初学者内容（Starter Content）** 的[Blueprint Third Person Project](https://dev.epicgames.com/documentation/404)项目。

1. 在内容浏览器中，选择 **添加（Add）** > **蓝图（Blueprints）** > **蓝图宏库（Blueprint Macro Library）**

   > [!NOTE]
   > (programming-and-scripting/blueprints-visual-scripting/UserGuide/Types/MacroLibrary).
2. 在 **选择父级类（Pick Parent Class）** 中选择 **Actor** 作为你的[父级类。](../../../specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/blueprint-class-assets/index.md)
3. 为你的宏库输入一个名称，然后 **双击** 来将其打开。
4. 这会显示 **蓝图宏（Blueprint Macro）** 界面。

### 创建"Scale Up"宏

1. 找到 **我的蓝图（MyBluprint）** 窗口，选中默认宏并且按下 **F2**，将其重命名为 **ScaleUp** 。
2. 在 **细节（Details）** 面板中，找到 **输入（Inputs）** 分类然后点击 **添加（Add）** (**+**) 按钮来创建两个新的输入。将第一个输入命名为 **In** 并设置为 **Exec** 类型，然后将另一个命名为 **InActor** 并设置为 **Actor** 类型。
3. 找到 **输出（Outputs）** 分类并点击 **添加（Add）** (**+**) 按钮来创建一个新的输出，命名为 **Out** 并设置为 **Exec** 类型。
4. 在 **ScaleUp** 宏的图表中，复制或者重建以下蓝图脚本。

该宏被调用的时候，它会获取作为 **InActor** 所提供的Actor，并将其尺寸放大1.25倍，然后设置 **Target** （指定为 **InActor** 的Actor）的新3D大小。现在你可以使用这个宏来改变任意Actor的大小。

### 创建"Add Health"宏

1. 从 **我的蓝图（MyBlueprint）** 窗口中添加另一个宏，命名为 **AddHealth**。
2. 在 **AddHealth** 的 **细节（Details）** 面板中，找到 **输入（Inputs）** 分类然后点击 **添加（Add）** (**+**) 按钮来创建两个新的输入。将第一个输入命名为 **In** 并设置为 **Exec** 类型，然后将另一个命名为 **GetHealth** 并设置为 浮点类型。
3. 找到 **输出（Outputs）** 分类并点击 **添加（Add）** (**+**) 按钮来创建两个新的输出，第一个命名为 **Out** 并设置为 **Exec** 类型，另一个命名为 **SetHealth** 并设置为浮点类型。

   上图中我们使用一个名为 GetHealth 的浮点值，通过 SetHealth 输出节点进行传递之前将把此值添加到该节点。
4. 在 **AddHealth** 宏的图表中，如下所示重建节点网络。

示例中，在输出结果值到 **SetHealth** 之前，为 **GetHealth** 浮点值增加 **50**。

1. **保存（Save）** 并关闭蓝图宏库。
2. 在 `Content/ThirdPerson/Blueprints` 文件夹中，打开 **BP_ThirdPersonCharacter** 蓝图。
3. 在 **我的蓝图（MyBlueprint）** 窗口中，找到 **变量（Variables）** 分类并点击添加 (+) 来创建一个新的 **浮点** 变量，命名为 **Health**，然后点击 **编译（Compile）**。
4. 在下方的事件图表中，复制或者重建蓝图脚本。

   > [!NOTE]
   > 在下方的代码中，我们在 **Q** 键按下时调用 **AddHealth** 宏。它将抓取 Health 变量（执行增加的宏脚本）并通过输出引脚 SetHealth 进行更新，然后再显示到屏幕上。 我们先使用 **E** 键检查 **Health** 是否大于 100，然后在Actor **Self**（即为 **ThirdPersonCharacter**）上调用 **ScaleUp** 宏。
5. **编译（Compile）** 并在编辑器中 **播放（Play）**。

## 最终效果

> 动图已省略：f810fa14248f4c4557ced2acf474cd54d4b45430bdcd842020dbfcb09c32bc48

在上述视频中，我们按下 **E** 键尝试调用 **ScaleUp** 宏。蓝图会首先检查默认设为0的 **Health** 值。之后，我们按下 **Q** 调用 **AddHealth** 宏，在按下几次按键后，你会发现角色的生命值和比例都放大了。只要提供生命值和目标Actor，这些宏便可以从其它任意蓝图中调用。

## 创建宏

本质上来说，**宏（Macro）** 和节点的重叠图表原理相同。他们都有通道节点设计的进入点和离开点。每个通道可拥有任意数量的执行或数据引脚。在其他蓝图和图表上使用时，这些引脚在宏节点上均为可见。

访问[创建宏](../index.md)页面来参考创建宏的示例。
