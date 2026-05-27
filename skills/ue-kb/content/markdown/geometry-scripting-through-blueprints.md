# Geometry Scripting Through Blueprints

---
title: "Geometry Scripting Through Blueprints"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/geometry-scripting-through-blueprints-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "几何体脚本编写简介", "Geometry Scripting Through Blueprints"]
---

# Geometry Scripting Through Blueprints

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 几何体脚本编写简介 / Geometry Scripting Through Blueprints

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/geometry-scripting-through-blueprints-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Geometry Scripting 提供蓝图和 Python 函数，用于创建自定义建模工具和工作流。本指南介绍通过蓝图使用 Geometry Scripting 的基础。以下步骤会创建一个用于关卡设计的程序化网格体工具，类似于为 [Lyra 示例项目](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/lyra-geometry-tools/index.md).

本指南将展示如何：

- 生成程序化几何体，用于快速关卡白盒。
- 使用布尔操作动态切割网格体。
- 创建 Static Mesh 烘焙函数。

本指南开发的工具是使用 Geometry Scripting 创建程序化网格体生成工具的一个小示例。更高级的示例是 **Procedural Content Generation Framework**，它以 Geometry Scripting 为基础。要进一步了解该工具集，请参阅 [Procedural Content Generation Overview](../../../../building-virtual-worlds/procedural-content-generation/procedural-content-generation-overview/index.md).

除程序化生成外，还可以创建的其他工作流包括：

- 为资产分配多个材质

  .
- 使用 Python 应用网格体布尔操作

  .
- 基于凸包生成 Blocking Volume。

## 前置知识

要理解并使用本页内容，必须：

- 具备基础理解：

  蓝图

  .
- 熟悉以下入门主题：

  Geometry Scripting

  ，尤其是其中介绍的新对象类型。

> [!NOTE]
> 本指南使用 [Third Person 模板](https://dev.epicgames.com/documentation/404)。不过，也可以使用任意项目跟随操作。

## 启用插件

使用 Geometry Scripting 需要启用相关插件。

要启用插件或确认插件已启用，请执行以下步骤：

1. 在 **[菜单栏](../../../../building-virtual-worlds/level-editor/index.md#menubar)**中，选择 **Edit** > **插件**.
2. 在搜索栏中输入“geometry script”。

   ![Enable Geometry Scripting Plugin](../../../../../assets/images/a3/a35f42a24064bb4be4e27747b0965a172b326c1f79e832a739f2a6adac345576.jpg)
3. 启用

   Geometry Script

   插件，并在弹出对话框中选择

   Yes

   。
4. 重启引擎。

## 创建蓝图类

开始前，必须确保使用正确的蓝图类。由于目标是为关卡设计创建程序化网格体，请使用 **GeneratedDynamicMeshActor** 类。

要选择蓝图类，请执行以下步骤：

1. 在

   Content Browser

   中右键点击并选择

   Blueprint Class

   .
2. 搜索并选择 **GeneratedDynamicMeshActor**.

   ![Generated Dynamic Mesh Actor Class](../../../../../assets/images/6b/6b06255bf119ca45e70034899a5190b92396730a94a879338ec732d000cff041.png)
3. 将蓝图命名为

   BP_ProceduralGen

   .

> [!NOTE]
> 如果没有看到 **GeneratedDynamicMeshActor** 选项，则 Geometry Scripting 插件未启用。

### 事件设置

创建类后，必须设置特定事件，用于填充构建工具时要使用的 Dynamic Mesh。

要创建事件，请执行以下步骤：

1. 在 Content Browser 中双击蓝图类。
2. 打开

   Event Graph

   .
3. 在图中右键点击，输入“generated mesh”过滤可用节点，然后选择 **Event on Rebuild Generated Mesh**。每当更新 Dynamic Mesh 参数并导致网格体重建时，该事件都会触发。

   ![Event Rebuild Generated Mesh](../../../../../assets/images/15/15247ed6796f5d055ebe8a8937d24b36be77a3575e7e959ff52fe4d5d0e72200.jpg)
4. 将 **Target Mesh** 输出提升为局部变量：右键点击其引脚并选择 **Promote to Variable**.

   ![Promote Pin to Variable](../../../../../assets/images/2e/2e6a333734fb776ea6336254e343b0af7454d859b0cd99302a85fb0e49c5117c.png)
5. 将变量命名为

   DynamicMesh

   ，将类型设为

   Dynamic Mesh

   ，并保持私有。该变量表示要编辑的 Dynamic Mesh。

## 构建几何体

创建蓝图类和事件后，即可开始添加 Geometry Scripting 函数。本指南的目标是生成可变换和切割的白盒形状。因此，需要先创建要编辑的网格体。

要创建网格体，请执行以下步骤：

1. 从

   DynamicMesh

   变量的执行引脚拖出连线，然后搜索并选择

   Append Box

   节点。这会向 Dynamic Mesh 添加一个盒体基本体。
2. 将 **DynamicMesh** 变量的输出引脚连接到 **Target Mesh** 输入引脚。

   ![Dynamic Mesh Variable](../../../../../assets/images/3a/3a6ecf673d05bfd5b7f42fa8fabb8aad86f7c914ee6dd0229dc2a0add5571f47.jpg)

通过最初这些节点，就已经创建了程序化网格体。可以编译并将蓝图拖入关卡来测试。要了解还可以立即创建哪些其他形状，请参阅 Geometry Scripting Reference 文档的 [Primitive Generation](https://dev.epicgames.com/documentation/404) 部分。

### 添加变换 Widget

为了能够动态调整网格体变换，可以添加交互式控制。

要添加交互式控制，请执行以下步骤：

1. 创建一个新的公开变量，命名为 **BoxSize** 并将类型设为 Vector。

   ![BoxSize Variable](../../../../../assets/images/a5/a57e82ff37ef3ec0a6e9339274c2988912c6826c82f030f0c31b1c5efc9a0aaa.png)
2. 在 **Details** 面板中，为该变量启用 **Instance Editable** 和 **Show 3D widget**。将 **Default Value** 设为 200, 200, 200。启用 3D widget 会创建一个操作器，用于交互式控制 X、Y、Z 变换。

   ![Variable Details Panel](../../../../../assets/images/c9/c910c62a479388ad6ba5e460f661acaad1743ece40e1e0177dc9ee7931cfdbac.png)
3. 拖出该变量并选择

   Get BoxSize

   .
4. 右键点击变量并选择

   Split Struct Pin

   。该变量的 X、Y、Z 值会驱动盒体尺寸。
5. 将对应的 X、Y、Z 值连接到以下节点的相应尺寸值： **Append Box**.

   ![Widget Size Values](../../../../../assets/images/27/27fabfdc964b5ff2c63f1d5a93fc36fb035cf616adfd89e61eeaf4f12065f189.jpg)
6. Compile

   （Ctrl + Alt）并

   Save

   （Ctrl + S）。

现在可以生成立方体网格体并动态调整尺寸。每次使用 widget 调整时，都会按设置尺寸生成新的 Dynamic Mesh，而不是缩放网格体。

> [!NOTE]
> 要显示该 widget，必须处于 **Selection Mode**.

## 使用布尔操作编辑

布尔操作会相减或相加网格体对。这有助于快速向网格体添加细节和位移效果。要为布尔函数创建第二个网格体，可以从 mesh pool 分配一个临时网格体。临时网格体可避免在编辑器中产生不必要几何体，从而降低计算处理压力。

要创建布尔操作，请执行以下步骤：

1. 右键点击图，然后搜索并选择

   Get Compute Mesh Pool

   。这会分配一个临时网格体来执行布尔操作。
2. 将

   Append Box 的

   执行引脚连接到

   Get Compute Mesh Pool

   .
3. 从

   Return Value

   引脚拖出连线，然后搜索并选择

   Request and Release Mesh

   。连接执行引脚。
4. 从

   Mesh

   引脚拖出连线，然后搜索并选择

   Append Cylinder

   。该节点会添加一个圆柱网格体，用于从盒体网格体中相减。
5. 将输出提升 **Target Mesh** 为变量，命名为 **BoolMesh**。将类型设为 **Dynamic Mesh** 并保持私有。

   > 图片已省略：Bool Mesh Variable
6. 从

   BoolMesh

   的执行引脚拖出连线，然后搜索并选择

   Apply Mesh Boolean

   。将使用该节点对网格体应用布尔操作。
7. 拖出并连接

   DynamicMesh

   变量的输出引脚连接到

   Target Mesh

   输入，该输入来自

   Apply Mesh Boolean

   .
8. 连接 **BoolMesh** 到 **Tool Mesh** 引脚，属于 **Apply Mesh Boolean**. **Tool Mesh** 表示要用于布尔操作的网格体。这一参数就是前面添加 **Append Cylinder** 节点的原因。

   > 图片已省略：Apply Mesh Boolean Node
9. 将 Apply Mesh Boolean 节点中的 Operation 类型设置为

   Subtract

   .
10. Compile

    （Ctrl + Alt）并

    Save

    （Ctrl + S）。

> [!TIP]
> 在 Level Editor 中编译并查看蓝图时，可能因为布尔效果太小而看不到。要查看效果，可以手动设置布尔网格体大小，或使用 widget 动态调整它。

### 添加 Widget

就像为盒体基本体创建 widget 一样，也可以为布尔网格体及其位置创建 widget。

要创建 widget，请执行以下步骤：

1. 在 **Variables** 面板下创建一个表示布尔网格体位置的公开变量，并命名为 **BoolLocation**，将类型设为 **Vector**.
2. 在 **Details** 面板中，启用 **Instance Editable** 和 **Show 3D widget**.
3. 右键点击 **Transform** 引脚，该引脚属于 **Append Cylinder** 节点，选择 **Split Struct Pin**，然后连接 **BoolLocation** 变量的输出引脚连接到 **Transform Location**.

   > 图片已省略：Bool Location Variable
4. 再创建一个公开变量，命名为

   BoolSize

   ，并将类型设为 Vector。可以用它调整布尔网格体大小。
5. 在

   Details

   面板中，启用

   Instance Editable

   和

   Show 3D widget

   ，然后将

   Default Value

   设为 1, 1, 5。
6. 将变量拖入图中并选择

   Get Bool Size

   .
7. 右键点击引脚并选择

   Split Struct Pin

   .
8. 连接 **Bool Size** 引脚到对应的 **Transform Scale** 引脚，属于 **Append Cylinder** 节点的原因。

   > 图片已省略：Bool Size Variable
9. Compile

   （Ctrl + Alt）并

   Save

   （Ctrl + S）。

现在已经有一个可动态变换成不同形状的网格体。

## 烘焙到 Static Mesh 的函数

现在已经有动态生成的网格体，可以将其应用到现有 Static Mesh 上，用于快速关卡设计。为此，可以创建一个烘焙函数，并将其暴露到 Level Editor 的 **Details** 面板。

要创建该函数，请执行以下步骤：

1. 创建一个新函数，命名为 **Bake Static Mesh**.

   > 图片已省略：Bake Static Mesh Function
2. 在 **Details** 面板中，为该函数启用 **Call in Editor** 以便从 Level Editor 激活该事件。

   > 图片已省略：Enable Call in Editor
3. 从函数的执行引脚拖出连线，然后搜索并选择

   Get Dynamic Mesh

   。该函数会拉取当前正在使用的 Dynamic Mesh。
4. 从 **Get Dynamic Mesh** 执行引脚拖出连线，然后搜索并选择 **Copy Mesh to Static Mesh**。同时，将 **Return Value** 连接到 **From Dynamic Mesh**。该函数执行时，会将 Dynamic Mesh 烘焙到所选 Static Mesh。

   > 图片已省略：Copy Mesh to Static Mesh Function
5. 要选择想要烘焙的 Static Mesh，必须将参数暴露到编辑器。创建一个公开变量，命名为

   TargetMesh

   ，将类型设为

   Static Mesh

   .
6. 将变量拖入图中并选择

   Get TargetMesh

   .
7. 右键点击变量引脚并选择

   Convert to Validated Get

   。该转换会设置函数，使其仅在已选择网格体时运行代码。
8. 连接 **Target Mesh** 引脚连接到 **To Static Mesh Asset**.

   > 图片已省略：Bake Static Mesh Graph

   最终烘焙脚本。
9. Compile

   和

   Save

   .
10. 一个 **Bake to Static Mesh** 按钮现在会显示在 Level Editor 的 **Details** 面板中。使用该按钮前，先更新 **Target Mesh** 为想要烘焙的 Static Mesh。

    > 图片已省略：Bake Static Mesh Button

## 查看最终结果

有了 Bake Static Mesh 函数和程序化网格体脚本，就可以使用 Dynamic Mesh 持续更新关卡中的 Static Mesh。

> 图片已省略：undefined

最终程序化网格体脚本。点击展开。

## 自行尝试

使用所学内容，尝试进行以下调整：

- 将盒体网格体改为球体。
- 添加第二个布尔网格体，以获得额外建模控制。
- 使用

  Create New Static Mesh Asset From Mesh

  节点，将 Dynamic Mesh 烘焙为新的 Static Mesh，而不是烘焙到现有 Static Mesh。

