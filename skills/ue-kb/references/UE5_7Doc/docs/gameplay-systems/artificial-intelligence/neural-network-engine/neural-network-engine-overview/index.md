---
title: "神经网络引擎概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/neural-network-engine-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "神经网络引擎", "神经网络引擎概述"]
---

# 神经网络引擎概述

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 神经网络引擎 / 神经网络引擎概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/neural-network-engine-overview-in-unreal-engine

**神经网络引擎（NNE）** 提供了一个常用API，以访问不同神经网络运行时（有时也被称为执行提供程序），并在不需要运行时特定编码的情况下对神经网络求值。虚幻引擎包括单独的运行时，你可以启用对应的插件，将其添加到你的项目。你可以动态选择最优运行时，从项目的NNE资产创建并执行神经网络，具体取决于你使用的模型和目标硬件。

NNE提供了不同的接口，由运行时实现，以覆盖不同的用例。这些用例可以需要采用不同方式来运行神经网络。这些接口决定了是在CPU、GPU还是与渲染帧匹配的GPU上运行。此实现能让你最大限度地控制是否以及如何在你的项目中执行神经网络。

你可以使用NNE运行实时推理，以使用人工智能（AI）强化游戏，并实现基于编辑器的功能，如资产操作、查询和美术师辅助工具。

以下是构成NNE的重要元素：

- 接口（Interfaces）

  是NNE运行时插件的可访问部分。
- 运行时（Runtimes）

  是用于在你的项目中实现一个或多个接口的插件。
- 资产（Assets）

  是在启用运行时的情况下可以导入虚幻引擎中的神经网络模型资产。
- 模型（Models）

  是存储在神经网络模型资产中的数据。

## 接口

接口是NNE运行时插件的可访问部分。要使API保持整洁且描述清晰，而不是直接访问运行时，你要使用运行时实现的一个接口类，并且该接口公开该运行时的API。每个接口对应单个清晰定义的用例，并基于它们是否能够对该类型的用例求值而在运行时实现接口。

举个用例的示例，在CPU上调用同步推理调用，使用 `INNERuntimeCPU` 和 `INNERuntimeGPU` 使模型求值与GPU上的帧渲染保持一致。`INNERuntimeRDG` 使用[渲染依赖性图表](../../../../designing-visuals-rendering-and-graphics/graphics-programming/render-dependency-graph/index.md#%E6%B8%B2%E6%9F%93%E5%9B%BE%E8%A1%A8%E6%9E%84%E5%BB%BA%E5%99%A8)（FRDGBuilder）异步排队。NNE公开了不同的接口，为使API尽量保持整洁和描述清晰，每个接口都对应单个类型的用例。

这种一致性可确保运行时开发人员能够专注于为每个接口支持对应的功能。将来可以添加新接口，用来涵盖新类型的用例，同时保持向后兼容性。

可用的接口有：

| 接口名称 | 说明 |
| --- | --- |
| `INNERuntimeCPU` | 此接口覆盖了应该在CPU上进行推理的所有用例。输入和输出张量在CPU上提供，内存不会转移到其他设备。它适合GPU上没有预算的用例，或与GPU内存同步不能证明计算有加快的用例。此接口创建的模型实例可以作为异步任务在游戏线程上运行（同步），或在其他任何线程上运行，只要调用者负责处理模型的线程安全和内存生命周期即可，其中包括输入和输出内存。 |
| `INNERuntimeGPU` | 此接口覆盖在GPU上对神经网络求值的运行时。输入和输出张量作为CPU内存提供，并需要与GPU同步，其中运行时将上传和下载它们。推理的发生独立于帧的渲染，但将与渲染管线争用GPU资源。此接口通常服务于仅限编辑器的用例，其中额外GPU同步和资源争用不影响性能。类似于 `INNERuntimeCPU` ，此接口创建的模型实例可以从任何线程运行，只要调用者负责处理线程安全和内存生命周期即可。 |
| `INNERuntimeRDG` | 此接口覆盖了将神经网络求值作为[渲染依赖性图表](../../../../designing-visuals-rendering-and-graphics/graphics-programming/render-dependency-graph/index.md)（RDG）的一部分的用例，后者向提供的RDG图表构建器添加了模型求值。此接口在神经网络消耗和产生在渲染帧时使用的资源时使用。推理在GPU上执行，输入和输出张量必须作为RDG缓冲区提供。推理调用从渲染线程调用，而模型创建和设置通常在游戏线程上执行。这允许与引擎资源紧密集成。 |

## 运行时

**运行时（Runtimes）** 是实现NNE接口的插件。运行时通常在启动时向NNE注册自身。

使用函数 `TArray<FString>UE::NNE::GetAllRuntimeNames()` 可获取所有可用运行时的名称，与它们实现什么接口无关。

使用模板化函数 `TArray<FString>UE::NNE::GetAllRuntimeNames<T>()` 可获取实现指定接口的运行时名称的预筛选列表。例如，要获取实现在CPU上发生的接口的所有运行时，请使用 `UE::NNE::GetAllRuntimeNames<INNERuntimeCPU>()` 。

要检索运行时，请使用函数 `TWeakInterfacePtr<INNERuntime>UE::NNE::GetRuntime(const FString& Name)` 。 或者，使用 `TWeakInterfacePtr<T>UE::NNE::GetRuntime<T>(const FString& Name)` 检索对应的模板化函数。

> [!NOTE]
> 即使启用了对应插件，也并非所有运行时在所有平台上都可用。如果运行时不可用，或者可用但未实现模板化函数中传递的接口，返回的弱指针将为null。由于运行时可以卸载自身，你应该在使用弱指针之前运行测试检查其有效性。
>
> 运行时通常随其相关插件和模块一起注册、注销、加载和卸载自身。但是，运行时的生命周期和注册取决于其特定实现。

## 资产

NNE插件允许你直接将神经网络模型文件导入虚幻引擎中，只要运行时插件支持该文件类型即可。虚幻引擎会在内容浏览器中为导入的神经网络模型创建 **NNE模型数据（NNE Model Data）** 资产。

> [!WARNING]
> 并非所有运行时都支持所有文件格式。某些类型的文件可能显示导入成功，但为该特定运行时创建对应模型可能仍会失败。请参考你使用的运行时，了解它支持的文件格式。

成功导入后，引擎会创建 **UNNEModelData** 资产。从内容浏览器打开资产，为你项目中实现的特定运行时启用和禁用模型。删除不需要的运行时会提高打包速度，减少项目的数据包大小。每个模型在默认情况下针对每个运行时优化，但最好仅选择带有你计划使用的模型的运行时。

虚幻引擎会按照与其他UE资产相同的方式加载NNE模型数据资产。例如，在Actor中定义了一个类型为 `UNNEModelData` 且带有UPROPERTY装饰器的公共类变量，当生成该Actor时，会自动加载编辑器中分配给它的模型。或者，如果内容路径已知，可以使用虚幻引擎函数 `LoadObject` 通过编程加载资产。

## 模型

**模型（Model）** 包含在接口中，并由运行时使用加载的UNNEModelData资产实现。你可以使用以下函数从资产创建模型：

- TSharedPtr<UE::NNE:IModelCPU> INNERuntimeCPU::CreateModelCPU(const TObjectPtr<UNNEModelData> ModelData)
- TSharedPtr<UE::NNE:IModelGPU> INNERuntimeGPU::CreateModelGPU(const TObjectPtr<UNNEModelData> ModelData)
- TSharedPtr<UE::NNE:IModelRDG> INNERuntimeRDG::CreateModelRDG(const TObjectPtr<UNNEModelData> ModelData)

并非每个运行时都可以从NNE模型数据资产创建模型。运行时作为烘焙的要求在虚幻编辑器中可用，但模型可能无法在当前平台上运行推理。你可以使用以下函数返回指示是否可以创建模型的状态：

- ECanCreateModelCPUStatus INNERuntimeCPU::CanCreateModelCPU(const TObjectPtr<UNNEModelData> ModelData) const
- ECanCreateModelGPUStatus INNERuntimeGPU::CanCreateModelGPU(const TObjectPtr<UNNEModelData> ModelData) const
- ECanCreateModelRDGStatus INNERuntimeRDG::CanCreateModelRDG(const TObjectPtr<UNNEModelData> ModelData) const

你应该在创建模型之前调用这些函数。即使结果指示可以创建模型，实际创建仍可能由于内部错误而失败。你应该始终检查返回的模型的共享指针，确认有效之后再使用。

> [!NOTE]
> 创建的模型通常包含不可变的缓冲区，作为在模型的不同实例之间共享的模型权重和参数。你可以在创建模型之后释放UNNEModelData，因为模型将在内部确保它们保留必需数据的指针。

## 模型实例

要运行推理，你可以通过以下任一函数从神经网络模型创建 **模型实例（Model Instance）** ：

- TSharedPtr<UE::NNE::IModelInstanceCPU> UE::NNE::IModelCPU::CreateModelInstanceCPU()
- TSharedPtr<UE::NNE::IModelInstanceGPU> UE::NNE::IModelGPU::CreateModelInstanceGPU()
- TSharedPtr<UE::NNE::IModelInstanceRDG> UE::NNE::IModelRDG::CreateModelInstanceRDG()

模型实例通常包含特定于会话的数据作为内部状态和中间缓冲区。你可以从将模型的不可变数据作为权重和参数共享的单个模型创建多个实例。在创建实例之后，可以释放模型，因为实例会保持自身对必需共享数据的引用。

在第一个推理调用之前，你必须调用以下函数，允许模型分配大小恰当的内部缓冲区：

```
    UE::NNE::ESetInputTensorShapesStatus SetInputTensorShapes(TConstArrayView<UE::NNE::FTensorShape> InInputShapes)
```

> [!NOTE]
> 运行时会报告无法在导入或烘焙时捕捉的所有潜在错误，你应该检查返回的状态码。每当输入形状更改时，必须再次调用该函数。为保持较低的计算资源开销，需避免不必要的重复调用。

调用者拥有所有NNE模型实例的输入和输出内存。调用者必须确保输入和输出张量的内存在整个推理调用期间保持有效且不变。在线程用例中，这需要特别谨慎地操作。

> [!TIP]
> 我们推荐批处理输入数据，因为在需要在每次更新或每帧多次对模型实例求值时，对批量求值比运行多个单独的调用性能更高。如果无法通过批处理同步多个调用，多个实例可以并发运行推理，而不违反NNE要求的线程安全。

## 极简NNE示例

你可以使用以下必需点和代码片段示例，开始在CPU上使用神经网络。

> [!NOTE]
> 为了简单明了并提高可读性，此示例不详细介绍如何准备和设置输入和输出张量。此示例也不检查结果，但你在真实用例中应该进行检查。
>
> 如需其他入门信息，请参阅[神经网络引擎快速入门指南](../neural-network-engine-quick-start/index.md)。

开始操作：

1. 在虚幻引擎中，从

   插件（Plugins）

   浏览器启用NNE运行时插件。
2. 将模块

   NNE

   添加为项目的

   .Build.cs

   文件的依赖项。
3. 通过内容浏览器将神经网络文件（例如

   *.onnx

   文件类型）导入虚幻引擎中。

使用以下代码加载并执行模型：

```
    // 包括NNE头文件    #include "NNE.h"    #include "NNERuntimeCPU.h"    #include "NNEModelData.h"     //  从神经网络模型数据资产创建模型    TObjectPtr<UNNEModelData> ModelData = LoadObject<UNNEModelData>(GetTransientPackage(), TEXT("/path/to/asset"));    TWeakInterfacePtr<INNERuntimeCPU> Runtime = UE::NNE::GetRuntime<INNERuntimeCPU>(FString("NNERuntimeORTCpu"));    TSharedPtr<UE::NNE::IModelInstanceCPU> ModelInstance = Runtime->CreateModelCPU(ModelData)->CreateModelInstanceCPU();     // 待办事项：设置输入和输出张量与张量绑定，以及对应的输入形状     // 给定特定输入大小，准备模型    ModelInstance->SetInputTensorShapes(InputShapes);     // 传递调用者拥有的CPU内存，运行模型    ModelInstance->RunSync(Inputs, Outputs);
```
