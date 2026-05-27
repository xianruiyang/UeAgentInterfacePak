---
title: "ICVFX最佳实践"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/in-camera-vfx-best-practices-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "ICVFX", "ICVFX最佳实践"]
---

# ICVFX最佳实践

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / ICVFX / ICVFX最佳实践

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/in-camera-vfx-best-practices-in-unreal-engine

在为"摄像机内视效（以下简称ICVFX）"搭建拍摄场景时，会面临一些挑战。两个主要的问题是：

- 让LED幕墙中的资产看起来足够逼真。
- 优化场景性能，确保其实时运行。

要解决这些问题，需要美术团队和舞台团队密切协作。许多特效在电脑工作站上运行时，效果可能很不错，但换成LED墙后可能会跑不动。这需要团队之间有足够沟通，来避免这种差异所带来的许多问题。

在开发ICVFX项目时，你可以参考本文中的内容。本文无法涵盖方方面面，也非绝对正确。你应该结合项目的实际情况，以此来最大限度提升性能。

## 项目设置

- 首先请确保正确设置你的项目，确保其高效运行。请参阅[ICVFX制片测试](../../../../samples-and-tutorials/engine-feature-examples/incamera-vfx-production-test-sample-project/index.md)文档，了解我们推荐的项目设置示例，然后按照你的项目要求酌情修改。
- 我们建议禁用 **虚拟现实（Virtual Reality）** 和 **混合现实（Mixed Reality）** 插件。这能减少运行虚幻引擎所需的资源，而且除了用于[虚拟勘景](../../../../building-virtual-worlds/virtual-scouting/index.md)和[Live Link XR](../../../../animating-characters-and-objects/skeletal-mesh-animation-system/live-link/livelinkxr/index.md)的情况之外，这些插件对于虚拟制片用途不大。
- 确保在 **内容浏览器（Content Browser）** 中定义你的 **项目结构（Project Structure）**。当你需要制作多个关卡和场景时，强烈建议你从一开始就定义一个目录结构，供美术师使用。
- 这里有一个ICVFX制片测试中的推荐结构：

  [ICVFX制片测试](../../../../samples-and-tutorials/engine-feature-examples/incamera-vfx-production-test-sample-project/index.md)

## 性能目标和分析

就采用虚幻引擎的实时渲染应用来说，项目在编辑器中运行时的性能通常要比发布后的效果差。但对ICVFX来说，项目在编辑器中的性能会明显好于虚拟制片舞台上的最终目标帧率。

nDisplay会带来额外的性能开销，因为要在ICVFX环境中渲染多个视图，并且在渲染期间要执行额外步骤来确保同步。此外，不同的拍摄舞台以及工作站（创建内容用），硬件规格可能不同，因此在创作内容时，要将这些差异与你的帧率目标一同考虑。

在[ICVFX制片测试](../../../../samples-and-tutorials/engine-feature-examples/incamera-vfx-production-test-sample-project/index.md)示例中，所有资产都是在一台采用双NVIDIA RTX 8000显卡和128GB DDR5 RAM内存的电脑上创建的；其目标舞台渲染节点采用双NVIDIA A6000显卡和128GB DDR5 RAM内存。

为了保证足够的性能预算，我们先设法让项目在美术师的工作站上达到 48 - 72 FPS，用的是4K全屏画面，分辨率比例是100%。我们把此作为基准。之后，我们还会在舞台外，对目标设备作进一步测试。该设备会在nDisplay中运行场景，其视口配置会尽可能模拟舞台设备工作负荷最厉害的情况。此外，临近制片前，我们会使用预期的硬件，在舞台上频繁测试场景。

本文主要关注ICVFX流程的性能提升和分析，除本文外，我们还推荐你查阅[测试和优化](../../../../testing-and-optimizing-content/index.md)，特别是[Unreal Insights](../../../../testing-and-optimizing-content/unreal-insights/index.md)一文，了解有关提高项目性能的更多资源。

在为舞台准备场景时，请考虑以下情况：

- 尽管把项目初期的目标帧率设置为最终帧率的 2-3倍，对于美术师来说可能会比较严苛，但不要以为这样就能应付一切情况，因为并非所有场景都会在性能上等比缩放。我们强烈建议你经常开展性能测试并记录结果。制片环节中的每一个人都有责任保障性能。只有及早测试、频繁测试，你才能避免在现场遇到性能不佳的情况。
- 请尽量在内容开发工作站上达到 **目标帧率**，并确保工作站与ICVFX片场的渲染节点规格一致。

  - 虽然很难让所有美术师的工作站都达到同等水平，但应务必保证至少有一台工作站能够访问，用于性能分析。
  - 可扩展性设置可用于近似模拟目标硬件的性能，但这样做的准确性较低，应仅用作大致的指引。
- 请在与舞台设备拥有相同规格的设备上定期执行 **性能分析**，并让场景的运行配置等同于任务最重的渲染节点的配置。这意味着，在为单个节点设置相关的内视锥和外视锥时，要使用舞台上使用的最大分辨率设置。
- 尽可能与舞台团队一起对舞台内容进行性能测试。不要把测试留到制片的最后一刻，也不要假定舞台团队会优化性能。
- 窗口缩放可能会影响引擎性能：

  ![窗口缩放](../../../../../assets/images/54/541ed2e8290d25aa65457c969452d80e038476ca1de8f61718962919d083f8aa.png)
- 使用[Unreal Insights](../../../../testing-and-optimizing-content/unreal-insights/index.md)生成nDisplay追踪。请参回看这场[直播](https://www.youtube.com/watch?v=TygjPe9XHTw)，了解具体方法。GPU性能分析和CPU性能分析这两篇文档也有所帮助。

## 资产创建和LOD

- [LOD](../../../../working-with-content/static-meshes/creating-and-using-lods/index.md)：当网格体在屏幕的渲染画面变大变小时，LOD会在不同数量级别的多边形间切换。LOD基于屏幕尺寸计算。
- **网格体表现（Representations）**：

  - 当资产十分靠近摄像机时，会用最原始的网格体表示。
  - 当资产离屏幕更远，不需要纹理和多边形细节时，可以用代理网格体表示。一般方法是，先用最复杂的着色器和最高分辨率纹理来创建原始几何体模型，然后用DCC应用，或用代理网格体工具来创建低分辨率版本的模型，并用简化的着色器烘焙纹理。
  - 如果资产在拍摄期间距离摄像机可近可远，则使用LOD来灵活调整。
  - 你可以在编辑器内为单个资产或一组背景资产生成代理网格体。请参阅[代理几何体概述](../../../../working-with-content/static-meshes/proxy-geometry-tool/proxy-geometry-tool-overview/index.md)，了解更多信息。
  - 同一个Actor中，共享相同材质的局部群集可以使用 **合并Actor（Merge Actors）** 合并到一起。

    - 如果Actor的某个局部群集使用不同的网格体和材质，你可以使用"合并Actor"将这些材质合并成一个共享材质资产，并将各种纹理合并成一个图集，以此降低绘制调用。这对于优化中等距离的资产最有用，因为合并图集可能会降低品质，导致纹理变小。假如要在资产距离摄像机较近时使用这种方法，应具体情况具体分析，只要品质降低不太明显就行。
    - 你可以将LOD和其他性能优化技巧用于合并的Actor。
- 对象剔除可能对性能产生负面影响。大型对象的剔除方式比较麻烦，从而可能会影响性能。静态场景相对还好，但假如LED摄影棚中的内容会在整个场景中移动，那么就要考虑大型对象的剔除问题。鉴于此，在合并网格体时，请不要将太多Actor合并到一起，因为大型网格体会影响剔除合并网格体的能力。
- [自动LOD](../../../../working-with-content/static-meshes/static-mesh-automatic-lod-generation/index.md)可能会让资产显得更柔和、朦胧。我们建议你留出一些预算来使用手动创建的LOD。

  > [!NOTE]
  > 只有LOD 1（也可能包括LOD 2）才可能需要手动创建。超出这两个级别之后，模型在屏幕不会很大，细节会看不太出。
- 尽可让美术总监、制片设计师或其他核准人员亲自看下优化后的版本，否则因为优化产生的预期外差异可能会增加你的预算并延长制作时间。
- 边工作边优化，不要把优化过程留到最后。定期优化项目更容易持续获得美术总监的认可。这样还能让你空出更多系统资源，用于其他地方，比如提高品质或实现动态特效，例如体积雾或动态光照。

  - 此外，我们建议你一开始就开启要使用的高品质和动态特效，这样就能完整了解性能的开销情况，还有多少性能冗余，是否要用控制台变量调整品质等等。
- 四边形过度绘制（Quad Overdraw）会极大幅度增加性能开销。要最大限度减少这种影响，请考虑以下问题和优化：

  - 避免过多使用半透明效果，尤其是大范围的半透明区域。我们建议改用遮罩材质，因为这样能降低性能开销。
  - 避免大量网格体堆叠。模型应该根据其屏幕尺寸创建。所有在线框模式下显示为实心的网格体，或接近实心颜色的网格体，都可能降低性能。
  - 法线贴图只应用于表现细节。不要将法线贴图用于一般的几何体。
  - 使用 **四边形过度绘制（Quad Overdraw）** 视口模式来分析场景。应避免出现绿色或更糟糕的情况，这样能降低四边形过度绘制的次数。屏幕中大部分画面应该是蓝色。
  - 请务必思考网格体最终会在LED屏幕上显示为多大。根据我们的经验，许多团队都没有仔细思考几何体的最终用途。假如一座山在LED墙上仅占100px x 100px，它就没必要包含200万个三角面。
  - 上述优化同样适用于纹理。GPU 没必要为对象加载8K纹理，除非对象就在摄像机前。
- 复用资产，让引擎尽可能用资产实例。避免使用太多唯一性的网格体，因为这样会降低性能。使用 **统计数据（Statistics）** 窗口来找出场景中的唯一资产或很少复用的资产。如果你在 **HWInstance** 列中看到大量1或2，就要小心了。也有一些例外情况，比如合并Actor后，或创建代理网格体后，也会生成新的唯一性Actor。
- 尽可能减少网格体上的材质ID数量。设法让每个资产只有1个材质。你可以用"合并Actor（Merge Actors）"来实现此目的。每个材质ID都意味着一次绘制调用。要降低性能开销，就要将绘制调用保持在最低水平。理想情况下，资产在导入时都已具备了正确数量的材质ID。
- 使用[材质函数](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/material-functions/index.md)来封装常用功能，让材质更易于维护，避免内容膨胀。
- 使用[材质参数集合](../../../../designing-visuals-rendering-and-graphics/unreal-engine-materials/material-functions/index.md)，简化材质设置。
- 尽可能使用主材质，这能让批量更改更容易。但请记住，如果主材质包含许多开关（switch），会增加着色器排列，进而增加编译时间。你需要在易维护性与编译时间之间取得平衡。请避免在片场的最后一刻时改动主材质，因为可能会有大量材质需要重新编译。
- 让距离摄像机近的资产使用复杂着色效果。让离摄像机远的资产使用简单着色。使用静态开关，避免为不同品质级别创建多个主材质；使用LOD来实现。然后，当对象距离很远时，相比使用大量复杂节点计算材质，我们建议直接将效果烘焙到纹理上，以减少着色器复杂度（也即指令数）。你可以回看我们的直播：[将材质烘焙到纹理](https://youtu.be/WaM_owaUpbE&sa=D&source=editors&ust=1633124927652000&usg=AOvVaw2VeZdLzVhs5UKFm6dUKB1L)，了解更多信息。
- 就视效和性能来说，4k或8k高分辨率资产几乎永远都不是上佳之选。很多时候，在实时拍摄期间，未必越"多"越好。超高清纹理在大多数情况下都用不到，而且会耗用本可以由其他场景元素使用的内存。请参阅[LOD纹理属性](../../../../gameplay-systems/networking-and-multiplayer/programming-network-multiplayer-games/replicate-actor-properties/index.md)和[图像序列中的Mipmap](../../media-framework/media-framework-overview/image-sequence-mipmapping/index.md)，了解更多信息。
- 考虑到Mipmap和流送，纹理长宽必须是2的乘方，但不必是正方形。它可以是矩形，只要长宽分辨率都是2的乘方即可。例如，128x256和256x256的纹理能正常工作，但8080x8080不行。
- 你要使用贴花吗？如果不是，请在 **项目设置（Project Settings）** 中禁用 **延迟贴花（Deferred Decals）**。
- 不要使用视频类内容，改用[图像序列视图（Flipbook）](../../../../animating-characters-and-objects/paper-2d-overview/paper-2d-flipbooks/index.md)。

  - 在ICVFX中，你肯定希望墙壁上所有节点都同步渲染。鉴于视频内容的编码方式，无法很好地同步视频，也无法确保每台机器都"指向"视频的同一"帧"。
  - 你可以使用纹理Flipbook（用材质参数驱动），或用EXR序列（由关卡序列驱动），这两种方法都适合用来实现动画序列的同步。

## 光照和渲染

- **高效光照（Efficient lighting）：** 避免光线追踪或过度使用动态光源，因为这类[光照](../../../../building-virtual-worlds/lighting-the-environment/index.md)开销很大。请改用更高效的方法，比如光照烘焙或其他低开销工具。只要使用得当，动态光照是一个很有用的工具，但应谨慎使用。

  - 如果需要动态光照，请考虑禁用 **投射阴影（Cast Shadows）**，减少性能影响。
  - 尽量不要依赖[光源函数](../../../../building-virtual-worlds/lighting-the-environment/features-and-properties-of-lights/using-light-functions/index.md)和[矩形光源](../../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/rectangular-area-lights/index.md)，两者都很昂贵，而比较起来，[IES描述文件](../../../../building-virtual-worlds/lighting-the-environment/features-and-properties-of-lights/using-ies-light-profiles/index.md)和[聚光源](../../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/spot-lights/index.md)开销更低。
  - 请考虑使用[预计算光照场景](../../../../building-virtual-worlds/lighting-the-environment/global-illumination/using-precomputed-lighting-scenarios/index.md)，以便在片场快速切换不同设置。
- **nDisplay成本（nDisplay costs）：** 设置复杂的场景时，始终记住，使用nDisplay会增加额外的性能开销，会远超场景原本的正常开销。相同的场景，在工作站上用虚幻引擎渲染和在LED墙上为ICVFX渲染，其性能开销是不同的。
- [光线追踪](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)不是[路径追踪](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/path-tracer/index.md)。我们发现有些用户不太了解什么时候应该在虚幻引擎中使用光线追踪。由于光线追踪在性能方面很昂贵，你可以改用体积光照贴图和反射探头来烘焙光照，实现更美观、更稳定的图像品质。

  - 虽然GPU Lightmass需用到光线追踪才能正常运作，但它不必用到其他一些会默认启用的光线追踪功能，例如光线追踪阴影、环境光遮蔽、全局光照和反射。所以，最好用控制台命令禁用这些功能：

    ```
          r.RayTracing.ForceAllRayTracingEffects 0
    ```

    请参阅[GPU Lightmass全局光照](../../../../building-virtual-worlds/lighting-the-environment/global-illumination/gpu-lightmass-global-illumination/index.md)，了解更多信息。
  - 使用其余这些光追特效也未必不可，前提是设备足够强大，能够应付这些特效。例如，[ICVFX制片测试](../../../../samples-and-tutorials/engine-feature-examples/incamera-vfx-production-test-sample-project/index.md)中用到了光线追踪阴影和光线追踪反射。
  - 假如你的项目需要用到光线追踪，我们建议你检查所有主材质，用 `RayTracingQualitySwitch` 来优它们在光追场景中的表现。此外，我们建议查看所有光线追踪设置，如采样、射线距离、反弹等。请参阅[光线追踪](../../../../building-virtual-worlds/lighting-the-environment/ray-tracing-and-path-tracing-features/hardware-ray-tracing/index.md)，了解更多信息。
- 通常，没有必要使用 **电影级（Cinematic）** 的 **引擎可扩展性（Engine Scalability）** 品质设置。相反，我们建议降低所有品质设置，使其在视觉效果上与电影级效果几乎相同，这样可以让场景节省大量性能开销。

  > [!NOTE]
  > 电影级品质设置会自动确定其他若干设置的数值，因此在使用更低等级的设置后，必须手动设置其中某些值。
- 在新项目开始时，检查 **项目设置（Project Settings）** 中的所有[渲染](../../../../designing-visuals-rendering-and-graphics/index.md)设置，然后根据项目需求来启用或禁用设置。这会重新编译所有着色器，不过在生成完[派生数据缓存](../../../../production-pipeline/using-derived-data-cache/index.md)后，就不会再需要重新编译着色器。
- 有些客户不太愿意烘焙光照，因为他们希望能够快速更改效果。因此，如何同时用好烘焙 *和* 动态光照就很重要。

  - 使用烘焙光照时，我们建议你合理设置光照贴图分辨率。不需要设置成4096p分辨率。
- 如果你不使用烘焙光照，请在 **项目设置（Project Settings）** 中禁用 **允许静态光照（Allow Static Lighting）**。
- [体积云](../../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)和光照特效很昂贵。请谨慎使用它们。请在实现所需外观后再烘焙体积云。
- [体积雾](../../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-fog/index.md)性能开销很大，因此，我们建议你改用常规雾效或着色器技巧。如果需要体积雾，我们建议调整其品质。请使用以下控制台变量优化体积雾：

  | 控制台变量命令 | 说明 |
  | --- | --- |
  | r.VolumetricFog.GridPixelSize 8 | 8是默认值，增加该值可提升性能，例如增加到16。请谨慎更改这些值，因为可能会导致视觉瑕疵。 |
  | r.VolumetricFog.GridSizeZ 128 | 128是默认值，降低该值可提升性能，例如减小到64。请谨慎更改这些值，因为可能会导致视觉瑕疵。 |
- **光照贴图（CPU和GPU）（Lightmaps (CPU & GPU)）**：设置合适的光照贴图。请参阅[展开光照贴图UV](../../../../working-with-content/static-meshes/understanding-lightmapping/index.md)，了解更多信息。

  - 请谨慎将光照贴图用于大型网格体，因为光照贴图的密度将被"稀释"。
  - 光照贴图自动生成算法很难对复杂网格体进行高效计算。生成的光照贴图可能包含一些细小UV三角形，这些三角形接收不到烘焙光照信息。在这种情况下，请考虑手动生成光照贴图。
- [动态光源重叠](../../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/movable-light-mobility/index.md)：请留意你的光源的半径和衰减距离，试着调整它们来避免光源重叠情况的发生；考虑为小型网格体禁用 **投射阴影（Cast Shadows）**。可以用 **光源复杂度（Light Complexity）** 视图模式来预览哪些位置有重叠。
- [动态阴影](https://dev.epicgames.com/documentation/404)：如果项目确实需要动态阴影，请确保你在性能与视效品质之间取得平衡。有几种方法可提高性能，并且对视效品质影响极低：

  - 使用[代理几何体阴影](../../../../working-with-content/static-meshes/proxy-geometry-tool/proxy-geometry-shadows/index.md)，简化复杂网格体的阴影。
  - 使用 **级联阴影贴图(CSM)** 时，你可以降低 **动态阴影距离（Dynamic Shadow Distance）** 和 **动态级联阴影数（Num Dynamic Cascade Shadows）** 设置，以实现更好的性能。
  - 考虑切换为 **距离场（Distance Field）**(DF)阴影或 **远距离阴影级联（Far Shadow Cascade）** 阴影。由于DF阴影是静态的，并且远距离级联阴影仅用于特定Actor，两者的表现都好于动态阴影。
  - 你还可以调整其他一些控制台命令，以提高性能。

    - r.ShadowQuality
    - r.Shadow.MaxResolution
    - r.Shadow.RadiusThreshold
    - r.Shadow.DistanceScale
    - r.Shadow.CSM.TransitionScale

      请参阅

      可扩展性参考

      文档，详细了解这些命令的用法。

## 舞台上

- 想办法在关卡中表示你的3D舞台，确保舞台地面平整。舞台区域需要清空全部CG资产，包括草地或植被；此外，请留意场景中的移动资产，或者避免让粒子发射器进入3D舞台体积。设置一个舞台对于开发和关卡设计很有用，能让你围绕舞台区域准确搭建场景。

  - 理论上，LED影棚中不应放置用于拍摄的3D资产。但在实践中，可以有一些3D资产；假如是这种情况，请避免舞台中的地板或天花板出现在画面中，因为这可能会导致画面出现不同景深从而穿帮。在舞台使用3D资产来拍摄时请务必仔细。
- 用[Web远程控制](../../../../production-pipeline/scripting-and-automating-the-unreal-editor/remote-control/index.md)功能或蓝图来创建实时操控选项，以便在片场使用iPad或平板电脑来控制。
- 阳光的直接光照很难在舞台上模拟，因此假如舞台在户外，我们建议你将舞台搭建在遮荫环境下。
- 考虑到舞台上的摄像机位置和距离。你不需要让所有对象都采用电影级渲染品质，只需关注摄像机视口内的内容即可。
- 留意你的场景是否为静态场景，还是需要在背景中添加一些运动或动画内容。渲染动态背景的开销很大，特别是以高品质渲染时。
