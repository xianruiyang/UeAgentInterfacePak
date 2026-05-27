# Groom缓存

---
title: "Groom缓存"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/using-groom-caches-with-hair-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "毛发渲染与模拟", "Groom缓存"]
---

# Groom缓存

> 路径：虚幻引擎5.7文档 / 管理内容 / 毛发渲染与模拟 / Groom缓存

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/using-groom-caches-with-hair-in-unreal-engine

**Groom缓存（Groom Cache）** 是Groom资产的一个扩展文件，用于播放在其它数字内容创建（DCC）应用程序中模拟，并使用Alembic导出到虚幻引擎的Groom动画。Groom缓存Alembic作为一种Groom Alembic，包含了可以将属性动画化的时间样本。支持动画化的属性有顶点位置、宽度和颜色。

## Groom缓存类型

可以导入到虚幻引擎的Groom缓存Alembic文件有两种：导线Groom缓存和发束Groom缓存

**导线Groom缓存（Guides Groom Cache）** 仅支持导线的顶点位置动画化。它利用引擎内的发束插值来将导线动画转移到渲染的发束，需要Groom资产启用每个Groom组的模拟。这适用于播放仅将顶点位置动画化的Groom动画，引擎内发束插值就足以达到预期的效果。这种Groom缓存比起发束Groom缓存更加轻量化并节省性能。

**发束Groom缓存（Strands Groom Cache）** 包含了每根发束的动画化属性，使其比导线Groom缓存消耗更多内存和带宽。换来优点是除了顶点位置以外还支持宽度和颜色，带来更多的灵活性，并且有更高的保真度，包含了和DCC应用中计算的完全一致的模拟。这种Groom缓存不使用引擎内插值，不需要启用Groom资产的模拟。当前发束Groom缓存的限制是它必须包括顶点位置动画，不能只包含宽度和颜色动画。

发束Groom缓存可以用于播放不能在引擎内模拟的Groom动画，或者用于应对模拟和插值不能达到预期的效果的情况。比如说显示毛发生长得更长更粗的动画。

> [!NOTE]
> 注意若想将Groom缓存和Groom资产搭配使用，它们必须有同样的拓扑结构，比如同等数量的发束、顶点、每个发束的顶点等等。如果想要让毛发变短，全局和每根发束的顶点数量都不能改变，只能在动画中调整它们的位置来表示毛发长度。

## 将Groom缓存导入虚幻引擎

由于Groom缓存是一个带时间样本的Groom，Groom缓存Alembic在导入时会被认作为普通的Groom。然而，**Groom导入选项（Groom Import Options）** 中会显示一个 **Groom缓存（Groom Cache）** 部分，其中将 **导入Groom缓存（Import Groom Cache）** 启用。

![Groom导入选项Groom缓存选项](../../../../assets/images/b1/b15d72cccf74b52f9f0cc7f1ed1f877105ff497e72c05608ca6938adb8f3b484.png)

> [!NOTE]
> 可以禁用导入Groom缓存来仅导入Groom资产。无法导入仅有导线的Groom资产或者Groom缓存。

对于仅有发束的Groom，导入时会使用插值设置自动生成导线，这些设置用于为导线Groom缓存生成导线。如果Alembic中已经包含了导线，会为Groom资产和Groom缓存使用这些已有的导线，除非启用了Groom导入选项中的 **覆盖导线（Override Guides）** ，位于 **组（Groups） > 序号[n]（Index [n]） > 插值设置（Interpolation Settings）**。

![Groom导入选项覆盖导线设置](../../../../assets/images/4a/4a0067465c05319cb876f47b24b97f5096812967addd963f9420409e3e0d7773.jpg)

如果已经有了一个与要导入的Groom缓存拓补结构兼容的Groom资产，可以禁用 **导入Groom资产（Import Groom Asset）** 并指定要使用的Groom资产。

![Groom导入选项导入Groom缓存时禁用导入Groom资产](../../../../assets/images/5a/5aec8cff96dda74f274fc88689bbc1781cc9ff3ac0f99caa0e92954473bcd928.png)

导入时会将指定的 **Groom资产（Groom Asset）** 的导入设置应用到要导入的Groom缓存上。抽值和插值设置尤为重要，它们能够保证Groom资产和Groom缓存导入同样的拓扑结构。

![Groom导入选项禁用导入Groom资产时指定Groom资产](../../../../assets/images/1e/1e0dec0dc8f76d963532b8d1f3fe8500a943d01a12b3b5066cb01e9acb465030.jpg)

> [!NOTE]
> **导入Groom资产（Import Groom Asset）** 禁用时，必须指定一个 **Groom资产（Groom Asset）** 才能导入Groom缓存。

Groom缓存部分其它的设置用于控制导入动画范围，比如指定起始和结束帧，以及跳过Groom动画起始部分可能存在的空帧。

![Groom导入选项Groom缓存动画选项](../../../../assets/images/80/8046be049d3c577b96e89bcfaccfdc2f010bd5b7ffce17bfbc700d51d514aaac.jpg)

## 在虚幻引擎中使用Groom缓存

导入Groom缓存之后，可以将其应用到一个 **Groom组件（Groom Component）** 的 **Groom缓存（Groom Cache）** 插槽。

![将Groom缓存分配至Groom组件](../../../../assets/images/bc/bc2cc90c099705c375a4692c1f5385ecc72d9efcd54364077a89abf4c0f48b70.png)

> [!NOTE]
> Groom缓存只能与拓扑结构兼容的Groom资产搭配使用，因为它们本身不包括渲染Groom发束需要的渲染数据和资源。

如果Groom组件已经有了一个 **Groom绑定（Groom Binding）**，那么无法将 **Groom缓存（Groom Cache）** (2) 分配至该Groom组件，这种情况时Groom缓存分配插槽会是灰色。

![Groom组件Groom缓存和绑定资产分配插槽。](../../../../assets/images/17/17054cfe31fbe6a3026a5e0e913490ef4d259a8e30ae94063f012e8b771b77aa.png)

> [!NOTE]
> 对于导线Groom缓存，Groom资产必须为每个 **Groom组（Groom Group）** 启用模拟，从而在使用编辑器内播放（Play-in-Editor）(PIE) 时让Groom动画能够显示出来。

### 在关卡序列中使用Groom缓存

Groom缓存可以在[关卡序列](../../../animating-characters-and-objects/cinematics-and-movie-making/unreal-engine-sequencer-movie-tool-overview/index.md)中使用和控制，需要在Actor上添加一个带有Groom组件的 **Groom缓存（Groom Cache）** 轨道。

![在关卡序列中创建Groom缓存轨道](../../../../assets/images/fe/fec10f696ed9d1c80603da7f6203cd27ec26c232c02a58d1b6d8ce66d178538f.png)

如果Groom组件已经有了一个Groom缓存，那么轨道上的Groom缓存部分会自动调整大小来适应动画范围。否则就需要手动设置大小。

> 图片已省略：关卡序列中Groom缓存轨道自动动画范围

