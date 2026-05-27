# GPU调试工具NVIDIA Nsight Aftermath

---
title: "GPU调试工具NVIDIA Nsight Aftermath"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/nvidia-nsight-aftermath-for-gpu-pipeline-debugging-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "第三方渲染工具和插件", "GPU调试工具NVIDIA Nsight Aftermath"]
---

# GPU调试工具NVIDIA Nsight Aftermath

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 第三方渲染工具和插件 / GPU调试工具NVIDIA Nsight Aftermath

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/nvidia-nsight-aftermath-for-gpu-pipeline-debugging-in-unreal-engine

虚幻引擎支持NVIDIA的 **Nsight™ Aftermath** C++库。该库能在NVIDIA GeForce GPU发生崩溃后，为Windows开发人员提供额外数据。这些数据包含崩溃发生时GPU状况的关键信息，使你能够在自己项目中追踪GPU的情况。

Aftermath是一个轻量级的工具。它减少了某些调试工具所需的性能足迹。事实上，它足够轻巧，以至于可以与游戏一起捆绑发布，提供客户电脑的数据。Aftermath使程序员能够在他们的代码中插入标记，帮助其跟踪发生崩溃的关键原因。现在，你可以在虚幻引擎编辑器中使用该功能来跟踪、修复遇到的问题。

有关如何在项目中使用它的详细信息，请访问[NVIDIA Nsight™ Aftermath文档](https://developer.nvidia.com/nvidia-aftermath)页面。

## 启用NVIDIA Nsight™ Aftermath

请在 `ConsoleVariables.ini` 配置文件中添加以下控制台变量，以便在你的项目中启用NVIDIA Nsight™ Aftermath文件。

```
	r.GPUCrashDebugging=1
```

或者，你也可将以下参数传至命令行将其启用：

```
	-gpucrashdebugging
```

## 日志

启用 NVIDIA Aftermath 后，您将在日志中看到以下输出：

```
	LogD3D11RHI: [Aftermath] Aftermath enabled and primed
```

在虚幻引擎 4 中访问日志的方法：**File Menu > Window > Developer Tools > Output Log**，或在项目文件夹中打开日志文本文件。

出现崩溃后，日志显示的内容与以下内容相似：

```
	LogD3D11RHI: Error: Result failed at X:[Project Folder]\Engine\Source\Runtime\Windows\D3D11RHI\Private\D3D11Viewport.cpp:290 with error DXGI_ERROR_DEVICE_REMOVED DXGI_ERROR_DEVICE_HUNG	LogRHI: Error: [Aftermath] Status: Timeout	LogRHI: Error: [Aftermath] GPU Stack Dump	LogRHI: Error: [Aftermath] 0: Frame2769	LogRHI: Error: [Aftermath] 1: FRAME	LogRHI: Error: [Aftermath] 2: Scene	LogRHI: Error: [Aftermath] 3: ComputeLightGrid	LogRHI: Error: [Aftermath] 4: Compact	LogRHI: Error: [Aftermath] GPU Stack Dump
```

在此例中，GPU 崩溃后出现的结果中，带 `[Aftermath]` 前缀的行说明了状态和问题位于帧中何处，便于您调查其根本诱因。

## 注意事项

对于拥有约 200 到 300 个标记的普通项目而言，Aftermath 的处理速度足够迅速，但如果单物体阴影之类的内容太多，开销则会较大，可能响应较慢。因此，该功能并非默认启用。

