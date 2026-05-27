---
title: "使用Python脚本化运行虚幻编辑器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/scripting-the-unreal-editor-using-python"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "使用Python脚本化运行虚幻编辑器"]
---

# 使用Python脚本化运行虚幻编辑器

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 使用Python脚本化运行虚幻编辑器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/scripting-the-unreal-editor-using-python

本页面介绍如何开始在虚幻编辑器中使用Python。

## 为何使用Python？

近年来，Python事实上已成为用于制作流程和3D应用程序之间的互操作性的首选语言，在媒体和娱乐行业中尤其流行。 这部分要归功于它能够支持各种各样的应用程序。 制作流程的复杂程度持续急剧上升，涉及到的应用程序的数量也在不断增多，拥有通用的脚本语言可以简化创建和维护大型资源管理系统的过程。

抛开这些外部原因，或与其他应用程序一起使用的需求，如果你希望在虚幻编辑器中自动化工作流程，Python也是绝佳的选择。 对于刚接触编程的人员来说，它相对比较容易入门，通过PySide等模块，它可以提供创建复杂而功能全面的用户界面的能力，而且它还向社区提供很多其他非常有用的免费模块，有助于降低你的工作难度。

通过在虚幻编辑器中使用Python，你可以：

- 打造可将虚幻编辑器与你在贵组织中使用的其他3D应用程序连接在一起的大型资产管理流程或工作流程。
- 在虚幻编辑器中使耗时的资产管理任务实现自动化。例如，为静态网格体生成细节级别（LOD）。
- 以程序化的方式在关卡中布置内容。
- 通过你自己用Python创建的UI控制虚幻编辑器。

## 将项目设置为使用Python

虚幻编辑器对Python的支持由**Python编辑器脚本插件（Python Editor Script Plugin）**提供。 需要先为当前项目启用该插件，然后才能在编辑器中运行Python脚本。

> [!NOTE]
> 当前，必须为每个项目分别启用该插件。

要启用该插件：

1. 打开项目，在主菜单中选择**编辑（Edit） > 插件（Plugins）**。
2. 在**插件（Plugins）**窗口中转到**脚本（Scripting）**分段。 在右侧面板中找到**Python编辑器脚本插件（Python Editor Script Plugin）**，然后勾选其**启用（Enabled）**复选框。

   ![启用Python编辑器脚本插件](../../../../assets/images/7d/7d52782324bdb66e5768706d3ef37cbc34d9fb2b4da58b5e60518b43e8689bc6.jpg)

   你还需要启用**编辑器脚本实用程序（Editor Scripting Utilities）**插件，它为许多常用的编辑器任务提供简化的API。 如需了解详情，请参阅[使编辑器的脚本与自动化](../index.md)。
3. 重启编辑器。

### Python 3.11.8

Python编辑器脚本插件（Python Editor Script Plugin）包含Python 3.11.8 的嵌入式版本。

这意味着无需在计算机上单独安装Python。

> [!TIP]
> 虚幻默认使用Python 3.11.8，因为它是当前[VFX参考平台](https://www.vfxplatform.com/)的重要组成部分。 如需使用别的Python版本，你可以在操作系统中将`UE_PYTHON_DIR`环境变量设置为指向要嵌入的安装程序，然后[从源代码重新编译虚幻引擎](../../../get-started/install/downloading-source-code/building-unreal-engine-from-source/index.md)。

## 在虚幻编辑器中运行Python代码的不同方式

可以使用多种不同的方式在虚幻编辑器中运行Python脚本，每一种方式都针对略微不同的使用场景而设计。 可以选择任何一种可满足你的需求的方式。

> [!NOTE]
> 不同于蓝图，Python环境仅**在虚幻编辑器中**可用，而当项目在虚幻引擎中以任何模式（包括"在编辑器中运行（Play In Editor）"、"独立游戏（Standalone Game）"、烘焙的可执行文件等）运行时不可用。 这意味着可以在脚本化和自动化编辑器或构建资源制作流程时自由使用Python，但当前无法将其作为游戏性脚本语言使用。

### 输出日志中的Python控制台

可以将虚幻编辑器的控制台输入栏切换为接受Python代码而非虚幻控制台命令。

![Python控制台](../../../../assets/images/58/58c5b7ddd8c28c8d61595077ea9557752a4623d25a1450d5218cf263a9a43fd7.jpg)

如上图所示，你可以在**输出日志（Output Log）**面板中执行此操作，或者在按`~`键调出控制台输入栏时执行此操作。

当控制台处于Python模式时：

- 你可以在该控制台中输入多行Python代码，并让编辑器立即执行每一行代码，其效果与在命令窗口中使用交互式Python控制台完全相同。 这是逐行执行Python代码的唯一方式；以下列出的所有其他方法运行的都是指定的脚本文件。
- 要一次运行多行代码，使用**Shift+Enter**分隔各行代码即可，或者粘贴从文本编辑器复制的多行代码块。
- 在控制台中输入文件名即可执行Python脚本文件。 如果你的Python脚本需要额外的命令行参数，请将它们添加在脚本名称后面。

> [!TIP]
> 内置的Python `print`函数的输出也将被重定向到**输出日志（Output Log）**面板中。

### py控制台命令

在Cmd模式下使用控制台时，你可以使用`py`命令将剩余的代码行作为Python代码运行，其效果和在上述的Python控制台中输入完全相同。

例如，该命令可运行指定的脚本文件：

命令行

C++

```
py "C:\MyScripts\my_script.py"
```

> [!NOTE]
> 不建议在启动编辑器时以`ExecCmd`命令行参数的值运行该命令。 这可能会导致脚本在编辑器环境就绪前就运行——例如，在启动关卡完全加载完之前。 请参阅下面的部分来了解更好的选项。

### 文件菜单

虚幻编辑器主窗口中的**文件（File）**菜单为你提供了运行Python脚本文件的新选项。

- 你可以使用**执行Python脚本（Execute Python Script）**功能来浏览计算机中尚未运行过的新脚本文件。
- 使用**最近使用的Python脚本（Recent Python scripts）**列表即可再次运行之前运行过的脚本。 将从磁盘重新读取文件，因此，如果在此期间你更改了脚本，将会运行新版本的脚本。

![从文件菜单执行Python](../../../../assets/images/5c/5ce63fa74e058667ba6b5303dcd9989742f9b95f6f781c427360f21cf22caa64.jpg)

### 命令行

如果从命令行或从脚本中启动虚幻编辑器，可以在命令行参数中指定Python脚本文件。 如果你的Python脚本需要额外的命令行参数，请将它们添加在脚本名称后面。

可以通过两种不同的方式从命令行中运行Python脚本。 在两种方法中，编辑器都会在运行完Python脚本后立即关闭。

**选项1：完整编辑器** 在该方法中，会启动完整虚幻编辑器，打开指定的项目，加载默认的启动关卡，然后在一切都加载就绪后立即运行Python脚本。 需要让脚本与项目中或关卡中加载用时可能较长的内容交互时，该方法非常有用。

在命令行中添加`ExecutePythonScript`参数，并将其值设置为要运行的Python脚本的路径和文件名。 例如：

命令行

C++

```
> UnrealEditor-Cmd.exe "C:\projects\MyProject.uproject" -ExecutePythonScript="c:\my_script.py"
```

> [!NOTE]
> 上述方法要求你为项目启用"编辑器脚本实用程序（Editor Scripting Utilities）"插件。 必须先在命令行中指定的虚幻引擎引擎项目中启用Python脚本插件。

**选项2：Commandlet** 该方法执行起来非常快，甚至无需打开编辑器界面，就可以在没有头文件的模式下运行脚本。

在命令行中为`UnrealEditor-Cmd.exe`添加参数：`-run=pythonscript -script=<script_file_or_code>`。 其中`<script_file_or_code>`可采用以下两种值：

- 要运行的Python脚本的路径和文件名。
- 要运行的Python语句和命令。 如有必要，可以在字符串中使用`\n`来转义换行符。

例如：

命令行

C++

```
> UnrealEditor-Cmd.exe "C:\projects\MyProject.uproject" -run=pythonscript -script="c:\\my_script.py"
```

或者：

命令行

C++

```
> UnrealEditor-Cmd.exe "C:\projects\MyProject.uproject" -run=pythonscript -script="a=5 \nb=10 \nc=a+b \nf=open('D:\myfile.txt','w+') \nf.write(str(c)) \nf.close()"
```

该命令行工具不会自动加载关卡，因此在编写脚本时，请记得先添加以下行：

命令行

C++

```
unreal.get_editor_subsystem(unreal.LevelEditorSubsystem).load_level("/Game/maps/UVlayoutTest.UVlayoutTest")
```

> [!NOTE]
> 必须先在命令行中指定的虚幻引擎引擎项目中启用Python脚本插件。

### init_unreal.py文件

如果编辑器在任何配置使用的路径中检测到名称为`init_unreal.py`的脚本文件（详见下文的"虚幻编辑器中的Python路径"），编辑器会立即自动运行该脚本。

如果你参与了一个项目或插件的开发工作，且知道使用该内容的每个人都需要在每次编辑器启动时运行相同的初始化代码，该方法非常有效。 你可以将初始化代码放在使用该名称的脚本中，并将脚本放在该项目或插件的**Content/Python**文件夹中。

### 启动脚本

在"项目设置（Project Settings）"中，你可以指定任意数量的Python脚本以让其在每次你打开该项目时运行。 编辑器会在默认启动关卡完全加载之后运行这些脚本。

选择**编辑（Edit） > 项目设置...（Project Settings...）**。 在**插件（Plugins）**列表下，选择**Python**。 然后，将脚本添加到**启动脚本（Startup scripts）**设置中：

![Python启动脚本](../../../../assets/images/f9/f900ef4ac0bbad455c673abb35a88a723f47efb000d44e425e2f8f917a5694ad.jpg)

完成后请重启虚幻编辑器。 下一次编辑器加载项目时，会运行新的启动脚本。

### 从纯编辑器蓝图

Python脚本插件向蓝图可视化脚本公开新节点，你可以在评估蓝图图表期间使用该脚本运行Python代码片段或文件。

> [!NOTE]
> Python执行节点仅在纯编辑器蓝图类（例如编辑器工具控件和编辑器工具蓝图）中可用。 请参阅[使用蓝图编写编辑器脚本](../scripting-the-unreal-editor-using-blueprints/index.md)。 你无法在运行时可用的蓝图类（例如直接从**Actor**所派生的类）中使用此方法。

你会在蓝图控制板的**Python > 执行（Execution）**分段下找到以下节点。

|  |  |  |
| --- | --- | --- |
| [Execute Python Script](https://dev.epicgames.com/community/api/documentation/image/514724f3-f3e8-4f3d-b7f1-dcc1c8bd4fc4?resizing_type=fit) | **Execute Python Script** | 执行你传入或键入到**Python命令（Python Command）**输入中的Python文本代码。 建议从蓝图调用Python，代替在Python中新建BlueprintFunctionLibrary（BPFL）类型。由于Python生成的类型（Python-generated types）是瞬时的，所以当保存或加载资产时，上述BPFL方法会引起问题，因此官方不再支持。**Execute Python Script**可以使用自定义的输入输出引脚，这些引脚可在节点上的Python脚本中作为变量使用，并可以通过节点属性来添加。-输入会在运行**Python脚本**前被设置在节点上，且可在脚本中读取。 -输出会在运行**Python脚本**后在节点上被读取，且可以在脚本中设置。**Execute Python Script**可以包含多行Python代码。使用**Shift+Return**即可输入新行。如果Python代码执行成功，则**Success?**输出true，否则输出false。 如果为false，你可以在**输出日志**中找到相关错误。此节点无法运行文件。 它只能执行Python代码行。 |
| [Execute Python Command](https://dev.epicgames.com/community/api/documentation/image/ecbe020d-6682-4ba0-9bd0-524592c1c03b?resizing_type=fit) | **Execute Python Command** | 执行你传入或键入到**Python脚本（Python Script）**输入中的Python文本代码。 节点将尝试根据输入确定它是文字代码还是文件名。-若Python代码或文件成功执行，则**返回值（Return Value）**输出true，否则输出false。 如果为false，你可以在**输出日志**中找到相关错误。 |
| [Execute Python Command Advanced](https://dev.epicgames.com/community/api/documentation/image/b21104b0-ec61-4a95-aaaa-7434f07701bd?resizing_type=fit) | **Execute Python Command (Advanced)** | 执行你传入或键入到**Python脚本（Python Script）**输入中的Python文本代码。 此节点类似于**Execute Python Command**节点，但提供了一些在某些场景中可能大有帮助的额外输入和输出。**执行模式（Execution Mode）**表示你希望以何种方式解译**Python脚本（Python Script）**输入。选择**执行文件（Execute File）**以强制命令将输入视为文件名，然后尝试查找并运行该文件。 该脚本返回的任何值都将打印到日志中。选择**执行脚本（Execute Script）**以强制命令将输入视为Python文本代码，并按原样执行。 该脚本返回的任何值都将打印到日志中。选择**求值脚本（Evaluate Script）**以强制命令将输入视为Python文本代码，按原样求值，然后在**命令结果（Command Result）**输出中返回脚本所生成的任何值。如果你将文件名传递给**Python脚本（Python Script）**输入，则**文件执行作用域（File Execution Scope）**将决定该文件是在全局作用域（**公共 (Public)**）中还是在沙盒作用域（**私有 (Private)**）中执行。 如果你希望文件中的代码能够访问已在Python环境中定义的变量和函数等，则需要选择**公共（Public）**。 但是，这样做也会使Python文件能够重新定义变量和函数。 这可能会偶然地导致意外行为。 因此，使用**私有（Private）**作用域可能会更安全。**命令结果（Command Result）**输出取决于**执行模式（Execution Mode）**。 当**Python脚本（Python Script）**输入被成功执行或求值，且**执行模式（Execution Mode）**为**求值脚本（Evaluate Script）**时，此输出将返回脚本生成的值。 当**Python脚本（Python Script）**输入被成功执行或求值，且**执行模式（Execution Mode）**为**求值文件（Evaluate File）**或**执行脚本（Execute Script）**时，此输出将返回`None`。 当**Python脚本（Python Script）**输入*未*被成功执行或求值时，此输出将包含错误信息。**日志输出（Log Output）**会提供执行输入脚本或文件期间写入Python日志的消息完整列表的访问权限。 如果你需要查找脚本编写的特定消息，则可以循环访问此数组。若Python代码成功执行，则**返回值（Return Value）**输出true，否则输出false。 若为false，你可以在引擎的**输出日志（Output Log）**、**日志输出（Log Output）**的输出引脚以及**命令结果（Command Result）**中找到相关错误。 |

## 虚幻编辑器中的Python环境和路径

当你使用相对路径运行Python脚本时，或在脚本中使用`import`命令导入另一个脚本模块时，运行或导入的脚本可以位于Python环境的`sys.path`变量中列出的任意路径中。

虚幻编辑器会自动向该`sys.path`列表添加多条路径：

- 项目文件夹下的**Content/Python**子文件夹。
- 主虚幻引擎安装文件夹的**Content/Python**子文件夹。
- 各个已启用插件的文件夹下的**Content/Python**子文件夹。
- 用户目录中的**Documents/UnrealEngine/Python**文件夹。 例如，在Windows 10中，该路径是`C:/Users/Username/Documents/UnrealEngine/Python`

也可以使用下述的任何一种方法将自己的路径添加到该列表中：

- 转到项目设置（Project Settings）。 选择**编辑（Edit） > 项目设置...（Project Settings...）**。 在**插件（Plugins）**列表下，选择**Python**。 然后将路径添加到**其他路径（Additional Paths）**设置中。 完成后请重启虚幻编辑器。

  ![额外的Python路径](../../../../assets/images/2d/2d8772c19172619a18853528dbc5a1b81665b5401d9b205b2e27cec255160139.jpg)
- 将这些路径添加到操作系统的`UE_PYTHONPATH`（如果你禁用了编辑器隔离解译器环境选项，则是`PYTHONPATH`）环境变量的值中，然后重新启动虚幻编辑器。
- 在Python脚本中或在Python控制台中直接将路径添加到`sys.path`列表中。

如需了解详情，请参阅[Python sys.path文档](https://docs.python.org/3/library/sys.html#sys.path)

默认情况下，虚幻引擎的嵌入式Python解释器会在隔离模式下运行。 选择**编辑（Edit） > 项目设置（Project Settings） > 插件（Plugins） > Python > 隔离解译器环境（Isolate Interpreter Environment）**即可禁用隔离模式

如需了解详情，请参阅[Python命令行 -I选项文档](https://docs.python.org/3/using/cmdline.html)

![隔离解译器环境](../../../../assets/images/7d/7d844869f6efe128c1b4961d1872a52483381f2b265b1de17cef5784334aec79.jpg)

无论选择何种隔离模式，**UE_PYTHONPATH**环境变量总是会被引擎解析，其内容也会被添加到`sys.path`中。 *UE_PYTHONPATH*的作用与*PYTHONPATH*变量相同，但它不应被任何第三方软件修改。

## 关于虚幻编辑器Python API

Python编辑器脚本插件（Python Editor Script Plugin）公开了各种各样的类和函数，你可以使用它们与虚幻编辑器、项目中的资源和关卡中的内容交互。 该API全部包含在`unreal`模块中。 要访问它，请在你在编辑器的Python环境中运行的任何Python脚本的开始位置导入该模块：

C++

```
import unreal
```

`unreal`模块几乎会公开在编辑器环境中从C++公开给蓝图的一切内容。 它不是预生成的，它可以自动反映在编辑器的蓝图中可用的一切。 在虚幻编辑器中启用新的插件时，被插件公开给蓝图的一切在Python中也会变得可用。 任何在项目中编写并公开给蓝图的C++代码也是如此。

Python API力求以对Python开发者尽可能友好的方式公开本地虚幻API。 例如：

- 必要时，简单数据类型可以透明地在Python和本机类型之间来回转换。 传入Python列表、集或字典时，会自动将它转换为虚幻数组、集或贴图。 检索API函数返回的列表、集或字典时，实际上是在获取虚幻类的实例，但其API与基础Python列表、集或字典类型完全一致。
- Python类保留与其表示的本地类型相同的继承层级。 这意味着你可以使用内置的Python函数`isinstance()`和`type()`来测试某个对象是否派生自某给定的类或与某给定的类匹配。
- 该API会尝试在虚幻中用于C++及蓝图的命名规范和Python的命名规范之间取得平衡。 Python API中的类和对象具有和在蓝图中相同的名称。 这通常和其原生类型相同，省略了前缀（例如 `U`或`T`）。 函数和属性名称会自动以小写的`snake_case`格式公开。 例如，你通常会调用诸如`unreal.StaticMeshActor.get_actor_transform()`之类的函数。 枚举值名称会自动以大写的`SNAKE_CASE`格式公开。
- 所有公开的函数都可以接受有序参数和采用任意顺序的命名参数。 例如，以下两个函数调用完全等效：

  C++

  ```
  unreal.get_editor_subsystem(unreal.StaticMeshEditorSubsystem).join_static_mesh_actors(list_of_actors, my_options)    unreal.get_editor_subsystem(unreal.StaticMeshEditorSubsystem).join_static_mesh_actors(join_options=my_options, actors_to_join=list_of_actors)
  ```

### API参考

有关虚幻Python API公开的所有类和函数的详细信息，请参阅位于此处的API参考：

[**虚幻编辑器Python API参考**](https://api.unrealengine.com/INT/PythonAPI/)

> [!NOTE]
> API参考并未详尽列出可能由插件公开给Python的一切。 如果安装了该API参考中未包含的其他插件，并且需要查看其脚本功能公开给Python的方式，可以生成你自己的包含所需插件的文档的本地版本的API参考。 如需了解相关指导说明，请参阅虚幻引擎安装文件夹中*Engine\Plugins\Experimental\PythonScriptPlugin\SphinxDocs*下的自述文件。

## 使用Python API的最佳实践

本部分将介绍使用Python API时需要谨记的重要事项。

### 使用资产

如果需要在项目中处理资源，请始终使用虚幻Python API中的函数来进行。 绝不要使用Python中内置的文件管理模块来直接处理磁盘上的资源文件。 例如，如果需要将资产移动到别的文件夹中，不要使用Python函数，如`os.rename`或`shutil.move`。 如果不遵守此规则，虚幻项目和资源中包含的内部内容引用可能会失效。

我们建议你使用编辑器脚本实用工具（Editor Scripting Utilities）插件提供的`unreal.EditorAssetLibrary`API，或虚幻Python API中内置的`unreal.AssetTools`类。

### 更改编辑器属性

可以使用Python来访问项目中的对象并以编程方式针对这些对象设置许多配置属性。 例如，Python脚本可以访问当前关卡中的静态网格体Actor，并设置Actor是否可以被破坏或它们是否应该在游戏中被隐藏等属性。 或者，可以检索其静态网格体组件并针对这些组件设置属性，例如其Lightmass设置，甚至它们链接到的静态网格体资源。

可以通过两种不同的方式将这些属性公开给Python：

- 标有"BlueprintReadOnly"或"BlueprintReadWrite"的项目将作为对象上的简单属性公开。 可以读取和修改这些属性，就像访问任何Python对象属性一样。
- 标有"ViewAnywhere"或"EditAnywhere"的项目将作为"编辑器属性"公开。 你可以使用各对象公开的一对特殊函数来读写这些值：`set_editor_property()`和`get_editor_property()`。

在各个类的API参考中，你可以在类说明之后找到**编辑器属性（Editor Properties）**的列表。 你可以使用`set_editor_property()`和`get_editor_property()`函数设置并获取所有相关值。 每当需要设置或获取某个对象的配置属性时，请先查看该列表以了解所需属性是否已在其中列出。

- 需要读取同时作为对象属性和编辑器属性而公开的值时，直接访问该属性的结果通常与调用`get_editor_property()`函数取得的结果相同。 但`get_editor_property()`函数通常还可以访问未直接在Python对象上公开的属性。
- 需要设置同时作为对象属性和编辑器属性公开的值时，在大部分情况下都应该使用`set_editor_property()`函数来设置该值，而非在对象上直接设置该值。 在UI中调整属性时，编辑器通常会于编辑更改前和编辑更改后在后台执行额外操作。 这些操作通常在某种程度上对你做出的选择作出反应，并且使编辑器UI与对象在游戏世界中的状态保持同步。 如果直接在Python对象上修改这些属性，编辑器代码不会自动运行。 另外，调用`set_editor_property()`设置属性的状态时，也会触发该编辑前和编辑后代码，就如同在编辑器UI的**细节（Details）**面板中更改了该设置。

例如，媒体播放器对象具有**打开时播放（Play on Open）**设置：

![细节](../../../../assets/images/c8/c88a81d202c2e15c17ff4d1acb0fb01f19e76bc870620b02929be7662be397a0.png)

这会在`unreal.MediaPlayer`类中的`play_on_open`类成员中公开：

C++

```
import unreal
		obj = unreal.MediaPlayer()
		# Modifying a property directly can have different results
		# than changing settings in the Editor UI.
		# Generally you'll want to avoid setting these values directly, like this:
		obj.play_on_open = True
		# This way of accessing the property will have exactly the same
		# result as changing the setting in the Editor UI:
		obj.set_editor_property("play_on_open", True)
		# Both ways of reading the value are equivalent.
```

### 尽可能使用虚幻类型

如果需要虚幻Python API提供的效用，如用于数学运算或操纵3D坐标的类，我们建议你使用虚幻实用程序而非使用你自己的实现。 我们对虚幻版本进行了优化，以确保引擎环境的最佳性能。

例如，需要在3D空间中操纵坐标时，请使用`unreal.Vector`类：

C++

```
import unreal    v1 = unreal.Vector()    v1.x = 10    v2 = unreal.Vector(10, 20, 30)    v3 = (v1 + v2) * 2    print(v3)
```

### 日志记录和反馈

`unreal`对象会通过所有引擎及编辑器子系统均使用的信息传递系统公开你可以在代码中用于发送日志、警告和错误消息的函数。 无论何时你需要让脚本向用户发送消息，我们都建议你使用该标准化的日志框架。

- 将`unreal.log()`用于信息性消息。 为方便起见，我们也实现了Python `print()`函数以在内部通过`unreal.log()`传递。
- 使用`unreal.log_warning()`来使用户注意到可能存在的问题。
- 将`unreal.log_error()`用于记录阻碍脚本按照预期运行的严重问题。

你的消息将与其他子系统发送的消息一起显示在**输出日志（Output Log）**面板中。

![Python日志消息](../../../../assets/images/35/35f969c250e922f0c23c8d26b20490b4914c2724d2284abfd6c66b49aea94dac.png)

### 支持撤销和重做

你的脚本可以充分利用虚幻编辑器中内置的撤销/重复系统。

你定义的每一条*事务（Transaction）*中都可以包含任意数量的Python操作。 使用这些事务，你可以将大型操作或多个不同对象上的操作捆绑为撤销/重复历史记录中的单个条目。 通常，如果你打算让脚本在多个对象上执行某特定更改，但是不希望每次更改都在撤销/重复历史记录中存在单独的条目，而是希望通过一个条目就可以撤销对所有对象所作的该更改。

要定义事务，请使用`unreal.ScopedEditorTransaction`作用域。 例如，如果你运行该代码：

C++

```
import unreal	obj = unreal.MediaPlayer()	with unreal.ScopedEditorTransaction("My Transaction Test") as trans:		obj.set_editor_property("play_on_open", False)		obj.set_editor_property("vertical_field_of_view", 80)
```

编辑器的**撤销历史记录（Undo History）**面板会立即按名称列出该事务：

> 图片已省略：撤销历史记录

作为一般规则，限定了范围的事务可以包含在编辑器UI中也无法撤销的任何操作。 但是，并非每个编辑器操作都是不可撤销的。 例如，你无法在编辑器UI中撤销模型导入，因此尝试在`unreal.ScopedEditorTransaction`中导入模型将无法产生预期的效果。

### 缓慢操作的进度对话

如果你的脚本需要在同一个操作中处理多个资源或Actor，可能需要较长的时间才能完成。 但是，当虚幻编辑器运行Python脚本时，其UI处于被封锁状态中，不允许其他的用户交互。 为了向用户提供大型任务的进度信息，从而避免编辑器让用户产生卡死或挂起的错觉，可以使用`unreal.ScopedSlowTask`作用域。

例如：

C++

```
import unreal
    total_frames = 100
    text_label = "Working!"
    with unreal.ScopedSlowTask(total_frames, text_label) as slow_task:
        slow_task.make_dialog(True)               # Makes the dialog visible, if it isn't already
        for i in range(total_frames):
            if slow_task.should_cancel():         # True if the user has pressed Cancel in the UI
                break
            slow_task.enter_progress_frame(1)     # Advance progress by one frame.
                                                # You can also update the dialog text in this call, if you want.
```

> 图片已省略：作用域内慢速任务的进度条
