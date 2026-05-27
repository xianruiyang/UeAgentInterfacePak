# 移动平台FSR

---
title: "移动平台FSR"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-mobile-fsr-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "移动端渲染功能", "移动平台FSR"]
---

# 移动平台FSR

> 路径：虚幻引擎5.7文档 / 移动端开发 / 移动端渲染功能 / 移动平台FSR

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-mobile-fsr-for-unreal-engine

AMD的 **FidelityFX Super Resolution（FSR）** 使用时间放大（Temporal Upscaling）功能从低分辨率输入生成高分辨率图像。应用程序不会直接以原生分辨率渲染，而是以更低的分辨率渲染，然后使用FSR将初始渲染结果的分辨率修改为原生分辨率，因此可以在性能受限的硬件上使用原本具有高昂成本的渲染过程。

**虚幻引擎（UE）** 支持针对移动平台进行了优化的FSR 1.0版本。本页提供有关如何启用移动平台FSR的说明，以及有关其配置参数的参考指南。

有关使用FSR的更多技术细节和指南，请参阅[AMD的FSR 1.0文档](https://github.com/GPUOpen-Effects/FidelityFX-FSR](https://github.com/GPUOpen-Effects/FidelityFX-FSR)。

## 移动平台FSR的优点

这种FSR实现方案会略微降低渲染质量，但会产生2倍（使用全精度）到4倍（使用半精度）的性能提升。与牺牲的质量相比，这种性能改进非常大，因此我们建议使用移动平台FSR，除非应用程序的最终渲染画面不是全屏尺寸。

## 启用移动平台FSR

要启用移动平台FSR，请按照以下步骤操作：

1. 打开 **插件（Plugins）** 窗口并启用 **移动平台FSR（Mobile FSR）** 插件（可在 **渲染（Rendering）** 类目中找到该插件）。

   ![Enabling the Mobile FSR plugin](../../../../assets/images/1a/1aa0c20f1bf47d0c3c92e67120de0672170e5bfaaac0526b0dd66679dd1b8acf.jpg)
2. 将控制台变量 `r.Mobile.FSR.enabled` 设置为1。可在控制台中或[设备描述（Device Profiles）](../../../sharing-and-releasing-projects/tools-for-general-platform-support/setting-up-device-profiles/index.md)中执行此操作。

启用移动平台FSR后，便可开始配置其相关变量。默认情况下，变量 `r.Mobile.FSR.RCAS.enabled` 和 `r.Mobile.FSR.Upsampling.enabled` 均设置为1（true）。

> [!TIP]
> 移动平台FSR将在虚幻编辑器的[移动预览（Mobile Preview）](../../development-tools-for-mobile-applications/using-the-mobile-previewer/index.md)中生效。

## 配置移动平台FSR

可在"设备描述（Device Profiles）"或控制台中使用以下参数来配置移动平台FSR：

| 参数 | 描述 |
| --- | --- |
| `r.Mobile.FSR.enabled` | 启用对移动平台FSR的支持。 |
| `r.Mobile.FSR.RCAS.enabled` | 启用FSR的锐化（CAS）部分，从而尽可能提高图像质量。 |
| `r.Mobile.FSR.RCAS.Sharpness` | 控制CAS生成的锐度等级。0是锐度最高的设置，值越高，锐度越低。 |
| `r.Mobile.FSR.RCAS.Denoise` | 启用对颗粒状输入（例如抖动的图像或在FSR之前应用了自定义胶片颗粒效果的输入）的支持。适用于风格化游戏或启用了效果的部分游戏。 |
| `r.Mobile.FSR.Upsampling.enabled` | 启用FSR的上采样部分。无需对CAS启用上采样，但这样做可提高一些质量。 |
| `r.Mobile.FSR.DisableCompute` | 禁用FSR的计算通道，从而提高Mali设备上的性能。 |

## 局限性

移动平台FSR应该在大多数后期处理中都能按预期工作，但如果在后期处理中有意应用特定噪点或模式，则可能会产生意外的瑕疵。

## 延伸阅读

有关在应用程序中使用FSR的技术细节指南，请参阅[AMD的FSR 1.0文档](https://github.com/GPUOpen-Effects/FidelityFX-FSR](https://github.com/GPUOpen-Effects/FidelityFX-FSR)。

