---
title: "光源混合器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-the-light-mixer-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "为场景设置光照", "雾、云、天空和大气的环境光源", "光源混合器"]
---

# 光源混合器

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 为场景设置光照 / 雾、云、天空和大气的环境光源 / 光源混合器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-the-light-mixer-in-unreal-engine

**光源混合器（Light Mixer）** 提供一个旨在满足光照创作要求的专用界面。 美术师可以隔离光源，更改其可视性，并随时启用相关设置以实现所需的外观。 光源也可以分组为各个集合，以便更快访问光源组。

光源混合器侧重于标准[光源类型](../../light-types-and-their-mobility/index.md)的管理，是[环境光源混合器（Environment Light Mixer）](../environment-light-mixer/index.md)的补充，而环境光源混合器侧重于环境光照组件，如天空、云、环境光源和天空光照。

"光源混合器（Light Mixer）"面板显示当前加载的关卡及其子关卡中存在的所有光源。 此处甚至可以显示用作现有场景Actor的组件或蓝图内部组件的光源。 你可以指定要在此面板中显示的光源参数，并直接在面板中更改参数值。

![Light Mixer Panel](../../../../../assets/images/6a/6ac876b658cf0351762e7dddae5e21720ae5a472b09b34f3be6649c74e8b45fe.png)

## 光源混合器界面

从编辑器主菜单中选择 **窗口（Window）> 光源混合器（Light Mixer）** 打开光源混合器。

**光源混合器（Light Mixer）** 界面包含以下元素：

![Light Mixer Interface](../../../../../assets/images/bb/bbd020431374d8e2ff9e036a2bf2deceb9e62612d73f3fb673665ee3934ae870.png)

1. 工具栏
2. "光源混合器（Light Mixer）"面板

### 工具栏

通过 **工具栏** 可以向场景中以及此组件面板的光源列表中添加不同类型的光源。

![Light Mixer Toolbar](../../../../../assets/images/39/3905fb04bae3690e2034cf92270cbbaa53fe1cf6932770f839f0a1d418f82c0b.png)

使用工具栏可执行以下操作：

- 为场景添加光源。
- 使用搜索栏过滤光源。
- 将关卡中的光源与光源混合器同步。
- 切换光源混合器选项。
- 管理光源集合。

### 同步选择

**同步选择（Sync Selection）** 切换开关可将光源混合器中的光源选择行为与大纲视图中的选择行为同步。

![Light Mixer Toolbar Sync Selection button](../../../../../assets/images/52/52f17c6ddde6901587278ff4b7889c9d35773b5e1f96882bdc4a4e82a27522a9.png)

如果已启用此选项，点击光源混合器列表中的项也会选择大纲视图中的相同项。

可以使用 **Alt + 点击** 的方式仅在光源混合器列表中选择所需的项，而不在大纲视图中选择相应的项。

如果已禁用此选项，则除非在光源混合器中按住 **Alt** 键的同时点击光源，否则选择行为将不会同步。

### 设置菜单

光源混合器的 **设置（Settings）** 菜单包含一些用于配置列表视图的选项，以及一条用于强制重建场景光源列表的命令。

![Light Mixer Panel toolbar setting menu](../../../../../assets/images/89/89a728ba2a021733ca2a44783dfbec2c86e87abd0898de0c47171bea7db2d1c5.png)

**设置（Settings）** 菜单包含以下选项：

![Light Mixer settings dropdown menu options.](../../../../../assets/images/3a/3a4abe9bcd22cc02bd716baf31085a0840237e4718ccd8e2e16e79102716931e.png)

- 列表视图选项（List View Options）

  ，切换文件夹在"光源混合器（Light Mixer）"面板中是否可见。
- 打开通用对象混合器实例（Open Generic Object Mixer Instance）

  ，打开一个空白面板以用于开发目的。 此基础工具集用于构建类似于"光源混合器（Light Mixer）"和"环境光源混合器（Environment Light Mixer）"面板的面板，这些面板包含若干可在单个位置编辑的不同对象。
- 重建列表（Rebuild List）

  强制"光源混合器（Light Mixer）"面板重新评估整个场景中的光源，并在列表未按预期更新时更新光源。 此功能类似于光源混合器的强制刷新。

## 管理光源

使用 **光源混合器（Light Mixer）** 面板可以管理和编辑场景中的光源。

### 过滤光源

使用"光源混合器（Light Mixer）"面板顶部的 **搜索过滤器（Search Filter）** 可以按名称过滤光源或对象。

![Light Mixer Search Filter](../../../../../assets/images/24/24882165e6068586193251a4d3216687e95b3e24e9fbd56556b1f6c620b71f03.png)

> [!TIP]
> 对于包含大量光源的大型场景，使用搜索功能来过滤光源可以加快工作流程。

### 选择多个光源

可以使用以下快捷键选择一个或多个光源：

- 按住

  Ctrl

  并点击所需的光源来单独选择光源。
- 点击一个光源，然后按住

  Shift

  在列表中选择另一个光源，可以选择成组的光源。 第一次点击和最后一次点击之间的所有对象将作为一个组。

也可以采用相同的方式取消选择各个光源或光源组。

### 编辑多个光源

通过一次选择多个光源，可从"光源混合器（Light Mixer）"面板中更改这些光源的共享属性的值，而无需单独更新每个光源。 同时编辑多个光源的属性可以加快场景光照和编辑操作的工作流程。 此外，还能够隔离光源并更改光源可视性以便处理关卡的区域。

### 光源可视性

切换可视性（或称为"静默"）将以非破坏性方式关闭和开启光源。 点击 **眼睛** 图标即可切换选定的一个或多个光源的可视性。

### 隔离光源

有一个选项（即 **单独（Solo）** 选项）可以隔离任何选定的一个或多个光源，以便只有选定光源可见。这样，就可以通过非破坏性的方式快速查看场景中一个或多个光源带来的光照影响。 可以单独隔离各个光源，也可以通过隔离父对象或文件夹来隔离一组光源。

点击 **耳机** 列下的 **短横线 ( - )** 图标可切换场景中所有未选定光源的 **Visibility（可视性）** 标记。 当光源设置为"单独（Solo）"时，短横线将替换为耳机图标。 点击设置为 **单独（Solo）** 的光源旁边的 **耳机** 图标将重新启用场景中所有其他光源的可视性。

### 添加光源

使用 **添加（Add）** 按钮可以向场景中添加定向光源、聚光源、点光源或矩形区域光源，然后可以点击这些光源并拖动到所需位置。

![Light Mixer toolbar Add lights dropdown selection.](../../../../../assets/images/b7/b7408651748ae63e81b3494ece0d75b0e4e1ec394c5048dc5aac90bed9f2fc02.png)

或者，可以将任意一种光源类型直接从菜单拖动到场景中进行放置。

## 光源上下文菜单

右键点击 **上下文菜单（Context Menu）** 的外观和工作方式与大纲视图中使用的上下文菜单类似。

> 图片已省略：Light Mixer panel component context menu.

> [!NOTE]
> 上下文菜单提供的另一个选项是 **选择或添加集合（Select or Add Collection）**，请在下面的[光源集合](#%E5%85%89%E6%BA%90%E9%9B%86%E5%90%88)小节中阅读其相关信息。

### 编辑选项

使用 **编辑（Edit）** 菜单可以对光源执行 **剪切（Cut）**、**复制（Copy）**、**粘贴（Paste）**、**复制（Duplicate）**、**删除（Delete）** 和 **重命名（Rename）** 操作。 或者，也可以使用快捷键（如Ctrl+X、Ctrl+V等）代替菜单选项。

### 替换光源

使用 **将选定的Actor替换为（Replace Selected Actors With）** 选项可以将选定的光源替换为另一光源。 甚至可以将它们替换为列表中其他不是光源的Actor。 列表中的所有Actor都必须至少有一个光源作为子组件。

### 重新设置光源的父项

有两种方法可以重新设置一个或多个光源的父项：

- 拖放方法

  - 选择要重新设置父项的光源，然后将这些光源拖到要作为父项的对象上。
- 附加到方法

  1. 选择要重新设置父项的光源。
  2. 右键点击选定的光源，然后从上下文菜单中选择

     附加到（Attach To）

     。
  3. 从列表中选择一个Actor以作为选定光源的父项。

## 光源集合

通过[集合](../../../../understanding-the-basics/content-browser/filters-and-collections/index.md#%E9%9B%86%E5%90%88)可以将资产进行分组以形成非破坏性的用户定义的集。 在"光源混合器（Light Mixer）"面板中，可以使用这一相同的工作流程来创建光源集合，通过组织和隔离经常更改的光源以方便访问，因此可以加快光照工作流程。

场景中的所有光源自动属于名为 **全部（All）** 的默认光源集合。 只有在创建另一个集合之后，才会显示这个特定集合类目。

### 创建光源集合

使用"光源混合器（Light Mixer）"面板中的右键点击 **上下文菜单** 可以创建光源集合。

1. 在

   光源混合器（Light Mixer）

   面板中选择一个或多个光源。
2. 右键点击选定的光源以打开

   上下文菜单

   。
3. 点击

   选择或添加集合（Select or Add Collection）

   。
4. 在文本字段中，为集合指定一个

   名称

   ，然后按

   Enter

   进行确认。

新建的光源集合将显示在"搜索过滤器（Search Filter）"和"光源混合器（Light Mixer）"面板列之间。 可以创建任意数量的光源集合来帮助管理场景，此数量没有限制。

> 图片已省略：Light Mixer Light Collections

### 查看光源集合

通过在搜索栏下的 **集合** 栏中点击某个光源集合的名称可以查看这个光源集合。 点击一个集合仅显示属于这个集合的光源和组件。 **全部（All）** 集合会将所有光源恢复到"光源混合器（Light Mixer）"面板。

### 向光源集合中添加光源

使用右键点击 **上下文菜单** 可以向光源集合中添加光源。 此工作流程与创建集合的工作流程大致相同，不同之处在于可以从现有光源集合列表中选择要添加的光源，而不是创建新集合。

打开 **选择或添加集合（Select or Add Collection）** 旁边的 **上下文菜单**，在文本字段下的列表中找到需要添加光源的现有光源集合，然后选中该集合旁边的复选框以向其中添加光源。

光源可以属于多个光源集合。 你可以根据需要创建任意数量的集合，并且相同的光源可以属于其中的任意集合。

### 从光源集合中删除光源

使用右键点击 **上下文菜单** 可以从光源集合中删除光源。 此工作流程与创建集合的工作流程大致相同，不同之处在于需要更改光源所属集合的选中状态。

打开 **选择或添加集合（Select or Add Collection）** 旁边的 **上下文菜单**，在文本字段下取消选中任何光源集合即可从这些集合中删除选定的光源。

### 删除、复制和重命名光源集合

右键点击任何光源集合的选项卡可以对该集合执行 **删除（Delete）**、**复制（Duplicate）** 或 **重命名（Rename）** 操作。

> 图片已省略：Light Mixer light collection right-click options to delete, duplicate, and rename.

> [!NOTE]
> **全部（All）** 光源集合是唯一无法删除、复制和重命名的集合。 右键点击该集合不会显示这些选项。

### 对光源集合重新排序

光源集合的重新排序方法是左键点击光源集合并将其拖动到新位置。

> [!NOTE]
> **全部（All）** 光源集合是唯一无法重新排序的集合。

## 自定义光源混合器

光源混合器提供一个需要在面板中显示的可自定义的光源属性列表。 你可以根据自己工作流程的需求添加和删除光源属性，显示最重要的光源信息和最常进行编辑的选项。

> 图片已省略：Light Mixer panel overflow menu to add user-editable light attribute columns.

可添加到"光源混合器（Light Mixer）"面板的可选光源属性。

### 添加和删除光源属性

属性列中列出了一些光源属性以方便快速访问，无需在"细节（Details）"面板和"光源混合器（Light Mixer）"面板之间来回切换。

添加和删除光源属性的方法是将鼠标移动到任何 **列** 标题上并点击 **溢出菜单** 图标（看起来像竖三点），这将打开用户可编辑的光源属性的列表。 你可以在属性列表中执行以下操作：

- 通过启用光源属性旁边的复选框，为选定的属性

  添加

  相应的列。
- 通过在启用了复选框的光源属性旁边禁用该复选框，为选定的属性

  删除

  相应的列。
- 通过在属性列表打开时开始键入属性的名称来

  搜索

  特定属性。 一个搜索过滤器将会替换菜单，然后仅显示与搜索词匹配的结果。

> [!NOTE]
> 目前，将任何属性列添加到"光源混合器（Light Mixer）"面板时，都会根据列在列表中的显示顺序添加列。 后续版本将允许配置列的位置。

## 光源作为组件

光源混合器可以列出并显示用作场景中其他Actor和蓝图的组件的光源。 你可以像编辑场景中的任何其他光源一样编辑这些其他Actor和蓝图中包含的光源，但不能在"光源混合器（Light Mixer）"面板中移动这些光源或重新设置它们的父项。

### 其他Actor内包含的光源

使用关卡的"细节（Details）"面板可以将光源作为组件添加到场景Actor。 这些光源将作为组件与它们的父Actor一起列在"光源混合器（Light Mixer）"面板中。

> 图片已省略：Scene Actor example with two Light Components being viewed in the Outliner and the Light Mixer.

以下是场景中具有两个点光源组件的Actor。

> 图片已省略：Scene Actor with two Light Components viewed in the Level's Details panel.

光源混合器可以识别出此Actor有两个光源组件，并在"光源混合器（Light Mixer）"面板中列出这些光源以及它们所属的Actor。

> 图片已省略：Scene Actor with two Light Components viewed in the Light Mixer's list of lights as individual editable line entries.

如果Actor只有一个光源作为组件，它将折叠成一个可编辑的行。

> 图片已省略：Scene Actor with a single Light Component viewed in the Light mixer's list of lights as a single editable line entry.

### 蓝图内包含的光源

作为组件包含在蓝图Actor中的光源会在光源混合器中列出。 你也可以点击蓝图，直接在蓝图编辑器中将其打开进行编辑。

> 图片已省略：Blueprint Asset example with two Light Components being viewed in the Level's Details panel and the Light Mixer.

以下蓝图中有两个点光源作为静态网格体组件的子组件。

> 图片已省略：Blueprint Editor showing a component with two Light Components.

将此蓝图添加到关卡时，光源混合器会识别出蓝图中包含光源组件，并在"光源混合器（Light Mixer）"面板中列出这些光源。

> 图片已省略：Blueprint with two Light Components viewed in the Light Mixer's list of lights as individual editable line entries.

如果蓝图只包含一个光源，它将折叠成一个可编辑的行。

> 图片已省略：Blueprint with a single Light Component viewed in the Light mixer's list of lights as a single editable line entry.
