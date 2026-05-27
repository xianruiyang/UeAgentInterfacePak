---
title: "视口显示标志"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/viewport-show-flags-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "关卡编辑器", "编辑器视口", "视口显示标志"]
---

# 视口显示标志

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 关卡编辑器 / 编辑器视口 / 视口显示标志

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/viewport-show-flags-in-unreal-engine

![Show Flag Header](../../../../../assets/images/d3/d3cda6e21a165962e88e7fa703b2112ce2ae08a637d3000980557f17b81e161d.jpg)

点击查看大图。

显示标志可在视口的 **显示（Show）** 菜单下找到。它们是你可以用来显示和隐藏在视口中查看的许多项目的手段。例如，你可以隐藏所有粒子，隐藏所有地形Object，或是进行关闭所有Sprite图标之类的更高级操作。

![Show Flag](../../../../../assets/images/9b/9b247feca347e7cbf4631cd2f2b2c03636f7279ce5d56a2dd2ed1798977c50a6.png)

点击查看大图。

## 普通

![Common Menu](../../../../../assets/images/a1/a141878c65df75cf305eea007d4a55cd980885ab4de63a66cfac8d6d2d65db41.jpg)

点击查看大图。

| **普通** |  |
| --- | --- |
| 名称 | 描述 |
| **抗锯齿（Anti-aliasing）** | 显示/隐藏抗锯齿效果。 |
| **大气（Atmosphere）** | 显示/. |
| **BSP** | 显示/隐藏关卡中的任何笔刷。*（**Alt + Q**）* |
| **碰撞（Collision）** | 显示/隐藏关卡中的碰撞Object。*（**Alt + C**）* |
| **贴花（Decals）** | 显示/隐藏场景中的贴花。 |
| **雾（Fog）** | 显示/隐藏高度雾效果。*（**Alt + F**）* |
| **网格（Grid）** | 显示/隐藏网格。 |
| **地形（Landscape）** | 显示/隐藏任何地形Object。*（**T**）* |
| **媒体平面（Media Planes）** | 显示/. |
| **寻路（Navigation）** | 显示/隐藏任何寻路网格体或其他寻路Actor。*（**P**）* |
| **粒子Sprite（Particles Sprite）** | 显示/隐藏场景中的任何粒子。 |
| **骨架网格体（Skeletal Meshes）** | 显示/隐藏场景中的任何骨架网格体。 |
| **静态网格体（Static Meshes）** | 显示/隐藏场景中的任何静态网格体。*（**Alt + W**）* |
| **半透明（Translucency）** | 显示/隐藏所有具备半透明材质的Object。顺便说一下，这也包括所有公告板图标。 |
| **控件组件（Widget Components）** | 显示/. |

## 后期处理

![Post Processing Menu](../../../../../assets/images/7f/7f16be9ea267239d0778aa176599de80624c5506f90fd9bba07ee096e491a665.png)

点击查看大图。

| 后期处理 |  |
| --- | --- |
| 名称 | 描述 |
| **泛光（Bloom）** | 显示/隐藏效果泛光。 |
| **摄像机缺陷（Camera Imperfections）** | 显示/隐藏摄像机缺陷效果。 |
| **颜色分级（Color Grading）** | 显示/隐藏颜色分级效果。 |
| **景深（Depth of Field）** | 显示/隐藏景深效果。 |
| **眼部适应（Eye Adaptation）** | 显示/隐藏眼部适应效果。 |
| **颗粒（Grain）** | 显示/隐藏颗粒效果。 |
| **HMD畸变（HMD Distortion）** | 显示/隐藏头戴式显示器（例如用于Oculus Rift的显示器）的畸变效果。 |
| **镜头光斑（Lens Flares）** | 显示/隐藏镜头光斑效果。 |
| **本地曝光（Local Exposure）** | 显示/. |
| **动态模糊（Motion Blur）** | 显示/隐藏动态模糊效果。 |
| **材质后期处理（Post Process Material）** | 显示/隐藏场景中任何可混合的材质后期处理的效果。 |
| **场景彩色边纹（Scene Color Fringe）** | 显示/隐藏任何场景彩色边纹效果的结果。 |
| **色调曲线（Tone Curve）** | 显示/. |
| **屏幕百分比（Screen Percentage）** | 显示/隐藏屏幕百分比后期处理效果的结果。 |
| **色调映射器（Tonemapper）** | 显示/隐藏色调映射器效果。 |
| **晕映（Vignette）** | 显示/隐藏晕映效果。 |

## 光源类型

![Light Types Menu](../../../../../assets/images/39/39bf128e3e12edb3e39c4b4ad5531e32d816c537350f2f9d8820bda22df06f87.jpg)

点击查看大图。

| 光源类型 |  |
| --- | --- |
| 名称 | 描述 |
| **定向光源（Directional Lights）** | 显示/隐藏来自场景中的定向光源Actor的光照结果。 |
| **点光源（Point Lights）** | 显示/隐藏来自场景中的点光源Actor的光照结果。 |
| **矩形光源（Rect Lights）** | 显示/. |
| **天空光照（Sky Lighting）** | 显示/隐藏来自场景中的天空光源Actor的光照结果。 |
| **聚光源（Spot Lights）** | 显示/隐藏来自场景中的聚光源Actor的光照结果。 |

## 光照组件

![Lighting Components Menu](../../../../../assets/images/42/426df2915bdd7b34816e618291462af76c246fc1d256d965cc2fe768d8e86317.jpg)

点击查看大图。

| 光照组件 |  |
| --- | --- |
| 名称 | 描述 |
| **环境光遮蔽（Ambient Occlusion）** | 显示/隐藏场景中的任何环境光遮蔽。 |
| **漫射（Diffuse）** | 显示/隐藏场景中的漫射光照结果，这包含了大部分场景颜色。 |
| **直接光照（Direct Lighting）** | 显示/隐藏直接光照结果，这包含了大部分场景高光。 |
| **动态阴影（Dynamic Shadows）** | 显示/隐藏场景中的动态阴影。 |
| **全局光照（Global Illumination）** | 显示/隐藏场景中的全局光照结果。 |
| **高光度（Specular）** | 显示/隐藏场景中的高光度结果。 |

## 光照功能部件

![Lighting Features Menu](../../../../../assets/images/72/72a17c35212e89ae38f18e378c421fcfaf2ffa038ad1f918a4272826950a687b.png)

点击查看大图。

| 光照组件 |  |
| --- | --- |
| 名称 | 描述 |
| **环境立方体贴图（Ambient Cubemap）** | 显示/隐藏环境立方体贴图的结果。 |
| **胶囊阴影（Capsule Shadows）** | 显示/. |
| **距离场环境光遮蔽（Distance Field Ambient Occlusion）** | 显示/隐藏从距离场网格体生成的环境光遮蔽的结果。 |
| **距离场阴影（Distance Field Shadows）** | 显示/隐藏从距离场网格体生成的全局光照的结果。 |
| **间接光照缓存（Indirect Lighting Cache）** | 显示/隐藏间接光照在动态Object上的结果。 |
| **光源函数（Light Functions）** | 显示/隐藏光源函数材质在光源上的结果。 |
| **光束（Light Shafts）** | 显示/隐藏光束的结果。 |
| **Lumen全局光照（Lumen Global Illumination）** | 显示/. |
| **Lumen反射（Lumen Reflections）** | 显示/. |
| **反射环境（Reflection Environment）** | 显示/隐藏反射环境的结果。 |
| **屏幕空间环境光遮蔽（Screen Space Ambient Occlusion）** | 显示/隐藏任何屏幕空间环境光遮蔽的结果。 |
| **屏幕空间接触阴影（Screen Space Contact Shadows）** | 显示/. |
| **屏幕空间反射（Screen Space Reflections）** | 显示/隐藏任何屏幕空间反射的结果。 |
| **次表面散射（Subsurface Scattering）** | 显示/隐藏屏幕空间中任何次表面散射的结果。 |
| **纹理光源配置文件（IES纹理）（Textured Light Profiles (IES Textures)）** | 显示/隐藏IES光照配置文件的结果。 |
| **体积雾（Volumetric Fog）** | 显示/. |
| **体积光照映射（Volumetric Lightmap）** | 显示/. |

## Lumen

![Lumen Menu](../../../../../assets/images/ef/efea0556a2a18255cabe8174fa60739fc5ee5ed5f451664a1cbca4d5e42cd29e.jpg)

点击查看大图。

| Lumen |  |
| --- | --- |
| 名称 | 描述 |
| **细节追踪（Detail Traces）** | 显示/. |
| **远景追踪（Far Field Traces）** | 显示/. |
| **全局追踪（Global Traces）** | 显示/. |
| **重新使用阴影贴图（Reuse Shadow Maps）** | 显示/. |
| **屏幕空间方向遮挡（Screen Space Directional Occlusion）** | 显示/. |
| **屏幕追踪（Screen Traces）** | 显示/. |
| **二次反射（Secondary Bounces）** | 显示/. |

## 开发人员

> 图片已省略：Developer Menu

点击查看大图。

| 开发人员 |  |
| --- | --- |
| 名称 | 描述 |
| **AI调试（AI Debug）** | 这会显示AI驱动的Pawn用于沿寻路网格体寻路的路径。 |
| **骨骼（Bones）** | 显示/. |
| **缓存虚拟阴影贴图（Cache Virtual Shadow Maps）** | 显示/. |
| **复合编辑器Primitives（Composite Editor Primitives）** | 显示/隐藏场景中的编辑器Primitives。 |
| **专用服务器调试绘图（Dedicated Server Debug Drawing）** | 显示/. |
| **禁用硬件遮挡检索（Disable Hardware Occlusion Queries）** | 显示/. |
| **Gameplay调试（Gameplay Debug）** | 这会显示AI驱动的Pawn用于沿寻路网格体寻路的路径。 |
| **GBuffer提示（材质属性）（GBuffer Hints (material attributes)）** | 对具有不恰当材质的Object上色。黄色表示Object不可能是不反光的，红色表示Object发出的光比其接收的还多。 |
| **命中代理（Hit Proxies）** | 显示/隐藏命中检测所使用的代理形状。 |
| **Log Visualizer** | 将Log Visualizer系统需要的任何数据拖到屏幕中。 |
| **创建合成编辑器Primitive不透明（Make Composite Editor Primitives Opaque）** | 显示/. |
| **屏幕调试（On Screen Debug）** | 这用于隐藏VisualizeTexture或统计输出等信息。 |
| **折射（Refraction）** | 显示/隐藏材质上的折射结果。 |
| **编辑器隐藏的Actor的阴影（Shadows of Editor-Hidden Actors）** | 显示在编辑器中隐藏的Object（例如通过按 **H** 键隐藏的Object）的动态阴影。 |
| **测试图像（Test Image）** | 显示用于显示器配置和图形设置的测试图像。 |
| **矢量场（Vector Fields）** | 显示/隐藏场景中的任何矢量场。 |
| **虚拟纹理Primitive（Virtual Texture Primitives）** | 显示/. |
| **可视化校正颜色（Visualize Calibration Color）** | 显示/. |
| **可视化校正自定义（Visualize Calibration Custom）** | 显示/. |
| **可视化校正灰度（Visualize Calibration Grayscale）** | 显示/. |

## 可视化

> 图片已省略：Visualize Menu

点击查看大图。

| 可视化 |  |
| --- | --- |
| 名称 | 描述 |
| **自适应景深（Adaptive Depth of Field）** | 对视图应用颜色编码过滤器，使被景深模糊的Object染上绿色，只有聚焦的区域才显示正常颜色。 |
| **泛光（Bloom）** | 显示一个可视化窗口，其中显示场景直方图以及各种设置如何影响泛光。 |
| **景深图层（Depth of Field Layers）** | 对视图应用颜色编码过滤器，使被近景深模糊的Object显示为绿色，被远景深模糊的Object显示为蓝色。被聚焦的Object显示为黑色。 |
| **距离场环境光遮蔽（Distance Field Ambient Occlusion）** | 显示根据网格距离场生成的环境光遮蔽的可视化表示。 |
| **仅绘制导致VSM无效化的几何体（Draw Only Geometry Causing VSM Invalidation）** | 显示/. |
| **全局距离场（Global Distance Field）** | 显示根据网格距离场生成的全局光照的可视化表示。 |
| **HDR** | 显示一个可视化窗口，其中显示场景直方图以及曝光设置如何影响亮度。 |
| **光线传播体积（Light Propagation Volumes）** | 显示用于光纤传播体积的体积可视化表示。 |
| **本地曝光（Local Exposure）** | 显示/. |
| **网格体距离场（Mesh Distance Fields）** | 显示为场景中的静态网格体生成的网格体距离场的可视化表示。 |
| **动态模糊（Motion Blur）** | 如果打开了动态模糊，此标志会将视图更改为动态模糊可视化查看器，让你看到用于计算模糊的动态矢量。 |
| **运动向量（Motion Vectors）** | 显示/. |
| **越界像素（Out of Bounds Pixels）** | 如果Object的某个像素存在于该Object的包围体之外，可能在包围体（而非网格体）位于画外时导致闪烁或Object消失。此可视化查看器会用蓝色、黄色和白色对这类像素上色。 |
| **物理场（Physics Field）** | 显示/. |
| **预计算的可视性单元（Precomputed Visibility Cells）** | 在配合预计算的可视性体积使用时显示预计算的可视性单元的可视化表示。 |
| **预览阴影指示器（Preview Shadows Indicator）** | 如果没有为静态/静止光源构建光照，将会在未构建的阴影中显示"预览（Preview）"字样。 |
| **屏幕空间反射（Screen Space Reflections）** | 屏幕空间反射的可视化表示。 |
| **阴影模型（Shading Models）** | 显示/. |
| **天空大气（Sky Atmosphere）** | 显示/. |
| **Strata材质（Strata Material）** | 显示/. |
| **次表面散射（屏幕空间）（Subsurface Scattering (Screen Space)）** | 让你可以在屏幕空间中看到次表面散射的可视化模式。 |
| **可视化关卡实例编辑（Visualize Level Instance Editing** | 显示/. |
| **可视化Probe上的光照（Visualize Lighting on Probes** | 显示/. |
| **可视化遮挡检索（Visualize Occlusion Queries** | 显示/. |
| **可视化后期处理堆栈（Visualize Post Process Stack** | 显示/. |
| **体积光照样本（Volume Lighting Samples）** | 在构建了静态光照的情况下，显示放置在Lightmass重要体积内部的体积光照样本的可视化表示。 |

## 高级

> 图片已省略：Advanced Menu

点击查看大图。

| 高级 |  |  |
| --- | --- | --- |
| 名称 | 描述 |  |
| **大气雾（Atmospheric Fog）** | 显示/隐藏场景中的大气雾Actor。 |  |
| **音频半径（Audio Radius）** | 显示/隐藏场景中的任何音频Actor的半径。 |  |
| **公告板Sprite（Billboard Sprites）** | 显示/隐藏关卡中的任何公告板Sprite。这不涉及Sprite粒子，只涉及公告板组件。 |  |
| **边界（Bounds）** | 显示/隐藏选定Object上的边界。 |  |
| **BSP拆分（BSP Split）** | 显示/隐藏世界场景几何体上的刷表面拆分。 |  |
| **摄像机宽高比条（Camera Aspect Ratio Bars）** | 显示/隐藏用于摄像机Actor中设置的特定宽高比的条形。 |  |
| **摄像机视锥体（Camera Frustums）** | 显示/隐藏场景中任何摄像机的视锥体。 |  |
| **摄像机安全框（Camera Safe Frames）** | 当通过摄像机Actor观察时，此标志显示该摄像机的安全框。安全框是距离屏幕边缘有一定距离的区域，在该区域中可以保证图像可见。 |  |
| **约束（Constraints）** | 显示/隐藏刚体约束。TODO |  |
| **延迟光照（Deferred Lighting）** | 显示/隐藏场景中的延迟光照。 |  |
| **植物叶子（Foliage）** | 显示/隐藏场景中的任何植物叶子Actor。 |  |
| **强制反馈半径（Force Feedback Radius）** | 显示/. |  |
| **青草（Grass）** | 显示/隐藏场景中的任何青草类Actor。 |  |
| **HISM/植被集合树（HISM/Foliage Cluster Tree）** | 显示/. |  |
| **HISM/植被遮挡边界（HISM/Foliage Occlusion Bounds）** | 显示/. |  |
| **实例化静态网格体（Instanced Static Meshes）** | 显示/隐藏场景中的任何实例化静态网格体。 |  |
| **大型顶点（Large Vertices）** | 显示/隐藏任何选定笔刷或静态网格体上大于通常水平的顶点。 |  |
| **关卡着色（Level Coloration）** | 用颜色对场景进行编码，使每个流送的关卡都得到不同的颜色。如果不使用关卡流送则无关紧要。 |  |
| **光源影响（Light Influences）** | 显示橙色线条，指出哪些光源影响到选定的Object。 |  |
| **光源半径（Light Radius）** | 显示/隐藏光源半径形状。*(**Alt + R**)* |  |
| **LOD父子关系（LOD Parenting）** | 使用LOD父子关系、MinDrawDistance等。如果禁用，将会显示LOD父子关系线条。 |  |
| **质量属性（Mass Properties）** | 显示/. |  |
| **网格体边缘（Mesh Edges）** | 这会叠加于视图的网格体线框上。 |  |
| **模式小部件（Mode Widgets）** | 显示/隐藏变换小部件，例如移动工具。 |  |
| **Nanite网格体（Nanite Meshes）** | 显示/. |  |
| **Niagara渲染器（Niagara Renderers）** | 显示/. |  |
| **纸2DSprite（Paper 2D Sprites）** | 显示/隐藏场景中的任何纸2DSprite Actor的半径。 |  |
| **物理材质遮罩（Physical Material Masks）** | 显示/. |  |
| **预计算可视性（Precomputed Visibility）** | 显示/隐藏场景中的任何预计算可视性体积的半径。 |  |
| **属性上色（Property Coloration）** | 显示/. |  |
| **渲染（3D）文本（Render (3D) Text）** | 是否渲染场景中可能存在的任何文本Actor或组件。 |  |
| **选择（Selection）** | 显示/隐藏选择突出显示的结果。 |  |
| **感官（Senses）** | 显示/. |  |
| **分隔半透明（Separate Translucency）** | 此标志显示/隐藏任何在其材质中运用了分隔半透明的Object。 |  |
| **阴影视锥体（Shadow Frustums）** | 显示/隐藏一些选择的颜色编码框，它们代表用于从每个光源投射阴影的阴影视锥体。 |  |
| **单层水面折射全精度（Single Layer Water Refraction Full Precision）** | 显示/. |  |
| **样条（Splines）** | 显示/隐藏关卡中存在的任何样条Actor。 |  |
| **流送边界（Streaming Bounds）** | 显示/隐藏每个流送关卡的球体半径。 |  |
| **时空AA（代替FXAA）（Temporal AA (instead FXAA)）** | 激活/停用时空抗锯齿。如果不选中该标志，视口会显示快速近似抗锯齿（FXAA）。 |  |
| **曲面细分（Tessellation）** | 显示/隐藏材质中的曲面细分结果。 |  |
| **顶点颜色（Vertex Colors）** | 显示/隐藏应用到场景中的网格体的任何顶点颜色。 |  |
| **可视化实例更新（Visualize Instance Updates）** | 显示/. |  |
| **体积（Volumes）** | 显示/隐藏场景中的任何体积。*(**Alt+O**)* |  |

## 体积

> 图片已省略：Volumes Menu

点击查看大图。

| 体积 |  |
| --- | --- |
| 名称 | 描述 |
| **全部显示（Show All）** | 显示场景中所有类型的体积。 |
| **全部隐藏（Hide All）** | 隐藏场景中所有类型的体积。 |
| **音频（Audio）** | 显示/隐藏音频体积。 |
| **阻挡（Blocking）** | 显示/隐藏阻挡体积。 |
| **摄像机阻挡体积（Camera Blocking Volume）** | 显示/隐藏摄像机阻挡体积。 |
| **剔除距离（Cull Distance）** | 显示/隐藏剔除距离体积。 |
| **层级LOD体积（Hierarchical LOD Volume）** | 显示/隐藏层级LOD体积。 |
| **Kill Z** | 显示/隐藏Kill Z。 |
| **关卡流送（Level Streaming）** | 显示/隐藏关卡流送体积。 |
| **Lightmass角色间接细节（Lightmass Character Indirect Detail）** | 显示/隐藏Lightmass角色间接细节体积。 |
| **Lightmass重要体积（Lightmass Importance）** | 显示/隐藏Lightmass重要体积。 |
| **寻路网格体边界（NavMesh Bounds）** | 显示/隐藏寻路网格体边界体积。 |
| **网格体合并抽值（Mesh Merge Culling）** | 显示/. |
| **寻路修饰符（Nav Modifier）** | 显示/隐藏寻路修饰符体积。 |
| **Pain Causing** | 显示/隐藏Pain Causing体积。 |
| **物理（Physics）** | 显示/隐藏物理体积。 |
| **后期处理（Post Process）** | 显示/隐藏后期处理体积。 |
| **预计算可视性覆盖（Precomputed Visibility Override）** | 显示/隐藏预计算可视性覆盖体积。 |
| **预计算可视性（Precomputed Visibility）** | 显示/隐藏预计算可视性体积。 |
| **过程植物阻挡体积（Procedural Foliage Blocking Volume）** | 显示/隐藏过程植物阻挡体积。 |
| **过程植物体积（Procedural Foliage Volume）** | 显示/隐藏过程植物体积。 |
| **触发器（Trigger）** | 显示/隐藏触发器体积。 |
| **可视化记录器筛选体积（Visual Logger Filter Volume）** | 显示/. |
| **体积光照映射密度（Volumetric Lightmap Density）** | 显示/. |
| **世界分区体积（World Partition Volume）** | 显示/. |

## 图层

> 图片已省略：Layers Menu

点击查看大图。

| 图层 |  |
| --- | --- |
| 名称 | 描述 |
| **全部显示（Show All）** | 将场景中的所有图层设置为可见。 |
| **全部隐藏（Hide All）** | 隐藏场景中所有图层。 |
| **图层名称（Layer Names）** | 此标志将填充你在场景中已创建的所有图层的名称，以便你个别地显示/隐藏每个图层。 |
| **我的新名称（My New Name）** | 显示/. |
| **基础结构2（Infrastructure 2）** | 显示/. |

## Sprite

> 图片已省略：Sprites Menu

点击查看大图。

> [!NOTE]
> 公告板Sprite通常是在编辑器中用于放置各种Object类型的图标。在这种情况下，它们不指代Sprite粒子。

| 公告板Sprite |  |
| --- | --- |
| 名称 | 描述 |
| **全部显示（Show All）** | 显示所有类型的公告板Sprite。 |
| **全部隐藏（Hide All）** | 隐藏所有类型的公告板Sprite。 |
| **角色（Characters）** | 显示/隐藏角色公告板Sprite。 |
| **贴花（Decals）** | 显示/隐藏贴花公告板Sprite。 |
| **效果（Effects）** | 显示/隐藏效果公告板Sprite，它们表示发射器Actor的位置。 |
| **雾（Fog）** | 显示/隐藏雾Actor公告板Sprite。 |
| **FTests** | 显示/隐藏FTest公告板Sprite。 |
| **信息（Info）** | 显示/隐藏信息公告板Sprite。 |
| **光照（Lighting）** | 显示/隐藏光源Actor公告板Sprite。 |
| **材质（Materials）** | 显示/隐藏材质公告板Sprite。 |
| **Matinee** | 显示/隐藏Matinee公告板Sprite。 |
| **杂项（Misc）** | 显示/隐藏不属于其他类别的杂项公告板Sprite。 |
| **寻路（Navigation）** | 显示/隐藏寻路公告板Sprite。 |
| **注释（Notes）** | 显示/隐藏注释公告板Sprite。 |
| **物理（Physics）** | 显示/隐藏物理公告板Sprite。 |
| **玩家出生点（Player Start）** | 显示/隐藏玩家出生点公告板Sprite。 |
| **天空（Sky）** | 显示/隐藏天空公告板Sprite。 |
| **解算器（Solver）** | 显示/. |
| **声音（Sounds）** | 显示/隐藏声音公告板Sprite。 |
| **目标点（Target Points）** | 显示/隐藏目标点公告板Sprite。 |
| **触发器（Triggers）** | 显示/隐藏触发器公告板Sprite。 |
| **风（Wind）** | 显示/隐藏风公告板Sprite。 |

## 植被类型

> 图片已省略：Foliage Types Menu

点击查看大图。

| 植被类型 |  |
| --- | --- |
| 名称 | 描述 |
| **显示全部（Show All）** | . |
| **隐藏全部（Hide All）** | . |
