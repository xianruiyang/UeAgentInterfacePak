# User Scene Textures for Post Process Materials

---
title: "User Scene Textures for Post Process Materials"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/post-process-material-user-scene-textures-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "后期处理效果", "后期处理材质", "User Scene Textures for Post Process Materials"]
---

# User Scene Textures for Post Process Materials

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 后期处理效果 / 后期处理材质 / User Scene Textures for Post Process Materials

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/post-process-material-user-scene-textures-in-unreal-engine

**User Scene Textures（用户场景纹理）** 是用户定义的 transient render target，可在 post process material 中写入和读取，从而支持 multi-pass 后处理效果。

本指南演示如何使用 User Scene Textures 创建屏幕可变模糊效果：屏幕中心不模糊，越靠近外缘模糊量越大。该模糊效果通过在原始 scene color 与两个经过 downsample 和 blur 的 User Scene Texture 之间插值实现；每个 User Scene Texture 都由 two-pass separable gaussian filter 生成。此方法通常比 single-pass blur 更高效。

![With the Variable Blur Post Process Material Effect](../../../../../assets/images/b7/b71d96050d2d23c34d1f948e2987bd3e38def262c818200762f906fcba8a1b45.jpg)

![Without any Post Process Materials Applied](../../../../../assets/images/e8/e80dc08b7118aa5720db26489e1b2e1e0fc92ea3d9323aa23fa44289ccf051bf.jpg)

应用 Variable Blur 后处理材质效果

未应用任何 Post Process Material

本指南将设置以下内容：

- 一个用于 downsample 和 blur user scene texture 的 material。
- 分别沿屏幕水平和垂直方向进行 blur 的 material。
- 多个 material instance，用于创建 User Scene Texture 的读取和写入元素。
- 探索此类效果的部分调试选项，包括 console command 和 material logic。

## 初步创建 Material

首先创建三个独立 material。每个 material 都会用于构建 variable blur 后处理效果所需的不同元素：一个 material 用于 downsample，另外两个 material 分别用于模糊效果的水平和垂直分量。后续会基于这些 material 创建 material instance，用于读取和写入 User Scene Texture，从而组成此 multi-pass 效果。

按以下步骤开始创建该效果：

1. 在

   Content Browser

   中点击

   Add（+）

   按钮并创建三个

   Material

   .
2. Name

   分别按如下方式命名每个 material：

   1. Downsample（降采样）
   2. BlurHoriz（水平模糊）
   3. BlurVert（垂直模糊）

此时应有三个如下所示的 material：

### 设置 Downsample Material

按以下步骤创建 Downsample material：

1. 打开

   Downsample（降采样）

   material。
2. 在 **Details（详情）** 面板中设置以下内容：

   1. Material Domain：

      Post Process（后处理）
   2. Blendable Location：

      Scene Color Before Bloom（Bloom 前场景颜色）
   3. User Scene Texture：

      Output（输出）

      1. 这用于写入名为“Output”的 user scene texture。
   4. User Texture Divisor：

      2, 2（两个值都为 2）

      1. 这会让 material 在 X 和 Y 两个维度上都按 2 倍 downsample。
   5. Resolution Relative To Input：

      Input（输入）

      1. 此项会在设置这些 material 的步骤中使用。不过，如果未设置，User Texture Divisor 会相对于绝对屏幕分辨率进行缩放。
3. 在 Material Graph 中右键点击并添加

   User Scene Texture（用户场景纹理）

   节点。
4. 选中 User Scene Texture node 后，使用 **Details（详情）** 面板设置以下参数：

   1. User Scene Texture：

      Input（输入）
   2. Filtered：

      勾选

      1. 应勾选此项，因为这里执行的是 bilinear downsample，它有助于避免 artifact。
5. 将

   Color

   输出从

   User Scene Texture（用户场景纹理）

   节点连接到

   Emissive Color

   输入，该输入位于主 material node。
6. 点击

   Save

   .

此时，一旦创建 User Scene Texture node，Preview 窗口会显示错误消息，提示缺少 input。这是一个调试显示，对于创建包含 User Scene Texture 的 post process material 很有用，因为它会显示正在运行的不同 pass 及其 input 和 output。

### 设置 BlurHoriz Material

按以下步骤创建用于模糊水平分量的 material：

1. 打开

   BlurHoriz（水平模糊）

   material。
2. 在 **Details（详情）** 面板中设置以下内容：

   1. Material Domain：

      Post Process（后处理）
   2. Blendable Location：

      Scene Color Before Bloom（Bloom 前场景颜色）
   3. User Scene Texture：

      Output（输出）

      1. 这用于写入名为“Output”的 user scene texture。
   4. Resolution Relative To Input：

      Input（输入）

      1. 此项会在设置这些 material 的步骤中使用。不过，如果未设置，User Texture Divisor 会相对于绝对屏幕分辨率进行缩放。
   5. Disable Pre Exposure Scale：

      勾选

      1. 此 material 不设置 User Texture Divisor，因为 blur 会在相同分辨率下执行。实际效果上，在此场景中保持未设置时，0 与 1 相同。
3. 在 Material Graph 中右键点击并添加

   User Scene Texture（用户场景纹理）

   节点。
4. 选中 User Scene Texture node 后，使用 **Details（详情）** 面板设置以下参数：

   1. User Scene Texture：

      Input（输入）
   2. Filtered：

      勾选
   3. Clamped：

      勾选
5. 从

   Color

   pin 拉出连线并添加

   Custom

   node。它将用于为此 material 编写一些 custom HLSL code。
6. 选中 Custom node 后，使用 **Details（详情）** 面板设置以下内容：

   1. Input Name：

      Tex

      1. 此 input 用于获取要传递给 Custom HLSL node 中 SceneTextureFetch 函数的 ID，并可配合连接到 input pin 的 SceneTexture 或 UserSceneTexture node 使用。
   2. 在 Code 字段中复制以下 HLSL code：

      ```
           // Gaussian blur with linear sampling     float offset[3] = { 0.0, 1.3846153846, 3.2307692308 };     float weight[3] = { 0.2270270270, 0.3162162162, 0.0702702703 };                 float3 Color = SceneTextureFetch(Tex.ID, float2(0,0)) * weight[0];                 for (int i=1; i<3; i++)     {         Color += SceneTextureFetch(Tex.ID, + float2(offset[i], 0.0)) * weight[i];     Color += SceneTextureFetch(Tex.ID, - float2(offset[i], 0.0)) * weight[i];     }     return Color;
      ```
7. 将

   Custom

   output 连接到主 material 的

   Emissive Color

   input。
8. 点击

   Save

   .

此后处理效果示例使用 custom HLSL，因此需要注意 **Disable Pre Exposure Scale** 需要设置，因为此设置会禁用一些会影响 post process material 的部分 input/output 缩放的逻辑。否则在编写 custom HLSL 时必须自行考虑这些缩放逻辑（常规节点逻辑会在需要时自动生成 scale 和 unscale 代码）。除了避免 custom HLSL 复杂化之外，这还会带来少量性能收益。使用 User Scene Texture 和 custom HLSL 时，通常建议禁用 pre-exposure scale。

> [!TIP]
> 此时可以在 material 的 Preview 窗口中预览 HLSL 结果：将 User Scene Texture node 中的“User Scene Texture”字段从“Input”改为“SceneColor”。这是一个特殊 input，会使用此管线阶段中的默认 scene color。
>
> 在 **User Scene Texture（用户场景纹理）** node 的 Details 面板中，将 **UserSceneTexture** to `SceneColor`, and **Save** 该 material。
>
> 编译完成后，Preview 窗口会显示此 custom HLSL code 的结果。球体边缘周围应被模糊，窗口中心区域较不模糊，如示例所示（完成后将其改回 Input）：
>
> *在 Preview 窗口中对比有无这些更改时的 material 效果。*

### 设置 BlurVert Material

按以下步骤创建用于模糊垂直分量的 material：

1. 打开

   BlurVert（垂直模糊）

   material。
2. 在 **Details（详情）** 面板中设置以下内容：

   1. Material Domain：

      Post Process（后处理）
   2. Blendable Location：

      Scene Color Before Bloom（Bloom 前场景颜色）
   3. User Scene Texture：

      Output（输出）

      1. 这用于写入名为“Output”的 user scene texture。
   4. Resolution Relative To Input：

      Input（输入）

      1. 此项会在设置这些 material 的步骤中使用。不过，如果未设置，User Texture Divisor 会相对于绝对屏幕分辨率进行缩放。
   5. Disable Pre Exposure Scale：

      勾选

      1. 此 material 不设置 User Texture Divisor，因为 blur 会在相同分辨率下执行。实际效果上，在此场景中保持未设置时，0 与 1 相同。
3. 在 Material Graph 中右键点击并添加

   User Scene Texture（用户场景纹理）

   节点。
4. 选中 User Scene Texture node 后，使用 **Details（详情）** 面板设置以下参数：

   1. User Scene Texture：

      Input（输入）
   2. Filtered：

      勾选
   3. Clamped：

      勾选
5. 从

   Color

   pin 拉出连线并添加

   Custom

   node。它将用于为此 material 编写一些 custom HLSL code。
6. 选中 Custom node 后，使用 **Details（详情）** 面板设置以下内容：

   1. Input Name：

      Tex

      1. 此 input 用于获取要传递给 Custom HLSL node 中 SceneTextureFetch 函数的 ID，并可配合连接到 input pin 的 SceneTexture 或 UserSceneTexture node 使用。
   2. 在 Code 字段中复制以下 HLSL code：

      ```
           // Gaussian blur with linear sampling     float offset[3] = { 0.0, 1.3846153846, 3.2307692308 };     float weight[3] = { 0.2270270270, 0.3162162162, 0.0702702703 };                 float3 Color = SceneTextureFetch(Tex.ID, float2(0,0)) * weight[0];                 for (int i=1; i<3; i++)     {         Color += SceneTextureFetch(Tex.ID, + float2(0.0, offset[i])) * weight[i];     Color += SceneTextureFetch(Tex.ID, - float2(0.0, offset[i])) * weight[i];     }     return Color;
      ```
7. 将

   Custom

   output 连接到主 material 的

   Emissive Color

   input。
8. 点击

   Save

   .

此 material 的设置与上一节中的 **BlurHoriz（水平模糊）** material 相同。两者唯一的区别是 HLSL code 会改变正负 `SceneTextureFetch` offset 的坐标设置顺序；这些 HLSL 行修改会在采样 input texture 时把 UV offset 从水平切换为垂直：

```
Color += SceneTextureFetch(Tex.ID, + float2(0.0, offset[i])) * weight[i];Color += SceneTextureFetch(Tex.ID, - float2(0.0, offset[i])) * weight[i];
```

## 设置 User Scene Texture（用户场景纹理）Material Instance（材质实例）

基础 material 设置完成后，需要基于它们创建多个 material instance，用来读取和写入 User Scene Texture。这些 instance 会构成屏幕中被模糊的水平与垂直部分，并决定这些 pass 对最终通过 post process volume 应用的模糊效果贡献多少。

### 创建 Horizontal Blur Material Instance

在此步骤中，将使用 **BlurHoriz（水平模糊）** material 创建一组 material instance，用于设置读取和写入 User Scene Texture 的基础信息，作为此 variable blur 效果的水平模糊组件。

#### HalfA 水平模糊 Material Instance

第一个 material instance 基于 **Downsample（降采样）** material 创建。此 material instance 会接收名为 Scene Color 的 input，并写入名为 HalfA 的 output。

1. 在 Content Browser 中右键点击

   Downsample（降采样）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“HalfA”。
2. 打开 material instance

   HalfA（半分辨率 A）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      SceneColor（场景颜色）
   2. User Scene Texture Output：

      HalfA（半分辨率 A）
4. Save

   该 material instance。

#### HalfB 水平模糊 Material Instance

第二个 material instance 基于 **BlurHoriz（水平模糊）** material 创建。此 material instance 会使用 HalfA 作为 input，并写入名为 HalfB 的 output。

1. 在 Content Browser 中右键点击

   BlurHoriz（水平模糊）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“HalfB”。
2. 打开 material instance

   HalfB（半分辨率 B）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      HalfA（半分辨率 A）
   2. User Scene Texture Output：

      HalfB（半分辨率 B）
4. Save

   该 material instance。

此时已设置好 HalfA 与 HalfB 两个 material instance，适合用 console command 在 Preview 窗口开启 user scene texture debug display `r.PostProcessing.UserSceneTextureDebug 1`。该显示会展示正在设置的 variable blur（可变模糊）post process material（后处理材质） 如何读取和写入 User Scene Texture。

启用该显示后，Preview 窗口会勾勒出此 material 正在运行的不同 pass。在 HalfB material instance 中，它会显示 HalfA material instance 生成名为 HalfA 的 output，而 HalfB 会读取该 output 并继续生成后续 output。

### 创建 Vertical Blur Material Instance

在这一组步骤中，将使用 **BlurVert（垂直模糊）** material 创建一组 material instance，用于设置读取和写入 User Scene Texture 的基础信息，作为此 variable blur 效果的垂直模糊组件。

#### HalfC 垂直模糊 Material Instance

第一个 vertical material instance 基于 **BlurVert（垂直模糊）** material 创建。它接收名为 HalfB 的 input，并写入名为 HalfC 的 output。

1. 在 Content Browser 中右键点击

   BlurVert（垂直模糊）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“HalfC”。
2. 打开 material instance

   HalfC（半分辨率 C）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      HalfB（半分辨率 B）
   2. User Scene Texture Output：

      HalfC（半分辨率 C）
4. Save

   该 material instance。

到这里，HalfA、HalfB 和 HalfC 这一组 half-res material 就设置完成了。

#### QuarterA 垂直模糊 Material Instance

第二个 vertical material instance 基于 **Downsample（降采样）** material 创建。它会为 quarter resolution 链写入 output：从 HalfC 读取 input，并输出到 QuarterA。

1. 在 Content Browser 中右键点击

   Downsample（降采样）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“QuarterA”。
2. 打开 material instance

   QuarterA（四分之一分辨率 A）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      HalfC（半分辨率 C）
   2. User Scene Texture Output：

      QuarterA（四分之一分辨率 A）
4. Save

   该 material instance。

#### QuarterB 垂直模糊 Material Instance

第三个 vertical material instance 基于 **BlurHoriz（水平模糊）** material 创建。它接收名为 QuarterA 的 input，并写入名为 QuarterB 的 output。

1. 在 Content Browser 中右键点击

   BlurHoriz（水平模糊）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“QuarterB”。
2. 打开 material instance

   QuarterB（四分之一分辨率 B）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      QuarterA（四分之一分辨率 A）
   2. User Scene Texture Output：

      QuarterB（四分之一分辨率 B）
4. Save

   该 material instance。

#### QuarterC 垂直模糊 Material Instance

第四个也是最后一个 material instance 基于 **BlurVert（垂直模糊）** material 创建。它接收名为 QuarterB 的 input，并写入名为 QuarterC 的 output。

1. 在 Content Browser 中右键点击

   BlurVert（垂直模糊）

   material，然后点击

   Create Material Instance（创建材质实例）

   。将其命名为“QuarterC”。
2. 打开 material instance

   QuarterC（四分之一分辨率 C）

   .
3. 在 Material Instance Editor 的 **Details（详情）** 面板中，在以下分类下设置： **Post Process Overrides（后处理覆盖）** 类别中：

   1. Input：

      QuarterB（四分之一分辨率 B）
   2. User Scene Texture Output：

      QuarterC（四分之一分辨率 C）
4. Save

   该 material instance。

到这里，QuarterA、QuarterB 和 QuarterC 这一组 quarter-res material instance 就设置完成了。

### Material Instance 的 Half-Res 与 Quarter-Res 结果

当这些 material instance 都设置为读取和写入 User Scene Texture 后，每个 instance 都应在各自的 Preview 窗口中显示结果。结果应类似下面的示例：模糊量会根据链路中到该点为止 material instance 读取和写入的 user scene texture 而变化。

启用 user scene texture debug display 后，可以看到这些 material instance 如何彼此协作。例如，在下面的 QuarterC preview 窗口中，debug display 会展示所有 input 和 output 如何串接在一起，形成此 variable blur 效果的多个层级。

## 设置 Variable Blur Material

现在已经设置好所有包含 half-res 与 quarter-res、经过 downsample 和 blur 的 user scene texture 的 material instance，接下来需要创建一个 material，将这些元素组合起来，形成可用于 post process volume 的 variable blur 效果。

### 创建 Triple Bilinear Lerp 材质函数

在创建用于组合所有组件的 material 之前，先创建一个 custom material function。它会在 half-res 与 quarter-res user scene texture 之间插值，使用 alpha 控制屏幕中受影响的区域，并接入 post process material 的 scene texture input。

1. 在

   Content Browser

   中点击

   Add（+）

   按钮并创建一个

   Material Function（材质函数）

   .
2. Name

   将 material function 命名为“TripleBilinearLerp”。
3. 打开

   Material Function（材质函数）

   .
4. 重新创建下方 material graph。

   1. 对于每个

      FunctionInput（函数输入）

      node，需要分别设置以下内容：

      1. 前三个使用

         Input Name A（输入名 A）

         ,

         B

         , or

         C

         并且它们的

         Input Type（输入类型）

         is

         Function Input Vector 4（函数输入 Vector4）

         .
      2. 最后一个的

         Input Name

         is

         Alpha（权重）

         and the

         Input Type（输入类型）

         is

         Function Input Scalar（函数输入标量）

         .
   2. 也可以复制上图中的代码，并直接粘贴到 material function 的 graph 中。
5. 将 **Lerp（线性插值）** to the **Output Result（输出结果）** 节点。
6. Save

   and

   Close

   材质函数编辑器。

### 使用 User Scene Texture 创建 Variable Blur Material

这是本流程中最后要创建的 material，用来把 variable blur 后处理效果的所有组件组合在一起。TripleBilinearLerp 材质函数 会使用 half-res 与 quarter-res user scene texture 在屏幕上创建 variable blur 效果；同时使用 Alpha input 控制屏幕中心、中部和外缘哪些区域受到模糊影响。

1. 在

   Content Browser

   中点击

   Add（+）

   按钮并创建一个

   Material

   。将 material 命名为“BlurApply”。
2. 打开

   BlurApply（应用模糊）

   material。
3. 在 **Details（详情）** 面板中设置以下内容：

   1. Domain：

      Post Process（后处理）
   2. Blendable Location：

      Scene Color Before Bloom（Bloom 前场景颜色）
4. 在 graph 中拖入 **TripleBilinearLerp（三路双线性插值）** material function，也就是前面步骤中创建的函数。
5. 添加一个 **Scene Texture（场景纹理）** input data expression。在 **Details（详情）** panel, set **Scene Texture Id（场景纹理 ID）** 设置为 **PostProcessInput0（后处理输入 0）**.

   > [!NOTE]
   > PostProcessInput0 与 SceneColor 相同，但它用于 post process material。
6. 将 **Color** 输出从 **SceneTexture:PostProcessInput0（后处理输入 0）** 节点连接到 **A** 输入，位于 **TripleBilinearLerp（三路双线性插值）** material function node。
7. 添加两个 **User Scene Texture（用户场景纹理）** node。分别在 Details 面板中设置以下内容：

   1. User Scene Texture：

      这会接入 half-res 与 quarter-res user scene texture。将其中一个命名为

      HalfC（半分辨率 C）

      另一个命名为

      QuarterC（四分之一分辨率 C）

      .
   2. Filtered：

      勾选
   3. Clamped：

      勾选
8. 将

   Color

   输出从

   UserSceneTexture:HalfC（半分辨率 C）

   节点连接到

   B

   输入，位于

   TripleBilinearLerp（三路双线性插值）

   节点。
9. 将

   Color

   输出从

   UserSceneTexture:QuarterC（四分之一分辨率 C）

   节点连接到

   C

   输入，位于

   TripleBilinearLerp（三路双线性插值）

   节点。
10. 在 graph 中添加一个

    Constant（常量）

    node。保持其值为 0。
11. 将 **Constant（常量）** to the **Alpha（权重）** 输入，位于 **TripleBilinearLerp（三路双线性插值）** 节点。

    > [!NOTE]
    > 这样可以确保 material 在进入本指南下一节之前能够编译通过。
12. 将

    TripleBilinearLerp（三路双线性插值）

    output to the

    Emissive Color

    输入，该输入位于主 material node。
13. 点击

    Apply

    来编译 material。

此时 material graph 应类似下图：

在 Preview 窗口中，可能会看到一个 `Red: Missing Input` 错误消息，目标是 `HalfC` 中的 user scene texture input： **QuarterA（四分之一分辨率 A）** material instance。此错误是因为 QuarterA 在 HalfC 实际写入之前就使用了 HalfC input。Preview 窗口无法处理多级依赖。不过，可以通过为 material 中的一些 pass 手动设置 priority 来修复此问题。

按以下步骤设置 material priority：

1. 打开以下 quarter-res pass：

   QuarterA（四分之一分辨率 A）

   ,

   QuarterB（四分之一分辨率 B）

   ，并

   QuarterC（四分之一分辨率 C）

   .
2. 在

   Details（详情）

   面板，在每个 material instance 的

   Post Process Overrides（后处理覆盖）

   下勾选

   Blendable Priority（混合优先级）

   .
3. 设置 **Blendable Priority（混合优先级）** 设置为 **1** ，用于每个 quarter-res instance。
4. Save

   and

   Close

   每个 material instance。
5. 打开

   BlurApply（应用模糊）

   material。
6. 在 **Details（详情）** panel, set the **Blendable Priority（混合优先级）** 设置为 **2**.
7. 点击

   Apply

   来编译 material。

在 Preview 窗口中，错误消息应已解决，如下方示例所示。此更改会让所有这些 pass 都在 **之后** half-res pass 之后运行，确保 half-res output 会在被需要之前创建完成。

#### 使用参数向 Material 添加 Variable Blur

上一节使用 Constant 值让 material 编译并得到结果。不过，可以结合一些逻辑使用 Alpha input，让屏幕上的 blur 实际发生变化：屏幕中心保持不模糊，周围区域中等模糊，外缘区域更强模糊，从而创建 variable blur 效果。

1. 删除

   Constant（常量）

   node，它当前连接到

   Alpha（权重）

   输入，位于

   TripleBilinearLerp（三路双线性插值）

   节点。
2. 从

   Alpha（权重）

   input 拉出连线，该 input 位于

   TripleBilinearLerp（三路双线性插值）

   node and add a

   Multiply（乘法）

   节点。
3. 从

   A

   输入，位于

   Multiply（乘法）

   node and add a

   Length（长度）

   expression。
4. 从以下节点的 input 拉出连线：

   Length（长度）

   node and add a

   Subtract（减法）

   节点。
5. 在

   Subtract（减法）

   node 上，将

   B

   input 的值设置为

   0.5

   .

   1. 这会把 screen space 中的模糊位置移动到画面中心。
6. 从

   A

   输入，位于

   Subtract（减法）

   node and add a

   Screen Position（屏幕位置）

   节点。
7. 点击

   Apply

   来编译 material。

此时 graph 应类似下图：

调整 **B** input 值，位于 **Multiply（乘法）** ，属于 **Alpha（权重）** 以控制屏幕上 blur 的强度。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Alpha Multiply：1.0 | Alpha Multiply：1.5 | Alpha Multiply：2.0 |

可以通过添加一个 **Subtract（减法）** node，并将其放在 **Multiply（乘法）** node 之前，来在屏幕中心创建一个没有 blur 的区域，并更精细地控制该效果。

逐步调整 **B** 上的 **Subtract（减法）** node 的值，可以缩放屏幕中心不发生 blur 的区域。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Subtract：0.0（无效果） | Subtract：0.1 | Subtract：0.25 |

> [!NOTE]
> 若要了解如何设置 material logic，以可视方式检查此效果在屏幕上应用 blur 的位置，请参阅 [使用颜色调试 Material Effect](#applyingcolortodebugthematerialeffect) 一节。

## 将 Post Process Material 添加到 Post Process Volume

最后一步是在场景中设置 post process volume，并向其中添加 post process material，以查看 variable blur 后处理效果实际运行。

1. 添加一个 **Post Process Volume（后处理体积）** 到场景中，并缩放到足够大的范围，以便在应用时看到效果。

   > [!TIP]
   > 可以勾选 **Infinite Extent（Unbound，无界）** 使 volume 覆盖整个世界，而不仅是自身 bounding box。
2. 在

   Details（详情）

   panel under

   Rendering Features（渲染功能）

   ，展开

   Post Process Materials（后处理材质）

   部分。
3. Click the

   Add（+）

   图标，位于

   Array（数组）

   旁边，以添加新的 Post Process Material 元素。重复此步骤，直到拥有

   7

   个 array element。
4. 在每个 array element 旁边点击下拉菜单并选择

   Asset Reference（资产引用）

   .
5. 在每个 array element 旁边点击下拉菜单，并分配本指南中创建的每个

   Post Process Materials（后处理材质）

   。它们应按以下顺序分配，因为运行顺序也将遵循此顺序：

   1. HalfA（半分辨率 A）
   2. HalfB（半分辨率 B）
   3. HalfC（半分辨率 C）
   4. QuarterA（四分之一分辨率 A）
   5. QuarterB（四分之一分辨率 B）
   6. QuarterC（四分之一分辨率 C）
   7. BlurApply（应用模糊）

此时 Post Process Materials array 应如下所示：

应用到 post process volume 后，效果会类似下图：中心不模糊，中部中等模糊，外缘模糊更强。

|  |  |
| --- | --- |
|  |  |
| First Person Template（第一人称模板） | Third Person Template（第三人称模板） |

> [!NOTE]
> 初看时可能很难分辨屏幕哪些部分没有 blur、哪些部分中等 blur、哪些部分重度 blur。可以按照 [使用颜色调试 Material Effect](#applyingcolortodebugthematerialeffect) 一节。

### 使用颜色调试 Material Effect

为了让此 variable blur 效果在场景中更明显，可以用少量 material logic 应用 color modulation。这有助于在屏幕上分别识别不同 user scene texture input 对应的不同 blur 等级。

1. 打开

   BlurApply（应用模糊）

   material。
2. On

   UserSceneTexture:HalfC（半分辨率 C）

   拉出连线，从

   Color

   output，并添加一个

   Multiply（乘法）

   节点。
3. 在 graph 中右键点击并添加一个

   Constant4Vector

   并为其设置颜色。
4. 将

   RGBA color pin

   连接到 input

   B

   上的

   Multiply（乘法）

   节点。
5. 将

   Multiply（乘法）

   output 连接到 input

   B

   上的

   TripleBilinearLerp（三路双线性插值）

   节点。
6. 对以下对象重复这些步骤：

   UserSceneTexture:QuarterC（四分之一分辨率 C）

   并连接它的

   Multiply（乘法）

   连接到 input

   C

   上的

   TripleBilinearLerp（三路双线性插值）

   节点。

结果应类似下图：

这会让 material preview 窗口显示类似下图的结果：

完成此设置后，可以使用 **Multiply（乘法）** node on the **Alpha（权重）** 输入，位于 **TripleBilinearLerp（三路双线性插值）** 来放大 variable blur 效果。

下面是在 material preview 窗口中展示该缩放系数的几个示例：

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Debug Colors Alpha Multiply：1.0 | Debug Colors Alpha Multiply：1.5 | Debug Colors Alpha Multiply：2.0 |

该 **Subtract（减法）** node 有助于在画面中心创建完全没有 blur 的 dead space。建议从较小值开始，并逐步增大，直到得到想要的 dead space。

下面是逐步增大 Subtract 值的几个示例，用于让画面中心不应用 blur。

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Debug Colors Subtract：0.0（无效果） | Debug Colors Subtract：0.1 | Debug Colors Subtract：0.25 |

当此 material 应用到 Post Process Volume 后，可以清楚看到 variable blur 效果如何在游戏场景中应用，例如下方使用 First Person 与 Third Person template 的示例。

|  |  |
| --- | --- |
|  |  |
| 使用 material debug color 的 First Person Template。 | 使用 material debug color 的 Third Person Template。 |

