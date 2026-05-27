---
title: "发射器生成组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/emitter-spawn-group-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "发射器生成组"]
---

# 发射器生成组

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 发射器生成组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/emitter-spawn-group-reference-for-niagara-effects-in-unreal-engine

**发射器生成** 模块仅在CPU上创建发射器时出现一次。本章节中的模块将初始化默认值或执行初始设置。以从堆栈顶部到底部的顺序执行模块。

在本文档中，"发射器生成"组中的各类模块均有对应章节进行介绍，并带有列出和描述该模块类型可用默认选项的表格。请注意：你可以创建Niagara发射器任意部分的自定义模块。此处列出的项仅为虚幻引擎4中自动包含的模块。

## 位置模块

| 模块 | 说明 |
| --- | --- |
| **在网格中生成粒子（Spawn Particles in Grid）** | 此参数根据用户定义的网格分辨率设置生成粒子。 |

## MAX脚本模块

| 模块 | 说明 |
| --- | --- |
| **生成MS顶点动画工具变换目标（Spawn MS Vertex Animation Tools Morph Target）** | 此参数生成并采样先前使用顶点动画工具创建的变换目标纹理。顶点动画工具生成表示变换目标混合形状的纹理。此模块为工具采集的每个顶点生成一个粒子。此模块应与 **更新MS顶点动画工具变换目标（Update MS Vertex Animation Tools Morph Target）** 模块配合使用。 |
| **更新MS顶点动画工具变换目标（Update MS Vertex Animation Tools Morph Target）** | 此参数获取 **更新MS顶点动画工具变换目标（Update MS Vertex Animation Tools Morph Target）** 模块生成的粒子，并将这些粒子放置于你所选的位置。 |

## 生成模块

| 模块 | 说明 |
| --- | --- |
| **每单位生成（Spawn Per Unit）** | 此模块根据以虚幻单位表示的传播距离生成粒子。 |
| **生成速率（Spawn Rate）** | 此模块以特定速率持续生成粒子。 |

## 新建便签本模块

在 **添加（Add）**（加号）菜单中选择此项目将打开 **便签本（Scratch Pad）** 面板（默认情况下，此面板位于 **系统概览（System Overview）** 旁），然后在 **选择（Selection）** 面板中放置 **便签本模块**。你还可使用 **Windows > 便签本（Windows > Scratch Pad）** 来打开便签本面板。但是，在堆栈中放置便签本模块之后，你在便签本中创建的所有模块或动态输入都将自动连接到脚本。如果你使用Windows菜单打开了便签本面板，则你在其中创建的所有项目都必须手动添加到脚本。

## 直接设置新值或现有值

从 **添加（Add）** 菜单中选择此项目将在 **选择（Selection）** 面板中放置 **设置参数（Set Parameter）** 模块。单击 **加号（Plus sign）**（**+**）图标，以选择 **添加参数（Add Parameter）** 或 **新建参数（Create New Parameter）**。

### 添加参数

假如你选择 **添加参数（Add Parameter）**，你需要从列出的参数中进行选择。这会将该参数添加至发射器生成组中的 **设置参数（Set Parameter）** 模块。

> [!NOTE]
> 部分参数可以在其他模块中设置或修改。部分则只能通过"设置参数"模块设置。

| 参数 | 说明 |
| --- | --- |
| **Emitter.Age** | 此参数定义此发射器的年龄。 |
| **Emitter.CurrentLoopDelay** | 此参数定义发射器当前循环重复之前的当前延迟量。 |
| **Emitter.CurrentLoopDuration** | 此参数定义当前发射器循环的时长。 |
| **Emitter.ExecutionState** | 此参数将影响发射器状态。有效值选择包括： **Active** **Inactive** **InactiveClear** **Complete** |
| **Emitter.ExecutionStateSource** | 此参数将指出执行状态设置的源。使用此参数，可延展性可更改状态，但只有在更高优先权的项目未定义此状态时才能更改。 |
| **Emitter.LocalSpace** | 此参数将定义粒子位置对应场景原点或拥有Niagara组件的位置。 **False**：粒子位置位于场景空间中，并相对于场景原点。位置为 **0,0,0** 的粒子将在场景原点处渲染。 **True**：粒子位置位于本地空间中，并相对于拥有Niagara组件的位置。位置为 **0,0,0** 的粒子将在拥有Niagara组件位置处渲染。 |
| **Emitter.LoopCount** | 此参数定义发射器循环的重复次数。 |
| **Emitter.LoopedAge** | 此参数计算相对于发射器当前循环的发射器年龄。例如，若发射器已激活8秒且每5秒循环一次，则发射器的LoopedAge将为 **3秒**。发射器每次循环时，LoopedAge返回0。 |
| **Emitter.NormalizedLoopAge** | 此参数计算相对于发射器当前循环的发射器年龄，标准化为 **0** 到 **1**。将NormalizedLoopAge表达为 **LoopedAge** 除以 **CurrentLoopDuration**。若发射器已激活8秒且每5秒循环一次，则发射器的LoopedAge将为 **3**。发射器的NormalizedLoopAge将为 **0.6**。 |
| **System.ExecutionState** | 此参数将影响系统状态。可选的有效值包括 **Active**、**Inactive**、**InactiveClear**、**Complete**、**Disabled** 和 **Num**。 |
| **System.ExecutionStateSource** | 此参数将指出系统执行状态设置的源。使用此参数，可延展性可更改状态，但只有在更高优先权的项目未定义此状态时才能更改。 |

### 新建参数

当你需要 **新建参数（Create New Parameter）** 是，你需要从列出的参数中进行选择。之后参数会添加到"发射器生成"组的 **设置参数（Set Parameter）** 模块。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| **音频示波器（Audio Oscilloscope）** | **数据接口（Data Interface）** | 此参数向发射器添加新的音频示波器数据接口模块。此音频示波器模块可以直接访问音频信号的波形数据。 |
| **音频频谱（Audio Spectrum）** | **数据接口（Data Interface）** | 此参数向发射器添加新的音频频谱数据接口模块。此音频频谱模块可以根据音频在特定频率下的响度来驱动可视化。 |
| **布尔（Bool）** | **基元（Primitive）** | 此参数添加具有true/false复选框的设置变量模块。 |
| **摄像机查询（Camera Query）** | **数据接口（Data Interface）** | 此参数向发射器添加新的摄像机查询数据接口模块。 此数据接口可以用于检索指定控制器索引的摄像机信息（摄像机位置、旋转、FOV等）。 |
| **碰撞查询（Collision Query）** | **数据接口（Data Interface）** | 此参数向发射器堆栈添加碰撞数据接口。此参数常与碰撞模块配合使用。 |
| **旋度噪点（Curl Noise）** | **数据接口（Data Interface）** | 此参数向发射器堆栈添加旋度噪点数据接口。若将此参数与旋度噪点力模块配合使用，此数据接口会将不同类型的噪点注入模拟。 |
| **彩色曲线（Curve for Colors）** | **数据接口（Data Interface）** | 此参数为模拟添加四通道彩色曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的颜色。 |
| **浮点曲线（Curve for Floats）** | **数据接口（Data Interface）** | 此参数为模拟添加单通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值。 |
| **矢量2D曲线（Curve for Vector 2Ds）** | **数据接口（Data Interface）** | 此参数为模拟添加双通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值对。 |
| **矢量三通道曲线（Curve for Vector 3s）** | **数据接口（Data Interface）** | 此参数为模拟添加三通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值集。 |
| **矢量四通道曲线（Curve for Vector 4s）** | **数据接口（Data Interface）** | 此参数为模拟添加四通道曲线数据接口。可通过动态输入或其他模块对此曲线进行采样，以创建随时间变化的浮点值集。 |
| **ENiagaraBooleanLogicOps** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于通过以下布尔逻辑进行测试： **大于** **大于或等于** **等于** **不等于** |
| **ENiagaraCoordinateSpace** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于区分坐标空间： **模拟（Simulation）**：如果已将发射器设置为本地，则请使用本地。否则使用世界。 **世界（World）**：在游戏的世界空间内。 **本地（Local）**：在所属组件的坐标空间内。 |
| **ENiagaraExecutionState** | **枚举（Enum）** | 管理系统或发射器执行状态的参数（例如 **Emitter.ExecutionState** 或 **System.ExecutionState**）将使用此列举类型。 |
| **ENiagaraExecutionStateSource** | **枚举（Enum）** | 指示执行状态设置的源。它用于允许可延展性更改状态，但只有在状态尚未被具有更高优先权的对象所定义时才有效。 |
| **ENiagara ExpansionMode** | **枚举（Enum）** | 此枚举供位置模块使用，用于确定扩展的起始点所在： **内部（Inside）** **居中（Centered）** **外部（Outside）** |
| **ENiagaraOrientationAxis** | **枚举（Enum）** | 此枚举供数个模块使用，用于确定使用哪个轴进行计算： **X轴（X Axis）** **Y轴（Y Axis）** **Z轴（Z Axis）** |
| **ENiagaraRandomnessMode** | **枚举（Enum）** | 设置此发射器使用的随机数生成类型。有效选择有： **模拟默认值（Simulation Defaults）** **确定性（Deterministic）** **非确定性（Non-Deterministic）** |
| **浮点（Float）** | **基元（Primitive）** | 此参数创建浮点值变量。 |
| **Grid2D收集（Grid2D Collection）** | **数据接口（Data Interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入2D数据数组，然后在模拟阶段期间迭代网格中的每个像素。 |
| **Int32** | **基元（Primitive）** | 此参数创建整数变量。 |
| **线性颜色（Linear Color）** | **基元（Primitive）** | 此参数创建以取色器形式表示的RGBA颜色变量。 |
| **矩阵（Matrix）** | **基元（Primitive）** | 此参数创建4x4矩阵变量。 |
| **网格体三坐标（Mesh Tri Coordinate）** | **结构体（Struct）** | 这是一个简单的结构体，它包含了三角形指数以及该三角形面上的重心坐标。 |
| **相邻网格3D（Neighbor Grid 3D）** | **数据接口（Data Interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入3D数据数组，然后在模拟阶段期间迭代体积中的每个像素。 |
| **Niagara ID** | **结构体（Struct）** | 此参数是用于追踪粒子的两部分结构体。用于快速访问该粒子的数据。该粒子在现存粒子中始终具有唯一性，但该粒子消逝后会被重用。**AcquireTag** 是获取此ID时的唯一标签。当一个粒子消亡且另一个粒子重新使用消亡粒子的索引时，利用该标签可对这两个粒子进行区分。 |
| **Occlusion Query** | **数据接口（Data Interface）** | 此参数将向发射器添加新的遮挡查询数据接口模块。此数据接口用于读取深度缓冲遮挡信息。 它只能与GPU发射器一起使用。 |
| **粒子属性读取器（Particle Attribute Reader）** | **数据接口（Data Interface）** | 此参数向发射器添加新的粒子属性读取器数据接口。此数据接口不仅可用于查询来自其他发射器的粒子有效荷载值，而且有时比事件更易于使用。 |
| **四元数（Quat）** | **基元（Primitive）** | 此参数创建四元数变量，用于代表旋转。 |
| **简单计数器（Simple Counter）** | **数据接口（Data Interface）** | 此参数将向发射器添加新的简单计数器数据接口模块。此数据接口将使你能够指令线程安全计数器递增计数。 它只能与CPU发射器一起使用。 |
| **骨架网格体（Skeletal Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与骨架网格体的骨骼或套接字和蒙皮几何体交互。 |
| **生成信息（Spawn Info）** | **结构体（Struct）** | 此参数是生成所用的结构体，以指定要创建的粒子 **数量（Count）**、从当前帧开始时间到开始生成之间的 **InterpStartDt** 或偏移、定义粒子生成时间间隔的 **IntervalDt**，以及可将生成粒子归属于不同类别的 **SpawnGroup**。 |
| **样条（Spline）** | **数据接口（Data interface）** | 这是一个数据接口，能够与样条资产交互。 |
| **静态网格体（Static Mesh）** | **数据接口（Data interface）** | 这是一个数据接口，能够与静态网格体的表面交互。 |
| **纹理取样（Texture Sample）** | **数据接口（Data interface）** | 这是一个数据接口，能够与GPU上的纹理交互。 |
| **矢量（Vector）** | **基元（Primitive）** | 此参数创建三通道浮点值集。 |
| **矢量2D（Vector 2D）** | **基元（Primitive）** | 此参数创建双通道浮点值集。 |
| **矢量4（Vector 4）** | **基元（Primitive）** | 此参数创建四通道浮点值集。 |
| **矢量场（Vector Field）** | **数据接口（Data Interface）** | 这是一个数据接口，能够查询矢量场。 |
| **体积纹理取样（Volume Texture Sample）** | **数据接口（Data Interface）** | 此参数向发射器添加新的体积纹理数据接口模块。 你可以使用此参数来进行体积纹理取样。 |
