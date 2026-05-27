---
title: "编辑器中的像素流送"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pixel-streaming-in-editor"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "像素流送", "像素流送开发指南", "编辑器中的像素流送"]
---

# 编辑器中的像素流送

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / 像素流送 / 像素流送开发指南 / 编辑器中的像素流送

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pixel-streaming-in-editor

## 像素流送工具栏

像素流送工具栏是用于在编辑器中控制像素流送的主要手段。

> [!NOTE]
> 要访问像素流送工具栏，请确保你启用了像素流送插件。

#### 使用远程信令服务器

切换此选项会阻止编辑器在你使用关卡和完整编辑器流送选项时创建嵌入式信令服务器。你必须手动启动编辑器外部的信令服务器，并指定其URL。不过，在大部分用例中，使用默认值即可。

#### 嵌入式信令服务器选项

这些值将指定在你使用编辑器流送功能时创建的嵌入式信令服务器的端口。除非你明确需要更改这些值，否则默认值应该能满足大部分用例的需求。

由于虚幻编辑器在Linux上不作为sudo运行，因为无法创建创建1000以下的端口绑定。由于端口80是用于流送的默认查看器端口，我们已在Linux上将默认编辑器流送查看器端口更改为8080。连接到流时，你必须在浏览器URL中指定此端口。

> [!NOTE]
> 这仅适用于嵌入式信令服务器。外部信令服务器仍将使用端口80，这不需要在浏览器中指定。

#### 虚拟摄像机

虚拟摄像机是添加到像素流送的试验性的新功能。如需详细了解如何使用此功能，请参阅[虚拟摄像机](../experimental-pixel-streaming-features/index.md)页面。

#### 编码解码器

这些选项将指定你的流将使用的编码器。如需详细了解每个编码解码器以及比较情况，请参阅[支持的编码解码器](../../unreal-engine-pixel-streaming-reference/index.md#%E6%94%AF%E6%8C%81%E7%9A%84%E7%BC%96%E7%A0%81%E8%A7%A3%E7%A0%81%E5%99%A8)页面。

## 编辑器流送

利用编辑器流送，你可以将虚幻引擎编辑器流送到网络浏览器，包括移动设备上的浏览器。这就带来了与编辑器远程交互的新潜力，还可提供安全优势，并为用户带来新的协作方式。此外，由于不必在本地硬件上运行应用，新的高效工作管线随之浮现。

编辑器流送利用基础像素流送模块，这意味着熟悉像素流送及其应用程序的用户能够很好地适应编辑器流送。

### 如何使用？

编辑器流送的设计宗旨是尽可能轻松地使用。要开始编辑器流送，请执行以下操作：

1. 确保你启用了像素流送插件。
2. 编辑器重启后，你会注意到工具栏上有一个新的"像素流送（Pixel Streaming）"菜单。
3. 打开像素流菜单并点击"流送完整编辑器（Stream Full Editor）"。
4. 好了！现在你的编辑器正在流送。打开浏览器并找到你的公共IP（127.0.0.1适合测试本地流）
5. 再次打开工具栏，你会发现几个IP，可供你从中访问你的流（网络配置允许的情况下）

> [!NOTE]
> 上述步骤将启动虚幻编辑器中嵌入的信令服务器。如果你更熟悉的工作流程是启动 **PixelStreamingInfrastructure** 仓库（可在此处找到）中的信令服务器，只需选中 **使用远程信令服务器（Use Remote Signaling Server）** 复选框，并输入此信令服务器的IP地址，然后开始流送即可。

### 如何在云中流送我的编辑器？

从云实例流送编辑器的实现方式与流送常规像素流送应用程序大体相同，不过存在一些轻微修改：

- 如果你的应用程序启动参数包含：

  -res=1920x1080

  或类似内容，你需要将其替换为

  -EditorPixelStreamingRes=1920x1080
- 如果你的应用程序启动参数包含：

  -resx=1920 -resy=1080

  或类似内容，你需要将其替换为

  -EditorPixelStreamingResX=1920 -EditorPixelStreamingResY=1080
- 如果你的应用程序启动参数包含：

  -Renderoffscreen

  ，你需要添加 -EditorPixelStreamingStartOnLaunch=true` 以开始流送，而无需与工具栏交互
- 如果你想使用引擎中嵌入的服务器之外的信令服务器，你需要添加

  -EditorPixelStreamingUseRemoteSignallingServer=true
- 最终命令类似于以下示例：

  Engine\Binaries\Win64\UnrealEditor-Cmd.exe -project Path\To\Your\Project.uproject -RenderOffscreen -EditorPixelStreamingRes=1920x1080 -EditorPixelStreamingStartOnLaunch=true -PixelStreamingURL=ws://127.0.0.1:8888

> [!NOTE]
> 在屏幕外渲染时的编辑器流送当前是试验性的，可能不稳定。

### 流送关卡编辑器

除了完整编辑器流送，我们还添加了专门流送编辑器关卡视口的选项。仅流送关卡视口时，连接的对等端不会看到周围元素，包括但不限于大纲视图、内容浏览器和一切弹出菜单。

要使用关卡流送，只需从工具栏选项选择 **流送关卡编辑器（Stream Level Editor）** 而不是 **流送完整编辑器（Stream Full Editor）**。
