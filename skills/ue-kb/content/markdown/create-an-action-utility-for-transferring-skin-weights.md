# Create an Action Utility for Transferring Skin Weights

---
title: "Create an Action Utility for Transferring Skin Weights"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/create-an-action-utility-for-transferring-skin-weights-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "几何体脚本编写简介", "Create an Action Utility for Transferring Skin Weights"]
---

# Create an Action Utility for Transferring Skin Weights

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 几何体脚本编写简介 / Create an Action Utility for Transferring Skin Weights

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/create-an-action-utility-for-transferring-skin-weights-in-unreal-engine

对于角色服装，通常会在外部 DCC（数字内容创作）应用中制作服装模型，并将其作为 Static Mesh 导入。随后将蒙皮权重从 Skeletal Mesh 传递到 Static Mesh，而不是手动绘制权重。该功能可在引擎内通过 [Panel Cloth Editor](../../../../gameplay-systems/physics/cloth-simulation/panel-cloth-editor-overview/index.md)使用。不过，也可以使用蓝图创建自定义工作流。

本指南说明如何在 Unreal Engine 中创建一个 Action Utility，将蒙皮权重（骨骼权重）传递到 Static Mesh。该 Action Utility 会接收给定的 Skeletal Mesh 资产（源）和 Static Mesh 资产（目标），并创建一个新的 Skeletal Mesh 资产。新资产包含 Static Mesh 的几何体，以及来自源资产的蒙皮权重。该 Action Utility 由用于转换几何体的 Geometry Scripting 函数组成。

### 前提条件

本指南中的 Action Utility 基于 [Convert Mesh Actor to Skeletal Mesh Asset](index.md) 教程中创建的工具。请使用该教程创建基础脚本，并理解其概念。也可以下载下方 zip 文件继续操作。

要按照本指南操作，请确保：

- 已启用 **Geometry Script** 插件。更多信息请参阅 [使用插件](../../../../understanding-the-basics/foundational-knowledge-in/working-with-plugins/index.md).
- 解压 [Example Content](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/6de98edf-9d4e-4fcd-a17e-669bcfb53218/examplecontent.zip) 文件，并将 **ActorActions** 文件夹放入项目的 **Content** 文件夹中。更多信息请参阅 [直接导入资产](../../../../understanding-the-basics/assets-and-content-packs/importing-assets-directly-into/index.md).

## 蓝图与函数设置

由于目标是通过右键菜单，基于给定的 Static Mesh 和 Skeletal Mesh 创建新的 Skeletal Mesh 资产，因此可以使用 **Binding Assets to a Skeletal Mesh** 教程中的同一个 Blueprint Utility。然后创建一个会显示在上下文菜单中的函数。

要创建新的 Actor Action 函数，请执行以下步骤：

1. 在 **Content Drawer**中，双击 **BP_StaticMeshtoSkeletalMesh_ActorAction** 将其打开。
2. 在 **My Blueprint** 面板中，点击 **Functions**.
3. 旁边的加号图标创建一个函数。将函数命名为 **TransferSkinWeights**。该名称会显示在上下文菜单中。

   ![UE Transfer Skin Weights Function](../../../../../assets/images/ab/ab3e7e42bb5d31f26000539e1a8026221f8ffcd3f1dba81ff7547ad24a145129.jpg)
4. 将 **StaticMeshtoSkeletal Mesh** 函数中的脚本复制到 **TransferSkinWeights** 函数中。
5. 删除用于复制骨骼索引和权重的节点：

   1. Bone Name 变量的 **Set** 节点。
   2. **Copy Bones from Mesh**
   3. **Mesh Create Bone Weights**
   4. **Get Bone Index**
   5. **Make Bone Weights**
   6. **Make Array**
   7. **Set All Vertex Bone Weights**
6. 连接 **TransferSkinWeights** 函数节点到相应的变量设置节点。

   1. 连接 **Skeleton Reference** 输出引脚到其 **Set** 节点。
   2. 在 **TransferSkinWeights** 节点，并将执行引脚连接到 Skeleton Reference 变量的 **Set** 节点。
   3. 将 Skeleton Reference 变量的 **Set** 节点执行引脚连接到 Asset Path and Name 变量的 **Set** 节点。
   4. 连接 **Asset Path and Name** 输出引脚到其 **Set** 节点。

脚本的基础部分会执行以下操作：

- 获取一个 Skeletal Mesh 和一个 Static Mesh 的选择结果，并将它们转换为 Dynamic Mesh。
- 捕获目标网格体与源网格体之间的相对变换。
- 将目标 Dynamic Mesh 转换为新的 Skeletal Mesh 资产。

![UE Base Script Convert to Dynamic Mesh](../../../../../assets/images/6b/6b86c714c04aadc61b05c7065dd9549f012a0e3734ef2e477d82d40f550f9c06.jpg)

## 材质映射

要将 Static Mesh 的材质应用到目标网格体，必须创建一个材质映射。材质映射会保存到新的 Skeletal Mesh 资产中，保留 Static Mesh 的所有材质信息。要捕获这些材质信息，需要设置一个材质变量。

要创建材质变量，请执行以下步骤：

1. In **My Blueprint > Local Variable**中，点击加号图标创建一个材质变量。
2. 将变量命名为“Materials”，并将引脚类型设置为 **Name**.
3. In **Details > Variable Type**中，将该类型的容器设置为 **Map**，然后将值类型设置为 **Material Interface**.

![UE Material Map](../../../../../assets/images/41/41cbf47cc70cac910247aa3c67aaaed8277c5bcf0bf761f4a4ee76cf0eb1d719.png)

要从 Static Mesh 拉取材质信息并将其应用到目标网格体，请执行以下步骤：

1. 在 **Static Mesh Component** 节点的输出引脚拖出连线，然后搜索并选择 **Get Material Slot Name**.
2. 从 **Return Value** 引脚拖出连线，然后搜索并选择 **For Each Loop**.
3. 连接 **Exec** 输入连接到 **Success** 引脚，该引脚来自 **Copy Mesh From Static Mesh with Section Materials**.
4. 从 **Loop Body** 输出拖出连线，然后搜索并选择 **Add** （位于 Map 分类）。
5. 连接 **Array Element** 连接到 **Add** 节点。

![UE Material Slot Names](../../../../../assets/images/d2/d2ae39f22a4d1d4c7a5c547006859971a62455b47b6d9c658c43a960a0d33147.jpg)

1. 拖入 **Materials** 变量并点击 **Get Materials**.
2. 连接 **Materials** 输出连接到 **Add** 节点。
3. 在 **Static Mesh Component** 节点的输出引脚拖出连线，然后搜索并选择 **Get Material by Name**.
4. 连接 **Material Slot Name** 输入引脚连接到 **Array Element** 输出引脚。
5. 连接 **Return Value** 输出连接到 **Add** 节点。
6. 在 **For Each Loop** 节点；将 **Completed** 输出连接到 **Transform Mesh** 节点。

![UE Material ID](../../../../../assets/images/9e/9e48f7789ef0f6cf2e553c1cd2cda553ab854a1cf386ada250e52a0a7836203a.jpg)

## 传递骨骼权重

与 **StaticMeshtoSkeletalMesh** 函数一样，Static Mesh 没有骨架数据或骨骼权重。因此，将其转换为 Dynamic Mesh 后，它仍然缺少这些数据。

区别在于，不再收集某个特定骨骼索引来绑定并添加权重，而是只使用 **Transfer Bone Weights From Mesh** 节点复制骨架信息。该节点会检查目标网格体顶点与源 Skeletal Mesh 上最近点之间的关系，并据此复制骨骼权重。可以使用选项控制该节点的行为。

要复制骨骼权重，请执行以下步骤：

1. 在 **Transform Mesh** 节点的执行引脚拖出连线，然后搜索并选择 **Transfer Bone Weights from Mesh**.
2. 连接 **Target Mesh** 输入和输出引脚。
3. 在 **Copy Mesh from Skeletal Mesh** 节点；将 **Dynamic Mesh** 输出连接到 **Source Mesh** 输入。
4. 从 **Options** 引脚并选择 **Make Geometry Script Transfer Bone Weights Options**.
5. Set **Transfer Method** 设为 **Inpaint Weights**.
6. **Compile** （Ctrl + Alt）并 **保存** （Ctrl + S）。

![UE Transform Bone Weights from Mesh](../../../../../assets/images/02/028c95ac027885a7a3b46734aaae0777b1c57619917f3a484b8a30efc9dd5dae.jpg)

### Inpaint Weights 传递方法

Inpaint Weights 更适合处理不贴身的服装，代价是执行时间略慢。它分两个阶段工作：

1. 与 **Closest Point On Surface** 选项类似，它会为目标网格体的每个顶点查找源 Skeletal Mesh 上的最近点。
2. 它不会直接复制权重，而是通过检查最近点是否位于一定距离内、两者法线偏差是否过大，来验证匹配是否合适。

要进一步了解这些选项，请参阅 [Panel Cloth Transfer Skin Weights Node](https://dev.epicgames.com/community/learning/tutorials/Dl20/unreal-engine-panel-cloth-transfer-skin-weights-node) 指南。Chaos 节点本质上与蓝图中的节点相同，共用同一套底层代码。

## 将 Dynamic Mesh 转换为 Skeletal Mesh 资产

由于 Dynamic Mesh 现在已经包含来自源网格体的必要信息，可以将其连同材质信息一起转换为新的 Skeletal Mesh 资产。

要转换为新的 Skeletal Mesh 资产并应用材质映射，请执行以下步骤：

1. 连接 **Transfer Bone Weights from Mesh** 和 **Create New Skeletal Mesh Asset from Mesh** 节点的执行引脚。
2. 在 **Create New Skeletal Mesh Asset from Mesh** 节点拖出连线，从 **Options** 引脚并选择 **Make Geometry Script Create New Skeletal Mesh Asset Options**.
3. 点击向下箭头展开选项列表。
4. 拖入 **Materials** 变量并点击 **Get Materials**.
5. 将变量连接到 **Materials** 输入选项。

![UE Convert Dynamic Mesh to Skeletal Mesh](../../../../../assets/images/1a/1abac6a6e0f0d9959e969eb049b5da2a6d46da3268bbba0e46ef3c5f34a16941.jpg)

## 运行 Action Utility

工具已经完成，可以使用。下面是该工具函数的片段。

要运行该 Action Utility，请执行以下步骤：

1. 将源 Skeletal Mesh 放入视口，并将其中一个衬衫资产与 Skeletal Mesh 身体对齐。
2. 先点击 Skeletal Mesh，然后 **按住 Shift 点击**Static Mesh，以同时选中二者。
3. 右键点击 Actor，并选择 **Scripted Actor Actions > Transfer Skin Weights** （也就是你为该函数设置的名称）。
4. 填写弹出的提示内容。

![UE Actor Action](../../../../../assets/images/4e/4ed0bef84876b48eaefd12ccc319d25731dee54bf08af1426a3b645d41429e5b.jpg)

该工具会将 Static Mesh 转换为一个带有源资产骨架数据的 Skeletal Mesh 资产。该资产应出现在你选择的文件夹中。

> 图片已省略：UE New Skeletal Mesh

> [!TIP]
> 可以在 Skeleton Editor 中测试骨骼权重传递结果。

