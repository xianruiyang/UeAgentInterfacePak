# K2Nodes 的简要介绍 (Part 1/2)

# K2Nodes 的简要介绍 (Part 1/2)

Source file: `unreal-engine-a-not-so-brief-intro-to-k2nodes.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/381o/unreal-engine-a-not-so-brief-intro-to-k2nodes
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 12185 字符。
## 摘要

本教程最初发布在 S1T2 博客 (https://s1t2.com/blog/brief-intro-k2nodes) 上，广泛介绍了 K2Nodes 的概念和组件，以及如何从头开始制作自己的组件。本教程不会逐步引导您完成制作这些节点的过程（尽管最后将提供完整的代码）。相反，它将尝试剖析 K2Node 的更重要的方面，并阐明它们的整体结构和约定。 K2Node 是一个非常奇特的蓝图节点，可用于包装比普通 UFUNCTION 更高级和动态的功能。例如，让一个节点的输入和输出根据其他输入和输出而变化。一种思考方式是内部具有两个或多个函数的蓝图节点；一个函数接受输入，将其传递给 N 个函数，然后另一个函数返回输出，就像蓝图中的子图一样。
## 中文整理
### 概览

在过去的三周里，我断断续续地涉足 **Slate ** 和 **K2Nodes** 的令人困惑的世界。目标只是更多地了解引擎的较低级别，但是，我就是我，我需要一个更具体的目标来努力保持动力和注意力。为此，我决定创建两个 K2Node： - 一个接受 **UObject **Reference 和 **FName** 的节点，然后获取并返回在 **UObject ** 中找到的同名变量（如果存在）。 - 接收 **UObject ** 引用、**FName** 和通配符的节点，然后设置并返回在 **UObject ** 中找到的同名变量（如果存在）。为了安全起见，两者都会返回“**bSuccess**”布尔值。本博客不会逐步引导您完成制作这些节点的过程（尽管最后将提供完整的代码）。相反，它将尝试剖析 **K2Nodes ** 更重要的方面，并阐明它们的整体结构和约定。最后，我希望我的旅程也能帮助您进入**K2Nodes**。那么，第一个主要问题：
### 什么是 K2Node？

似乎很明显，但这是一个很难盲目回答的问题，而且网上没有太多资源可以简单地解释它。 In short, a **K2Node **is a very fancy Blueprint Node that can be used to wrap more advanced and dynamic functionality than your average **UFUNCTION**. For example, having the inputs and outputs of a Node change depending on other inputs and outputs, or having core functionality of the Node completely change depending on input types.一种思考方式是内部具有两个或多个函数的蓝图节点；一个函数接受输入，将其传递给 N 个函数，然后另一个函数返回输出，就像蓝图中的子图一样。您可以在 **Source/Editor/BlueprintGraph/Classes/** 中找到 Engine **K2Nodes **，我强烈建议您花一些时间阅读。 Two good examples are** K2Node_SpawnActorFromClass** and **K2Node_GetDataTableRow **as they have some solid comments as well as fairly straightforward outcomes (not the code though, it is hard to read without getting to know **K2Node **syntax).回到我的预期结果，为什么我必须使用 **K2Nodes**？您可以[通过正常的 UFUNCTIONS 绝对达到相同的结果](https://shootertutorial.com/2016/03/20/get-set-variables-by-name/)。然而我想以最困难的方式偷懒；我想要一个主节点来完成这一切，而不是每个变量类型都有一个节点。 Initially I tried using a [CustomThunk](https://forums.unrealengine.com/t/tutorial-how-to-accept-wildcard-structs-in-your-ufunctions/18968) which is how you can accept Wildcards into normal **UFUNCTIONS**.虽然那里有很多东西需要学习，但我不会在这个博客中深入讨论 - 它没有完成这项工作，因为我无法获得通配符返回值。所以唯一的选择是**K2Nodes**。所以我开始挖掘。
### K2Node 剖析

首先，我必须阅读一些有关该主题的文章。以下是我最初使用的一些很好的资源： - [Unreal 的文档](https://docs.unrealengine.com/5.0/en-US/API/Editor/BlueprintGraph/UK2Node/) - [Unreal Wiki 教程](https://michaeljcole.github.io/wiki.unrealengine.com/Create_Custom_K2_Node_For_Blueprint/) - [关于 Unreal 的非常有用的概述论坛](https://forums.unrealengine.com/t/making-a-custom-blueprint-k2node-in-c-can-anybody-help-me-please/26765) 但是，在阅读完所有这些内容（您应该这样做）后，您最有用的资源将是引擎中的现有节点，尤其是与您想要实现的功能类似的节点。就我而言，这是 **K2Node_GetClassDefaults、K2Node_VariableGet** 和 **K2Node_VariableSet**。是的，最后两个是每个蓝图图中都存在的获取/设置变量节点。显而易见的一件事是，所有 **K2Nodes ** 中都存在大量的样板文件，它们决定了它的外观和行为。以这些为例：

**.cpp**

```cpp
FText UPSK2Node_SetObjectVarByName::GetNodeTitle(ENodeTitleType::Type TitleType) const
{
  return LOCTEXT("SetObjVarByNameK2Node_Title", "Set Object Variable By Name");
}
FText UPSK2Node_SetObjectVarByName::GetTooltipText() const
{
  return LOCTEXT("SetObjVarByNameK2Node_Tooltip", "Sets the value of a variable in a provided object. Takes in the target object and the name of the variable to be changed, then sets the value to the provided New Value.");
}
FText UPSK2Node_SetObjectVarByName::GetMenuCategory() const
{
```

正如您所看到的，这三个函数只负责为节点提供名称、工具提示和类别。值得注意的是，它们返回 **LOCTEXT ** 类型，这是因为这在技术上是 Slate 代码，因此文本必须干净、优化且可本地化。另一个是这样的：

**.h**

```cpp
virtual void GetMenuActions(FBlueprintActionDatabaseRegistrar& ActionRegistrar) const override;
```

**.cpp**

```cpp
void UPSK2Node_SetObjectVarByName::GetMenuActions(FBlueprintActionDatabaseRegistrar& ActionRegistrar) const
{
  Super::GetMenuActions(ActionRegistrar);
  UClass* Action = GetClass();
  if (ActionRegistrar.IsOpenForRegistration(Action))
  {
    UBlueprintNodeSpawner* Spawner = UBlueprintNodeSpawner::Create(GetClass());
    check(Spawner != nullptr);
    ActionRegistrar.AddBlueprintAction(Action, Spawner);
  }
```

这个函数将你的K2Node添加到蓝图图表的右键菜单中，所以它非常重要。其他大块的样板是：

**.h**

```cpp
//Helpers for getting pins
UEdGraphPin* GetThenPin() const;
UEdGraphPin* GetTargetPin() const;
UEdGraphPin* GetVarNamePin() const;
UEdGraphPin* GetNewValuePin() const;
UEdGraphPin* GetReturnResultPin() const;
UEdGraphPin* GetReturnValuePin() const;
```

这些是方便的小函数，用于获取该节点具有的所有引脚（输入和输出）的引用。您不需要*这些功能，但它们确实让您的生活更轻松。请注意，它们不会覆盖任何内容，因此它们的实现取决于您。我是这样做的：

**.cpp**

```cpp
UEdGraphPin* UPSK2Node_SetObjectVarByName::GetThenPin() const
{
  const UEdGraphSchema_K2* K2Schema = GetDefault<UEdGraphSchema_K2>();
  UEdGraphPin* Pin = FindPinChecked(UEdGraphSchema_K2::PN_Then);
  check(Pin->Direction == EGPD_Output);
  return Pin;
}

UEdGraphPin* UPSK2Node_SetObjectVarByName::GetNewValuePin() const
{
```

请注意，缺少获取 Exec 引脚的函数。这是因为它已经在超级 **K2Node.h** 中声明，不需要重写。我们的样板之旅的最后一个是 **FNames** 的处理和存储。在我的旅行中，我遇到了三种不同的缓存 **FText**/**FNames** 的方法，其中一种具有明确的机械目的，而其他两种则更简单但通用性较差。我们缓存这些是因为，根据 **K2Node_GetDataTableRow** 中的注释：

```cpp
/** Constructing FText strings can be costly … */
```

由于许多 Slate 内容都在 UI Tick 上运行，因此明智的做法是尽可能减少开销。第一种方法如下：

**.cpp**

```cpp
namespace FSetterFunctionNames
{
  static const FName FloatSetterName(GET_FUNCTION_NAME_CHECKED(UPSData, SetFloatByName));
  static const FName IntSetterName(GET_FUNCTION_NAME_CHECKED(UPSData, SetIntByName));
  static const FName Int64SetterName(GET_FUNCTION_NAME_CHECKED(UPSData, SetInt64ByName));
...
...
};
```

在此示例中，我在 **蓝图函数库 **(UPSData) 中返回我的 Setter 函数的 **FName **。这些只是正常的 **UFUNCTIONs**。可以使用 **FSetterFunctionNames::FloatSetterName** 访问此方法，并且非常简单。第二种方法：

**.cpp**

```cpp
struct FGetPinName
{
  static const FName& GetTargetPinName()
  {
    static const FName TargetPinName(TEXT("Target"));
    return TargetPinName;
  }
  static const FName& GetVarNamePinName()
  {
    static const FName VarNamePinName(TEXT("VarName"));
```

非常相似，此方法使用 Struct 代替 **Namespace**，并使用 **static const** 函数代替 static **const **变量。您可以通过 **FGetPinName::GetTargetPinName()** 进行访问，这与命名空间方法几乎相同。我可能是错的（在本博客中的每个语句上添加前缀），但我认为这两种方法可以互换，这取决于您自己的偏好和编码标准。最后一个方法是这样的：

**.h/.cpp**

```cpp
//.h
FNodeTextCache CachedNodeTitle;

//.cpp
CachedNodeTitle.SetCachedText(FText::Format("Get Row From {1}"), DataTablePin->DefaultObject->GetName(), this);
```

我最终没有使用这种方法，因为我只是在事后才发现它，但考虑到它使用了引擎结构，我相信它是最可靠的。它还允许动态缓存 **FTexts**，这是 rad，因为您的节点标题（在本示例中）可以根据输入值而变化（这就是 **GetDataTableRow **Node 所做的，请检查一下）。这意味着它仅在需要时构造新的 **FText **一次，而不是每次更新。这些是样板文件的大部分。接下来，我们将讨论实现奇迹所需调用的主要函数。

