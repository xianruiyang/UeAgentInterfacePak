# 定序器设置器功能

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/9yGb/unreal-engine-sequencer-setter-functions

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3915 字符。

## 摘要

在 Sequencer 中对属性进行动画处理时，有时需要围绕更改进行额外的行为，而不仅仅是设置值。如果您希望对象对…的更改做出反应，这会很有用。

## 中文整理

### 概览

在 Sequencer 中对属性进行动画处理时，有时需要围绕更改进行额外的行为，而不仅仅是设置值。如果您希望对象对属性所做的更改做出反应，或者您希望为属性的处理方式定义不同的行为，这会很有用。例如，如果您想要将变换应​​用于不同的坐标空间（例如世界坐标空间和本地坐标空间）。默认情况下，在 Sequencer 中对属性进行动画处理只会直接设置属性的值；但是，可以在 Sequencer 将调用的函数中定义其他行为。如果 Sequencer 找到名为 Set[PropertyName] 的 UFunction，将调用该函数而不是直接设置值。 Sequencer 还应该识别属性是否具有使用 BlueprintSetter 属性说明符定义的 setter。例如，这比让参与者在勾选时轮询属性的值要好，因为该函数仅在属性更改时才被调用。但它也有缺点，因为 Sequencer 按名称搜索这些函数，这可能会导致函数被无意调用。我们正在开发一种新的评估方法，该方法允许以更稳健的方式来定义如何应用属性更改。在那之前，setter 函数是实现这一目标的最佳受支持方法。作为参考，在 FTrackInstancePropertyBindings::CacheBinding 中搜索 setter 函数。这会在绑定对象上查找与名称 FunctionName 匹配的函数。 FunctionName 在 FTrackInstancePropertyBindings 构造函数中设置。如果传入名称，则它使用该名称，否则它将查找名为 Set[PropertyName] 的名称。以下是构造函数中的相关代码： static const FString Set(TEXT(“Set”)); const FString FunctionString = Set + PropertyName.ToString();函数名 = FName(*FunctionString);您可以在 C++ 或蓝图中定义该函数。我们现有的文档在混合角色动画和关卡序列的上下文中引用了这些函数（将它们称为代理函数），但本文将概述更通用和直接的步骤。对于链接文档中概述的步骤，请从第 2 节第 6 步开始。请注意，该文档遗漏了一些在编辑器中预览的重要步骤。 [https://docs.unrealengine.com/en-US/Engine/Sequencer/HowTo/GameplayAnimBlending/index.html](https://docs.unrealengine.com/en-US/Engine/Sequencer/HowTo/GameplayAnimBlending/index.html) 创建您的属性，可以是 C++ 中的 UProperty，也可以是蓝图变量。这需要通过蓝图中的“Expose to Cinematics”标志或使用 C++ 中的 interp 属性说明符来暴露给电影。文档页面希望您通过在蓝图中将其标记为“实例可编辑”来使其可编辑。对于 C++，您可以添加 EditAnywhere 属性说明符。创建 UFunction 设置器。确保其名称为 Set[PropertyName]。例如，如果步骤 1 中的 UProperty 名为 FloatToAnimate，则 UFunction 应命名为 SetFloatToAnimate。这需要采用与您要设置动画的属性相同类型的输入。对于蓝图，此函数需要选中“在编辑器中调用”，以便在编辑器中预览序列时才能正常工作。在 C++ 中，您可以使用 CallInEditor 函数说明符执行相同的操作。设置您要更改的属性的值。链接的文档会跳过此步骤，并且由于不需要在编辑器中预览，因此这不是问题，但 Sequencer UI 使用此值在时间轴中显示。如果没有此步骤，当序列在编辑器中播放或擦除时，UI 中显示的值将永远不会改变。

