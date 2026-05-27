---
title: "虚幻引擎5迁移指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-5-migration-guide"
breadcrumbs: ["虚幻引擎5.7文档", "新内容", "虚幻引擎5迁移指南"]
---

# 虚幻引擎5迁移指南

> 路径：虚幻引擎5.7文档 / 新内容 / 虚幻引擎5迁移指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-5-migration-guide

本指南介绍了如何将虚幻引擎4项目迁移到 **虚幻引擎5（UE5）** 中。

**虚幻引擎5** （UE5）在虚幻引擎4（UE4）的基础上引入了一系列改动、升级和新功能。尽管新引擎有了大量更新，但内置的转换流程仍能保证大部分内容可以自动完成迁移，无需用户执行任何操作。

要开始迁移，请在启动程序中打开UE5。如果UE5EA已经在运行，请在主菜单中点击 **文件（File）> 打开项目（Open Project）** 菜单项。然后，选择你要升级的项目并点击 **打开（OPEN）**。

点击 **打开副本（Open a Copy）** 按钮。这样可以把项目升级为一个单独的副本，保留原项目不变。

![Opening a project copy to upgrade it to UE5](../../../assets/images/b0/b0ce003e8745243e05e09f1cfccb0522d5868be150ac3f49d9a51ebe8d13119e.png)

如果你点击对话框中的 **更多选项（More Options）**，你可以选择以下两种方式：

- 跳过转换，尝试按原样打开项目。
- 直接转换，尝试转换现有项目，而不是复制它。

> [!NOTE]
> 当你需要把项目升级到UE5版时，我们推荐使用上文介绍的 **打开副本（Open a Copy）** 方法。 **直接转换（Skip conversion）** 和 **跳过转换（Convert in-place）** 可能无法正常使用，并且可能会导致数据损坏和数据丢失。

> [!WARNING]
> 将某个项目升级到新版本虚幻引擎后，你将无法在旧版本中打开它。这样做将会失败。

转换完成后，大部分项目都可以直接在UE5中构建和运行。不过，某些新功能或升级过的功能可能需要手动更新才能生效。最显著的系统改动（或新增部分）包括Nanite、Lumen和Chaos。假如项目涉及大量图形内容，那么需要你针对Nanite和Lumen手动做一些处理，才能让画面看起来和UE4中的相同。假如项目涉及大量物理效果，你需要做一些资产修改，以便用于Chaos系统。

在本文中，我们将介绍强制更新和其他值得注意的系统更新，例如系统的废弃和迭代情况。如果你要用到这些功能，请按照 **强制更新** 中的说明执行更新，以便将UE4项目成功升级为UE5。在 **其他变化** 小节中描述的更新不一定会影响你的项目，但也请注意。

## 不同版本的转换说明

请参考下表，了解用不同虚幻引擎创建的项目将如何进行转换。

| **项目创建时的版本** | **转换说明** |
| --- | --- |
| 虚幻引擎4.0到4.26 | 你的项目可以在原有版本的虚幻引擎中或更新版本的引擎中加载。 虚幻引擎API在过去一段时间内已经发生了很多变化，这意味着用早期版本创建的一些项目可能无法正确加载。例如，在4.0版本中保存的蓝图可能会调用在4.10版本中已废弃、在5.0版本中不存在的函数。不过，项目应该仍然可以加载，允许你修复因为内容过时或删除引用而导致的问题。 |
| 虚幻引擎4.27 | 你的项目将在虚幻引擎4.27、5.0以及更新版本中加载。请注意，你的项目 **不会** 在虚幻引擎5.0抢先体验版中加载。 这部分在虚幻引擎5.0抢鲜体验版的[兼容性说明](https://docs.unrealengine.com/5.0/en-US/Welcome/#compatibility)中有所说明。 |
| 虚幻引擎5.0 | 你的项目可以在虚幻引擎5.0和之后的更新版本中加载。 |
| 虚幻引擎5.1及更新版本 | 你的项目可以在原有版本的虚幻引擎中或更新版本的引擎中加载。 |

### 资产兼容性

在虚幻引擎旧版本中保存的资产可以在较新的版本中打开。例如，如果你在虚幻引擎4.26中保存了一个资产，你可以用虚幻引擎5.0打开它。

在新版本虚幻引擎中保存的资产 **不能** 在旧版本中打开。例如，如果你在虚幻引擎5.0中保存了一个资产，你将无法在虚幻引擎4.26中打开它。

## 必须执行的更新

下文介绍为了把项目从UE4升级到UE5所需的更新操作。其中有些操作是强制的，而有些则是可选的（推荐在UE5EA版中执行，未来版本中这些可选操作会变成强制操作）。

### 开发平台改动

如果你需要使用Visual Studio编写C++代码，你必须升级到Visual Studio 2019。这也是最新版UE4默认使用的Visual Studio IDE。UE5不支持Visual Studio 2017或Visual Studio 2015。

UE5版不支持32位平台，并且没有计划在未来添加针对32位平台的支持。

UE5对 **目标平台名称（Target Platform Names）** 进行了标准化。你因此开发人员将需要更新构建脚本，在某些情况下还需要更新 `DeviceProfiles.ini` 文件。这主要会对直接运行它们的开发人员产生影响。如果你使用 **UAT**，你就不需要进行更改。

下表列出了目标平台名称的列表：

| UE4目标平台 | UE5EA目标平台 |
| --- | --- |
| Windows | WindowsEditor |
| WindowsNoEditor | Windows |
| MacNoEditor | Mac |
| Mac | MacEditor |
| LinuxNoEditor | Linux |
| Linux | LinuxEditor |
| LinuxAArch64NoEditor | LinuxAArch64 |

### PhysX和Chaos Physics系统

UE5使用 **Chaos Physics** 引擎进行物理模拟，取代了默认的 **PhysX**。虽然UE5仍然保留了PhysX，但将在后续的版本中删除。Chaos Physics下的物理模拟的行为方式与PhysX不同，开发人员要进行调整才能看到一致的行为。

对于任何默认创建的新项目，物理模拟的更新率（tick rate）将有所不同。可以通过项目设置（菜单：**编辑 > 项目设置**）中的异步物理更新（Tick Async Physics）来更改更新率。这个新功能将在自己的线程上模拟物理，而不是在游戏线程上模拟。

在新改动中，物理模拟将以固定频率运行，从而提高确定性。由于具有固定的更新速率，网络物理模拟同步将更加容易，因为客户端和服务器系统以相同的间隔运行。

由于不在游戏线程上运行，游戏线程中的输入指令（input）发送给物理系统后，可能会在一段延迟后，物理系统才会响应输入操作。你必须先考虑这种延迟，以避免编写严重依赖物理模拟的项目时，发生不可预测的行为。在物理线程上的C++回调函数中运行物理相关的游戏逻辑代码能够减轻这种问题，但需要修改项目代码才能使用这种方法。

### 用于调试着色器的控制台变量

虚幻引擎5发布后，用于调试着色器的控制台变量有部分改动。下表列出了一个关于这些重命名的指南。

如果你的项目在配置文件中使用了这些变量，你需要在将项目迁移到UE5时更新它们，以便继续将之前生成的数据用于着色器调试。

| **老版本中的控制台变量名称** | **新版本中的控制台变量名称** | **说明** |
| --- | --- | --- |
| `r.Shaders.KeepDebugInfo` | `r.Shaders.Symbols` | 通过生成符号并将其写入控制台的磁盘，来实现着色器调试。桌面符号是在线保存的。 |
| N/A | `r.Shaders.ExtraData` | 生成着色器名称和其他额外的着色器数据。 |
| `r.Shaders.PrepareExportedDebugInfo` | `r.Shaders.GenerateSymbols` | 生成符号，但不将其写入磁盘。相反，符号保存在衍生数据缓存（DDC）中。 |
| `r.Shaders.ExportDebugInfo` | `r.Shaders.WriteSymbols` | 如果符号已经生成，则将其写到磁盘上。 |
| `r.Shaders.AllowUniqueDebugInfo` | `r.Shaders.AllowUniqueSymbols` | 根据着色器来源生成符号关联。默认情况下这是关闭的。 |
| `r.Shaders.ExportDebugInfo.Zip` | `r.Shaders.WriteSymbols.Zip` | 当把符号写入磁盘时，它们会作为一个ZIP文件被写入。 |

> [!NOTE]
> 控制台变量 `r.Shaders.KeepDebugInfo` 被拆分为两个控制台变量（`r.Shaders.Symbols` 和 `r.Shaders.ExtraData`），以便在只需要符号的时候，删除对运行时着色器数据的修改。这对于支持导出调试信息的平台很有用，因为它允许在不改变最终着色器数据的情况下，为发布版本构建生成符号。

有关该过程的更多信息，请参考[着色器调试](../../designing-visuals-rendering-and-graphics/graphics-programming/shader-development/index.md)页面。

## 其他改动

> [!NOTE]
> 如果只是让你的 **虚幻引擎4**（UE4） 项目能在 **虚幻引擎5**（UE5） 中运行，这些更新并不是必需的，但未来版本中可能会需要这些更新，或者能让你利用引擎的全部功能。
>
> 请阅读本文来了解如何为未来的 **虚幻引擎5**（UE5）版本做好准备，最大程度利用引擎的新功能和升级功能。

### C++对象的指针属性

> [!NOTE]
> 以下内容仅适用于C++项目。蓝图用户可以跳过。C++许可项目可以继续使用原始对象指针，或选用 `TObjectPtr`。

UE5引入了 `TObjectPtr`，一种基于模板的64位指针系统，可选择性地用来取代编辑器版本（editor builds）中的原始对象指针（raw object pointer）。此系统添加了动态解析和访问追踪功能，并且它的效用和非编辑器版本中的原始指针完全相同。`TObjectPtr` 变量在传递给函数或保存为局部变量时，会自动转换为原始指针。尽管大多数涉及 `TObjectPtr` 的操作都会把 `TObjectPtr` 隐式转换成原始指针，但在涉及直接操作引擎类时，你可能需要在少数情况下手动改动。之前很多在 `UPROPERTY` 中采用原始指针的引擎类现在都改为使用 `TObjectPtr`。项目中与引擎类交互的地方可能需要少量代码更新，用 `TObjectPtr` 来取代最原始的指针。例如，`AActor` 的 `RootComponent` 属性在UE4中是一个 `USceneComponent*` 指针，但在UE5EA中是 `TObjectPtr<USceneComponent>` 类型。少数情况下，你可能需要更新与 `RootComponent` 直接交互的代码。不过，调用 `GetRootComponent` 的地方会始终保持不变，因为它的返回类型仍然是 `USceneComponent*` 。

使用UE5EA进行编程开发时，我们建议对 `UObject` 指针属性和 `UCLASS` 以及 `USTRUCT` 中的容器类使用 `TObjectPtr<T>` 而非 `T*`。由于在非编辑器版本中，`TObjectPtr` 会转换成原始指针，这不会影响已发布产品的行为或性能，但会改善你在编辑器版本中的开发体验。请参照以下方法来使用新的指针系统：

- 在调用容器函数的"Find"类函数时，请使用 `TObjectPtr<T>*`（而非 `T**`）来获取返回值。
- 通过原始指针容器进行的基于范围的遍历可能已经使用了 `auto*` 作为迭代器变量类型。将它们改为 `auto&`。此外，我们还建议在新代码中使用 `auto&` 或 `const auto&`，因为 `TObjectPtr` 可以缓存已解析的对象地址，从而为之后的访问操作节约时间。
- 当你需要原始指针但隐式转换不可用时，对你的 `TObjectPtr` 调用 `ToRawPtr` 或 `Get`。常见情况包括三值操作，以及再在 `const_cast` 内部。在将参数传递给函数委托时，将并行委托函数声明为传递函数，取代具有 `TObjectPtr` 参数的原始指针。下面的示例展示了一个传递委托函数：

  ```
               // Original function signature, using raw pointers, which we will use in most cases:      static bool MyFunction(UObject* FirstParameter);		          // In rare cases where implicit conversion is not available, use this pass-through function.             // Pass-through function signature, using TObjectPtr:      static bool MyFunction(TObjectPtr<UObject> FirstParameter);		      // Pass-through function body (in the source file):      bool UMyClass::MyFunction(TObjectPtr<UObject> FirstParameter)      {          return ShouldShowResetToDefault(FirstParameter.Get());      }
  ```

> [!NOTE]
> 在大多数情况下，例如将参数传递给函数或者用局部变量保存数据，`TObjectPtr` 会自动保存为原始指针类型。只有少部分情况下（例如上文描述的），你才需要执行少数代码改动。大多数项目不需要。

#### 可选的转换工具

UE5提供了 **UnrealObjectPtrTool** —— 一个能将引擎可见的原始指针属性自动转换为 `TObjectPtr` 的系统。你可以在IDE的解决方案目录中的 `UE5/Programs/UnrealObjectPtrTool/` 部分中找到该程序。源代码位于 `Engine/Source/Programs/UnrealObjectPtrTool/` 中。可执行文件位于 `Engine/Binaries/Win64` 目录中。根据你的操作系统或开发环境，可执行文件可能位于你的 Engine/Binaries/OS 目录中，其中OS表示你的操作系统。

> [!NOTE]
> 这个可选工具旨在方便你把项目中的原始指针转换成 `TObjectPtr`。它将更新类中的 `UPROPERTY` 变量和头文件中的结构体定义，但不会对你的源代码进行上文提及的所需的更改；你仍然需要手动调整，并确保你的项目在使用 **UnrealObjectPtrTool** 之前完成编译。

要使用 **UnrealObjectPtrTool**，请按照以下步骤进行操作：

1. 在 `Engine\Programs\UnrealHeaderTool\Config` 目录中找到你的 `DefaultEngine.ini` UHT配置文件。
2. 在你的DefaultEngine.ini文件中，修改以下脚本：

   ```
           	NonEngineNativePointerMemberBehavior=AllowAndLog
   ```
3. 重新构建你的项目，确保所有代码都被UHT解析。
4. 根据项目的编译方式，你可以在名为Log.txt或UnrealHeaderTool.log的文件中找到UHT日志。这些文件位于以下文件夹目录中：

   ```
               C:\Users\USERNAME\AppData\Local\UnrealBuildTool\Log.txt              C:\Users\USERNAME\AppData\Local\UnrealHeaderTool\Saved\Logs\UnrealHeaderTool.log            Engine\Programs\UnrealBuildTool\Log.txt
   ```
5. 在Visual Studio解决方案中编译UnrealObjectPtrTool。

   > [!NOTE]
   > 只有在通过源代码运行引擎时才需要这个步骤，否则，当你通过Epic Games启动程序安装引擎时，UnrealObjectPtrTool会被预编译。
6. 运行UnrealObjectPtrTool可执行程序：

   ```
                  UnrealObjectPtrTool.exe <UHT_LOG_PATH> -SCCCommand="p4 edit -c UPGRADE_CL {filenames}"
   ```

   > [!NOTE]
   > 你可以选择性地添加以下参数来预览可能存在的变化：-PREVIEW 或 -n。

### 渲染

以下默认设置已发生改变，并可能会影响你的项目的视觉效果：

- **屏幕空间全局光照（Screen Space Global Illumination）：**屏幕空间全局光照（测试版）**的项目设置和相关的控制台变量 `r.SSGI.Enable` 已被删除。如果要重新启用屏幕空间全局光照作为项目的默认全局光照方法，请点击**项目设置（Project Settings） >（引擎）渲染（(Engine) Rendering） > 全局光照属性（Global Illumination properties）**，将**动态全局光照方法**设置为**屏幕空间（测试版）**。如果要在后处理体积上重新启用屏幕空间全局光照，请进入体积的属性并找到**全局光照**类别，然后将**方法**字段设置为**屏幕空间（测试版）**。
- **基于Lumen硬件光线追踪的光线追踪支持：** 独立的光追功能在虚幻引擎5中已经被废弃了。不过，引擎计算这些光照效果的能力并未被取消，因为Lumen涵盖了这些光照功能。被删除的是在虚幻引擎4中开发的独立的光线追踪系统。这些功能在工作时相互独立，也就是说，它们无法保证对引擎的相同功能提供一致的支持。Lumen将为其硬件光线追踪路径中的反射和全局光照添加全新的光线追踪功能的实现。随着UE5的不断完善，Lumen的光线追踪功能将继续改进，提供更广泛的支持，并与引擎的其他功能不断协同。

  - 光线追踪反射、全局光照，和阴影已被划分为各自独立的功能，可以独立启用。这些功能中的每一个都可以在

    项目设置（Project Settings） > 渲染（Rendering）

    中找到，并且需要启用

    支持硬件光线追踪（Support Hardware Ray Tracing）

    来使用它们。

  *在全局光照（Global Illumination）部分，选择 **动态全局光照方法（Dynamic Global Illumination Method）** 作为首选项。* 在反射（Reflections）部分，选择 **反射方法** 作为首选项。 * 在硬件光线追踪（Hardware Ray Tracing）部分，勾选 **光线追踪阴影** 复选框。

  - 反射和全局光照也可以使用后处理体积来设置（在全局光照和反射方法中选择）。
- **生成网格距离场：** Lumen的 **软件光线追踪**功能主要依靠 **有向距离场（Signed Distance Fields）** 来表示网格体。所有 **距离场** 的 **默认体素密度** 已从0.1增加到0.2。这对于让Lumen实现较好的软件追踪效果是必要的，但它大大增加了距离场的内存占用。要调整该属性，请点击 **项目设置 >（引擎）渲染**，你能找到 **生成网格距离场（Generate Mesh Distance Fields）** 复选框和 **距离场体素密度（Distance Field Voxel Density）** 属性。改变这个设置后，你可能需要重新启动编辑器以使其生效。

#### 删除内容

**Nanite** 已经取消了 **硬件曲面细分** 的大部分用例。硬件曲面细分已在UE5中删除。对于Nanite不支持的用例，用户可能需要在必要时提高其资产分辨率。

**Lumen** 取代了 **光线传播体积（Light Propagation Volumes）** 和 **距离场全局光照（Distance-Field Global Illumination）**（DFGI）。

* 与光线传播体积相比，Lumen提供了更多功能，其品质要好很多并且在积极开发中，尽管Lumen的基础性能开销更高。

* DFGI是一个实验性功能；开发者应该使用Lumen而不是DFGI来实现动态全局光照。

* 随着时间的推移，Lumen全局光照和反射将取代大多数具有类似或更高品质效果的光线追踪功能。

**老版色调映射器（Legacy Tonemapper）** 在UE4中已被废弃，在UE5中将彻底删除。开发人员无需任何操作。

#### 废弃内容

- Cascade

  将在UE 5.0中被废弃，并在后续版本中删除。UE5开发者应该改用

  Niagara

  。一个将Cascade数据升级到Niagara的自动转换器正在开发中。
- 部分

  光线追踪

  功能将被废弃，它们将不再属于独立系统，而是整合到Lumen硬件光追系统中。这意味着反射和全局光照将直接整合到Lumen中。这些独立的功能已被废弃，以便实现一致的体验和更广泛的引擎功能支持。（详情请参见上文的"渲染"小节)。

### 世界构建

#### 删减内容

**世界分区（World Partition）** 是UE5用来处理大型、流送场景的系统。UE4使用的 **世界合成（World Composition）** 系统仍然在，但已被废弃，今后不会有升级、修复或其他支持。世界合成将在未来的UE5版本中被移除。

要将你的地图升级到世界分区系统，请在项目中使用 `WorldPartitionConvertCommandlet`，并提供要转换的每张地图的名称，一次一个。例如，如果要转换 `QAGame` 项目中的 `/Game/Maps/Tools/Landscape/TM_WorldComp_P` 中的 `TM_WorldComp_P` 地图，请在运行编辑器时添加以下命令行：

```
	QAGame -run=WorldPartitionConvertCommandlet TM_WorldComp_P -ConversionSuffix -SCCProvider=None
```

这会把 `TM_WorldComp_P` 地图转换为使用世界分区系统。`-ConversionSuffix` 会让转换后的地图保存为 `TM_WorldComp_P_WP`，而不是覆盖原始地图。由于 `-SCCProvider=None` 选项，这个命令在运行时不会与项目的源码控制提供者产生交互。这个过程还将生成一个 `TM_WorldComp_P.ini` 文件，其中包含用于转换地图的设置，以及用于未来可能的转换的设置。转换过程会基于现有的World Composition数据建立运行时网格（用于世界分区系统），并将地图中的Actor分配给相应的网格中。

> [!NOTE]
> 使用C++的开发者可以查看 `UWorldPartitionRuntimeSpatialHash::ImportFromWorldComposition` 和 `UWorldPartitionRuntimeSpatialHash::GetActorRuntimeGrid` 来了解或修改网格生成和Actor分配相关的逻辑。

### 工具

#### 删除内容

全新的几何体编辑工具将取代实验性的 **老版本可编辑网格体插件**。

**影片渲染队列（Movie Render Queue）** 将取代 **影片场景捕获（Movie Scene Capture）**。

**VR关卡编辑** 将被剥离，只支持VR预览，但UE5将继续支持虚拟制片堪景。

**镜头录制器（Take Recorder）** 将取代 **Sequence录制器（Sequence Recorder）**。镜头录制器包含Sequence录制器提供的所有功能。

**摄像机动画序列（Camera Animation Sequences）** 将取代 **摄像机动画（Camera Anims）**。

UE5还删除了与被删除插件相关的 **编辑器功能包**。这些插件的用户要确保不在其项目中引用被删除的内容。

#### 废弃内容

**Sequencer** 将在UE5完全发布后完全取代 **Matinee**。Matinee已被废弃，但在UE4中仍然存在。

### 控制绑定

#### 更改

**Space** 被重命名为 **Null**。

**Gizmos** 被重新命名为 **Shapes**。

**基于当前内容设置初始变换（Set Initial Transform from Current）** 现改为 **基于当前内容设置偏移变换（Set Offset Transform from Current）**。

#### 废弃内容

**集合（Collections）** 现在被 **数组（Arrays）** 所取代。

**变换约束（Transform Constraint）** 节点已被废弃，并被单独的 **点（Point）**、**旋转（Rotation）** 和 **父约束（Parent Contraint）** 节点所取代。

新的 **父约束（Parent Constraint）** 节点可以用来代替 **投射到新父节点（Project to New Parent）** 和 **设置变换（Set Transform）** 节点。

现在你可以使用 **空间切换（Space Switching）** 来代替 **父切换约束（Parent Switch Constraint）**。

**Bezier数据类型（Bezier Data Type）** 已被 **Splines插件（Splines plugin）** 取代。

**ControlRigHierarchyModifier** 不再能用于Python，它已被替换为用于查询绑定元素的 **RigHierarchy** 和用于编写绑定元素的 **RigHierarchyController**。

**ControlRigBlueprint** 不再拥有 **控制器（Controller）**属性。要访问主 **RigVMController**，请使用函数：**ControlRigBlueprint.get_controller()**。

映射不会在构造脚本中处理，而是在控制绑定组件的 **预初始化（Pre-Initialize）** 中处理。

### 音频

#### 删除内容

**虚幻音频混合器（Unreal Audio Mixer）** 将在UE 5.0中取代被废弃的 **老版音频后端（Legacy Audio Backends）**。用户不需要采取任何操作。UE5将使用虚幻音频混合器并默认采用前沿音频后端；这些后端与之前的所有音频功能兼容。

#### 废弃内容

**Audio Volumes**、**Sound Class Mix**和**Sound Cues** 将在UE 5.0中被废弃，并计划在UE5的未来版本中移除它们。

- Sound Cue将被 **MetaSounds** 所取代，后者将在UE 5.0中使用。
- 声音类混合（Sound Class Mix） 将被 **调制（Modulation）** 和 **子混合（Submix）** 系统所取代，后者现在已经可用。
- 音频体积将被目前正在开发的新系统所取代，该系统将在UE 5.0中使用。

我们鼓励用户尽快使用这些系统的新版本内容。

### Gameplay框架

#### 删除内容

**蓝图原生化** 在UE5中将不再存在。采用了这一功能的项目不会出现任何变化，也不需要接受任何修改，就能正常运行，尽管性能可能会受到影响。如果发生这种情况，开发人员需要采取其他优化方法。

### 网络

#### 废弃内容

**AES、RSA和RSA密钥AES加密处理程序** 已被废弃并计划移除。

### 核心

#### 删除内容

**Zen Loader** 将取代 **事件驱动加载器（Event-Driven Loader）**。由于大多数用户不直接与事件驱动加载器对接，这一变化在项目迁移时无需任何操作。

#### 废弃内容

**Unreal Insights** 将在UE 5.0完全发布后取代 **统计系统（Stats System）**。统计系统将保留在UE 5.0中，但最终会被移除以支持Unreal Insights。
