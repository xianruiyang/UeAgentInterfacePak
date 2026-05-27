---
title: "异步计算"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/asynccompute-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "图形编程", "异步计算"]
---

# 异步计算

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 图形编程 / 异步计算

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/asynccompute-in-unreal-engine

渲染硬件接口（RHI）现支持Xbox One的异步计算（**AsyncCompute**）。 此法可运行与渲染异步的**`dispatch()`**调用，有效利用未使用的GPU资源（计算单元（CU）、寄存器和带宽）。 异步计算使用单独的上下文，我们提供RHI函数来同步渲染和计算上下文。 Dr PIX 可用于识别从异步计算获益的区域。 例如，特定渲染通道中半数 CU 均未使用，这些 CU 则可能被异步计算任务所利用。

异步计算存在一些限制：

- 不支持UAV计数器缓冲（这是XDK的限制，将生成D3D警告）
- 异步计算作业不会在PIX GPU捕获中显示（尽管它们确实出现在定时捕获中），PIX只捕获图形即时上下文（这是平台限制）。
- 驱动器不提供自动管线强制清空。 如果需要刷新，需显式调用RHICSManualGpuFlush（例如， 一个调度依赖于前一个调度）。

## API

- **RHIBeginAsyncComputeJob_DrawThread**（EAsyncComputePriority Priority）

  从渲染线程开始异步计算任务。 优先级用于确定分配任务（通过 ID3D11XComputeContext::SetLimits）的着色器资源数量。 当前有两个可用优先级：AsyncComputePriority_High和AsyncComputePriority_Default。
- **RHIEndAsyncComputeJob_DrawThread**

  完成异步计算任务。 返回一个用于同步的32位栅栏指数；如计算被禁用或无进行中的计算任务，则返回-1。
- **RHIGraphicsWaitOnAsyncComputeJob**

  在图形直接上下文中插入一个命令进行阻止，直到异步任务完成。 传递 -1 会导致此进程提前结束。

在 RHIBeginAsyncComputeJob_DrawThread 和 RHIEndAsyncComputeJob_DrawThread 调用之间，RHI 处于异步计算状态。 这段时间中，支持的RHI命令将通过异步计算上下文执行。 不支持的RHI函数将断言。

## 启用/禁用

编译时可通过 #define USE_ASYNC_COMPUTE_CONTEXT 启用或禁用异步计算。 运行时可通过`r.rdg.asynccompute`控制台变量禁用。 异步计算禁用后，异步计算块中的调度将在图形命令缓冲上同步执行。 PC上的USE_ASYNC_COMPUTE_CONTEXT被定义为0，因D3D11.1不支持。

## PIX

异步计算上下文任务不在GPU采集中进行采集，因此异步计算启用时这些采集可能呈现出错误的GPU性能画面。 为进行图形调试，应使用上述控制台变量禁用异步计算。 异步计算由 PIX 定时采集支持。 它们在时间轴中如下图所示：

## 制作人员

此功能由Lionhead Studios实现。 我们将其整合并用作Xbox One渲染的优化工具。
