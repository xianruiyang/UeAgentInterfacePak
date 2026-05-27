# MetaSound Pages

---
title: "MetaSound Pages"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/metasound-pages-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "Sound Source", "MetaSounds", "MetaSound Pages"]
---

# MetaSound Pages

> 路径：虚幻引擎5.7文档 / 处理音频 / Sound Source / MetaSounds / MetaSound Pages

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/metasound-pages-in-unreal-engine

**MetaSound 页面** 是 MetaSound 变体，可用于支持不同硬件性能等级。使用页面时，可以定义一组 MetaSound 输入值，或定义完全不同的 MetaSound 图表，然后根据平台目标或运行时逻辑在页面之间切换。

平台与页面不是一一对应关系，因此可以根据复杂度、CPU 使用、内存使用或其他因素进行映射。

> [!NOTE]
> 不能使用页面修改正在活动的 MetaSound 实例，因为分页数据交换发生在 MetaSound 实例执行之前。

## 使用页面

### 调整项目设置

![Adjust Project Settings](../../../../../assets/images/7a/7a7ad4df44b1b16eac7273c75c8851e3f994e72e3ea26112ac0da34121e713dc.png)

可以在 Project Settings 中创建页面并调整其设置。

1. 选择

   Edit > Project Settings

   .
2. 在左侧的

   Engine

   标题下选择

   MetaSounds

   .
3. 修改以下设置，位置在

   Pages (Experimental)

   部分：

   1. 点击

      Add

      按钮，用于

      Page Settings

      向数组添加页面。
   2. 展开新的数组元素。
   3. 设置

      Name

      ，例如“Low”、“High”或“Mobile”。页面在数组中的顺序很重要。请参阅

      回退处理

      了解更多信息。
   4. 如果

      Targetable

      为 true，该页面会面向所有平台。如果要面向特定平台，请点击

      Add

      按钮，用于

      Targetable

      并选择目标平台。重复此步骤可设置多个平台。
   5. 如果要在特定平台上从 cook 中排除此页面，请点击

      Add

      按钮，用于

      Exclude from Cook

      并选择要排除的平台。重复此步骤可设置多个平台。
   6. 如果想要面向“Default”以外的页面，请设置

      Target Page Name

      为所需页面。请参阅

      Target Page Name

      for more information on this setting.

> [!NOTE]
> 该 **Default** 页面不能删除或重命名。

#### 回退处理

如果活动平台未实现目标页面，MetaSound 会使用 **Page Settings**中 cooked 页面索引顺序。具体来说，MetaSound 会回退到它所实现的下一个更低索引顺序页面。如果未找到回退页面，MetaSound 会使用默认实现。

#### Target Page Name

该 **Target Page Name** 设置会指定执行 MetaSound 时使用的页面。此目标会在播放期间反映到 **Play In Editor（PIE）**.

可以通过以下方式设置 Target Page Name：

- 在 Project Settings 中
- 在 Platform

  .ini

  文件中（

  [PROJECT_ROOT]\Platforms\[PLATFORM_NAME]\Config\[PLATFORM_NAME]MetaSound.ini

  )
- 使用控制台变量

  cvar au.MetaSound.Pages.SetTarget [PAGE_NAME]
- 在运行时通过蓝图或 C++ 设置

![Target Page Name](../../../../../assets/images/85/8586ab8ee5a46714942d5df80445f2ac42e8a4f931ba9fd54665bf974880a380.jpg)

> [!NOTE]
> Target Page Name 默认也会反映到 **MetaSound Editor** ，但也可以使用其他平台和页面进行试听。请参阅 [在编辑器中试听页面](#auditioningpagesineditor) 了解更多信息。

### 分页 MetaSound 图表

![Paging MetaSound Graphs](../../../../../assets/images/2c/2cbda9731433b57e64bdd2fe59aedb773abad93d347eb6ea4949e05c14e5e0d6.png)

在 Project Settings 中设置页面后，可以在 MetaSound Source 和 Patch 图表的 **Pages** 标签页中使用它们。

在 **Pages** 标签页中，可以：

- 从

  Add Page Graph

  下拉菜单中选择页面，以添加新页面。
- 选择右侧的

  垃圾桶

  按钮以移除页面。
- 选择左侧的

  Focus (<-)

  按钮以聚焦页面。

添加页面时，现有图表会复制到新页面。之后，对活动图表的任何更改只会应用于聚焦页面。应使用此工作流先创建最佳声音，然后为需要更低复杂度图表的变体添加页面。

所有页面共享相同的输入和输出成员，包括接口。不过，变量按每个图表设置。

> [!TIP]
> 可以在 **MetaSound Graph** 面板左下角看到当前聚焦页面。

### 分页 MetaSound 输入

![Paging MetaSound Inputs](../../../../../assets/images/ef/ef0ae0018e91d570000684eeeb25b2b2c478611b908528552203aae81101df2d.png)

除了图表变体，也可以为每个页面设置不同的默认输入值。例如，可以根据目标页面的不同资源需求，在数组中指定不同数量的 Sound Wave。

要创建分页输入，请执行以下操作：

1. 在

   Members

   面板中选择一个输入。
2. 在

   Details

   面板中，点击

   Default Value > Add Page Default Value

   下拉菜单并选择相关页面。这会创建一个新的

   Default Value

   条目。
3. 设置新条目的值。

#### 无图表输入回退

与页面关联的输入变体独立于图表变体。如果某个给定页面没有可用分页图表，则会使用下一个可用分页图表作为回退，并应用任何相关输入变体。

例如，可以按以下方式在“Medium”页面的图表上使用“Low”分页输入：

1. 在 Project Settings 中按顺序创建“Medium”和“Low”页面。
2. 在 MetaSound 上：

   1. 创建“Medium”分页图表。
   2. 创建“Low”分页输入。

> [!NOTE]
> 请参阅 [回退处理](#fallbackhandling) 了解更多信息。

### 在编辑器中试听页面

![Auditioning Pages in Editor](../../../../../assets/images/ed/edd689b4ae8e7dd91ad00916c242ff6969ee3bba75bdc0e7af7e82e389bcb1f8.jpg)

默认情况下，在 MetaSound Editor 中试听 MetaSound 对应 PIE 中播放的内容。

不过，可以在 **Audition** 菜单中覆盖此功能，并设置以下内容：

- Audition Platform

  - 设置平台，并将相关目标和 cook 设置应用到试听。
- Sync With Graph Page

  （默认启用）- 启用后，在 MetaSound Editor 中播放 MetaSound 会播放聚焦页面的图表。禁用后，可以选择特定的

  Audition Page

  进行预览。

如果该页面不是所选 Audition 平台的目标页面， **Play** 按钮会变为黄色，并显示警告图标和相关工具提示。不过仍然可以播放它。

> [!TIP]
> Audition 菜单设置会反映到 **Editor Preferences > MetaSound Editor**.

## 限制

- 不能在 MetaSound Preset 中添加或移除页面，但可以覆盖页面输入默认值。
- 接口输入默认值不支持页面输入默认值。
- C++ 节点类不支持页面输入默认值。
- 项目不能改变编辑器中的试听行为。

