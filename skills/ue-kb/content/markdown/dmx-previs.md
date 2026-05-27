# DMX Previs

---
title: "DMX Previs"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dmx-previs-sample-project-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "DMX Previs"]
---

# DMX Previs

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / DMX Previs

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dmx-previs-sample-project-for-unreal-engine

DMX Previs示例是一个完全动画化的数字灯光秀示例，采用了虚幻引擎的[DMX](../../../working-with-media/communicating-with-media-components-from/dmx/dmx-overview/index.md)插件。 此示例由我们与[Moment Factory](https://momentfactory.com/home)合作创建，用于展示现场活动的视效预览效果，同时确保在数字场景中尽可能重现现实中的相关技术。 为了利用虚幻引擎的渲染能力，并展示新开发的代理灯具系统，该示例采用了一个照亮整个开放空间的复杂照明装置。

> [!WARNING]
> 这段视频中的灯光会出现反复闪烁，可能引起不适或导致光敏性癫痫患者的癫痫发作。 建议观众谨慎观看。

Moment Factory的现场活动视效预览DMX示例项目|虚幻引擎

研究和修改此示例将帮助你了解如何实现以下操作：

- 使用DMX插件Sequencer集成，记录并在外部照明台上播放已编程的整个现场活动。
- 使用可扩展灯具系统为真实硬件设备创建你自己的支持DMX的虚拟灯具。
- 为实时视效预览和高质量媒体导出定制和调整灯具的渲染函数。

> [!NOTE]
> 此项目会占用大量CPU性能，因为需要在Sequencer中播放DMX轨道，同时也会占用大量GPU性能，因为需要渲染高品质体积光束效果。 有关此项目的硬件需求，请参阅"灯具和硬件"小节。

## 入门指南

使用DMX Previs示例项目的步骤如下：

1. 通过**Fab**访问[DMX预览示例](https://fab.com/s/14fbd7034e1b)，点击**添加到我的库（Add to My Library）**，即可在**Epic Games启动器**中显示该项目文件。

   1. 或者，你也可以在启动程序的Fab中或UE的Fab插件中搜索该示例项目。
2. 在**Epic Games启动器**中，找到**虚幻引擎 > 库 > Fab库**以访问项目。

   > [!NOTE]
   > 只有在你安装了兼容的引擎版本时，示例项目才会出现在**Fab库**中。
3. 点击**创建项目（Create Project）**并按照屏幕上的提示下载示例并启动新项目。

要了解有关从Fab访问示例内容的更多信息，请参阅[示例与教程](../../index.md)。

1. 按下**播放（Play）**查看视效预览序列。

   ![播放视效预览序列](../../../../assets/images/b9/b91a4e6952a714e5495808436eaa2c94a866decf4deff685ce4184aa9029fff2.jpg)

> [!NOTE]
> 要以最佳性能查看灯光秀，使用**发布（Shipping）**配置构建项目。
>
> 按以下步骤将项目的构建配置设为**发布（Shipping）**：
>
> 1. 在编辑器的主菜单中，选择**文件（File）>打包项目（Package Project）>构建配置（Build Configuration）**，然后选择**发布（Shipping）**。
> 2. 选择**文件（File）>打包项目（Package Project）>Windows**，使用**发布（Shipping）**配置打包项目。
>
> ![虚幻编辑器菜单中的发布构建配置选项](../../../../assets/images/a6/a6613fd70bff1f2b3da76bf8e35cab580c57a8bfb90bc39544fa8c51ca0fe514.jpg)

## 从多个角度查看灯光秀

打开项目并按**在编辑器中运行（Play in the Editor）**后，序列从过场动画摄像机视图开始播放。

要从虚拟观众席的其他角度观看灯光秀，可以使用项目的[关卡蓝图](../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/types-of-blueprints/level-blueprint/index.md)中定义的播放功能按钮切换摄像机视图，或者禁用**Sequencer**中的过场动画摄像机。 两种方法详见下文。

![观看灯光秀](../../../../assets/images/29/29783c6feafb3a472ddbbcaccaa13344386ff171db6c03647f8687c7a28fe59e.jpg)

图像由Moment Factory提供。

### 显示播放功能按钮

启动虚幻会话后，可以使用以下播放功能按钮。

| 按键 | 说明 |
| --- | --- |
| **F9** | 显示FPS计数器（独立版和发行版）。 |
| **空格键** | 暂停或恢复序列和DMX播放。 |
| **T** | 在过场动画与自由摄像机之间切换。 在自由摄像机模式下，可以移动摄像机来近距离观察灯具，并从其他角度观看灯光秀。 |
| **V** | 在预定义的摄像机视图之间循环。 |
| **R** | 重新启动序列和DMX播放。 |
| **Escape** | 退出会话。 |

### 禁用过场动画摄像机

可以使用**T**切换键在自由摄像机与过场动画之间切换。 按**V**在预定义的摄像机位置之间切换。 按以下步骤在灯光秀期间完全关闭影视级摄像机。

1. 在**内容浏览器（Content Browser）**中点击**内容（Content）>序列（Sequences）**，打开其中的**DMXPrevis_Animations**。

   ![内容浏览器中的DMX Previs动画](../../../../assets/images/58/580d7053a88ab3bd1693b814745df89292bb54070ba0d0f706aaae60957fc55b.jpg)
2. 在**Sequencer**窗口中，右键点击**镜头切换（Camera Cuts）**轨道并从选项中选择**静音（Mute）**。

   ![Sequencer窗口镜头切换轨道静音选项](../../../../assets/images/1f/1f1f2f2a9e066de426e16f98392d47a8fbcf013415b3742bc56cd8abaf819f3a.jpg)
3. 按**播放（Play）**。 你可以自由移动摄像机，从不同角度观看灯光秀。

## 实时修改灯光秀

当DMX轨道在Sequencer中播放时，如果能在观看的同时修改其效果，那就再好不过了。 本节就将介绍如何更改某些灯具的外观和效果。

> [!NOTE]
> 项目包含的资产比本节中所述的更多。 探索项目中所有的灯具；每种类型都有自己的蓝图和功能。

### 更改点光源距离

按以下步骤修改某些光源的光源距离值。 减小此值可以帮助提高播放期间的性能；增大此值可以产生更多的体积光束效果。

1. 在**世界大纲视图（World Outliner）**的搜索栏中键入**Spot**，选择所有筛选出来的资产。

   ![按Spot一词筛选资产](../../../../assets/images/7a/7a75a8c923fa819eaa6426ebe8a8d2460dc6956bf413e608080dfbce59e4730e.jpg)
2. 在**细节（Details）**面板中，将**光源距离最大值（Light Distance Max）**属性从**5000.0**更改为较小的值以改善性能，或更改为较大的值，以提高体积效应。

   ![光源距离最大值5000](../../../../assets/images/93/9346b5032c3158da456437352ad76c658f8bf2b575fe477b8667d4660e19d3b0.jpg)

   ![光源距离最大值1000](../../../../assets/images/6b/6b0303d17d1e7e7ab3c9d8ee0f84faf625459ac0524887ee2d7007caf480238f.jpg)

   光源距离最大值5000

   光源距离最大值1000

### 调整光束质量

所有使用的灯具都是专为该项目定制的，并具有自适应质量逻辑，以实时平衡速度和质量。 自适应质量逻辑在**内容（Content）>DMX>灯具材质（FixtureMaterials）**中的**M_Beam_Inhibitive_Master**材质中定义。

> 图片已省略：fixture materials in the content browser

此材质将根据实时DMX变焦角度动态调整体积光束着色器示例数。

- 要保持高性能并最大程度降低对视觉效果的影响，光束越宽，示例数越少。
- 要提高光束锐度，光束越窄，示例数越多。

可在**材质编辑器（Material Editor）**中调整**M_Beam_inhibitive_Master**材质的质量设置。 这些设置位于**参数默认值（Parameter Defaults）**面板中。

> 图片已省略：材质参数默认值面板

- **低质量级别（Low Quality Level）：**定义预定义示例数的最低可能倍数。
- **最高质量级别（Max Quality Level）：**定义预定义示例数的最高可能倍数。
- **使用MRQ重载（Use MRQ Override）：**对所有灯具材质和材质实例应用特定乘数，而不考虑设置的最小和最大值。 在导出项目的高质量视频或图像序列时，此属性很有用。
- **基于变焦的强度（Zoom Based Intensity）：**启用后，当变焦较宽时，光源函数会降低强度，但当变焦较窄时，会更接近预期的亮度。 这模拟了真实光源的行为，当光束较宽时，任何给定表面上的亮度都较低。

> 图片已省略：低质量级别0.3最高质量级别1.0

> 图片已省略：低质量级别0.3最高质量级别5.0

低质量级别0.3最高质量级别1.0

低质量级别0.3最高质量级别5.0

*左图中，最高质量级别（Max Quality Level）设为1，这会产生 更具颗粒感的光束。 右图中，最高质量级别（Max Quality Level）设为5， 光束看上去更锐利。*

> [!NOTE]
> **质量级别（Quality Levels）**设为大于**1**的值意味着使用[影片渲染队列](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline#movierenderqueue)进行离线渲染。 对于本项目，**质量级别（Quality Level）**的**低质量级别和最高质量级别**通常都设为**2**，以生成画面。

### 更改T形台单元数

按以下步骤更改"T形台"中使用的DMX灯具矩阵的单元数。

1. 在项目的**内容浏览器（Content Browser）**中，双击**DMXLib_v4**资产打开**DMX库编辑器（DMX Library Editor）**。

   > 图片已省略：内容浏览器中的DMX库资产
2. 在**灯具类型（Fixture Types）**选项卡中，选择**矩阵/像素条（Matrix/Pixel Bar）**下的**T形台地带（CatwalkStrip）**。 本例将修改**模式属性（Mode Properties）**。

   > 图片已省略：catwalk strip mode properties
3. 在**模式属性（Mode Properties）**面板中，将**Y单元（Y Cells）**属性值从**5**更改为**20**。

   > 图片已省略：changing the value of the y cells property
4. 在**世界大纲视图（World Outliner）**中，选择所有**T形台地带（CatwalkStrips）**资产。
5. 在**细节（Details）**面板的**DMX矩阵灯具（DMX Matrix Fixture）**分段，点击**生成预览网格体（Generate Preview Mesh）**，以使用在DMX库中所做的更改更新视口中的网格体。

   > 图片已省略：细节面板DMX矩阵灯具分段生成预览网格体按钮
6. 在视口中，所有**T形台地带（CatwalkStrips）**现在都有更多单元。

   > 图片已省略：catwalk 5 Y cells

   > 图片已省略：catwalk 20 Y cells

   catwalk 5 Y cells

   catwalk 20 Y cells

## 使用影片渲染队列导出媒体

在典型的现场活动视效预览工作流中，设计人员和美术师会为了更快的迭代而采用较低质量级别。 它可用于渲染高质量图像序列或Apple ProRes文件，以供审查。

本示例包括[影片渲染队列](https://dev.epicgames.com/documentation/assets/animating-characters-and-objects/Sequencer/movie-render-pipeline#movierenderqueue)的两个预设值，用于生成高分辨率媒体。 这些预设值位于**内容（Content）>过场动画（Cinematics）>影片管线（MoviePipeline）>预设值（Presets）**中。 两个预设值有不同的分辨率：

- **UHD**：导出到Apple ProRes 422 HQ的超高清（3840x2160）的预设值。
- **FHD**：导出到Apple ProRes 422 HQ的全高清（1920x1080）的预设值。

> 图片已省略：movie render queue presets

按以下步骤使用影片渲染队列导出高质量媒体。

1. 在项目的**世界大纲视图（World Outliner）**中，选择所有聚光源并将其**光源距离最大值（Light Distance Max）**属性设置为**12,000**。

   > 图片已省略：spotlight light distance max 12000
2. 在项目的**内容浏览器（Content Browser）**中，导航到**DMX>灯具材质（FixtureMaterials）**。
3. 在材质编辑器中打开**M_Beam_Inhibitive_Master**材质。
4. 在**材质编辑器**的**参数默认值（Parameter Defaults）**面板中进行以下操作：

   1. 将**低质量级别（Low Quality Level）**设为**2.0**。
   2. 将**最高质量级别（Max Quality Level）**设为**2.0**。

   > 图片已省略：quality levels set to 2
5. 关闭材质编辑器。
6. 在主编辑器中，选择**窗口（Window）>过场动画（Cinematics）>影片渲染队列（Movie Render Queue）**，打开**影片渲染队列（Movie Render Queue）**窗口。

   > 图片已省略：open the movie render queue window
7. 按**添加渲染（Add Render）**按钮，选择**DMXPrevis_Animations**关卡序列。

   > 图片已省略：select the DMX previs animations level sequence
8. 在**设置（Settings）**列，点击下拉箭头并选择所需预设值，即UHD或FHD。

   > 图片已省略：select the preset in the settings column
9. 点击**渲染（本地）（Render (Local)）**以便在本地导出已渲染的帧。

   > 图片已省略：点击渲染本地

> [!NOTE]
> 可将**M_B_Inhibitive_Master**中的**MRQ重载（MRQ Override）**参数设置为**1.0**，以重载**低质量级别**和**最高质量级别**。

## 现场活动视效预览项目文件结构

此示例项目包括各种资产，以便使用DMX重新创建观众席和完整的灯光秀。 为了帮助你探索项目中的所有内容，请参阅下面所有文件夹的描述。

### 内容浏览器

> 图片已省略：内容浏览器层级中的DMX子文件夹

**内容（Content）**文件夹包含以下子文件夹：

- **资产（Assets）：**舞台和观众席的一般项目和关卡资产。
- **音频（Audio）：**灯光秀的音轨。
- **蓝图（Blueprints）：**[游戏模式](../../../gameplay-systems/gameplay-framework/game-mode-and-game-state/index.md)使用旁观者Pawn重载。
- **过场动画（Cinematics）：**用于超高清（UHD）和全高清（FHD）离线渲染的[影片渲染队列](../../../animating-characters-and-objects/cinematics-and-movie-making/movie-render-pipeline/index.md#movie-render-queue)设置。
- **DMX：**所有DMX相关内容。

  - **磁盘（Disks）：**特定项目的DMX灯具遮光板，可控制光源的形状和图案。 给定的光源在整场灯光秀中可以有多个遮光板，并可以动画化。
  - **效果表（EffectTables）：**定义项目中使用的支持DMX的光源类型的效果。
  - **灯具材质（FixtureMaterials）**：特定项目的已优化DMX灯具材质。 这是DMX插件附带的扩展内容。
  - **灯具蓝图（FixturesBP）：**特定项目的照明灯具蓝图。 这是DMX插件附带的扩展内容。
  - **遮光板轮（GoboWheel）：**与**磁盘（Disks）**文件夹的内容相同，但作为单独的纹理。
  - **插件（Plugins）：**实用的DMX工具和控件。
  - **SpecialFXBP：**特定项目的火焰、激光和烟花灯具资产。 它还包含舞台中央DMX受控的球体。
  - **DMXLib_v4：**项目核心[DMX库](../../../working-with-media/communicating-with-media-components-from/dmx/create-a-dmx-library-and-add-fixture-patches/index.md)，包含所有灯具定义、域和补丁。
- **效果（Effects）：**

  - **泛光（Bloom）：**特定项目的高质量复杂泛光**纹理**，无条纹。
  - **烟花（Fireworks）：**特定项目的烟花**蓝图**和[Niagara](../../../visual-effects/index.md)粒子系统。
  - **闪光（Flash）：**观众手机光源和**Niagara**粒子系统。
  - **RockLevitation：**漂浮岩石**Niagara**粒子系统。
  - **水材质（WaterMaterials）：**项目的高质量水材质。
- **地图（Maps）：**关卡的不同部分都包含在单独的地图中：

  - **主要（Main）：**包含Sequencer轨道、后期处理体积和音轨的持久关卡。
  - **DMXControlled：**此关卡包含所有DMX受控的元素、照明灯具和效果。
  - **地形（Terrain）：**此关卡包含地形和岩层。
  - **现场（Venue）：**此关卡包含现场和结构相关的Actor，例如舞台、观众和灯光架。
- **MegaScans：Quixel MegaScan**资产，用于地形和环境。
- **影片（Movies）：**包含用于播放影片的[媒体框架](../../../working-with-media/integrating-media/media-framework/index.md)资产。

  - **Clock_LED：**包含用于对围绕T形台的时钟LED进行动画处理的图像序列。
  - **窗帘（Drapes）：**包含窗帘视频投影的图像序列。
- **MSPresets：**MegaScan预设值资产。
- **序列（Sequences）：**包含[关卡序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md)。
- **灯光秀文件（Showfile）：**来自[grandMA2](https://www.malighting.com/downloads/products/grandma2/)照明控制台的灯光秀文件（`.zip`）。 你可以解压缩该文件，并在控制台上使用。
- **启动（Splash）：**项目加载到虚幻编辑器中时的启动图像。
- **Tropical_Jungle_Pack：**用于环境的资产包。

### 世界大纲视图（World Outliner）

探索**世界大纲视图（World Outliner）**中的所有资产，特别是以下项目和文件夹：

- **摄像机（Cams）：**Sequencer过场动画和预定义摄像机位置使用的摄像机。
- **DMX_FX**和**DMX_LX：**DMX受控的灯具和效果。
- **DMXPrevis_Animations：**驱动灯光秀、音轨和DMX轨道的关卡序列。

## 灯具和硬件

此示例旨在使用以下灯具和硬件。

### 灯具

| 灯具名称 | 灯具类型 | 数量 |
| --- | --- | --- |
| 照明灯具 |  |  |
| **观众台条形灯（Audience Strip） - 无像素** | 自定义LED | 50 |
| **观众台洗墙灯-LEDPar灯（Audience Wash LED Par）** | Elation SixPar 300 | 12 |
| **T台条形灯（Catwalk Strip） - 5像素** | 自定义LED | 20 |
| **条形灯矩阵（Matrix Strip） - 5像素** | 自定义LED | 32 |
| **景观洗墙灯-LEDPar灯（Scenic Wash LED Par）** | Elation SixPar 300 | 14 |
| **SpotMH1** | Elation Proteus Maximus | 64 |
| **SpotMH2** | Robe Megapointe | 94 |
| **Strobe RGB** | Elation Protron 3K LED Strobe | 122 |
| **舞台条形灯（Stage Strip） - 5像素** | 自定义LED | 24 |
| **条形灯（Sun Strip） - 5像素** | 自定义LED | 90 |
| **灯光架顶灯（Truss Toner）** | Elation SixPar 300 | 220 |
| **WashMH1** | Ireos Space Canon | 8 |
| **WashMH2** | GLP X4 | 16 |
| **死亡金属LEDPar灯（Vomitory LED Par）** | Elation SixPar 300 | 2 |
| **照明灯具总数** |  | 768 |
| SFX灯具 |  |  |
| **烟花** | 不适用 | 8 |
| **激光RGB** | 不适用 | 6 |
| **烟火发射器** | 不适用 | 33 |
| **SFX灯具总数** |  | 47 |

### 光照控制台

| 硬件 | 数量 |
| --- | --- |
| **grandMA2光源** | 1 |
| **MA照明NPU** | 1 |

### DMX

| 规格 | 说明 |
| --- | --- |
| **通道** | 7368 |
| **DMX域（DMX Universes）** | 15 |
| **协议** | Art-Net |
| **唯一提示（Unique Cues）** | 144 |
| **时间码同步** | MIDI |

## 插件

以下插件提供此示例中所示的核心功能：

- DMX引擎
- DMX灯具
- DMX像素映射
- DMX协议
- 关卡序列编辑器
- 影片渲染队列

