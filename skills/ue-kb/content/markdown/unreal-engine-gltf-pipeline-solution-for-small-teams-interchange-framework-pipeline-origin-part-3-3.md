# unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin (Part 3/3)

# unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin (Part 3/3)

Source file: `unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 主要蓝图

**蓝图管道**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0" ExportPath="/Script/BlueprintGraph.K2Node_Event'/Game/project_guild/Core/InterchangeFramework/IEBP_Pipeline.IEBP_Pipeline:EventGraph.K2Node_Event_0'"
   EventReference=(MemberParent="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangePipelineBase'",MemberName="ScriptedExecutePipeline")
   bOverrideFunction=True
   NodePosX=-16
   NodePosY=-464
   NodeGuid=1324AABE43D4D9EC54978DAC4720C84B
   CustomProperties Pin (PinId=F074415D4170814BAA7111B1DE068804,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangePipelineBase'",MemberName="ScriptedExecutePipeline"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=1A3D255E4E5C1C435E778880ADE479C4,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 4CB2BB1D45C055B9EDC8F6884DADEED4,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=27F7FC8B43CBB5179A91A8B520050231,PinName="BaseNodeContainer",PinToolTip="Base Node Container\nInterchange Base Node Container Object Reference",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangeBaseNodeContainer'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 96FF443D45196145AFF33F94DFB6C10E,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=FD6CBDFA460698E9C39186A214D2176E,PinName="SourceDatas",PinToolTip="Source Datas\nArray of Interchange Source Data Object References",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/InterchangeCore.InterchangeSourceData'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
```

复制片段时，在蓝图中包含相应的函数非常重要；否则，主蓝图将无法正常工作。此外，当您复制和粘贴代码片段时，默认的类变量可能无法正确设置，这意味着您需要手动配置它们。 - 变量名称 |状态|值-创建文件夹|解锁/可见 | True - 设置命名约定 |解锁/可见 | True - 优化检查 |解锁/可见 | True - 生成 Lod |解锁/可见 |真 - 最大多边形数 |锁定/隐藏| （您的项目规则限制）- 最大纹理分辨率 |锁定/隐藏| （您的项目规则限制）- 其余的剩余变量 |锁定/隐藏| （留空，无，否则可能会破坏蓝图）

### Python 交换管道

这是相同的管道解决方案，以 Python 模板的形式呈现，您可以在其上进行构建。 Python 为虚幻引擎内部和外部的开发提供了广泛的功能。

**自定义 Python 交换管道**

```
import unreal

@unreal.uclass()
class CustomPythonPipeline(unreal.InterchangePythonPipelineBase):

    # Unreal Interchange Python Pipeline Properties
    create_folders = unreal.uproperty(
        bool,  
        meta=dict(
            default_value=True,
```

### Python 管道设置

在虚幻引擎中，有两种主要方法可确保您的 Python 管道脚本在启动时执行： 1. **项目设置链接：** 您可以在虚幻的 **项目设置** 中显式链接您的 Python 管道脚本。导航到 **Project Settings > Python > Startup Script** 并指定 .py 文件的路径。 2. **init_unreal.py 自动加载：** 或者，对于特定于项目的脚本来说，通常更方便，您可以将脚本文件命名为 init_unreal.py。如果此文件放置在项目的 Content/Python 文件夹中（例如 YourProjectName/Content/Python/init_unreal.py），虚幻引擎将在启动时自动执行它，而无需在项目设置中手动链接。这通常是此类启动脚本的理想位置。

![创建 Python Pipeline 资源：在虚幻编辑器中创建新的 Interchange Python Pipeline 资源。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-05.jpg)

![分配 Python 管道：就像我们对蓝图管道所做的那样，打开项目设置，搜索“Interchange Pipeline”，然后在 InterchangeGLTFTranslator 下添加一个数组元素并分配新创建的 Python 管道资源。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-06.jpg)

### 行动中

设置管道后，您将在导入过程中观察到以下情况：

![扩展的导入选项：导入文件时，您将在导入对话框中看到其他修改器堆栈。这些代表您可以在导入管道过程中使用的可选功能，为您提供更多控制。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-07.jpg)

![自动创建文件夹：在导入资源的位置，管道将根据正在实现的资源类型（例如纹理、静态网格物体、材质）自动创建有组织的文件夹。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-08.jpg)

![标准化命名和 LOD：资产将根据您定义的标准命名约定自动重命名。此外，如果您的项目未启用 Nanite，管道还将使用通用的“Deco”预设为您的静态网格物体生成细节级别 (LOD)。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-09.jpg)

![优化警告：如果任何导入的文件（纹理、骨架网格物体或静态网格物体）超过预定义的规则限制（例如多边形计数、纹理分辨率），内置优化检查将向您发出警告。](assets/unreal-engine-gltf-pipeline-solution-for-small-teams-interchange-framework-pipeline/image-10.jpg)

### 结论

开发高效的资产管道对于任何游戏开发团队都至关重要，尤其是对于在紧迫期限内（例如 Global Game Jam 期间）运营的小型团队而言。正如我们所见，手动管理资产通常会导致混乱、不一致和浪费时间。通过利用虚幻引擎的**交换框架**与**glTF**文件格式，我们展示了一个强大的解决方案，可以自动化和标准化资产导入过程。该管道不仅确保资产从一开始就被正确命名和组织，而且还自动检查优化并为各种引擎功能（如 LOD 生成）做好准备。无论是使用**蓝图**实现可视化脚本，还是使用**Python**实现更大的灵活性和自动化，核心原则保持不变：简化艺术家的工作流程并从第一次资产导入开始保持项目完整性。这种方法可以最大限度地减少与资产管理相关的常见问题，为您的团队腾出宝贵的时间来专注于真正重要的事情：创造一款精彩的游戏。

