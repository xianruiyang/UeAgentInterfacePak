---
title: "毛发渲染和模拟快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/hair-simulation-and-rendering-quick-start-guide-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟", "毛发渲染和模拟快速入门"]
---

# 毛发渲染和模拟快速入门

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟 / 毛发渲染和模拟快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/hair-simulation-and-rendering-quick-start-guide-in-unreal-engine

毛发渲染和模拟指南重在帮助你了解虚幻引擎4中在蒙皮网格体上处理毛发梳理的基础知识。

在阅读完此教程后，你将了解如何：

- 设置项目进行毛发渲染和模拟。
- 设置Groom用于带动画的骨骼网格体。
- 设置简单的

  毛发

  材质。
- 启用并控制毛发物理效果。

## 1 - 必要设置

1. 用

   虚幻项目浏览器

   新建项目并创建一个

   第三人称（ThirdPerson）

   模板项目。
2. 在编辑器中，前往主菜单并选择 **编辑（Edit）** > **项目设置（Project Settings）**，打开项目设置（Project Settings）窗口。 在 **渲染（Rendering） > 优化（Optimization）** 分类下，启用 **支持计算皮肤缓存（Support Compute Skin Cache）**。

   > [!TIP]
   > 由于下一步也需要重启编辑器，可忽略编辑器窗口右下角弹出的 **立即重启（Restart Now）** 按钮。
3. 接下来再次前往主菜单，这次选择 **编辑（Edit）** > **插件（Plugins）**，打开插件（Plugins）浏览器窗口。

   在搜索栏中搜索术语"梳理（Groom）"，或在左侧面板中选择 **几何体（Geometry）**类目，并启用以下插件：

   - Alembic Groom导入器
   - Groom
4. 重启编辑器，让项目设置（Project Settings）和插件（Plugins）的更改生效。

## 2 - 创建和导入Groom

即便是简单角色也可以拥有不同类型的毛发，例如头发、胡子、眉毛等。每种类型的毛发皆拥有各自的材质和物理设置。每个分组中也有不同类型的毛发，例如模拟期间将使用的毛发。当你在DCC应用中设计毛发Groom时，可以定义此类信息。Unreal Engine会查看此信息来创建导线。

1. 在你选择的DCC应用中创建Groom，然后将其导出为Alembic（.abc）文件格式。

   > [!NOTE]
   > 利用[Alembic for Grooms规范](../using-alembic-for-grooms/index.md)，根据正确的命名规范对Groom进行设置，以便在Unreal Engine中使用。
2. 在内容浏览器中点击 **导入（Import）** 按钮导入Alembic文件和梳理。
3. 在Groom导入选项（Groom Import Options）窗口中点击 **导入（Import）**。

   - 修改烘焙进Groom的原始旋转，可以避免额外的运行时消耗。
   - 选用覆盖导线复选框来用导入发束中选择的一组发束替换导入的导线。导线数量取决于毛发至导线密度数值。
   - 使用插值质量和插值距离来修改转移导线运动时导线和发束之间如何配对。
   - 随机化导线和独特导线复选框决定导线如何影响发束；判断单个还是多个导线来影响一根发束。
4. 点击 **导入（Import）**.

在导入过程中，Groom系统将查找符合[Alembic for Grooms](../using-alembic-for-grooms/index.md)规范页面中所述的Alembic命名惯例的属性和组，并导入到新的Groom资产中。在这些属性中，RootUV属性会获取底层表面的UV，比如蒙皮表面，这样Groom之间可以有一些空间变化。

## 3 - 将Groom连接至骨骼网格体

骨骼组件可以用于在骨骼网格体的表面附上Groom资产并绑定Groom。一个可选的绑定资产用于缓存骨骼网格体的Groom项目数据，可以减少初始化时的GPU开销。

### 设置Groom组件

> [!NOTE]
> 这部分指南将使用 **第三人称（ThirdPerson）** 模板中的 `SK_Mannequin` 。若未找到，可在内容浏览器中点击 **新增（Add New）** > **添加功能或内容包（Add Feature or Content Pack）**，并选择 **第三人称（ThirdPerson）** 模板，即可将其添加到项目。
>
> 请注意：同样的设置也可适用于角色蓝图。

1. 在 **内容浏览器（Content Browser）** 中找到 **SK_Mannequin** 骨骼网格体并将其拖入场景。可在 **Mannequin > Character > Mesh** 文件夹下找到该骨骼网格体。
2. 在场景中选中骨骼网格体，然后在 **细节（Details）** 面板中点击 **添加组件（Add Component）**，添加一个 **Groom** 组件。
3. 选中 **Groom** 组件然后使用 **Groom资产（Groom Asset）** 插槽将导入的Groom指定给骨骼网格体。
4. 启用 **将Groom绑定到骨骼网格体（Bind Groom to Skeletal Mesh）**。 Groom会调整位置并跟随它所绑定的骨骼网格体一起移动。

   > [!NOTE]
   > 若要启用该属性，则 *必须* 在项目设置中启用 **支持计算皮肤缓存（Support Compute Skincache）**。否则该属性将不可用。

Groom和骨骼网格体之间的绑定信息会在设置 **将Groom绑定到骨骼网格体（Bind Groom to Skeletal Mesh）** 标记后计算。该操作会导致计算时临时卡顿。要避免该问题，应创建一个绑定资产（见下文）。

### 创建绑定资产

1. 在内容浏览器中，找到你的 **Groom** 资产。右键点击Groom并在快捷菜单中选择 **创建绑定**。
2. 接着会弹出一个 **Groom绑定选项** 窗口。要创建资产，你必须指定一个 **目标骨骼网格体（Target Skeletal Mesh）**；你还可以根据情况，指定一个和目标骨骼网格体享有相同拓扑结构的 **源骨骼网格体（Source Skeletal Mesh）**。设置完这些选项后，点击 **创建（Create）**。
3. 在关卡中选中骨骼网格体。在 **细节（Details）** 面板的组件面板中选中 **Groom** 组件。在 **Groom** 分段中，确保启用 **将Groom绑定给骨骼网格体（Bind Groom to Skeletal Mesh）** 选项，然后将你创建的绑定资产指定给 **绑定资产（Binding Asset）** 插槽。

> [!NOTE]
> 把绑定资产指定给Groom组件时，选项 **将Groom绑定给骨骼网格体（Bind Groom to Skeletal Mesh）** 会自动设置完毕，并且只要绑定资产处于使用状态，该选项就无法被禁用。

## 4 - 设置毛发材质

> [!NOTE]
> Unreal Engine默认包含带 `HairDefaultMaterial` 的简单毛发材质。

由于Unreal Engine包括默认毛发材质，因此以下步骤为本指南的可选内容。如之前并未设置过毛发材质，以下步骤将指导你完成所需的属性和设置。

1. 在内容浏览器中点击 **新增（Add New）** 按钮，从下拉菜单中选择 **材质（Material）**，并为资产命名。
2. 在材质编辑器中，用 **细节（Details）** 面板执行以下设置：

   - 着色模型（Shading Model）：

     毛发（Hair）

   > [!NOTE]
   > 还需要启用 **使用发束（Use with Hair Strands）**。材质应用到梳理组件后，此复选框会自动启用，并重新编译材质。如未启用，可在材质编辑器中从"细节（Details）"面板的 **使用（Usage）** 类目中启用它。
3. 在材质图表中，为基础 *毛发* 材质使用以下节点设置：

   为底色使用 **Constant4Vector**，并使用 **常量** 来控制粗糙度。

   > [!TIP]
   > 若要设置更复杂的毛发材质，则在材质图表中使用 **HairAttribute** 表达式访问毛发属性，例如UV、尺寸（Dimensions）、RootUV、种子（Seed）。
4. 保存并关闭

   材质编辑器。
5. 应用毛发材质有两种方式：通过关卡或蓝图中的相关细节（Details）面板直接在Groom资产组件上应用，或从内容浏览器中打开Groom资产。将毛发材质指定到 **材质** 元素槽。

   |  |  |
   | --- | --- |
   | Groom资产Actor（细节面板） | Groom资产（内容浏览器） |

## 5 - 设置毛发物理特性

下一步，是为Groom资产启用物理模拟。

1. 在内容浏览器中找到Groom资产并打开其属性编辑器。
2. 在毛发物理分类中，勾选 **启用模拟（Enable Simulation）**。

启用后，就可以使用毛发物理分类下的属性控制毛发的物理属性了。

> [!NOTE]
> 关于Groom资产属性的详情，请参见[毛发渲染与模拟设置](https://dev.epicgames.com/documentation/404)参考页面。

启用后，就可以在编辑器中工作以及使用"在编辑器中运行"（PIE）或"在编辑器中模拟"模式时，看到毛发应用了物理效果。
