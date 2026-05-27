---
title: "数据注册表"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/data-registries-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "数据驱动的Gameplay元素", "数据注册表"]
---

# 数据注册表

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 数据驱动的Gameplay元素 / 数据注册表

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/data-registries-in-unreal-engine

编程语言

C++

从下拉菜单中选择一个选项以查看与之相关的内容

**数据注册表**是一种高效的全局储存空间，用于存储带有`USTRUCT`标签的数据结构。 数据注册表支持同步和异步数据访问，以及用户定义的缓存行为。 数据注册表主要用于常见的只读数据。

> [!NOTE]
> 由于数据注册表包含在插件中，因此需要一些设置才能使用它。 [数据注册表快速入门](quick-start-guide-for-unreal-engine-data-registries/index.md)详细介绍了设置流程以及一些基本概念。针对基于特定会话的数据，例如剧情进度或角色的当前状态，请使用引擎的"保存游戏（Save Game）"系统。

你可以将数据注册表设置成为从不同源头加载或生成数据，还可以通过资产扫描和手动注册来填充。 数据注册表类似于**复合数据表（Composite Data Tables）**，但除了标准的表格数据行之外，还可以存储曲线数据。此外，它使用一个间接层，而不是手动将多个表复合在一起。

## 数据源

Data Registry 会从两种来源收集数据项： **Data Registry Sources** and **Meta Data Registry Sources**。这些来源并不是实际数据项；Data Registry 会使用它们查找或生成数据项。数据来源在 Data Registry 中出现的顺序很重要；如果在一个来源中找不到特定数据项，Data Registry 会继续查找列表中位于其后的来源。

这会形成覆盖和回退行为的可能性，并使上下文特定来源能够覆盖通用来源。Data Registry 插件包含内置的 Data Registry Source 和 Meta Data Registry Source，用于包装 **Data Tables** (`UDataTable`) and **Curve Tables** (`UCurveTable`).

### 数据注册表源

Data Registry 会直接拥有一组 Data Registry Source 对象，可在 Data Registry Asset 内的数组中创建并配置这些对象。这些对象表示到特定数据来源的接口，Data Registry 可在其中查找信息，例如单个数据表或 Web 数据库。可以创建以下类的子类： `UDataRegistrySource` ，以处理其他类型的数据，或实现不同的间接规则，将标识符映射到数据项。

创建的任何子类都会在向 Data Registry Asset 添加新数据来源时出现在下拉列表中。

### 元数据注册表源

Meta Data Registry Source 会在运行时创建并拥有其他数据来源。它不会显式列出所有数据来源，而是使用通用规则定位包含数据项的资产，例如扫描一组用户命名路径。它们也可以监听特定资产的手动注册。由于 Meta Data Registry Source 是动态生成的，它们发现的数据来源以及这些来源中的数据项会在运行时加载到 Data Registry 中。与 Data Registry Source 类似，可以创建自己的子类以处理其他数据类型、创建不同扫描规则等。为此，需要重载 `UMetaDataRegistrySource` 类。

创建的任何子类都会在向 Data Registry Asset 添加新 Data Source 时作为选项出现在下拉列表中。

## 标识符

数据注册表插件使用独有的标识符来查找数据注册表以及其中包含的单个数据项。 这些标识符本质上都是[基于字符串的名称](../../../cpp-programming/programming-in-the-unreal-engine-architecture/string-handling/index.md)，不过`FDataRegistryType`（用于数据注册表资产）和`FDataRegistryId`（用于数据注册表中的单个数据项）结构却属于封装器，能提供实用的编辑器内部功能。 `FDataRegistryType`用于辨识数据注册表资产，而`FDataRegistryId`用于辨识数据注册表和其中的特定数据项。 如果你需要查找数据注册表资产或从中检索单个数据项，可以使用这些标识符类型。

每个数据注册表资产都必须在**注册表类型（Registry Type）**字段中具有唯一名称。 如果两个数据注册表资产在此字段中具有相同的名称，系统将仅识别和填充其中一个。 类似地，如果多个数据项共用同一个标识数值（名称或Gameplay标签），那么注册表会读取所有项，但检索操作将仅访问数据注册表资产加载的第一个数据项。如需了解数据项的加载顺序，请参阅[数据源](index.md#data-sources)小节。

> [!NOTE]
> 使用C++的开发者可以通过创建子数据注册表类和重载`ResolveDataRegistryId`函数来更改此行为。

### 数据注册表资产标识符

设置 Data Registry Asset 时，开发者必须将 **Registry Type** 字段设置为唯一名称值。这是 Data Registry 的标识符。设置该值后， `FDataRegistryType` 字段会立即在编辑器各处的下拉列表中加入新的 Data Registry 名称。这可以防止在其他资产中引用 Data Registry 时因拼写错误造成用户错误，并让选择过程更快、更容易。

上图：设置数据注册表资产的标识符。

### 数据项标识符

标识单个数据项（例如数据表中的一行）需要指定 Data Registry Asset 和数据项本身。 `FDataRegistryId` 类型包含这两个标识符。其 **Data Registry Type** 字段会显示为下拉列表，可从中按标识名称选择任何已知 Data Registry。从该下拉列表选择 Data Registry 名称后， **Data Registry ID** 字段会改变以适配该 Data Registry。

如果 Data Registry 的 ID Format 使用 Gameplay Tag，用户界面会显示一个经过筛选的列表，包含该 Gameplay Tag 及其所有子项。如果 Data Registry 的 ID Format 不使用 Gameplay Tag，用户界面会显示该 Data Registry Asset 包含的所有已知行的下拉列表。

> [!NOTE]
> 如果编辑某个数据注册表资产，在通过数据项标识符引用该资产的其他资产中，你的更改可能不会立即生效。 如果发生这种情况，可能是因为数据项标识符在其下拉列表中包含废弃的数据行。 在引用数据注册表（而不是数据注册表资产自身）的资产中点击**编译（Compile）**按钮，即可使用最新的数据项信息更新界面。

左侧是数据注册表资产的数据项选项，且ID格式使用了Gameplay标签。

> [!TIP]
> 由于`FDataRegistryId`包含一个`FDataRegistryType`成员变量（名为`RegistryType`），因此不需要单独的`FDataRegistryType`标识符就可以找到包含数据行的数据注册表资产。

#### 动态标识符解析

默认情况下，系统会通过搜索所提供 `ItemName` 的 `FDataRegistryId` 字段值来查找数据项。如果这不是项目所需的理想行为，可以创建自己的 `UDataRegistry` 子类并重载 `MapIdToResolvedName` 函数，以在本地作用域中包含额外 `FDataRegistryResolverScope` 结构体。通过在 `ResolveIdToName` 子类中重载 `FDataRegistryResolverScope` 函数，可以重新映射传入的行名称，甚至可以使用动态或玩家特定信息。解析 ID 后，系统会生成一个 `FDataRegistryLookup` ，该值保证在系统内唯一，并用作缓存唯一 ID。

## 快速函数参考

以下函数对于你快速掌握数据注册表很有帮助。 此处并未列出完整信息，但列出了你在项目中设置数据注册表后，访问数据时需要用到的基本函数。

| 函数 | 说明 |
| --- | --- |
| `UDataRegistrySubsystem::Get` | 返回指向 `UDataRegistrySubsystem` 实例的指针。作为列表中唯一的静态函数，该函数充当子系统入口点。 |
| `UDataRegistrySubsystem::GetRegistryForType` | 接收名称或 `FDataRegistryType` （可独立提供，也可来自 `FDataRegistryId::RegistryType`）并返回 `UDataRegistry` 指针，指向匹配的 Data Registry（如果存在）。 |
| `UDataRegistrySubsystem::RegisterSpecificAsset` | 按 `FDataRegistryType`搜索 Data Registry，并向其中添加特定资产。如果未提供有效 `FDataRegistryType`，子系统会尝试将该资产添加到子系统中的所有 Data Registry。若至少一个 Data Registry 接受该资产，则返回 `true` 。 |
| `UDataRegistry::GetCachedItem` | 在 Data Registry 中搜索与所提供 `FDataRegistryId` 对应的数据项。如果函数调用时该项不在缓存中，函数会返回 null。否则，函数返回一个 const 指针，指向 Data Registry 存储的任意结构体类型。 |
| `UDataRegistry::GetAllCachedItems` | 填充一个 map，其中每个缓存项都会使用指向引擎 `UScriptStruct` 数据的指针（作为 `const uint8*`），并使用该项的 `FDataRegistryId` 作为键。还会通过单独输出参数提供 `UScriptStruct` 本身。这通常可用作调试工具来遍历缓存，例如使用 `UScriptStruct::ExportText` 函数记录每个缓存项的内容。 |
| `UDataRegistry::EvaluateCachedCurve` | 查找与所提供 `FDataRegistryId` 对应的曲线，并使用给定输入值对其求值。如果调用时请求的曲线不在缓存中，此函数会失败。该函数的返回值类型为 `FDataRegistryCacheGetResult`，它提供所请求曲线的缓存状态信息，最重要的是说明是否找到该曲线。曲线的输出值类型为 `float`，通过输出参数返回。 |
| `UDataRegistry::AcquireItem` | 类似于 `GetCachedItem`，但即使调用时数据项尚未缓存，也会查找该数据项。此函数是异步的；搜索完成时会运行类型为 `FDataRegistryItemAcquiredCallback`的回调函数。该函数返回值为 `bool` ，表示是否成功调度回调； `false` 返回值表示发生错误，回调函数不会运行。 `true` 返回值表示回调函数会运行，但不保证数据项存在。 |

> [!WARNING]
> 缓存从 Data Registry 获取的结构体指针可能不安全。虽然某些数据项始终可用，但其他数据项会动态加载，并且 Data Registry 可能在没有警告的情况下卸载它们。如果可能处理可卸载数据，推荐做法是在获取后立即使用该数据，或缓存自己的副本，而不是保留来自 Data Registry 的指针。

## 与游戏功能集成

数据注册表插件可以添加来自游戏功能插件的数据注册表和单个数据注册表来源。 如需相关流程的详细信息，请参阅[游戏功能和模块化Gameplay](https://dev.epicgames.com/documentation/unreal-engine/game-features-and-modular-gameplay-in-unreal-engine?application_version=5.7)页面。
