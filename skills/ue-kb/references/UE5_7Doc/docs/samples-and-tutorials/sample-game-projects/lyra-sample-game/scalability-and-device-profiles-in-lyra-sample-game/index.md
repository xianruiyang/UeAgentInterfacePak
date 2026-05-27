---
title: "Lyra可扩展性和设备描述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/scalability-and-device-profiles-in-lyra-sample-game-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "Lyra可扩展性和设备描述"]
---

# Lyra可扩展性和设备描述

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / Lyra可扩展性和设备描述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/scalability-and-device-profiles-in-lyra-sample-game-for-unreal-engine

## 设置项目的可扩展性和设备描述

虚幻引擎提供了各种各样的 **可扩展性（Scalability）** 设置，可用于影响项目的性能和视觉质量。通常，引擎默认设置可以满足你的大部分需求，但你可能想更改这些设置，以提高性能或质量。项目可以在多个平台上启动，因此，可扩展性设置所需的值可能因平台而异。PC等平台的行为可包含五花八门的硬件，因此，不同的用户可能需要调整这些设置，从而在最大程度上匹配特定的系统。

## 可扩展性和设备设置系统

要实现可扩展性方面的目标，你可以组合使用多个引擎系统，以创建适用于所有平台和用户的项目配置文件配置。你将在下面找到此过程中涉及的不同引擎系统的解释。

## 控制台变量

大部分性能和质量设置在引擎中实现为[控制台变量](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/console-variables-cplusplus/index.md)（CVar）。这些是具名变量，用于存储数字、字符串或枚举值。控制台变量在源代码中设置了默认值，可以由特定于游戏的配置文件或下面所述的其他系统覆盖。 大部分变量可以在游戏正在运行时或从命令行进行设置，从而可以在将质量和性能设置提交到值之前进行预览。你可以点击工具栏，找到 **编辑（Edit）> 引擎（Engine）** **>数据驱动的控制台变量（Data Driven Cvar）> 控制台变量数组（CVars Array）** 并点击 **添加（Add）** （ **+** ）按钮，从而将数据驱动的控制台变量添加到项目中。

![项目设置控制台变量](../../../../../assets/images/39/39d0c85a885d32cb8e2f0fe280ee23e846586fcddddb6bf2d7c9ba31d05131b8.png)

上图中是位于项目设置中的数据驱动的控制台变量数组。

## 设备描述

引擎使用[设备描述](../../../../sharing-and-releasing-projects/tools-for-general-platform-support/setting-up-device-profiles/index.md)来定义可能运行项目的各种物理设备。你可以前往工具栏，点击 **工具（Tools）** > **仪表测量（Instrumentation）>** **平台（Platforms）** > **设备描述（Device Profiles）** 找到这些设置。

![平台设备描述](../../../../../assets/images/c6/c65a5140b48277783e80e3fb66cb8611a7d4cfb0b656efcc0fdcdcc402bface8.png)

例如，在默认引擎设置中，有一个基本"Android"设备描述，用于每个Android设备。

![Android设备描述](../../../../../assets/images/7a/7a70d477ef2057456884f053387a38135482233eef0907c46191d4fdba0e495c.png)

在设备描述设置中，你可以访问现有设备描述(1)，此外，你还可以在控制台变量列(2)中编辑你自己的控制台变量。

基本描述的下方是多个性能桶，例如"Android_High"，以及该描述下面的特定CPU/GPU类型。项目启动时，引擎将使用[可自定义的流程](../../../../mobile-development/android-support/packaging-and-publishing-android-projects/customizing-device-profiles-and-scalability-in-e75f27cc/index.md)来决定使用哪个特定设备描述，然后应用与该描述关联的设置，从顶级开始，例如"Android"，并使用其下面更具体的描述中设置的值进行覆盖。

## 可扩展性组

[可扩展性系统](https://dev.epicgames.com/documentation/404)用于定义可以在运行时选择的一组相关的性能设置。例如，引擎默认 **PostProcessQuality** 组定义了 **动态模糊（Motion Blur）** 和 **泛光（Bloom）** 的设置，并拆分为4个级别，范围从低（Low）到史诗（Epic），以及表示最高质量的电影（Cinematic）级。当项目或用户选择某个具体的可扩展性组质量级别时，将应用该质量级别中的所有控制台变量。

![引擎可扩展性设置](../../../../../assets/images/c1/c17513b51ba60e810bd29aac050417b8f6b30e66477a7b8def3d9f280b929022.png)

可扩展性组将先应用其控制台变量设置，然后再应用设备描述。具体的设备描述中定义的设置将覆盖用户所选可扩展性组中的设置。这意味着，设备描述可以先指定基本可扩展性组控制台变量，如 `sg.PostProcessQuality` ，然后再覆盖单独的设备。

你可以使用如下所述的一般平台配置覆盖系统，从而创建特定于平台的可扩展性组设置。但是，不能为具体的设备描述设置不同的可扩展性组。

> [!NOTE]
> 一般而言，可扩展性组在PC等开放平台上很有用，因为这些平台允许用户利用不同范围的PC硬件组件。

## 游戏用户设置

`UGameUserSettings` 类存储了各个用户可以从选项UI菜单更改的所有设置。用户的指定设置存储在运行你的项目的特定设备上的GameUserSettings.ini文件中。在限制文件访问的某些平台上，需要启用特定于平台的选项才能正确保存和加载游戏用户设置。默认引擎类将存储用户为每个可扩展性组所选的质量，以及窗口分辨率等特定设置。 许多项目可能需要使用特定于游戏的子类，具体方法是创建原生子类，然后修改GameUserSettings类名。这可以从 `DefaultEngine.ini` 文件完成，方法是找到[/Script/Engine.Engine]小节，或找到 **编辑（Edit）** > **项目设置（Project Settings）** > **引擎（Engine）** > **通用设置（General Settings）** > **默认类（Default Classes）** > **高级（Advanced）** > **游戏用户设置类（Game User Settings Class）** 。

![通用用户设置](../../../../../assets/images/32/3224ece7ba01106602d45e622fa38dfa3f97d70e2ff9e490fc2e0a236d136813.png)

在特定于游戏的设置类中，你可以添加新设置或更改在运行时应用设置的方式。特定游戏的默认值可以在游戏的 `DefaultGameUserSettings.ini` 文件中设置，该文件将用于所有新用户。游戏用户设置会向蓝图公开，并且包含很多实用的函数，这些函数可从基于蓝图的设置UI调用，或在源代码中调用。

例如，`RunHardwareBenchmark` 函数将运行自动化基准，以检测本地机器的相对CPU和GPU速度，并使用从 `PerfIndexThresholds` 开始的 `Scalability.ini` 设置来估算特定机器的最佳可扩展性组设置。然后，你可以调用 `ApplyHardwareBenchmarkResults` 以应用和保存设置。

## 纹理组设置

在编辑器中创建纹理时，你可以将纹理分配给不同的组，例如"World"或"UI"。这些组将指定在运行时应用哪些[纹理设置](../../../../designing-visuals-rendering-and-graphics/textures/texture-format-support-and-settings/index.md)。每个组针对大小上限、Mip级别以及纹理组设置了不同的设置，你可以针对特定设备描述进行自定义。打包时会考虑这些设置。你可以为移动设备版本设置较低的最大分辨率，安装包将仅包含可以在该设备上流送的Mip级别。纹理组设置不直接使用控制台变量，因为控制台变量无法运行时进行修改。

## 设置优先级

在应用设置之前，会从配置文件加载设置。核心[配置文件层级](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/configuration-files/index.md)用于决定将应用哪些设置。对于从配置文件加载但无法在运行时修改的所有设置，此优先级都很重要。对于使用控制台变量系统并且可以在运行时修改的设置，将按以下顺序应用，较高的数字覆盖较低的数字。此顺序在 `EConsoleVariableFlags` 枚举中定义：

| **优先级顺序（Priority Order）** | **标记（Flag）** | **说明（Description）** |
| --- | --- | --- |
| 1 | SetByConstructor | 控制台变量的构造函数中设置的默认值。 |
| 2 | SetByScalability | 可扩展性组质量级别设置的值。 |
| 3 | SetByGameSetting | 引擎的GameUserSettings设置的低优先级值。 |
| 4 | SetByProjectSetting | 从DefaultEngine.ini文件的[/Script/Engine.RendererSettings]等小节中设置ProjectSettings。 这些设置通常由位于编辑器中的项目设置（Project Settings）菜单进行设置。 |
| 5 | SetBySystemSettingsIni | `DefaultEngine.ini` 的[ConsoleVariables]和[SystemSettings]小节。 |
| 6 | SetByDeviceProfile | 从设备描述，其中更具体的描述覆盖更一般的描述。 |
| 7 | SetByGameOverride | 游戏的GameUserSettings子类设置的高优先级值，这应该用于需要覆盖设备描述的设置。 |
| 8 | SetByConsoleVariablesIni | 引擎 `ConsoleVariables.ini` 文件，主要用于开发中的测试。 |
| 9 | SetByCommandline | 由一些命令行选项使用。 |
| 10 | SetByCode | 由各种调试工具使用。 |
| 11 | SetByConsole | 最高优先级，通过在运行中游戏的控制台中输入"NameOfCVar Value"来设置 |

![优先级调用顺序](../../../../../assets/images/ef/ef02c32316ffc2721218df36068bd23339fe634bbf2d239f2b4ffc4c33a93429.jpg)

例如，此图中演示了引擎覆盖流程，从可扩展性组系统开始。首先，引擎将在引擎提供的 `BaseScalability.ini` 文件中检查[PostProcessing@2]类别（在UI中显示为高（High）），其中包含泛光的控制台变量（CVar）。

然后，引擎将检查这些设置是否已被特定于游戏的 `DefaultScalability.ini` 文件或诸如 `WindowsScalability.ini` 等特定于平台的文件中的类别[PostProcessing@2]覆盖。

接下来，引擎将从 `BaseEngine.ini 文件` 开始检查[SystemSettings]类别中指定的控制台变量。`DefaultEngine.ini` 或特定于平台的ini中的所有覆盖如以前一样进行应用。

调用顺序继续向下进入设备描述系统。首先，会运行[设备描述匹配规则](https://dev.epicgames.com/documentation/404)以决定应该应用的最低级别设备描述（在此案例中为Android Galaxy）。

接下来，它开始应用规则，首先应用与设备匹配的最高级别设备描述（Android）。它首先检查引擎提供的 `BaseDeviceProfiles.ini` 中的控制台变量，然后检查特定于游戏的 `DefaultDeviceProfiles.ini` 以查看是否覆盖了控制台变量。

此流程会沿层级继续向下，以类似于上述Android调用的流程检查AndroidMid和Android Galaxy设备描述设置。应用所有设备描述之后，将继续在上述的更高优先级别应用覆盖。

# 设置特定于游戏的覆盖

如果你想更改游戏的特定设置，则需要设置配置文件。设置存储在多个不同的位置，因此这是一个多步骤流程，从查找正确的设置开始。 在下面的例子中，我们将演示从"泛光质量（bloom quality）"之类的一般概念开始，进而查找 `r.BloomQuality` 之类特定设置的流程。你可以从 `.ini` 文件、编辑器内的控制台变量列表或在源代码中查找此设置。

### 引擎配置： BaseScalability.ini

首先找到 `Engine/Config` 文件夹，然后点击 `BaseScalability.ini` 文件。打开该文件后，你可以查找PostProcessQuality组小节以查找变量 `r.BloomQuality` 。

```
	[PostProcessQuality@0] 	r.MotionBlurQuality=0 	r.MotionBlur.HalfResGather=1 	r.AmbientOcclusionMipLevelFactor=1.0 	r.AmbientOcclusionMaxQuality=0 	r.AmbientOcclusionLevels=0 	r.AmbientOcclusionRadiusScale=1.2 	r.DepthOfFieldQuality=0 	r.RenderTargetPoolMin=300 	r.LensFlareQuality=0 	r.SceneColorFringeQuality=0 	r.EyeAdaptationQuality=2 	r.BloomQuality=4
```

## 设备描述：控制台变量

找到 **工具（Tools）** -> **平台（Platforms）** -> **设备描述（Device Profiles）** ，打开设备描述编辑器。进入编辑器之后，找到 **Windows** 描述，然后在 **控制台变量（CVars）** 列中，点击Windows旁边的 **编辑** 图标。

![设备描述编辑控制台变量](../../../../../assets/images/e8/e8fd7c80955336ee2a7e53934cc426fd8167ca66b5f955022be68c5802146fdd.png)

这将打开一个窗口，其中包含一个分类列表，列出了可以从设备描述设置的所有控制台变量：

![泛光质量变量](../../../../../assets/images/b0/b0aaab3cfabbb42377b8d1729e1239f1f29444b363f7d31ade73e6ebc204bb69.png)

上图中所示的泛光质量（Bloom Quality）变量在渲染（Rendering）类别中列出。

### 编辑器命令行

打开运行中的游戏或编辑器窗口，敲 **波浪号** 键（**~**）打开完整控制台，然后在 **命令（Cmd）** 行文本字段中输入"Bloom"。自动补全小节将列出包含"Bloom"在内并可以在运行时设置的所有控制台变量，其中包括 `r.BloomQuality` 。

> 图片已省略：编辑器命令行泛光

### 手动搜索

你可以使用Visual Studio等支持引擎目录内文本搜索的代码编辑器，在引擎中的所有 `.ini` 文件中搜索"bloom"等术语。你也可以在引擎API代码库中搜索特定术语。找到指定的控制台变量或配置设置后，我们推荐你在所有引擎 `.ini` 文件中搜索该设置，这样你就会知道它是在何处设置的，然后你可以应用特定于游戏或平台的设置。

## 覆盖配置文件中的设置

如果你希望某个控制台变量设置在所有平台和可扩展性组中始终相同，可以从 `DefaultEngine.ini` 文件的[ConsoleVariables]小节来实现这一点。例如，我们可以将以下内容添加到 `DefaultEngine.ini` 文件，以在所有情况下覆盖泛光质量。

```
	[ConsoleVariables] 	r.BloomQuality=1
```

如果你要找的设置位于 `BaseScalability.ini` 或其他配置文件中，则可以在项目中创建新的配置文件来覆盖它。为此，请在项目的配置目录中创建或编辑与引擎同名的文件，但用Base替换Default。 你可以在引擎中添加或查找与变量同名的小节。例如，要更改低（Low）质量后期处理可扩展性组的泛光质量，你可以将以下文本添加到 `DefaultScalability.ini` 文件。

```
	[PostProcessQuality@0] 	r.BloomQuality=1
```

如果引擎在WindowsEngine.ini等特定于平台的配置文件中设置控制台变量，则可以使用特定于平台的相同配置文件针对特定平台覆盖此设置。此外，若特定于平台的设置不使用设备描述或控制台变量系统，你可以将其更改。为此，请创建特定于平台的新配置文件，使其与引擎中相同的配置匹配。例如，要覆盖 `Engine/Config/Windows/WindowsEngine.ini` 文件，你可以创建新的 `ProjectName/Config/Windows/WindowsEngine.ini` 文件，并进行上述相同类型的更改。

对于使用引擎中顶级Platforms目录的主机之类的平台，我们推荐你在项目文件夹中创建并行目录。你可以在正确的目录中创建 `PlatformNameScalability.ini` 文件，这样你可以覆盖Android等特定平台的可扩展性组。

## 设置设备描述

要顾及特定于设备的差异，你将需要设置特定于项目的设备描述层级。最简单的方法是使用 **设备描述（Device Profile）** 编辑器，前往 **工具（Tools）** > **平台（Platforms）** > **设备描述（Device Profiles）** 即可找到该编辑器。 进入编辑器后，点击你想为其设置值的设备描述旁边的 **编辑** 图标。

> 图片已省略：特定于设备的描述

我们推荐你编辑包含了你想更改的所有设备的最高级别描述。然后，编辑控制台变量列表，以针对你想更改的描述添加或删除设置：

> 图片已省略：最高描述变量

> [!WARNING]
> 此屏幕不会保存你的更改。不同于编辑器中的其他设置屏幕，你将需要使用编辑器顶部的按钮打开 `DefaultDeviceProfiles.ini` 文件，然后当你完成编辑后，点击 **保存为默认值（Save as Defaults）** 以将更改写入项目的 `DefaultDeviceProfiles.ini` 文件。如果编辑器连接到源代码控制，你可能需要点击该相同区域，将该文件检出或添加到源代码控制。此编辑器保存只会写入修改的描述，但你可能需要手动修复产生的.ini文件，使其更易于阅读。

特定于平台的 **纹理LOD组（Texture LODGroups）** 设置可以从设备描述（Device Profiles）窗口进行设置，方法是点击TextureLODGroups列中的 **编辑** 图标。

> 图片已省略：纹理LOD组

如果有大量平台会运行你的项目，那么在选择覆盖引擎默认值的方式时，选择将[/Script/Engine.TextureLODSettings]小节添加到你的 `DefaultDeviceProfiles.ini` 这种覆盖方式可能更简单。你还可以将新的 `DeviceProfileNameAndTypes` 条目添加到[DeviceProfiles]小节，从而添加更多设备描述。执行这些方法后，你的设置现在将如你预期那样运作。但是，由于上表中所述的设置优先级层级，更高优先级的引擎设置可能与更低优先级但特定于项目的设置相冲突。

例如，如果引擎在 `DefaultDeviceProfiles.ini` 中设置了一个变量，但你想按可扩展性组设置它，那么你必须撤销引擎的设备描述设置。

## 撤销现有引擎设置

在某些情况下，你需要撤销某个设置的引擎默认值，因为它会与你所需的设置相冲突。通常，此行为是因为你想将某个设置移至设置优先级列表中的不同级别，或在不同可扩展性组之间移动一些事项。例如，我们想将泛光质量（Bloom Quality）从后期处理可扩展性（PostProcess Scalability）桶移至效果（Effects）桶。为此，可以打开你的 `DefaultScalability.ini` 文件并添加类似于下面例子的行：

```
		[PostProcessQuality@0] 		-r.BloomQuality=4 		[PostProcessQuality@1] 		-r.BloomQuality=4 		[PostProcessQuality@2] 		-r.BloomQuality=5 		[PostProcessQuality@3] 		-r.BloomQuality=5 		[PostProcessQuality@Cine] 		-r.BloomQuality=5 		[EffectsQuality@0] 		r.BloomQuality=2 		[EffectsQuality@1] 		r.BloomQuality=2 		[EffectsQuality@2] 		r.BloomQuality=2 		[EffectsQuality@3] 		r.BloomQuality=5 		[EffectsQuality@Cine] 		r.BloomQuality=5
```

这将使用高级配置系统语法，其中你使用以"-"开头的行来取消一个类别中的引擎更改（DefaultScalability中的行需要与BaseScalability中的行精确匹配，"-"除外），然后将其移至新的类别。

覆盖数组，例如位于 `BaseDeviceProfiles.ini` 文件中的 **控制台变量（CVars）** 数组，可以通过使用两种不同的方法来完成。如果你使用编辑器中的 **设备描述（Device Profile）** 窗口并保存你的设置，则系统将创建带有多个 `-CVars=` 行的DefaultDeviceProfile，这些行将取消数组中的每个单独的默认元素。

如果你想擦除引擎设置的整个数组并将其替换掉，可以使用以下行：

```
	!Cvars=ClearArray
```

然后使用以下行添加新元素：

```
	+CVars
```

此外，如果基本数组使用 `@Array=Key` 语法，则会被视为贴图，你可以覆盖使用该键的行。

例如，下面的行可以添加到 `DefaultDeviceProfiles.ini` 文件，将世界法线贴图（World Normal Map）纹理设置为自动缩减为2048x2048的尺寸（如果原本大于该数量）。

位于 `BaseDeviceProfiles.ini` 中的行 `@TextureLODGroups=Group` 意味着你无需使用 `-` 或 `!` 前缀来删除旧值：

```
	[/Script/Engine.TextureLODSettings] 	+TextureLODGroups=(Group=TEXTUREGROUP_WorldNormalMap,MinLODSize=1,MaxLODSize=2048,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)
```

# Lyra例子

此Lyra游戏示例解释了如何为你的特定项目组合这些不同的功能。在下面的小节中，你将看到不同的组件是如何组合起来的。

## 可扩展性组

`Lyra/Config/DefaultScalability.ini` 文件是手动创建的，方法是复制位于 `Engine/Config` 文件夹中的 `BaseScalability.ini` 文件并重命名，然后进行编辑，删掉所有冗余的小节。

该文件包含两组更改，调整了可扩展性组的工作方式：

- 自动化基准工具使用的 **性能阈值（Performance Thresholds）** 现在已从原始引擎默认值提升，因此需要更快速的计算机才能达到高（High）或史诗（Epic）质量级别。
- `foliage.DensityScale` 和 `grass.DensityScale` **控制台变量（Console Variable）** 设置已移出FoliageQuality类别，且已移入ViewDistanceQuality类别。

> [!NOTE]
> 这样做是为了简化选项菜单UI，因为不需要针对特定游戏单独挑出植被质量。

## 设备描述

`DefaultDeviceProfiles.ini` 文件是使用位于编辑器中的 **设备描述（Device Profile）** 窗口中的"保存为默认值"（Save To Defaults）选项创建的，然后手动编辑了这些值以添加更多描述，后续使用设备描述（Device Profile）窗口进行了修改，以调整单独的设置。

它包括以下更改：

- 添加了默认纹理组覆盖，用于为特定于游戏的"UI With MIPs"类别定义设置，该类别是在编辑器中使用 `DefaultEngine.ini` 中的[EnumRemap]小节命名的。
- 添加了新的移动设备描述以充当IOS和Android的基本描述。
- 使用新的控制台变量设置和覆盖纹理组定义了新的移动设备描述，以减小移动设备上的Mip大小上限，从而节省内存和下载大小。这些大小在烘焙时应用。
- 修改了IOS和Android设备描述，以将其基本描述设置为新的移动设备描述。

## 平台配置文件

平台配置文件提供了为你自己的项目创建文件的例子。位于Config文件夹中的 `Default*.ini` 文件中提供了公开平台的配置文件。`Lyra/Config/PlatformName/PlatformName*.ini` 目录中提供了需要平台持有者许可的受支持平台，例如游戏主机。

> [!NOTE]
> 如果你有非公开平台的许可证，你可以联系Epic合作伙伴。请参阅[Epic在线服务](https://dev.epicgames.com/en-US/services)，了解更多信息。

Lyra包括一个自定义配置选项，可用于创建特定于游戏发行版的变体。例如，如果你的游戏在多个基于Windows的商店发布，你可以在包含了能覆盖特定于商店的设置的.ini文件的Config/Custom文件夹中创建子文件夹。

这些 `.ini` 文件覆盖通过开发命令行选项来启用：

```
	-CustomConfig=Directory
```

你也可以使用位于 `Target.cs` 文件中的CustomConfig参数。你可以创建使用类似于 `Config/Custom/CustomConfigName/PlatformName/PlatformNameEngine.ini` 的文件路径命名的文件，添加特定于平台的自定义配置文件。

## 游戏用户设置

对于处理特定于用户的设备设置，Lyra使用 `ULyraSettingsLocal` 类作为 `UGameUserSettings` 的子类。Lyra使用相同的设置UI来修改仅存储在设备上的本地设置，例如体积和图形质量（Volume and Graphics Quality），并使用 `ULyraSettingsShared` 类来处理可以写入云存储并在多个设备上使用的键绑定。

请参阅[GameSettings插件](../lyra-sample-game-settings/index.md)文档，了解更多信息。
