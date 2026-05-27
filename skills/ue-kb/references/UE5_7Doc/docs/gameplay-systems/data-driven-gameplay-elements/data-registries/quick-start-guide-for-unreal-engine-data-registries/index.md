---
title: "数据注册表快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-for-unreal-engine-data-registries"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "数据驱动的Gameplay元素", "数据注册表", "数据注册表快速入门"]
---

# 数据注册表快速入门

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 数据驱动的Gameplay元素 / 数据注册表 / 数据注册表快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/quick-start-guide-for-unreal-engine-data-registries

在开始使用**数据注册表（Data Registries）**之前，需要先启用数据注册表插件，然后就可以创建和配置你的第一个数据注册表，并向其中填充数据。

1. 要启用数据注册表插件，找到**编辑（Edit）** > **插件（Plugins）**。 在**插件（Plugins）**窗口中搜索，或者浏览所有插件来找到**Gameplay**类别下的**数据注册表（Data Registry）**插件。 找到插件后，确保勾选**启用（Enabled）**复选框。

   > [!NOTE]
   > 如果插件窗口提示你需要重启编辑器来使插件生效，请在执行更多操作之前进行重启。
2. 选择**编辑（Edit）** > **项目设置（Project Settings）**以找到**项目设置**
3. 在左侧面板中的**游戏（Games）**分段下，可以看到被标为**数据注册表（Data Registry）**的类别。

   > [!NOTE]
   > 如果找不到该类别，确保你启用了**数据注册表（Data Registry）**插件，并在启用后重启了编辑器至少一次。
4. 在右侧面板中，将至少一个条目添加到**要扫描的目录（Directories to Scan）**数组。 这会告知系统在何处查找数据注册表资产。 `/Game/DataRegistries`就是一个典型的条目，但是目录的添加数量不受限制，具体取决于你要为项目使用怎样的组织模式。 你可以趁此机会检查你指定的所有目录都存在，并验证你创建的数据注册表资产都在正确的位置。
5. 导航至你在内容浏览器的**要扫描的目录（Directories to Scan）**中指定的目录之一，然后添加新的数据注册表资产。 右键点击右侧面板中的空白位置并展开上下文菜单中的**杂项（Miscellaneous）**，即可完成此操作。 在展开的上下文菜单中，选择**DataRegistry**，然后从显示的列表中选择合适的子类。
6. 命名并打开新数据注册表。
7. 在**注册表类型（Registry Type）**字段中输入全局唯一名称。 如果希望使用[游戏标签](../../../programming-with-cpp/using-gameplay-tags/index.md)来辨识属于此数据注册表的资产，请确保在**ID格式（ID Format）**类别下的**基本Gameplay标签（Base Gameplay Tag）**字段中对其进行设置。
8. 将**项结构体（Item Struct）**字段设置为此数据注册表将包含的结构体类型。 这通常是**DataTableRowHandle**或 **SimpleCurve**，但也可以是任何数据类型。
9. 将一个或多个数据源添加到**数据源（Data Sources）**数组中。 必须为每个条目选择要添加的数据类型，并指定数据来源。 你可以使用内置的数据类型，也可以添加你的项目或任何启用的插件所定义的类型。 此时，你需要提供一些数据供数据注册表管理。

   - 对于从已知与现存资产中采集行数据的简单源类型，例如**DataTable源**或**CurveTable源**，请选择要读取的源资产。 **表格规则（Table Rules）**分段介绍了来自你指定的资产的数据行的缓存行为，因此请检查这些规则是否适用于你的用例。
   - 对于在运行时生成新数据源的**DataTable元数据源**或**CurveTable元数据源**而言，你还需要进行一些其他设置。 选择要生成的源类型、适用于所生成源的任何访问或引用规则，以及用于确定系统在查找资产时的扫描或使用规则。 元数据源可以扫描资产或者接受已注册的资产（采用C++代码），也可以同时实现这两种操作。
   - 例如，你可以将搜索路径指定为 `/Game/SearchableDataTables`，但排除 `*PrivateData*` ；如此一来即可排除所有包含子字符串"PrivateData"的路径，因此不会扫描诸如`/Game/SearchableDataTables/PrivateData/`和`/Game/SearchableDataTables/SubPath/SomePrivateDataHere/`这样的路径。
10. 完成数据源的设置之后，请配置**缓存规则（Cache Rules）**来满足项目的特定需求。 要查找你可以配置的设置，请展开数据注册表编辑器中的**缓存（Cache）**分段。

    > [!NOTE]
    > 由于数据注册表功能仍在开发中，某些设置可能无法按照预期工作。
11. 你可以趁此机会检查数据注册表中是否包含了你所期望的项。 点击工具栏上的**刷新（Refresh）**按钮，并审核**注册表预览（Registry Preview）**选项卡上的内容。你可以在这里预览数据注册表当前已知的所有项。 如果结果不符合预期，请修改数据源规则，然后再次点击**刷新（Refresh）**按钮。

    如果有多个源拉取了行，那么行可能会在列表中多次出现；这不是错误，通常表示元数据源将相同的数据当作了简单源或其他元数据源。 但是，顺序很重要；若尝试检索的数据项出现在多个源中，那么只有数据注册表发现的第一个实例才可以访问。 浏览左侧面板中 **数据源** 下的 **运行时源** 类别，查看数据注册表中按照加载顺序列出的每个项的每个实例的源。

    > [!NOTE]
    > 你可以在左侧面板的**数据源（Data Sources）**的下方查看**运行时源（Runtime Sources）**类别，了解数据注册表中按加载顺序列出的各项的各实例的源。
12. 在所有内容检查无误之后，保存你的数据注册表。 在未来的会话中，数据注册表将在启动期间自动加载和填充。 如果你更改了数据注册表，请按刷新按钮更新数据项。
13. 如果你计划通过C++代码使用数据注册表，请打开项目的`Build.cs`文件。 实际的文件名称将包含你的项目名称；例如，如果项目名称是"MyProject"，则文件名将是`MyProject.Build.cs`。 查找设置了`PublicDependencyModuleNames`变量的行，然后将`"DataRegistry"`添加到该数组。 最终的行看起来应该类似于这样：

    C++

    ```
    PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "DataRegistry" });
    ```

在完成这些步骤之后，你的项目将设置为使用数据注册表！ 如需了解注册表的工作原理以及优势，请参阅[数据注册表](../index.md)页面。
