---
title: "系统更新组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/system-update-group-reference-for-niagara-effects-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建视觉效果", "Niagara参考页面", "Niagara系统和发射器模块参考", "系统更新组"]
---

# 系统更新组

> 路径：虚幻引擎5.7文档 / 创建视觉效果 / Niagara参考页面 / Niagara系统和发射器模块参考 / 系统更新组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/system-update-group-reference-for-niagara-effects-in-unreal-engine

每个粒子每帧都会调用 **系统更新（System Update）** 模块。本文中的模块会在每一帧中更新新的数值。模块在更新时会按照从堆栈顶部到底部的顺序执行。

在本文中，系统更新组中的每种模块都有相应的小节进行介绍，并附有表格说明模块的默认可用选项。注意，你可以为Niagara系统或发射器的任意部分创建自定义模块。本文中仅列出虚幻引擎4自带的模块。

## 系统状态模块

下表介绍了可为系统状态模块设置的各种参数。

| 参数 | 说明 |
| --- | --- |
| **非活动响应（Inactive Response）** | 此设置确定当发射器进入非活动状态时会发生什么状况。非活动意味着发射器处于休眠状态，且不再能够生成或管理粒子。选项包括： **完全（Complete）**：发射器完成任务，然后终止系统。 **终止（Kill）**：立即终止系统以及发射器。 |
| **循环行为（Loop Behavior）** | 此设置说明循环重复次数。 |
| **循环时长（Loop Duration）** | 此设置确定生命周期的时长。你可以使用随机数对其进行初始化，但默认情况下，初始时长值将作为以下所有循环迭代的时长而持续存在。 |
| **重新计算每个循环的时长（Recalculate Duration Each Loop）** | 如果你需要计算每个循环迭代的新时长，请勾选此复选框。 |
| **循环延迟（Loop Delay）** | 如果你需要延迟循环，请勾选此复选框并输入循环持续时长的值。 |
|  |  |

## 新建暂存区模块

在 **添加（Add）**（加号）菜单中选择此项目将打开 **暂存区（Scratch Pad）** 面板（默认情况下，此面板位于 **系统概览（System Overview）** 旁），然后在 **选择（Selection）** 面板中放置 **暂存区模块**。你还可使用 **Windows > 暂存区（Windows > Scratch Pad）** 来打开暂存区面板。但是，在堆栈中放置暂存区模块之后，你在暂存区中创建的所有模块或动态输入都将自动连接到脚本。如果你使用Windows菜单打开了暂存区面板，则你在其中创建的所有项目都必须手动添加到脚本。

## 直接设置新值或现有值

从 **添加（Add）**（加号图标）菜单中选择此项目将在 **选择（Selection）** 面板中放置 **设置参数（Set Parameter）** 模块。单击 **加号（Plus sign）**（**+**）图标，以选择 **添加参数（Add Parameter）** 或 **新建参数（Create New Parameter）**。

### 添加参数

选择 **设置特定参数（Set Specific Parameter）** 后，你可以在列出的参数中进行选择。此操作会向系统更新组添加 **设置参数（Set Parameter）** 模块。

> [!NOTE]
> 其中部分参数可在其他模块中进行设置或修改。其余仅可使用设置变量（Set Variable）模块进行设置。

| 参数 | 说明 |
| --- | --- |
| **System.Age** | 此参数定义已命名系统的存在时间。 |
| **System.CurrentLoopDelay** | 此参数定义已命名系统的当前循环重复之前的当前延迟量。 |
| **System.CurrentLoopDuration** | 此参数定义已命名系统的循环时长。 |
| **System.ExecutionState** | 此参数影响系统状态。可选的有效值包括： Active Inactive InactiveClear Complete |
| **System.ExecutionStateSource** | 此参数指示执行状态设置的源。它用于允许可延展性更改状态，但只有在状态尚未被具有更高优先权的对象所定义时才有效。 |
| **System.LocalSpace** | 此参数定义粒子位置是否对应于世界原点或所属Niagara组件的位置。设置包括： **False**：粒子位置位于世界空间中，并相对于世界原点。位置 **0,0,0** 的粒子将在世界原点处渲染。 **True**：粒子位置在本地空间中，并相对于所属Niagara组件的位置。位置 **0,0,0** 的粒子将在所属Niagara组件位置处渲染。 |
| **System.LoopCount** | 此参数定义系统循环重复的次数。 |
| **System.LoopedAge** | 此参数计算系统相对于其当前循环的存在时间。例如，若系统已激活 **8** 秒且每 **5** 秒循环一次，则系统的LoopedAge将为 **3** 秒。系统每次循环时，LoopedAge返回0。 |
| **System.NormalizedLoopAge** | 此参数计算系统相对于其当前循环的存在时间（其值规范化为介于 **0** 与 **1** 之间）。NormalizedLoopAge表示为 **LoopedAge** 除以 **CurrentLoopDuration**。若系统已激活 **8** 秒且每 **5** 秒循环一次，则系统的LoopedAge将为 **3**。系统的NormalizedLoopAge将为 **0.6**。 |
| **System.ExecutionState** | 此参数影响系统状态。可选的有效值包括： **Active** **Inactive** **InactiveClear** **Complete** |
| **System.ExecutionStateSource** | 此变量链接到ENiagaraExecutionStateSource参数，指出系统执行状态设置的源。它用于允许可延展性更改状态，但只有在状态尚未被具有更高优先权的对象所定义时才有效。 |
|  |  |

### 新建参数

选择 **新建参数（Create New Parameter）** 后，你可以在列出的参数中进行选择。此操作会向系统更新部分添加 **设置参数（Set Parameter）** 模块。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| **音频示波器（Audio Oscilloscope）** | **数据接口（Data interface）** | 此参数向发射器添加新的音频示波器数据接口模块。此音频示波器模块可直接访问音频信号的波形数据。 |
| **音频频谱（Audio Spectrum）** | **数据接口（Data interface）** | 此参数向发射器添加新的音频频谱数据接口模块。此音频频谱模块可以根据音频在特定频率下的响度来驱动可视化。 |
| **布尔（Bool）** | **基元（Primitive）** | 此参数添加具有true/false复选框的设置变量模块。 |
| **摄像机查询（Camera Query）** | **数据接口（Data interface）** | 此参数向发射器添加新的摄像机查询数据接口模块。 此数据接口可以用于检索指定控制器索引的摄像机信息（摄像机位置、旋转、FOV等）。 |
| **ENiagaraBooleanLogicOps** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于通过以下布尔逻辑进行测试： **大于** **大于或等于** **等于** **不等于** |
| **ENiagaraCoordinateSpace** | **枚举（Enum）** | 此枚举供各种模块和动态输入使用，用于区分坐标空间： **模拟（Simulation）**：如果已将发射器设置为本地，则请使用本地。否则使用世界。 **世界（World）**：在游戏的世界空间内。 **本地（Local）**：在所属组件的坐标空间内。 |
| **ENiagaraExecutionState** | **枚举（Enum）** | 管理系统或发射器执行状态的参数（例如 **Emitter.ExecutionState** 或 **System.ExecutionState**）将使用此枚举类型。 |
| **ENiagaraExecutionStateSource** | **枚举（Enum）** | 指示执行状态设置的源。它用于允许可延展性更改状态，但只有在状态尚未被具有更高优先权的对象所定义时才有效。 |
| **ENiagaraExpansionMode** | **枚举（Enum）** | 此枚举供位置模块使用，用于确定扩展的起始点所在： **内部（Inside）** **居中（Centered）** **外部（Outside）** |
| **ENiagaraOrientationAxis** | **枚举（Enum）** | 此枚举供数个模块使用，用于确定使用哪个轴进行计算： **X轴（X Axis）** **Y轴（Y Axis）** **Z轴（Z Axis）** |
| **ENiagaraRandomnessMode** | **枚举（Enum）** | 此枚举供位置模块使用，用于确定扩展的起始点所在： **内部（Inside）** **居中（Centered）** **外部（Outside）** |
| **浮点（Float）** | **基元（Primitive）** | 此参数创建浮点值变量。 |
| **Grid2D集合（Grid2D Collection）** | **数据接口（Data interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入2D数据数组，然后在模拟阶段期间迭代网格中的每个像素。 |
| **Int32** | **基元（Primitive）** | 此参数创建整数变量。 |
| **线性颜色（Linear Color）** | **基元（Primitive）** | 此参数创建以取色器形式表示的RGBA颜色变量。 |
| **矩阵（Matrix）** | **基元（Primitive）** | 此参数创建4x4矩阵变量。 |
| **网格体三坐标（Mesh Tri Coordinate）** | **结构体（Struct）** | 这是一个简单的结构体，它包含了三角形指数以及该三角形面上的重心坐标。 |
| **相邻网格3D（Neighbor Grid 3D）** | **数据接口（Data interface）** | 此参数与模拟阶段配合使用。它使用户能够读取或写入3D数据数组，然后在模拟阶段期间迭代体积中的每个像素。 |
| **Niagara ID** | **结构体（Struct）** | 此参数是用于追踪粒子的两部分结构体。用于快速访问该粒子的数据。该粒子在现存粒子中始终具有唯一性，但该粒子消逝后会被重用。**AcquireTag** 是获取此ID时的唯一标签。当一个粒子消亡且另一个粒子重新使用消亡粒子的索引时，利用该标签可对这两个粒子进行区分。 |
| **遮挡查询（Occlusion Query）** | **数据接口（Data interface）** | 此参数将向发射器添加新的遮挡查询数据接口模块。此数据接口用于读取深度缓冲遮挡信息。 它只能与GPU发射器一起使用。 |
| **四元数（Quat）** | **基元（Primitive）** | 此参数创建四元数变量，用于代表旋转。 |
| **简单计数器（Simple Counter）** | **数据接口（Data interface）** | 此参数将向发射器添加新的简单计数器数据接口模块。此数据接口将使你能够指令线程安全计数器递增计数。 它只能与CPU发射器一起使用。 |
| **粒子属性读取器（Particle Attribute Reader）** | **数据接口（Data interface）** | 此参数向发射器添加新的粒子属性读取器数据接口。此数据接口不仅可用于查询来自其他发射器的粒子有效荷载值，而且有时比事件更易于使用。 |
| **生成信息（Spawn Info）** | **结构体（Struct）** | 此参数是生成所用的结构体，以指定要创建的粒子 **数量（Count）**、从当前帧开始时间到开始生成之间的 **InterpStartDt** 或偏移、定义粒子生成时间间隔的 **IntervalDt**，以及可将生成粒子归属于不同类别的 **SpawnGroup**。 |
| **矢量（Vector）** | **基元（Primitive）** | 此参数创建三通道浮点值集。 |
| **矢量2D（Vector 2D）** | **基元（Primitive）** | 此参数创建双通道浮点值集。 |
| **矢量4（Vector 4）** | **基元（Primitive）** | 此参数创建四通道浮点值集。 |
| **矢量场（Vector Field）** | **数据接口（Data interface）** | 这是一个数据接口，能够查询矢量场。 |
| **体积纹理取样（Volume Texture Sample）** | **数据接口（Data interface）** | 此参数向发射器添加新的体积纹理数据接口模块。你可以使用此参数来进行体积纹理取样。 |
|  |  |  |
