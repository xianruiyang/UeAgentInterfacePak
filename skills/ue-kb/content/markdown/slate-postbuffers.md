# Slate Postbuffers

---
title: "Slate Postbuffers"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-slate-postbuffers-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "UMG编辑器参考", "Slate Postbuffers"]
---

# Slate Postbuffers

> 路径：虚幻引擎5.7文档 / 创建用户界面 / UMG编辑器参考 / Slate Postbuffers

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-slate-postbuffers-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Slate postbuffer** 会采样游戏场景，供 UI 材质使用，类似后期处理材质中使用 SceneColor 的方式。这让你可以创建同时作用于游戏世界和用户界面的视觉效果。Slate postbuffer 也可以应用 **Slate postprocess** 类，用于处理模糊等全局后期处理。

Slate postbuffer 的一些示例用例包括：

- 模糊透明弹出消息背后的场景。
- 使用暗角效果表现伤害或黑暗。
- 屏幕范围模糊，可选择性遮挡 widget 和游戏世界。
- 类似老旧 VHS 磁带的失真滤镜。

> [!TIP]
> 以上每个示例都可在 **UI_SlatePostBuffer** 关卡中找到，该关卡位于 [Content Examples](https://dev.epicgames.com/documentation/assets/samples-and-tutorials/content-examples) 项目。

本页提供：

- 使用 Slate postbuffer 的工作流概述。
- Slate postbuffer 如何工作及其限制的技术信息。
- 执行以下操作的说明：

  - 启用 Slate postbuffer。
  - 配置 Slate postbuffer。
  - 创建新的 Slate Post Processor 类。
  - 将 Slate postbuffer 集成到材质中，并将其应用到 UI 元素。

## 概述

> [!WARNING]
> Slate postbuffer 和 postprocessor 类是全局资源，因此应与整个团队沟通项目如何使用它们。

虚幻引擎最多支持 5 个 Slate postbuffer，每个都会采样游戏场景供 UI 材质使用。可以为每个 postbuffer 设置 Slate postprocessor 类，在 UI 材质使用之前对该 buffer 应用全局后期处理。如果没有 postprocessor，它只会采样游戏场景的副本。

![The Slate RHI Settings in Project Settings](../../../../assets/images/2f/2f27a12026bb11718011b469314e28a08a5011d3eaf2c1a422e123f82f328108.jpg)

要填充 postbuffer，必须向 UI 添加一个 **Post Buffer Update** widget。该 widget 的包围盒会决定 buffer 中哪些区域会填充后期处理像素。 postbuffer 还会包含 Z 顺序上位于 update widget 下方的 widget 外观。 未被 update widget 覆盖的 buffer 区域会保留上一帧内容，或保持黑色。

UI 材质可以使用 **GetSlatePost** 函数采样 postbuffer。例如，`GetSlatePost0` 会采样 Slate Postbuffer 0，而 `GetSlatePost4` 会采样 Slate Postbuffer 4。UI 材质可以像后期处理材质使用 SceneColor 采样场景一样使用 Slate postbuffer。

![Example of the GetSlatePost node in use](../../../../assets/images/89/89596229633f029e2be6425cc95da017afd514213acf43d7cf09924ffb6ed6d8.jpg)

将 UI 材质应用到 widget 后，它会使用该 widget 将材质的后期处理应用到其背后的屏幕区域。以下示例使用反转的 Y 轴 UV 坐标，将方形 widget 内的视口部分上下翻转。

![Example of a picture-in-picture with inverted UV coordinates from the Content Samples project](../../../../assets/images/ff/ffc31d7dae658b70c76b1d16a4fbdfc7278403892adb12027eaf43039f7a1f29.jpg)

作为更复杂的示例，以下截图显示了一个 widget 将屏幕扭曲成老旧 VHS 磁带效果。应用 VHS 失真材质的 widget 占据整个屏幕，并叠放在 UI 中其它 widget 之上。这使 UE 可以一起处理 UI 和游戏场景，因此可以在 UMG Blueprint 中使用文本 widget 控制日期和 timecode 等元素。

![Example of a Slate postbuffer creating a VHS blur](../../../../assets/images/4b/4b54f531365bc63d3e47174940ce094b7d7a8bb20704e51bd7b31f4de5d19f44.jpg)

> [!NOTE]
> 默认情况下，GetPostBuffer 节点会直接采样 UI widget 背后的内容。要了解如何重写它们，请参阅下方“在 UI 材质中使用 Postbuffer 的提示”小节。

## 启用 Slate Postbuffer

要启用 Slate postbuffer，请将以下 CVar 添加到项目的 `*Engine.ini` 文件中：

C++

DefaultEngine.ini

```
[ConsoleVariables]	Slate.CopyBackbufferToSlatePostRenderTargets=1
```

或者，可以使用以下控制台命令启用此 CVar：

Command Line

```
-dpcvars=Slate.CopyBackbufferToSlatePostRenderTargets=1
```

## 在 Project Settings 中配置 Slate Postbuffer

要配置 postbuffer：

1. 打开 **Project Settings**.
2. 导航到 **Game**> **Slate RHIRenderer Settings** > **Post Processing**.
3. 展开要配置的 buffer 的下拉菜单。可以按需启用或禁用每个 buffer。

   ![Enable the postbuffer in your project settings.](../../../../assets/images/a7/a767a7a564057bafe2efa365e081aa6ec4dc63572bb35e6727a117bf32d57d2e.jpg)
4. 如果希望向 Slate postbuffer 添加特定后期处理，请为其选择 **Post Processor Class** 。

   ![Set the post processor class alongside your postbuffer settings.](../../../../assets/images/f4/f4a2450b5ed029abc60985d7b4bbd1b4e5dc21894816c8ead2ce72d1c04635d7.jpg)
5. 如果希望提高性能或节省显存，可以将 postbuffer 设置为仅使用游戏窗口一半分辨率（面积为四分之一）。

   如果仅将 buffer 用于模糊，且模糊强度始终高于 3.2，则这不会影响质量。更强的模糊总是在半分辨率或更低分辨率下计算。

   ![Setting the postbuffer resolution to half.](../../../../assets/images/86/86ac140161be1f83ca8e3795a322898af929ac8f9f6a35f91fe5e5e2081e3e32.jpg)

## 创建并使用 Slate Post Processor 类

要创建新的 Slate postprocessor 类：

1. 创建一个 **新的 Blueprint Class**派生自 **USlateRHIPostBufferProcessor** 或其任一子类。本教程使用 USlatePostBufferBlur 作为示例。

   ![Use the Slate postbuffer blur class as the base for a new Blueprint](../../../../assets/images/7a/7a4bf6a6cdb9d43e2d2ccf1a77939364f5057fdf426b74b2fa159e50e34f5c5e.jpg)
2. 打开新 postprocessor 的 Blueprint，然后编辑 class defaults。将 **Gaussian Blur Strength** 的默认设置改为不同于父类继承默认值的值。在此示例中，Gaussian Blur Strength 设置为 10.0。

   > 图片已省略：Set the blur strength for the derived postbuffer blur class.
3. 打开 **Project Settings** > **Slate Renderer Settings** > **Post Processing**，展开某个 postbuffer 的下拉菜单，并将 **Post Processor Class** 设置为新的 postprocessor。

   > 图片已省略：Set the blur postprocessor on one of the postbuffers.

UE 现在会在 widget 复制 backbuffer 之前，使用你的 postprocessor 处理它。在此例中，它会添加 gaussian blur。

> [!NOTE]
> 也可以通过从 `USlateRHIPostBufferProcessor` 派生新的 C++ 类来实现自己的 postprocessor。

### 运行时修改 Slate Post Processor

可以使用 **Slate FX Subsystem**.

1. 创建一个 **Slate FX Subsystem**节点在运行时修改 Slate postprocessor 的值。
2. 调用 **Get Slate Post Processor** 从某个 postbuffer 获取 postprocessor。
3. 将 postprocessor 转换为合适的类。
4. 从转换后的 postprocessor 对象访问 postprocessor 参数。

   > 图片已省略：Modifying a blur postprocessor at runtime in Blueprint.

   *上图只是运行时修改 postprocessor 的示例。我们不建议像图中那样在 tick 上执行此操作。*

> [!NOTE]
> 由于 Slate postbuffer 和 postprocessor 是全局资源，如果像上方示例那样修改 Slate Post Processor 的值，该值会全局变化。因此，使用此 postprocess 的每个 Slate widget 或 UI 材质实例都会反映该变化。运行时修改 Slate postprocess 值前请谨慎，并与整个团队沟通。

## 在 UI 材质中使用 Postbuffer

要创建采样 postbuffer 的 UI 材质：

1. Create a new **Material**.
2. 将材质的 **Material Domain** 设置为 **User Interface**.

   > 图片已省略：Set the material's domain to User Interface
3. 要采样 buffer，请调用与要使用的 postbuffer 对应的 **GetSlatePost** 函数。例如，`GetSlatePost0` 会获取 Slate Postbuffer 0。

   > 图片已省略：Use a GetSlatePost node to get a postbuffer.

### 在 UI 材质中使用 Postbuffer 的提示

以下是在 UI 材质中使用 postbuffer 的一些提示：

- 默认情况下，GetSlatePost 节点只会采样当前 widget 背后的像素，但可以使用 **UVs**输入修改此行为。
- 使用 **LinearRGB**获取经过 gamma 校正的 backbuffer 采样。
- **RGB**适用于正确颜色反相等效果。

下图是一个材质示例，它使用 postbuffer 创建旋转的 UE 标志，并反转其背后世界的颜色。UE 标志纹理馈入 Opacity 输出，而 Final Color 会反转 GetSlatePost0 的 RGB 输出。

> 图片已省略：A material that inverts and blurs portions of the buffer.

下图使用了此材质。请注意，尽管没有向 `GetSlatePost0` 提供 UV 输入，该材质仍会采样 widget 正后方的场景。

> 图片已省略：The previous material in use on UE logos in frame.

如果只想捕获游戏场景，请将 widget 放在层级结构底部。

如果希望 widget 也包含 UI，请按以下步骤在 postbuffer 中捕获 UI：

1. 在 UMG Designer 的 Palette 中找到 **Post Buffer Update Widget** 。

   > 图片已省略：The Post buffer update widget in the palette.
2. 将该 Widget 添加到希望当前 UI 更新的位置。Slate postbuffer 会在此 widget 放置的位置更新。

   > 图片已省略：An example of the update widget placed in the hierarchy.

   > [!NOTE]
   > 建议将 update widget 放为层级结构中的最后一个元素，以确保它在要采样的 widget 之后（或其上方）绘制。
3. 在 Details 面板中配置 Post Buffer Update Widget。

   > 图片已省略：Configuring the details of the post buffer update widget.

The **Post Buffer Update Widget** 具有以下参数：

| 参数 | 说明 |
| --- | --- |
| **Perform Default Post Buffer Update** | 如果为 true，会执行默认的仅场景复制/Slate postprocess。如果为 false，则不会执行默认复制/处理。如果没有 postbuffer update 被“绘制”且此设置关闭，当 widget 尝试采样 Slate postbuffer 时，行为未定义。结果可能是上一帧或黑白画面，应避免这种情况。 |
| **Buffers to Update** | 已弃用。请改用 **Update Buffer Infos** 。 |
| Update Buffer Infos | 此 widget 将触发捕获的 Buffer 数组，以及每个 Buffer 的 Post Processor 属性。 |

配置 Post Buffer Update Widget 后，其它 widget 可以自由采样 Scene 和 UI，并包含你选择更新的 buffer 上应用的任何 post FX。

### Postbuffer 与绘制顺序

要让 postbuffer update 正常工作，Slate 必须先绘制 postbuffer 将要采样的所有 UI 元素， *然后* postbuffer 才能采样它们。将 postbuffer 放在垂直/水平/grid box 内的 overlay 中，可能因绘制顺序不一致而无法保证这一点。作为准则：

- 层级结构底层应放置希望显示 postbuffer 影响视觉效果的 widget。
- 中间层应包含 postbuffer widget。
- 顶层应是一个采样 postbuffer 并将效果应用到底层的材质。

下图展示有效的绘制顺序：

> 图片已省略：An example hierarchy.

以下图片展示应用到 horizontal box 中图片上的材质：

> 图片已省略：An example material that blurs the inside of a horizontal box.

## 技术信息与限制

以下是有关 Slate postbuffer 行为的一些技术说明和限制。

### 采样

GetSlatePost 节点会采样指定 postbuffer 的当前状态，供 widget 采样。这些 buffer 是全局的，因此使用它们需要团队规划。

### 性能与模糊后期处理

使用 postbuffer 时，会使用多步 Kawase Dual Filter 的优化版本，以高精度近似 Gaussian blur。根据所用模糊强度（对应 Gaussian 的“sigma”值），模糊可以在降采样图像上计算。

随着模糊强度提高，中间 render pass 数量也会增加。不过，使用更高模糊强度并不一定带来更高性能成本。事实上，在降采样生效之前，较弱的模糊强度反而可能有更高性能成本。

#### 多个 Post Processor

当使用多个带 postprocess 的 postbuffer 时，只需要为屏幕上实际可见的 postprocess 支付性能成本。例如，如果有两个 postbuffer，各自使用不同值的 blur postprocess：

- 如果只有其中一个可见，则只为它支付成本。
- 如果二者都可见，则为二者都支付成本。

### 最小化 Buffer 使用

只有在绘制了使用某个 buffer 的 widget 时，该 buffer 才会被复制/填充。当某个 buffer 两帧未被使用时，它会在 GPU 上调整为 1x1。

### HDR 支持

Slate postbuffer 支持 **HDR**。不过，使用 HDR 时，材质应 **从 RGB 采样**而不是 LinearRGB。此外，HDR 支持仅在 HDR Composite 关闭时可直接工作。如果想使用 HDR composite，可能需要在使用时校正 gamma 值。

### 缓存的 Buffer 使用

Widget 材质会在材质/纹理创建和资源更新时缓存 postbuffer 使用情况，但不会在每次绘制时更新此缓存值。

由于此缓存，如果在全局 CVar `Slate.CopyBackbufferToSlatePostRenderTargets` 关闭时运行，材质可能会停留在显示未使用的状态。在这种情况下，尝试使用 postbuffer 的材质可能只能采样黑/白。如果发生这种情况，可能需要重启来清除使用缓存并获得正确结果。建议在 *Engine.ini 中或测试早期启用 `Slate.CopyBackbufferToSlatePostRenderTargets`。

在 PIE 中使用 Post Buffer Update Widget 调整大小时，采样结果可能会在调整期间暂时变为黑/白。出现此问题是因为我们在 postbuffer update widget 的尺寸检查上更保守。此问题只出现在 PIE 中，因为 PIE 由于要绘制编辑器，在调整大小期间绘制更活跃。Standalone 或 Shipping 构建中不会出现此问题。

