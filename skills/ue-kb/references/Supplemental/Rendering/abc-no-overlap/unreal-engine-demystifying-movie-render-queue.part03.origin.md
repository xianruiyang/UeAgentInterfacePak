# 揭秘电影渲染队列（续 3）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue
- 原始文件：unreal-engine-demystifying-movie-render-queue.origin.md
- 分段：第 3/3 段

- [https://docs.substance3d.com/spdoc/gpu-drivers-crash-with-long-computations-128745489.html](https://docs.substance3d.com/spdoc/gpu-drivers-crash-with-long-computations-128745489.html)
- [https://docs.microsoft.com/en-us/windows-hardware/drivers/display/timeout-detection-and-recovery](https://docs.microsoft.com/en-us/windows-hardware/drivers/display/timeout-detection-and-recovery)
- [What's it doing!?](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#what'sitdoing!?)
- [Deferred or Hybrid Raytraced Rendering (Non-path traced)](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#deferredorhybridraytracedrendering(non-pathtraced))
- [Temporal Sample Count](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#temporalsamplecount)
- [Spatial Sample Count](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#spatialsamplecount)
- [Anti Aliasing Method](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#antialiasingmethod)
- [Path-traced Rendering Samples](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#path-tracedrenderingsamples)
- [Raytrace/Lumen/RT Shadow Samples](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#raytrace/lumen/rtshadowsamples)
- [WARMUPS](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#warmups)
- [CVARS](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#cvars)
- [Movie Render Graph](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#movierendergraph)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/GxdV/unreal-engine-demystifying-movie-render-queue#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)
