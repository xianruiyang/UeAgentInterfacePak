---
title: "Gameplay Tags"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-gameplay-tags-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "游戏性架构", "Gameplay Tags"]
---

# Gameplay Tags

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 游戏性架构 / Gameplay Tags

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-gameplay-tags-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Gameplay Tags** 是用户定义的字符串，用作概念性、层级化标签。可以将 Gameplay Tag 应用到项目中的对象，并对其进行评估以驱动 Gameplay 实现，类似于检查布尔值或标志。

可以用它们表达许多不同概念，包括：

- 对象属性，例如 `Character.Enemy.Zombie`
- 对象正在做什么或能够做什么，例如 `Movement.Mode.Swimming`
- 游戏事件和触发器，例如 `GameplayEvent.RequestReset`

Gameplay Tag 可以拥有任意数量的层级，层级通过 `.` 字符分隔。例如，Tag `Event.Movement.Dash` 有三个层级，其中 `Event` 是层级中最宽泛的标识符，而 `Dash` 是最具体的标识符。

## 定义 Gameplay Tags

必须将 Gameplay Tag 添加到 Tag 字典中，Unreal Engine 才能识别它们。可以使用以下任一方法添加或移除 Tag：

- 直接在以下位置添加或移除： **Project Settings**
- 从以下资产导入： **Data Table** 资产
- 使用 C++ 定义

上述所有方法都在 **Project Settings** 中设置，位置在 **GameplayTags** 部分，该部分位于 **Project** 标题下。

### 在 Project Settings 中添加 Tag

定义新 Gameplay Tag 最简单的方法是直接在 **Project Settings**.

要在其中添加 Tag： **Project Settings**，请执行以下操作：

1. 启用 **Import Tags From Config**。这会从 `.ini` 文件导入所有 Gameplay Tag，包括 `Config/DefaultGameplayTags.ini` 以及位于 `Config/Tags`.
2. （可选）点击 **Add new Gameplay Tag source** 按钮，创建新的源 `.ini` 文件，位置在 `Config/Tags` 中，用于存储 Gameplay Tag。为项目的不同方面创建单独源文件，有助于大型项目中的组织和协作。
3. 点击 **Manage Gameplay Tags** 按钮，该按钮位于 **Gameplay Tag List** 条目旁。这会打开 **Gameplay Tag Manager** 窗口。
4. 在 **Gameplay Tag Manager** 窗口中，点击左上角的 **Add (+)** 按钮。
5. 输入所需的 **Name**, **Comment**和 **Source**。Comment 会显示在 Tag 的工具提示上，Source 则是存储该 Tag 的 `.ini` 文件。
6. 点击 **Add New Tag** 按钮。

可以在列表中右键单击某个 Tag，并从上下文菜单选择选项来重命名、删除、复制它，或为其添加新的子 Tag。来自以下来源以外的 Tag `.ini` 文件不能在 **Gameplay Tag Manager** 窗口。

> [!NOTE]
> 可以使用文本编辑器编辑 Tag `.ini` 源文件，但必须重启编辑器才能加载更改。

### 从 Data Table 资产导入 Tag

可以从 [Data Table](../../data-driven-gameplay-elements/index.md) 资产导入 Gameplay Tag，行类型为 `GameplayTagTableRow`。使用此方式可以：

- 在 **Data Table Editor**.
- 编辑器运行时修改 Data Table。
- 通过将 `.csv` or `.json` 文件导入为 Data Table 来添加 Tag。

要从 Data Table 导入 Tag，请在 **Project Settings**:

1. 点击 **Add Element (+)** 按钮，该按钮位于 **Gameplay Tag Table List**.
2. 点击新索引的下拉菜单并选择你的 Data Table。

### 使用 C++ 定义 Tag

可以使用以下宏通过 C++ 定义 Gameplay Tag，这些宏定义于 `NativeGameplayTags.h`:

- `UE_DECLARE_GAMEPLAY_TAG_EXTERN`：用于在 `.h` 文件中声明定义于 `.cpp` 文件中的 Tag。
- `UE_DEFINE_GAMEPLAY_TAG`：用于在 `.cpp` 文件中定义在 `.h` 文件中声明的 Tag，且不带工具提示注释。
- `UE_DEFINE_GAMEPLAY_TAG_COMMENT`：用于在 `.cpp` 文件中定义在 `.h` 文件中定义 Tag，并带工具提示注释。
- `UE_DEFINE_GAMEPLAY_TAG_STATIC`：用于在 `.cpp` 文件中定义只对定义文件可用的 Tag。与其他 `DEFINE` 宏不同，此宏不应与 `DECLARE` 宏调用配对。

> [!NOTE]
> 必须将 `GameplayTags` 模块添加到项目的 `Build.cs` 文件中，才能在 C++ 中访问 Gameplay Tags 功能。

#### 示例实现

C++

```
// In .h fileUE_DECLARE_GAMEPLAY_TAG_EXTERN(Movement_Mode_Walking); // In .cpp fileUE_DEFINE_GAMEPLAY_TAG_COMMENT(Movement_Mode_Walking, "Movement.Mode.Walking", "Default Character movement tag");
```

更详细的示例实现请参阅 `LyraGameplayTags.h` 和 `LyraGameplayTags.cpp` 中设置，位置在 [Lyra 示例游戏](../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md) 项目。

## 使用已定义的 Gameplay Tag

定义后，可以将 Tag 应用到对象，并评估这些 Tag 来驱动项目中的 Gameplay。

### 将 Tag 应用到对象

按以下方式将 Tag 应用到对象：

1. 向对象添加一个 **Gameplay Tag Container** ([FGameplayTagContainer](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer?application_version=5.5)）类型变量。该变量会存储多个 Gameplay Tag。
2. 使用 Add Gameplay Tag（[AddTag](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/AddTag?application_version=5.5)）函数向容器添加指定 Tag。

也可以使用 Remove Gameplay Tag（[RemoveTag](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/RemoveTag?application_version=5.5)）函数从容器中移除 Tag，并使用 Append Gameplay Tag Containers（[AppendTags](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/AppendTags?application_version=5.5)）函数将 Gameplay Tag Container 追加到一起。

> [!NOTE]
> 可以直接使用 Gameplay Tag（[FGameplayTag](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTag?application_version=5.5)）类型变量，但对象通常拥有多个 Tag，因此通常需要 Gameplay Tag Container。

### 使用条件函数评估 Tag

可以基于对象的 Tag 驱动 Gameplay 实现。要评估对象 Gameplay Tag Container 中存储的 Tag，可以使用多种条件函数，例如：

- Has Tag（[HasTag](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/HasTag?application_version=5.5))
- Has Any Tags（[HasAny](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/HasAny?application_version=5.5))
- Has All Tags（[HasAll](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer/HasAll?application_version=5.5))

请参阅 [FGameplayTagContainer](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagContainer?application_version=5.5) C++ API 参考和 [GameplayTags](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags?application_version=5.5) Blueprint API 参考以了解更多信息。

> [!NOTE]
> 以空 Gameplay Tag Container 作为输入参数调用条件函数会返回 false，但 `All` 等函数除外，例如 `HasAll`。这是因为容器中没有任何 Tag 缺失于源集合。

#### Gameplay Tag Query

**Gameplay Tag Query** ([FGameplayTagQuery](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/FGameplayTagQuery?application_version=5.5)）类型变量会组合条件函数，以更直接、更紧凑的方式建立复杂逻辑。

Gameplay Tag Query 支持以下表达式：

- **Any Tags Match**：测试查询中是否至少有一个 Tag 存在于容器中。
- **All Tags Match**：测试查询中的所有 Tag 是否都在容器中。如果查询为空，则返回 true。
- **No Tags Match**：测试查询中的所有 Tag 是否都不在容器中。如果查询为空，则返回 true。

此外，Gameplay Tag Query 支持以下根表达式，这些表达式会基于子表达式求值：

- **Any Expressions Match**：测试任一子表达式是否返回 true。
- **All Expressions Match**：测试所有子表达式是否都返回 true。如果没有子表达式，则返回 true。
- **No Expressions Match**：测试是否没有任何子表达式返回 true。如果没有子表达式，则返回 true。

## 高级主题

### 设置 Tag 编辑限制

可以按用户限制 Gameplay Tag 的编辑权限（适用于任意层级）。

要限制编辑，请在 **Project Settings** 中设置以下设置，位置在 **Advanced Gameplay Tags > Advanced**:

- **Restricted Config Files**： `.ini` 文件列表，用于存储受限 Tag，并与拥有编辑权限的 **Owner** 列表配对。
- **Restricted Tag List**：显示一个 **Gameplay Tag Manager** 窗口，可修改受限 Tag。

如果未列为 Owner 的用户尝试编辑受限 Tag，会显示警告消息，要求用户确认已获得 Owner 允许进行编辑。如果用户未确认，则不会执行编辑。

> [!NOTE]
> 受限 Tag 创建后不能在编辑器中删除。要删除受限 Tag，必须直接编辑 `.ini` 文件。

### 在 C++ 中简化 Tag 访问

可以通过使用 [IGameplayTagAssetInterface](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/IGameplayTagAssetInterface?application_version=5.5)改进 Gameplay Tag 实现。该接口提供以下优点：

- 无需显式转换对象即可获取对象的 Tag。
- 可以为每种可能类型编写自定义代码。

实现该接口并重载 [GetOwnedGameplayTags](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/GameplayTags/IGameplayTagAssetInterface/GetOwnedGameplayTags?application_version=5.5) 函数会创建一个蓝图可访问的方法，用与该对象关联的 Tag 填充 Gameplay Tag Container。多数情况下，这意味着将 Tag 从基类复制到新容器，但你的实现也可以从多个容器收集 Tag，或调用蓝图函数来访问蓝图声明的 Tag，或执行对象需要的任何逻辑。

示例实现请参阅 `ALyraTaggedActor` 类，位于 [Lyra 示例游戏](../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md) 项目。
