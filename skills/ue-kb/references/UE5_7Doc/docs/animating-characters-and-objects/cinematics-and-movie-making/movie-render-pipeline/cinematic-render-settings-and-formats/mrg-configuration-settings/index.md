---
title: "MRG配置设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/mrg-configuration-settings-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "影片渲染管线", "渲染设置与格式", "MRG配置设置"]
---

# MRG配置设置

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 影片渲染管线 / 渲染设置与格式 / MRG配置设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/mrg-configuration-settings-in-unreal-engine

## 屏幕追踪

Lumen默认启用了一些屏幕追踪元素。这可能会干扰图表所调用的部分图层可见性设置。 例如，如果你希望角色对反射和全局光照可见，但在给定图层上对主像素隐藏，那么启用屏幕追踪将导致角色按需在Lumen场景中显示，因此建议禁用这些元素。

禁用Lumen屏幕追踪的方法有多种。

- 你可以调用控制台变量：

  - `r.Lumen.Reflections.ScreenTraces 0`
  - `r.Lumen.ScreenProbeGather.ScreenTraces 0`
- 使用下列控制台命令在显示标记（Show Flags）中禁用两者

  - ShowFlag.LumenScreenTraces 0
- 在显示标记（Show Flags）分段下的MRG Deferred Rendering节点中，也可以将其提升为变量。

![ImageAltText](../../../../../../assets/images/48/489b0cbe3a7ad6f71a0defead22fb5d349803d776f0cffe557b6eb0c49a37ecc.png)

- 在虚幻引擎5.4版本中，后期处理体积（Post Process Volume）的Lumen全局光照分段和Lumen反射分段都添加了屏幕追踪布尔参数。

![ImageAltText](../../../../../../assets/images/d6/d656b61b261c982fb45c9056576e2c0ccc79f98470ca5abc2aa20134b1c6d92c.png)

下方给出了直观的示例，展示了屏幕追踪对"隐藏时影响间接光照（Affect Indirect Lighting While Hidden）"的干扰。第一张图片展示了球体在下方镜面上的反射。

![ImageAltText](../../../../../../assets/images/fe/fe51b3dc2bb5f8b90e53c5f628e63258066a658e0d7b34287795f8307d56b976.jpg)

启用"隐藏时影响间接光照（Affect Indirect Lighting While Hidden）"并禁用"可见（Visible）"时，反射消失了，因为它是使用屏幕空间反射绘制的。

![ImageAltText](../../../../../../assets/images/5c/5cbd14dd7546fff25a002c8d06d564cb2fe57a2bfac80ad7142af77425d8c2ae.jpg)

但如果在"后期处理体积（Post Process Volume）"中禁用屏幕追踪，反射就会重新出现。

![ImageAltText](../../../../../../assets/images/0f/0f453acca8cd409fec7173558e5067acf55ac10aff91015d6e87aa5da5a6042c.jpg)

对比：

![ImageAltText](../../../../../../assets/images/59/59c71925a96f3c3f50514c0d99b7757e8c4c49bb6c84bb8cddc44f549b0a7e6d.jpg)

> [!NOTE]
> 禁用Lumen屏幕追踪可能会改变场景的外观，因此建议在为关卡提供光照时设置这一功能，而不是纯粹在渲染时切换。

## 色调曲线

使用 **半透明Actor** 时，建议 **禁用色调曲线** ，因为引擎应用曲线/编码前会预先对alpha进行乘算。因此，如果你应用了色调曲线并尝试在其本身的图层上渲染部分半透明对象，那么合成后的结果会与你在引擎中看到的有所不同。在这种情况下，色调曲线会给出非线性颜色，这对此类合成而言并不理想。你可能必须禁用色调曲线才能使用自己的OCIO配置。

## 允许OCIO

**Allow OCIO on the Deferred** 和 **Path Traced Rendering** 节点为面向数据的渲染图层提供了退出选项（默认为开启），而这类渲染层是通过显示标记（Show Flags）和材质修改器（Material Modifiers）处理的，并不适合OCIO。

## Groom

- 有时，若在渲染Groom时有多个图层存在动态模糊，可能产生不正确的结果。建议尝试使用命令 `MoviePipeline.FlushLayersDebug 1` 进行改进。
- 要在使用holdout时改善Groom周围的光晕，推荐使用 `r.HairStrands.HoldoutMode 1` 命令。
