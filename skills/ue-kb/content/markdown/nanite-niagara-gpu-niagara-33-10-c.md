# Nanite Niagara GPU 粒子渲染器及使用单个 Niagara 系统渲染 33 种不同网格的 10 万个粒子。蓝图和 C++代码性能评测

# Nanite Niagara GPU 粒子渲染器及使用单个 Niagara 系统渲染 33 种不同网格的 10 万个粒子。蓝图和 C++代码性能评测

- 来源: https://dev.epicgames.com/community/learning/tutorials/w6wG/unreal-engine-nanite-niagara-gpu-particle-renderer-and-rendering-of-100-000-particles-using-a-single-niagara-system-with-33-different-meshs-blueprint-and-c-code-performance-review
- 原文标题: Nanite Niagara GPU Particle Renderer and Rendering of 100,000 particles using a single Niagara System with 33 Different Meshs. Blueprint and C++ code performance review

粒子渲染器及使用单个 Niagara 系统渲染 10 万个粒子（包含 33 种不同网格）的性能评估。蓝图和 C++代码性能评测

静态网格渲染将 Niagara 粒子系统引入 Lumen 和 Nanite 绘制调用中……它完善了 Nanite 生态系统。随着 Unreal 5.5 也为 Nanite 添加了骨骼网格支持，一切皆可 Nanite 化。

在这段 37 分钟的视频中，我将演示如何导出 10 万个 Niagara GPU 模拟粒子，每个粒子都是一个随机的静态网格体，然后将它们导出到蓝图中，并在每一帧都转换为 Nanite ISM（实例化静态网格体）组件。我使用了批量添加的批量更新方法。

<< 更新：适用于 UE5.3.2 的插件项目文件已上传至 GitHub：https://github.com/aggressivemastery/NaniteNiagara/ >>

概括： I

我每帧/刻导出 10 万个 GPU Niagara 粒子数据，并将导出的数组按静态网格索引转换为 C++ 变换数组。然后，我通过批量添加的方式，将这些变换应用到启用 Nanite 的实例静态网格组件上。这实现了 Nanite Niagara GPU 模拟静态网格渲染。它还支持 Nanite 遮罩材质（例如某些 VFX/烟雾/抠图类型）或植被。 I

我修改了内置的粒子导出节点，使其导出粒子旋转速度而非速度，并将旋转方向（世界坐标）和粒子网格索引打包到导出的浮点数值中。这种网格数据打包方式使我能够通过一次遍历将每个粒子排序到数组中。

-LinkedIn : (Micah Berninghausen)

-LinkedIn：（Micah Berninghausen）

-Reddit : u/DiePepsi -Reddit：u/DiePepsi Additional Detail: 更多详情：

虚幻引擎 5.0 新增了一种名为“Nanite”的渲染技术。Nanite 会在每个帧/刻生成一个全局静态网格体，该网格体是视图中所有启用 Nanite 的静态网格体的近似 1:1 合并表示。这大大减少了绘制调用次数，并且在视图中启用 Nanite 的网格体越多、未启用 Nanite 的网格体越少时，性能表现最佳。 Unreal Engine 4.27 added the ability to export Niagara GPU Simulation data using an experimental Niagara "Export" node, for each GPU simulated particles (CPU simulated are also supported,

虚幻引擎 4.27 新增了使用实验性的 Niagara“导出”节点导出 Niagara GPU 模拟数据的功能，可以导出每个 GPU 模拟的粒子（也支持 CPU 模拟，但 CPU 模拟比 GPU 模拟慢得多）。 Epic Games Content Sample Project(s) for Unreal Engine 4.27+ or newer UE5.0, 5.1, 5.2, 5.3, 5.4, 5.5+ you will find the "Game/Maps/Niagara_Advanced_Particles" Level, within that level "Export GPU Niagara Particles to Blueprints"

内容示例项目适用于虚幻引擎 4.27+ 或更高版本（UE5.0、5.1、5.2、5.3、5.4、5.5+），您会找到“Game/Maps/Niagara_Advanced_Particles”关卡，在该关卡中，“Export GPU Niagara Particles to Blueprints”将是 Niagara

设置每帧导出粒子位置，但仍然使用静态网格渲染器。

本视频演示了如何使用 Niagara GPU 导出的每帧粒子数据，作为 Nanite 实例静态网格体批量更新的手段。为此，我们必须转换导出的每粒子数据。通过蓝图转换 1 万个粒子时，转换时间线性增加，大约需要 20 毫秒；而使用 C++ 转换后，转换时间可缩短至 0.3 毫秒。之后，使用 C++ 处理 10 万个粒子，即可实现 4K Nanite 渲染实例静态网格体 60fps 的帧率。

可以通过将转换任务从游戏线程卸载到另一个线程来进一步优化，这可能是我下一步的工作。主要工作量并非从 Niagara 导出数据，而是将这些数据转换为变换并排序到变换数组中。

粒子导出带宽似乎成本低廉，冲击效果小，并且随着导出粒子数量的增加呈线性增长。

您可以将每帧的位置数组导入到 GPU Niagara Particles 中。您还可以将粒子死亡时的事件导出到蓝图（本视频演示的是导出每一帧，而不仅仅是死亡帧）。 So Import and Export of Objects to GPU Simulate in Niagara is now fully supported, and using this runtime particle nanite rendering, we can do fully-nanite VFX... besides transparency? (skeletal

现在，Niagara 完全支持将对象导入和导出到 GPU 模拟，并且使用这种运行时粒子纳米渲染技术，我们可以实现完整的纳米特效……除了透明度之外？（UE5.5 源码版本支持骨骼网格。）

## 重要设置或设置详情： Niagara***

Niagara*** 更新：我忘记说明如何在 C++ 中访问 Niagara 粒子数据结构类型了。除了在头文件/cpp 文件中包含 Niagara 之外，还需要在项目的 Build.cs 文件中包含 Niagara。以下是需要添加到 .Build.cs 中的代码片段。 - GPU Simulation is the best choice,

- GPU 模拟是最佳选择，CPU 也受支持。 - Collisions are done with Global Mesh Distance Fields,

碰撞检测采用全局网格距离场法， useful commands: 常用命令：

## r.AOGlobalDistanceField.MinMeshSDFRadiusInVoxels 5（默认值 0.5）

这意味着小于此体素数的网格将被排除在全局场生成之外。对我来说，5.0 的设置既能包含足够小的网格，又能保证足够的生成速度，您可以根据自己的喜好和效果进行调整。

您也可以将其设置为半径：r.AOGlobalDistanceField.MinMeshSDFRadius MeshDistanceFields: 网格距离场： Each Static Mesh Asset in your project, needs to be enabled to "generate mesh distance fields" and your project settings needs to "enabled mesh distance fields generation." Both the static mesh build settings, and the project settings, have mesh distance fields "density" settings that can be reduced,

项目中的每个静态网格资源都需要启用“生成网格距离场”功能，并且项目设置也需要启用“网格距离场生成”功能。静态网格构建设置和项目设置中都有网格距离场“密度”设置，降低该设置可以加快网格距离场的生成速度。

有：“网格距离场”和“全局网格距离场”。 Global Mesh Distance Fields is Cheaper SHADOW COPY, and goes further distance from the camera than the Mesh Distance Fields. Both editor "view" modes exist, be sure you are looking at "Global distance fields"

全局网格距离场比阴影复制更便宜，并且比网格距离场作用于更远的摄像机距离。编辑器中同时存在这两种“视图”模式，调试粒子交互时，请务必查看“全局距离场”。全局距离场

如果使用硬件光线追踪，可能会导致全局网格距离场出现问题。我不确定它们是否会被生成。此设置应该会启用 RTX 距离场生成，但我尚未测试过：r.DistanceFields.SupportEvenIfHardwareRayTracingSupported 1

以下是用于调用 BlueprintFunctionLibrary 的 C++ 头文件和主体文件，该调用用于将 Niagara 导出的粒子数据数组转换为基于网格索引的变换数组。这需要修改随附的“Niagara 导出粒子数据导出到蓝图”节点，使其包含网格旋转而非速度，并将网格索引和 qw 值打包到缩放粒子数据中。此细节在 YouTube 视频中进行了讲解（如下片段所示），并在该视频和下文中通过蓝图进行了演示。

## 项目文件

## 适用于 UE5.3.2 的 GitHub 插件文件

```cpp
// Niagara GPU Export to Blueprints for Nanite ISM Renderering Version 1.0 by @GameDevMicah Berninghausen 4/9/2024
// GPUCPPExportFunctionLibrary.h verbose notes for BP to C++ converts
#pragma once
#include "CoreMinimal.h" //Includes Basic Req Calls
#include "NiagaraDataInterfaceExport.h" //*grants access to niagara array structure variable types
#include "Kismet/BlueprintFunctionLibrary.h" //This is our Parent Class a Blueprint Function Libary, if another actor or class this may change to include your calls/var access
#include "GPUCPPExportFunctionLibrary.generated.h" //Generated .h file
// Custom data structure for Niagara export exposed as a blueprint type called FNiagaraExportData
```

GPUCPPExportFunctionLibrary.cpp：用于 BP 转 C++ 的详细说明。

```cpp
// Niagara GPU Export to Blueprints for Nanite ISM Renderering Version 1.0 by @GameDevMicah Berninghausen 4/9/2024
// GPUCPPExportFunctionLibrary.cpp verbose notes for BP to C++ converts
#pragma once
#include "GPUCPPExportFunctionLibrary.h" //you must include your .h header file (class/var definitions) to your cpp file body
//Here we Start/Create the Body of our Function named "GPUExportCPP"
//We define at the start of the line what our Return type data to blueprints will be, a "T-Array" or List of "FNiagaraExportData" data types,
//FNiagaraExportData types/Structure is Defined in the Corrisponding .h header file GPUCPPExportFunctionLibrary.h as a list of transform arrays called 'positions' by Particle MeshIndex
//UGPUCPPExportFunctionLibrary is the parent class of this code, this class can be callable by any blueprint as a function Libaray and doesnt need to be attached to an actor.
//GPUExportCPP is the function name or blueprint node you will look for, how you call this function
```

Nanite Niagara：按网格索引将导出的 GPU 粒子数据数组转换为 Transform 数组（C++）。

MyProject.Build.cs 文件：为了访问 Niagara 的粒子结构数据类型，必须把 “Niagara” 加入模块依赖。

```cpp
// Fill out your copyright notice in the Description page of Project Settings.
using UnrealBuildTool;
public class Mesh5000 : ModuleRules
{
public Mesh5000(ReadOnlyTargetRules Target) : base(Target)
{
PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
```

## added "Niagara" to :

已将“Niagara”添加到：PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "Niagara" }); //为 ExportConverterFunction 添加

## 事件粒子数据

## 尼亚加拉系统

展示了带有蓝图和 C++ 转换调用的 Nanite Niagara Actor GameDevMicah 的《虚幻引擎 5 中的 Nanite Niagara 渲染：蓝图 C++ 教程（类似 EpicGames）》 -

GameDevMicah 的《虚幻引擎 5 中的 Nanite Niagara 渲染：C++ 蓝图教程》（Epic Games 出品） Aggressive Mastery 激进掌控

![thumbnail-image](../assets/images/nanite-niagara-gpu-particle-renderer-performance-01.jpg)

GameDevMicah 的《虚幻引擎 5 中的 Nanite Niagara 渲染：C++ 蓝图教程》（Epic Games 出品）

蓝图 Niagara Scratch pad 节点修改至虚幻引擎 5.3 内容示例粒子数据从 GPU 示例项目导出到蓝图（高级粒子级别，发射器 4.2）

