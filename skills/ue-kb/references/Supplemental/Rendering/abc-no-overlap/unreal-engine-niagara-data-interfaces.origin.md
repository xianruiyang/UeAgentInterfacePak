# 尼亚加拉数据接口

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/jPMm/unreal-engine-niagara-data-interfaces
- 原始文件：unreal-engine-niagara-data-interfaces.origin.md
- 分段：第 1/2 段

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/jPMm/unreal-engine-niagara-data-interfaces

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 5708 字符。

## 摘要

Niagara 数据接口 由 Austin C 撰写的文章。数据接口允许您使用自定义逻辑和数据源来扩展 Niagara。一个数据接口...

## 中文整理

### 概览

由 Austin C 撰写的文章。数据接口允许您使用自定义逻辑和数据源扩展 Niagara。数据接口提供可在模块脚本图中使用的 cpu 和 gpu 函数。这些自定义函数将在执行 Niagara 模拟时被调用，可用于从模拟中提取数据、处理数据或将自定义数据注入模拟中。 Niagara插件中已经有很多数据接口，只需搜索UNiagaraDataInterface的子类即可。在编写自己的数据接口之前，查看基类及其提供的功能以及一两个现有的数据接口绝对是有意义的。另外，如果您需要的只是将一些静态数据注入到模拟中，请查看是否不能为此使用用户参数或数组数据接口。

### 示例项目

UE5 附带了一个模板数据接口，您可以在 Engine\Plugins\FX\ExampleCustomDataInterface 中使用，它由三个主要文件组成： - Source\ExampleCustomDataInterface\Private\NiagaraDataInterfaceMousePosition.h Source\ExampleCustomDataInterface\Private\NiagaraDataInterfaceMousePosition.h - Source\ExampleCustomDataInterface\Private\NiagaraDataInterfaceMousePosition.cpp Source\ExampleCustomDataInterface\Private\NiagaraDataInterfaceMousePosition.cpp - Shaders\Private\NiagaraDataInterfaceMousePosition.ush Shaders\Private\NiagaraDataInterfaceMousePosition.ush 请注意，如果您的数据接口只需要，此示例同时提供 cpu 和 gpu 功能cpu 支持，那么您可以通过删除大部分功能来大大简化实现。对于只需要为cpu颗粒运行的示例数据接口，

您可以查看UNiagaraDataInterfacePlatformSet。

### 数据接口UProperties

您放在数据接口上的任何 UPROPERTY 都将暴露给堆栈中的用户，并且无法通过粒子属性进行设置。这对于配置所有函数调用的数据接口以及提供粒子属性类型不支持的数据（例如字符串或 UClass 引用）非常有用。如果您希望通过用户参数设置数据接口属性，则可以使用 FNiagaraUserParameterBinding 属性。例如，UNiagaraDataInterfaceExport 使用它来设置用于将其数据导出到的 UObject。如果在数据接口上定义任何 UProperty，请确保重写 Equals() 和 CopyToInternal()，否则在堆栈中使用数据接口时可能会遇到问题。

### 穿线注意事项

Niagara 模拟不一定在游戏线程上运行，因此了解哪些数据接口函数是线程安全的、哪些不是非常重要。如果您需要执行任何游戏线程工作，例如访问 UObject，则可以使用以下方法： - InitPerInstanceData - 运行一次以设置模拟的实例数据 InitPerInstanceData - 运行一次以设置模拟的实例数据 - PerInstanceTick - 在模拟之前的每个刻度运行。需要 HasPreSimulateTick() 返回 true！ PerInstanceTick - 在模拟之前运行每个刻度。需要 HasPreSimulateTick() 返回 true！ - PerInstanceTickPostSimulate - 与 PerInstanceTick 相同，但在模拟完成后运行。需要 HasPostSimulateTick() 返回 true！ PerInstanceTickPostSimulate - 与 PerInstanceTick 相同，但在模拟完成后运行。需要 HasPostSimulateTick() 返回 true！您通过 GetVMExternalFunction 提供的数据接口函数不是线程安全的，可以在模拟期间从任意数量的线程调用。如果您需要访问任何游戏线程数据，请使用提供的实例数据对象来存储该数据。例如，

UNiagaraDataInterfaceCollisionQuery 支持异步线路跟踪。它使用 InitPerInstanceData() 来设置保存跟踪查询和命中结果的结构。在模拟过程中，它返回上一帧查询的结果，并从粒子收集所有新查询并将它们存储在实例数据对象中。 PerInstanceTickPostSimulate() 触发 UWorld 的新查询，PerInstanceTick() 收集上一帧查询的结果。

### 生成用户反馈

如果要为数据接口实现一些自定义验证逻辑以向堆栈中的用户提供反馈，可以重写以下函数之一： - void ValidateFunction(const FNiagaraFunctionSignature& Function, TArray<FText>& OutValidationErrors)：每当编译数据接口函数之一时都会运行此函数。如果此处返回任何文本消息，则编译失败并向用户显示错误。这主要用于捕获无效配置，例如，即使在项目设置中禁用了距离字段，也尝试对距离字段进行采样时。 void ValidateFunction(const FNiagaraFunctionSignature& Function, TArray<FText>& OutValidationErrors)：只要编译数据接口函数之一，就会运行此函数。如果此处返回任何文本消息，则编译失败并向用户显示错误。这主要用于捕获无效配置，例如，即使在项目设置中禁用了距离字段，也尝试对距离字段进行采样时。 - void GetFeedback(…)：当数据界面在堆栈中向用户显示时执行，它不仅允许您向用户提供任何类型的堆栈注释，而且还提供快速修复功能，以便用户可以自动修复任何问题。 void GetFeedback(…)：当数据界面在堆栈中向用户显示时执行，它不仅允许您向用户提供任何类型的堆栈注释，而且还提供快速修复功能，

以便用户可以自动修复任何问题。在知识库中获取更多答案！ - 虚幻引擎

## 相关链接
