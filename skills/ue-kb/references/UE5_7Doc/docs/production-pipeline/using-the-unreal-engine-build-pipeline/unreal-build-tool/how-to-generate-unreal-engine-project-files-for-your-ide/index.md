---
title: "IDE的项目文件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-generate-unreal-engine-project-files-for-your-ide"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "虚幻编译工具", "IDE的项目文件"]
---

# IDE的项目文件

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 虚幻编译工具 / IDE的项目文件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-generate-unreal-engine-project-files-for-your-ide

> [!NOTE]
> 以下指南适用于从源代码下载并编译虚幻引擎的用户，该代码已在GitHub上提供。 如需详细信息，请参阅[下载虚幻引擎源代码](https://dev.epicgames.com/documentation/assets/programming-and-scripting/development-environment-setup/downloading-unreal-engine-source-code)

下载最新版**虚幻引擎（UE）**代码后，你可能会注意到其中并未包含针对编译和运行引擎或游戏示例的**Visual Studio（VS）**或**Xcode**项目文件。 您需要运行一个脚本，它将生成可供加载的项目文件：

- 运行位于虚幻引擎根目录中的`GenerateProjectFiles.bat`文件。
- 项目生成器工具将分析模块和目标编译文件，并生成新的项目文件。 这可能需要一段时间才能完成。

对于VS开发者而言，此操作将在同一目录中生成一个`UE5.sln`文件。 您将使用此解决方案文件来编译和运行UE游戏和程序。 首次编译时，我们建议使用Win64平台的开发配置进行编译。

默认情况下，我们将针对检测到SDK的所有可用平台生成可编译项目，以便您还能够编译和调试控制台和移动平台。 若只想针对当前运行平台（如Windows）生成项目，请使用`-CurrentPlatform`参数运行`GenerateProjectFiles.bat`。 项目文件容量会相对更小。

> [!WARNING]
> 从源码管理同步新的代码修改后，务必重新运行`GenerateProjectFiles.bat`。 如忘记此操作，编译或运行游戏时可能会出错。

若对模块进行了添加或删除源文件等本地修改，则需重新运行`GenerateProjectFiles.bat`。 不建议手动更改项目文件。

## 命令行选项

项目生成器拥有部分可选命令行参数，如有需要可以使用这些参数来自定义已生成项目文件，以更好地匹配用户需求。 通常不需要、也不推荐使用这些选项。

| 选项 | 说明 |
| --- | --- |
| `-CurrentPlatform` | 只生成当前桌面平台（Windows或Mac）的可编译项目，而非所有检测到的可用目标平台。 |
| `-2022` | 以VS 2022原生格式生成项目。 设置此项后，将使用Visual C+2022编译器进行编译。 |
| `-ThirdParty` | 将标头和其他文件从第三方库中添加至项目。 举例而言，如希望在如PhysX、Steamworks或Bink等的Visual Assist中查看符号和文件，此操作将十分实用。 但它会增加项目文件的加载时间！ |
| `GAME_NAME -Game` | 要求项目生成器生成仅包含指定项目名称的代码和内容的项目（不包括其他所有已发现项目）。 同时必须指定项目名称。 例如`GenerateProjectFiles.bat ShooterGame.uproject -Game`将生成仅针对ShooterGame的源和目标的项目。 |
| `-NoIntelliSense` | 跳过生成用于在IDE中自动完成和错误波浪线提示的IntelliSense数据。 |
| `-AllLanguages` | 包括所有语言的引擎文档。 默认情况下项目中仅包含英文文件。 |
| `-OnlyPublic` | 指定后，引擎模块的已生成项目只仅会包含公开头文件。 引擎模块默认包含所有源文件。 此操作可缩短项目的加载时间，但导航引擎代码可能会变得更难。 |
| `-NoShippingConfigs` | 在已生成项目中省略`Shipping`和`Test`编译配置。 这将减少需要处理的目标配置的数量。 |
| `-Platforms=PLATFORM_1+PLATFORM_2+...` | 覆盖生成可编译项目所针对的默认平台集，转而生成指定平台的项目。 可利用"+"字符进行分隔，指定多个平台。 此操作同时会使用包含平台名称的后缀来命名生成的解决方案文件。 |

## 其他信息

`GenerateProjectFiles.bat`脚本是一款围绕虚幻引擎编译工具而设计的简单封装程序。它会以一种特殊的模式启动以编译项目文件，而非编译程序的可执行文件。 它会使用`-ProjectFiles`命令行选项调用虚幻编译工具。

UE编译系统实际上不需要项目文件来编译代码。 虚幻编译工具始终使用模块和目标编译文件来寻找源文件。 因此，添加新的源文件并触发编译时，即使项目文件未被刷新，新的源文件也可能被包含在编译中。

针对VS项目生成的解决方案文件为`UE5.sln`，其保存位置为虚幻引擎根目录。 但项目文件的保存位置为`UNREAL_ENGINE_ROOT/Engine/Intermediate/ProjectFiles/`目录。 可安全地随时删除这些文件并重新生成项目，但如进行删除，可能会丢失部分项目特定的偏好（如命令行参数字符串）。

### 生成项目文件的优点

当然是有利也有弊，以下是我们决定生成UE项目文件的主要原因：

- 虚幻引擎被设计为可支持多种平台，但不同团队可能仅会专注于为某些特定的平台展开工作。 生成项目文件后，可省略不相关的特定平台文件和编译配置。
- 虚幻引擎的编程方法由多个子模块组成，为方便程序员添加新模块，我们将其设计得尽可能简单。
- 项目生成器会给出高度精确的定义，并包含了你在使用虚幻引擎代码时VS IntelliSense所用的路径。
- 自动生成项目文件让设置新项目变得更加容易。
- 我们希望能支持多种平台和开发环境（如VS和Xcode）。 手动维护多个项目文件集容易出错，且极为枯燥。
- 我们希望让程序员可以生成高度自定义的项目文件。
- 源文件的目录结构会在项目文件解决方案层级中自动镜像。 在浏览源文件时此操作十分便利，但手动创作的项目将变得难以维护。
- 虚幻引擎编译配置非常复杂，且难以手动维护。 对开发人员而言，项目生成器将它变得几乎一目了然。

### 使用生成项目文件添加的其他文件

除C++模块的源代码外，我们还将其他多个文件自动添加到生成的项目中。 这是便于在搜索时寻找此类文件。 以下是添加到已生成项目中的其他文件的部分范例：

- 着色器源代码（`*.usf`文件）
- 引擎文档文件（`*.udn`文件）
- 程序配置文件（`*.ini`文件）
- 本地化文件（`*.int`文件）
- 程序源文件和清单（`*.rc`、.manifest）
- 特定的外部（非生成）项目文件（如UnrealBuildTool、Clean）

### 项目文件和源代码管理

项目文件不会被签入源代码管理。 将源码管理冲突合并到项目文件中既繁琐、又容易出错。 新系统将项目文件视为纯中间物，从而完全避免了这种情况。 另外，对开发不同游戏项目的各个团队而言，解决方案文件并不相同。 如不进行修改，Epic使用的项目文件对其他团队可能并无用处。

### 调试项目生成器代码

以下技巧有助于你调试对项目生成代码所做的改动：

- 将启动项目更改为虚幻编译工具（UnrealBuildTool）。
- 将用于调试的命令行参数设为`-ProjectFiles`。
- 将工作目录设置为本地路径`UNREAL_ENGINE_ROOT/Engine/Source/`。
- 正常编译和调试。

注意，项目生成器在你使用VS进行工作时可能会删除你正在使用的项目文件。 因此，有时将虚幻编译工具项目直接加载到VS中，而不通过常规UE解决方案文件进行调试将十分实用。

### 编译多个配置

你可以使用VS中的**批量编译（Batch Build）**功能。 该功能位于**编译（Build）**菜单下。 选择所有要编译的配置并点击**编译（Build）**即可。

### 与UnrealVS扩展集成

针对VS的[UnrealVS扩展](../../../../cpp-programming/setting-up-your-development-environment-for-cplusplus/setting-up-visual-st-61f67f0f/using-the-unrealvs-extension-for-unreal-engine-892ac6f8/index.md)中有一个工具栏按钮，点击该按钮即可为当前加载的解决方案重新生成项目文件。

你还可以为此功能绑定快捷键。 方法是转到VS，打开**工具（Tools） > 选项（Options） > 环境（Environment） > 键盘（Keyboard）**，然后搜索UnrealVS.RefreshProjects。

请注意，此功能只有在加载了解决方案后才会被启用（因为该工具需要知道要为哪个代码分支生成项目）。 如果你还未生成过`UE5.sln`文件，需要先直接运行`GenerateProjectFiles.bat`脚本。
