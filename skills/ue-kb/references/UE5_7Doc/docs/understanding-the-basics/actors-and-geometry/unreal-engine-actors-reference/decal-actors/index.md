---
title: "贴花Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/decal-actors-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "贴花Actor"]
---

# 贴花Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 贴花Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/decal-actors-in-unreal-engine

延迟贴花（Deferred Decal）提供了更好的性能和维护性。通过写入GBuffer而非重新计算光照，它具备了几点优势：

- 许多光源的性能变得更加可预测，因为对光源数量或类型没有限制（所有光源都使用相同的代码路径）
- 使用屏幕空间遮罩时，还可以实现一些在其他情况下很难实现的效果（比如潮湿层）。

贴花的渲染方式是，在贴花影响区域的周围的一个方框中渲染。

## 在关卡中添加贴花

在场景中添加贴花的方法是：在 **内容浏览器（Content Browser）** 中选择合适的贴花材质，然后在视口中 **右键单击**，在上下文菜单中选择 **放置Actor（Place Actor）**。然后可以使用变形工具调整贴花的大小和方向。

## 调整大小、平铺次数和偏移

创建贴花后，你可以使用平移和旋转控件对其进行定位和定向。

非等分缩放控件（non-uniform scaling widget）能控制贴花体积的宽度、高度和远平面距离。

## 延迟贴花属性

延迟贴花只有几个属性：

| 属性 | 说明 |
| --- | --- |
| **材质（Material）** | 此属性定义了贴花的材质。 |
| **排序顺序（Sort Order）** | 此属性允许用户控制多个贴花堆叠时的排序方式。值越高，越在顶部渲染。 |

> [!WARNING]
> 设置排序值时，请小心操作。如果在大量不同贴花上设置大量排序值，可能会导致贴花无法按状态排序，从而损害性能。

## 材质设置

**DecalBlendMode** 定义了如何将材质属性（漫反射、镜面反射、法线、不透明度...）应用到GBuffer。

不透明度用于混合贴花的贡献。一个高效贴花只会处理少量的GBuffer属性。 我们当前优化的案例由以下其他模式表示：***DBM_Diffuse***、***DBM_Specular***、***DBM_Emissive***、***DBM_Normal***。

| 项目 | 说明 |
| --- | --- |
| **半透明（Translucent）** | 它将混合完整材质，更新GBuffer，不适用于烘焙光照。 |
| **染色（Stain）** | 它将调制基色（Modulate BaseColor），混合其余部分，更新GBuffer，不适用于烘焙光照。 |
| **法线（Normal）** | 它将仅混合法线，更新GBuffer，不适用于烘焙光照。 |
| **自发光（Emissive）** | 它仅适用于附加自发光。 |
| **DBuffer_半透明颜色、法线、粗糙度（DBuffer_Translucent Color, Normal, Roughness）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。如果没有连接法线，那么它将成为DBM_TranslucentNormal。 |
| **DBuffer_半透明颜色（DBuffer_Translucent Color）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。 |
| **（DBuffer_半透明颜色、法线）DBuffer_Translucent Color, Normal** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。如果没有连接法线，那么它将成为DBM_DBuffer_Color。 |
| **DBuffer_半透明颜色、粗糙度（DBuffer_Translucent Color, Roughness）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。 |
| **DBuffer_半透明法线（DBuffer_Translucent Normal）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。 |
| **DBuffer_半透明法线、粗糙度（DBuffer_Translucent Normal, Roughness）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。如果没有连接法线，那么它将成为DBM_DBuffer_Roughness。 |
| **DBuffer_半透明粗糙度（DBuffer_Translucent Roughness）** | 它适用于非金属，也可以放入DBuffer中用于烘焙光照。 |
| **（实验性）体积距离函数（Volumetric Distance Function (experimental)）** | 它将根据LightVector在不透明度中输出一个有向距离。 |

***DBM_ScreenSpaceMask*** 比较特殊，因为它可以影响一个特殊的遮罩通道，即SSAO当前使用的通道（环境遮挡）。这使贴花能够覆盖或淡化某些区域的作用。

***DBM_DiffuseSpecularEmissive*** 是影响多个GBuffer通道的模式。

注意，材质混合模式也会影响GBuffer值的混合方式。因此，可以将漫反射的颜色相乘。

你可以使用GBuffer视图模式检查逐像素存储的GBuffer值。

贴花本地位置是0到1范围内的第3个位置。纹理UV给出了x和y分量。如果你需要z分量，你可以连接一个CameraVector节点来获得所有3个矢量分量。

## 性能

受贴花影响的对象的网格体复杂性不影响性能。贴花的性能取决于着色器的复杂性和屏幕上的着色器边框的大小。

我们可以进一步提高每个贴花的性能。在理想情况下，贴花的边框较小，以获得更好的像素性能。这可以手动实现。虽然自动化的方法是可行的，但是优秀的设计人员也可以通过调整布局来进一步提高性能。

视图模式 **ShaderComplexity**（编辑器UI或"viewmode ShaderComplexity"）可以用来查看对像素着色成本的影响，它使用一个像素着色器成本进行估算，并在多个贴花重叠时累加。 目前，贴花遮罩功能在这方面没有效果（由于使用了模板硬件特性，遮罩部件应该有较低的固定成本）。 以下显示了没有贴花时（左图）、带有贴花时（右图）、在法线渲染模式下时（上图）以及启用ShaderComplexity时（下图）的场景：

颜色越深，表示这些像素的性能成本越高。这些信息可以用来优化正确的着色器，去除几乎不可见的贴花或更有效地放置它们。

## 当前局限

- 我们目前只支持延迟贴花，而且它们只对静态对象有效。
- 法线混合当前不能围绕对象。
- 流送尚未连接，所以请确保纹理没有流送。
- 遮罩贴花（不影响其他对象）没有完全实现。

## 2x2区块瑕疵修复

贴花的边缘可能有2x2像素块瑕疵，如下面的截图所示。

这正是节点"贴花导数（Decal Derivative）"的用武之地。必须小心使用这个节点，因为它对性能有很大的影响。它返回各向异性纹理过滤所必需的贴花的默认纹理坐标在X轴和Y轴上的导数，但计算方法与使用硬件的默认节点和DDX/DDY节点不同，以避开这个2x2像素块瑕疵。

使用它可以修复受益于它的贴花上的瑕疵。

### 当前局限

- DecalMipmapLevel不支持自定义UV，但你可以修补它的输出。
