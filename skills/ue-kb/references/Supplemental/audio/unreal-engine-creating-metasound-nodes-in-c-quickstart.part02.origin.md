# 在 C++ 中创建 MetaSound 节点快速入门 (Part 2/2)

Source file: `unreal-engine-creating-metasound-nodes-in-c-quickstart.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 创建操作符

这是您接下来需要实现的工厂函数。当图形构建器需要实例化节点的新运行时实例时，将调用此函数。它是实际为节点分配内存的函数。

```cpp
static TUniquePtr<IOperator> CreateOperator(const FCreateOperatorParams& InParams, 
                                                        TArray<TUniquePtr<IOperatorBuildError>>& OutErrors)
{
	const Metasound::FDataReferenceCollection& InputCollection = InParams.InputDataReferences;
	const Metasound::FInputVertexInterface& InputInterface = GetVertexInterface().GetInputInterface();
 
        TDataReadReference<float> InputA = InputCollection.GetDataReadReferenceOrConstructWithVertexDefault<float>(InputInterface,   
                                                                METASOUND_GET_PARAM_NAME(InputAValue), InParams.OperatorSettings);
         TDataReadReference<float> InputB = InputCollection.GetDataReadReferenceOrConstructWithVertexDefault<float>(InputInterface, 
                                                                METASOUND_GET_PARAM_NAME(InputBValue), InParams.OperatorSettings);
```

这是使用 METASOUND_GET_PARAM_NAME 宏可以防止由于顶点名称不匹配而出现错误的另一个位置。
### 节点创建与注册

最后一步是创建并注册您的实际节点，使其在 MetaSound 编辑器中显示为选项。对于具有静态顶点接口并始终创建相同 IOperator 类型的节点，可以继承辅助类 FNodeFacade - 这将生成为您创建 MetaSound INode 所需的大量样板代码。使用此功能时，您的 MetaSound Node 在功能上将充当 FNodeFacade 的包装器：

```cpp
class FTutorialNode : public FNodeFacade
{
	public:
		FTutorialNode(const FNodeInitData& InitData) : FNodeFacade(InitData.InstanceName, InitData.InstanceID,   
                      TFacadeOperatorClass<FTutorialOperator>())
		{
		}
};
```

要注册您的 MetaSound，您可以使用宏 METASOUND_REGISTER_NODE，它将把您的节点作为唯一的输入。重要的是，如果您的 MetaSound 节点是模板化的，您将需要显式注册您想要在 MetaSound 编辑器中看到的每个模板实例。 MetasoundMathNodes.cpp 和 MetasoundTriggerAnyNode.cpp 都提供了注册大量模板化 MetaSound 的示例。
### 基于现有模板进行构建

很多时候，从一个简单的 MetaSound 节点开始很有用，该节点具有运行所需的所有基础设施，然后填写所需的参数和功能更改。因此，我们有一个片段提供了可以用作模板的完整演示 MetaSound 节点。目前，它仅将两个数字相加，但它应该足以突出显示节点在 MetaSound 图表中可见并运行所需的信息。这可以直接添加到您项目的 MetaSound 插件中。

```cpp
#include "MetasoundExecutableOperator.h"     // TExecutableOperator class
#include "MetasoundPrimitives.h"             // ReadRef and WriteRef descriptions for bool, int32, float, and string
#include "MetasoundNodeRegistrationMacro.h"  // METASOUND_LOCTEXT and METASOUND_REGISTER_NODE macros
#include "MetasoundStandardNodesNames.h"     // StandardNodes namespace
#include "MetasoundFacade.h"				         // FNodeFacade class, eliminates the need for a fair amount of boilerplate code
#include "MetasoundParamHelper.h"            // METASOUND_PARAM and METASOUND_GET_PARAM family of macros

// Required for ensuring the node is supported by all languages in engine. Must be unique per MetaSound.
#define LOCTEXT_NAMESPACE "MetasoundStandardNodes_MetaSoundTutorialNode"
```
