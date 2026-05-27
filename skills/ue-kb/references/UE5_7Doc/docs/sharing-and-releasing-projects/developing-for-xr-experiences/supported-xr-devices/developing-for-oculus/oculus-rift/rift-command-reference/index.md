---
title: "Rift命令参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/rift-command-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "分享和发布项目", "XR开发", "支持的XR设备", "Oculus开发", "Oculus Rift", "Rift命令参考"]
---

# Rift命令参考

> 路径：虚幻引擎5.7文档 / 分享和发布项目 / XR开发 / 支持的XR设备 / Oculus开发 / Oculus Rift / Rift命令参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/rift-command-reference-in-unreal-engine

以下部分包含诸多INI和控制台命令，可用于调整UE4和Oculus Rift相互互动的方式。

| 命令 | 描述 |
| --- | --- |
| **vr.oculus.bHQBuffer** | 启用/禁用将浮点纹理格式用于眼睛层。 |
| **vr.oculus.bHQBuffer** | 启用/禁用将多个mipmap等级用于眼睛层。 |
| **vr.oculus.bUpdateOnRenderThread** | 启用/禁用渲染线程上的更新。 |
| **vr.oculus.Debug.bShowStats** | 启用或禁用统计数据的渲染。 |
| **vr.oculus.Debug.CaptureCubemap** | 采集一张Oculus Home的立方体贴图。可选参数（所有数字参数皆默认为零）：xoff= 从原点的-X轴偏移 yoff= -Y轴偏移 zoff=-Z轴偏移 yaw= -- 查看的方向（roll和pitch固定为零） gearvr -- 生成一张GearVR格式立方体贴图（采集的立方体高度为1024像素，而非2048像素）。 |
| **vr.oculus.Debug.EnforceHeadTracking** | 设为开启后则强制进行头部追踪，即使未在立体模式中也同样如此。 |
| **vr.oculus.Debug.FCP** | 显示或覆盖当前的远剪切平面。 |
| **vr.oculus.Debug.IPD** | 显示或修改当前的瞳孔间距（米）。 |
| **vr.oculus.Debug.NCP** | 显示或覆盖当前的近剪切平面。 |
| **vr.oculus.Debug.Reset** | 将诸多立体渲染参数重设为原始设置。 |
| **vr.oculus.Debug.Show** | 显示诸多立体渲染参数的当前值。 |
| **vr.oculus.PixelDensity** | 像素密度将渲染目标纹理尺寸设为推荐纹理尺寸的一个因子。因其可能稍大于原生分辨率，将PixelDensity设为1.0与将r.ScreenPercentage设为100并不相同 |
| **vr.oculus.PixelDensity.adaptive** | 启用或禁用自适应像素密度。 |
| **vr.oculus.PixelDensity.max** | 自适应像素密度启用时的最大像素密度。 |
| **vr.oculus.PixelDensity.min** | 自适应像素密度启用时的最小像素密度。 |
| **vr.oculus.ShowGlobalMenu** | 打开全局菜单。 |
| **vr.oculus.ShowQuitMenu** | 打开退出菜单。 |
| **vr.oculus.Stress.CPU** | 开始CPU压力测试。用法：vr.oculus.Stress.CPU [PerFrameTime [TotalTimeLimit]] |
| **vr.oculus.Stress.GPU** | 开始GPU压力测试。用法：vr.oculus.Stress.GPU [LoadMultiplier [TimeLimit]] |
| **vr.oculus.Stress.PD** | 开始像素密度压力测试，像素密度按每TotalTimeLimit秒一帧的频率变化。用法：vr.oculus.Stress.PD [TotalTimeLimit] |
| **vr.oculus.Stress.Reset** | 重设压力测试器并停止当前运行的所有压力测试。用法：vr.oculus.Stress.Reset |
