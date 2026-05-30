# 在 C++ 中创建 MetaSound 节点快速入门 (Part 1/2)

Source file: `unreal-engine-creating-metasound-nodes-in-c-quickstart.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/ry7p/unreal-engine-creating-metasound-nodes-in-c-quickstart
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 14765 字符。
## 摘要

这是通过 C++ 代码制作新型 MetaSound 节点的快速入门指南。
## 中文整理
### 概览

MetaSounds 提供了丰富的开箱即用的节点库。然而，有时您可能希望有一个不存在的节点。在那一刻，您会想知道如何创建自己的节点。也许您只是想尝试和了解 DSP 和音频编程，MetaSounds 是一个有趣的尝试环境。或者，也许您有一个现有的工具和功能库，希望将其移植到 MetaSounds，以便您可以将其集成到数百种游戏中使用的东西中。好消息是，如果您了解 C++，那么创建自己的节点是相当容易的。
### 设置新的 C++ 虚幻引擎插件

在开始之前，首先要做的是制作一个新的 C++ 虚幻引擎插件。有一些关于如何创建新插件的现有文档，您可以在[此处](https://docs.unrealengine.com/4.27/en-US/ProductionPipelines/Plugins/)找到。一旦您完成了基本的 C++ 插件设置（例如 MyCustomMetaSoundPlugin.uplugin）并准备就绪，请告诉 C++ 插件链接到现有的 MetaSound 插件。您可以通过将其作为插件依赖项添加到插件的 .uplugin json 文件中来完成此操作，如下“插件”列表中所示：

```
{


    "FileVersion": 3,

    "Version": 1,

    "VersionName": "1.0",

    "FriendlyName": "My Custom MetaSound Plugin",
```

您还需要确保模块的构建依赖项在公共依赖项或私有依赖项中包含 MetasoundEngine。在模块的 build.cs 文件中，将“MetasoundEngine”作为条目添加到 PublicDependencyModuleNames 或 PrivateDependencyModuleNames 字段中，如下所示：

```cpp
PrivateDependencyModuleNames.AddRange(
			new string[]
			{
				"MetasoundEngine"	
			}
			);
```
### 编写新的 MetaSound 节点

令人惊讶的是，编写新的 MetaSound 只需要添加一个私有 .cpp 文件。然而，有些人可能更喜欢将节点拆分为传统的 .h 和 .cpp C++ 文件。只需要定义两个类： - 从 TExecutableOperator 派生的操作符类 - 从 FNodeFacade 派生的节点类
### 操作员类

此类定义了描述、创建和执行节点的方式。它也是运行时在 MetaSound 图中实例化的对象。操作符通过函数 GetNodeInfo() 描述自身，通过函数 CreateOperator() 创建自身，并在函数 Execute() 中执行。
### 数据参考

您将需要您的类存储对所有输入的读取引用以及对节点将使用的所有输出的写入引用。必要的参考类使用命名约定 F[Type]ReadRef 和 F[Type]WriteRef，并且存在基元类型 int、float、string 和 bool，以及 MetaSound 特定类型 Trigger、Audio Buffer、Audio Modulation Parameter、Time 和 Wave Asset。对于音频缓冲区和触发器等类型，您可能需要包含额外的头文件。您的节点运算符需要继承的类是 TExecutableOperator。以下是使用可执行运算符类 FTutorialOperator 创建节点运算符的示例。

```cpp
 // Include to access the TExecutableOperator class
#include "MetasoundExecutableOperator.h"

class FTutorialOperator : public TExecutableOperator<FTutorialOperator>
{
     public:
		// REST OF CODE

     private:
```
### 构造函数

MetaSound 的构造函数可能是您首先要编写的内容之一。构造函数将需要一个 const FOperatorSettings & 和 const read 节点输入变量的引用作为函数的输入参数。构造函数需要创建对节点输出参数的写引用，并将输入和输出参数初始化为合理的值。上面提到的 FTutorialOperator 的示例实现如下所示：

```cpp
FTutorialOperator(const FOperatorSettings& InSettings,
                  const FFloatReadRef& InInputAValue,
                  const FFloatReadRef& InInputBValue)
                  : InputAValue(InInputAValue)
                  , InputBValue(InInputBValue)
                  , TutorialOutputNode(FFloatWriteRef::CreateNew(*InputAValue + *InputBValue))
		{
		}
```

当使用触发器或音频缓冲区类型的输出节点时，需要分别使用 FTriggerWriteRef::CreateNew(InSettings) 或 FAudioBufferWriteRef::CreateNew(InSettings) 来初始化输出节点。
### 执行

这就是 MetaSound 的主要功能所在。换句话说，您应该在此处放置任何数学、数字信号处理或您希望节点在每帧执行的其他操作。根据节点的预期功能，此功能的实现复杂性可能会有很大差异。对于一个简单的节点，这可能就像读取输入，执行较小的操作，然后用结果更新输出一样简单，如下所示：

```cpp
void Execute()
{
	*TutorialOutputNode = *InputA + *InputB;
}
```

值得注意的是，一旦放置了 Node，MetaSound 图中的执行函数就会被频繁调用。因此，避免缓慢或阻塞的函数很重要。否则，当您的节点在 MetaSound 中使用时，您将面临出现性能问题的风险，这可能会导致恼人的爆音和点击声。一些最佳实践包括利用缓冲区优化代码（例如您可以在文件 BufferVectorOperations.cpp 中找到的代码），而不是任何逐个样本循环。此外，在重做计算成本可能很高的节点中，通常值得存储输入参数的最后一个值来验证输出是否需要更改。
### 获取节点信息

这是您需要为节点提供的函数，用于检索有关 MetaSound 节点的必要元数据。它提供了包含 MetaSound 命名空间的类名称，该命名空间在 MetaSound 编辑器中显示为子类别。它还提供其他信息，例如版本号、可本地化的显示名称、可本地化的描述、节点作者以及告诉用户是否丢失的提示（即有人正在加载 MetaSound 图表，但没有您的插件）。最重要的是，这个函数返回默认的顶点接口定义，它本质上是节点输入和输出（即顶点）的对象和类型。 GetNodeInfo 的示例实现如下：

```cpp
static const FNodeClassMetadata& GetNodeInfo()
{
	auto CreateNodeClassMetadata = []() -> FNodeClassMetadata
	{
		FVertexInterface NodeInterface = DeclareVertexInterface();

		FNodeClassMetadata Metadata
		{ 
                FNodeClassName { StandardNodes::Namespace, "Tutorial Node", 
                     StandardNodes::AudioVariant },
```

**顶点接口** 您可能已经注意到上面的 GetNodeInfo() 实现中的 DeclareVertexInterface 函数。在图形术语中，我们的 MetaSound“参数”（或引脚）被称为顶点。要定义 MetaSound 节点，图形构建器需要了解构建节点的顶点。因为它在节点定义中的几个地方被引用，所以它通常有助于定义构造 FVertexInterface 对象的静态本地辅助函数：

```cpp
static const FVertexInterface& DeclareVertexInterface()
{
	using namespace TutorialNodeNames;

	static const FVertexInterface Interface(
		FInputVertexInterface(
		       TInputDataVertexModel<float>
                       (METASOUND_GET_PARAM_NAME_AND_METADATA(InputAValue)),

	               TInputDataVertexModel<float>
```

另请注意，顶点模型对象是模板化的，并定义顶点中的数据类型（即引脚类型）。 MetaSounds 目前支持浮点型、整数型、布尔型、Metasound::FAudioBuffer、Metasound::FTrigger 以及将来可能支持的更多核心类型。目前，在 MetaSounds 中添加类型支持（即新的引脚类型）需要更多的工作，尽管有计划让插件可以轻松扩展类型支持。 **定义输入和输出** DeclareVertexInterface 中使用的宏帮助器 (METASOUND_GET_PARAM_NAME_AND_METADATA) 需要额外的解释。这是一个方便的宏，用于检索参数的名称和工具提示描述，以帮助防止在参数名称输入错误时可能出现的难以发现的错误。在 API 中的各个位置实现节点的输入和输出（也称为“节点参数”）之前，预先定义它们非常有用。节点输入和输出当前通过其 FName 在节点 API 中引用。由于有多个位置会引用节点名称，因此在 .cpp 文件的顶部在节点的唯一命名空间中定义它们非常有用，而不是在引用它们的地方重新键入它们。我们建议使用以您的插件为前缀或唯一的命名空间，以避免与其他插件发生命名空间冲突。请注意，由于参数既有名称也有本地化的工具提示，因此我们创建了一个方便的宏来一次性定义它们：METASOUND_PARAM。要使用此功能，请在 .cpp 文件顶部包含 MetasoundParamHelper.h：

```cpp
#include "MetasoundParamHelper.h"
```

以下是具有两个输入引脚/参数和一个输出引脚/参数的 MetaSound 节点的示例：

```cpp
namespace MyPlugin
{
	namespace TutorialNodeNames
	{
		METASOUND_PARAM(InputAValue, "A", "Input value A.");
		METASOUND_PARAM(InputBValue, "B", "Input value B.");
		METASOUND_PARAM(OutputValue, "Sum of A and B", "The sum of A and B.");
	}

	// REST OF CODE
```

我们将在节点实现的其余部分引用这些已定义的参数，详细信息如下： - 检索名称和工具提示时：METASOUND_GET_PARAM_NAME_AND_METADATA(InputAValue) - 仅检索参数名称时：METASOUND_GET_PARAM_NAME(InputAValue) **本地化 ** MetaSound 标准节点库针对引擎支持的所有语言进行了本地化。它使用 LOCTEXT 系统生成需要本地化的文本。您需要确保每个节点的本地化命名空间都是唯一的，并且在定义节点名称和工具提示时考虑本地化键。紧随 .cpp 文件中包含的标头之后应该是您的节点特有的 LOCTEXT 命名空间的 #define： #define LOCTEXT_NAMESPACE "MyPlugin_TutorialNode" 在 .cpp 文件的最后，需要取消定义 LOCTEXT_NAMSPACE： #undef LOCTEXT_NAMESPACE
### 获取输入和获取输出

这是您需要实现的 IOperator（由 TExecutableOperator 继承）的虚拟函数。这些函数允许 MetaSound 图形通过返回数据引用集合分别与节点的输入和输出进行交互。这些函数通常具有非常简单的实现，利用函数 AddDataReadReference 以及您的参数名称和您的私有读/写引用作为参数。示例实现如下所示：

```cpp
virtual FDataReferenceCollection GetInputs() const override
{
    using namespace TutorialNodeNames;
	FDataReferenceCollection InputDataReferences;
		 
    InputDataReferences.AddDataReadReference(
        METASOUND_GET_PARAM_NAME(InputAValue), 
        InputA);
			 
    InputDataReferences.AddDataReadReference(
```

请注意，这是另一个受益于使用宏助手的函数。 GetInputs/GetOutputs 中使用的节点名称与 GetVertexInterface 等函数之间的不匹配可能会导致难以发现的错误，因此提前定义名称可以帮助减少用户错误，并且如果您选择这样做，也可以在以后更轻松地更改名称。
