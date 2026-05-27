---
title: "FText"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/ftext-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "字符串处理", "FText"]
---

# FText

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 字符串处理 / FText

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/ftext-in-unreal-engine

在 **虚幻引擎** 中，[文本本地化](../../../../working-with-content/localizing-content/text-localization/index.md)的主要组件是 `FText` 类。此类通过提供下列功能支持文本本地化，因此面向用户的所有文本都应使用此类：

- [创建本地化的文本文字。](../../../../working-with-content/localizing-content/text-localization/index.md#textliterals)
- [设置文本格式](../../../../working-with-content/localizing-content/text-localization/index.md#textformatting)（根据占位符模式生成文本）。
- [根据数字生成文本。](../../../../working-with-content/localizing-content/text-localization/index.md#numericaltextgeneration)
- [根据日期时间生成文本。](../../../../working-with-content/localizing-content/text-localization/index.md#chronological)
- [生成衍生文本](../../../../working-with-content/localizing-content/text-localization/index.md#transformative)，如将文本设为大写或小写。

`Ftext` 同时具有 `AsCultureInvariant` 函数（或 `INVTEXT` 宏），可创建非本地化的（即"语言不变"）文本。这在进行如将玩家名从外部API转换为可在用户界面显示的文本等操作时，十分有用。

可使用 `FText::GetEmpty()` 或仅使用 `FText()`,创建空白 `FText`。

## 转换

`FText` 和 `Fstring``间可相互转换。但`FText`包含与本地化数据关联的字符串，而`FString` 仅包含一条字符串，因此以上方法固然会造成损失，将废弃（或无法创建）本地化数据。另一方法是[文本值整理](../../../../working-with-content/localizing-content/text-localization/index.md#textvaluemarshalling)，其可提供无损转换，但该方法产生的数据更适合内部整理，而非供用户查看。

下列转换函数可生成不含本地化数据的 `FText` 字符串：

| `FText` 函数 | 描述 |
| --- | --- |
| `AsCultureInvariant` | 以现有 `FString` 创建非本地化且语言不变的 `FText` 实例。 |
| `FromString` | 通过现有的 `FString` 创建一个非本地化的 `Ftext` 实例。 此效果等同于非编辑器版本中的 `AsCultureInvariant`。在编辑器版本中，此函数不会将文本标记为语言不变，也就是说若将其指定到已保存资源中的 `FText` 属性，其仍为可本地化状态。 |
| `FromName` | 以现有 `FName` 创建非本地化的 `FText` 实例。此效果等同于在 `FName` 参数的 `ToString` 函数输出上调用 `FromString`。 |

要从 `FText` 转换为 `FString`，请使用 `ToString` 函数。得到的 `FString` 将包含 `FText` 的字符串数据，但不包含本地化数据。

## 比较

`FText` 数据比简单字符串复杂，因此其不支持重载运算符比较。相反，其提供多个函数，以执行识别其中细微数据的比较。可用下列比较函数：

| `FText` 函数 | 描述 |
| --- | --- |
| `EqualTo` | 此函数使用 [`ETextComparisonLevel`](https://api.unrealengine.com/INT/API/Runtime/Core/Internationalization/ETextComparisonLevel__Type/index.html)值决定要使用的比较规则。其返回 `布尔`，表明在此类比较规则下，调用 `FText` 是否与其他函数匹配。 |
| `EqualToCaseIgnored` | 此函数为包装，用于以 `ETextComparisonLevel` 的 `Second` 值调用 `EqualTo`。返回值直接来自 `EqualTo`。 |
| `CompareTo` | 此函数使用 [`ETextComparisonLevel`](https://api.unrealengine.com/INT/API/Runtime/Core/Internationalization/ETextComparisonLevel__Type/index.html)值决定要使用的比较规则。与多数字符串或内存比较函数相同，其会返回 `int32`，其中零表示相等，而负值或正值分别表示调用 `FText` 的序位低于或高于 `FText` 参数。 |
| `CompareToCaseIgnored` | 此函数为包装，用于以 `ETextComparisonLevel` 的 `Second` 值调用 `CompareTo`。返回值直接来自 `CompareTo`。 |

## 在用户界面中使用FText

### Slate/UMG

Slate和UMG使用内置控件的 `FText` 属性或参数，此类内置控件显示或控制面向用户文本。建议使用用户构建的自定义控件的 `FText`。

### HUD/画布

要利用带画布的HUD系统显示 `FText`，新建 `FCanvasTextItem` 并将其 `Text` 变量设为要显示的文本，如下放范例代码所示：

```
	// Create a new FCanvasTextItem instance to contain the text.	FCanvasTextItem TextItem(FVector2D::ZeroVector, TestHUDText, BigFont, FLinearColor::Black);	// Add the text into the FCanvasTextItem.	TextItem.Text = FText::Format(LOCTEXT("ExampleFText", "You currently have {0} health left."), CurrentHealth);	// Draw the text to the screen with FCanvas::DrawItem.	Canvas->DrawItem(TextItem, 10.0f, 10.0f); 
```

> [!NOTE]
> 在HUD中使用画布时，须在 `DrawHUD` 函数中调用 `DrawItem`，或者在以 `DrawHUD` 开头的函数链中调用该函数。
