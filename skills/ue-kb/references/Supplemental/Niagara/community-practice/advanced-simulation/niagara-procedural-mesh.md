# 尼亚加拉 - 程序化网格

- 来源: https://dev.epicgames.com/community/learning/tutorials/dXm6/unreal-engine-niagara-procedural-mesh
- 原文标题: Niagara - Procedural Mesh

## 尼亚加拉 - 手术网格

1. Motivation 1. 动机

多年来，Niagara 已经发展成为一个通用的 GPU 计算框架。它不再局限于处理粒子，因此涌现出了许多非常规的渲染应用程序。

## 使用 Niagara 进行行进立方体

虽然内置渲染器在创建这些效果方面做得相当不错，但我认为使用专门的渲染设置可以做得更好。

例如，使用此插件实现的行进立方体算法比使用网格渲染器渲染粒子快近 6 倍。内存占用方面也略胜一筹。

主要优势在于我们可以使用无粒子设置，从而消除模拟和渲染粒子的开销。

2. Plugin Setup 2. 插件安装

该插件的核心功能是允许用户为 GPU 驱动的渲染生成 ExecuteIndirect 参数。

用户既可以在 GPU 脚本中写入顶点数据，也可以使用 Material 内部的程序设置来生成顶点数据（请参阅示例部分）。

## 发动机改装（可选，但推荐）

为了读取材质内部的自定义数据，我们需要对着色器进行一些小的更改，以便在材质内部使用顶点/实例信息。

要添加到 MaterialTemplate.ush 中的文本 #if NIAGARA_PROCEDURAL_MESH_FACTORY

#如果 NIAGARA_PROCEDURAL_MESH_FACTORY uint NiagaraProcMesh_VertexId; uint NiagaraProcMesh_InstanceId; #endif

## 尼亚加拉发射器

⚠ 该插件仅支持 GPU 发射器。

## 程序化三角形发射器

## ProceduralMesh_Initialize

## 程序网格初始化

此模块用于设置网格的初始顶点/实例数。之后可以使用 ProceduralMeshSetDrawArgs 模块覆盖此值。

当发射器在运行时生成新顶点（而非使用固定拓扑结构）时，可以使用 ResetEveryFrame。一种常见的设置是将顶点/实例计数保持为零，并在粒子更新阶段每帧添加新顶点/实例之前将其重置。 InitializeBuffers flag tells the module to allocate vertex buffer for storing built-in attributes (Position, PrevPosition, Normals, Tangents..)

标志告诉模块分配顶点缓冲区来存储内置属性（位置、前一个位置、法线、切线……）。如果我们在材质内部以程序方式生成顶点数据，则此标志是可选的。 ProceduralMesh_SetVertexAttribute

此模块用于更新程序网格的内置属性。此外，还有一个 ProceduralMesh SetTriangleAttribute 模块，用于同时设置三个顶点的值（如果粒子更新的是三角形而不是顶点数据）。 ProceduralMesh_Renderer 程序网格渲染器

这是新的渲染器，用于渲染发射器/粒子生成的数据。

## 使用可变三角形数量的程序网格

3. Examples 3. 示例

让我们来看看除了使用网格渲染器之外，重现静态网格的 3 种不同方法 :p

部分设置需要对引擎进行修改，所以请在尝试之前先添加相应的修改 :)

## 使用顶点缓冲区（NS_ReproduceMesh）

这是使用程序化网格设置的最简单方法。

由于数据是以顶点属性的形式写入的，因此它的行为类似于网格渲染器，不需要对材质进行任何修改。

## 使用顶点自定义数据（NS_ReproduceMesh_CustomData）

该系统使用渲染目标将顶点数据传递给材质。

这意味着该材料需要手动加载数据。

这样用户就可以使用自定义格式（例如，位置信息使用 Float16 格式）。

## 仅材质设置（NS_MeshBufferTextures）

此设置不会在 Niagara 中生成任何顶点数据。

它只是传递用于渲染的绘制参数，顶点属性在材质内部生成。

在这个例子中，我烘焙出了位置/法线/切线纹理，而不是从 Niagara 中写入它们。

材质设置可以随意 :)

材质可以访问 Parameters.VertexId 和 Parameters.InstanceId，它们可用于执行程序逻辑。 4. Limitations 4. 局限性

## 手动滴答

当手动勾选 Niagara 组件（NiagaraComponent::AdvanceSimulation 及其变体）时，该设置不起作用。

这也可能在 Niagara 编辑器中显示为瑕疵，因为该编辑器在拖动时间线时使用手动标记。 Simulation Order 模拟订单

## 典型的 Niagara 每帧更新内容大致如下：

ProcMeshClearArgs -> SimulateParticles -> BasePass -> BasePass 后的 SimulateParticles -> TranslucencyPass

如果渲染器使用不透明材质，并且在 BasePass 之后进行模拟（使用 Gbuffer/Collision DI），这意味着到 BasePass 运行时，渲染器将没有有效的 DrawArgs。

对于这些情况，最好在 ParticleUpdate 或 SimulationStage 中调用 ProceduralMesh_SetDrawArgs。

## 光线追踪支持

对光线追踪的支持有限。

以前在 UE5.0 上可以，但之后引擎禁用了 Pascal 架构 GPU 上的 RTX 功能，所以我没办法测试了 :p

## r.RayTracing.Geometry.NiagaraProceduralMesh 1 个人结果可能有所不同 :) 5. Showcase 5. 展示

使用该插件制作的一些效果（插件本身不包含这些效果 :p）

模拟效果：将程序样条线转换为网格。

巧克力涂层：行进立方体设置。

轮廓：屏幕空间图块，用于加速轮廓渲染。

蒙皮：在 Niagara 内部执行顶点蒙皮。

## 项目文件

## 程序网格插件
