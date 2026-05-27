# 3D文本Actor

---
title: "3D文本Actor"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/3d-text-actor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考", "3D文本Actor"]
---

# 3D文本Actor

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考 / 3D文本Actor

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/3d-text-actor-in-unreal-engine

你可以使用基于几何体的 **文本3D（Text 3D）** Actor将高分辨率 **3D文本** 添加到关卡中。可在任何想要在虚拟世界中显示清晰、高品质文本的项目中使用3D文本对象，例如直播和虚拟场景。

> [!TIP]
> 你可以使用[Sequencer编辑器](../../../../animating-characters-and-objects/cinematics-and-movie-making/how-to-make-movies/index.md)为3D文本对象制作动画，在虚幻编辑器中直接创建动态图形。

## 启用3D文本插件

要使用3D文本，必须先启用 **文本3D（Text 3D）** 插件。

1. 在主菜单中，选择 **编辑（Edit）> 插件（Plugins）**。
2. 在 **文本（Text）** 选项卡中启用 **文本3D（Text 3D）**。

   系统会弹出一条插件正在实验阶段的警告。请点击"是"。
3. 点击

   立即重启（Restart Now）

   以便在项目中使用此插件。
4. 若对项目进行了更改，则会打开一个窗口，可在其中保存所做变动，然后再重新启动。

## 在关卡中放置3D文本

1. 在 **放置Actor（Place Actors）** 面板中，选择 **所有类（All Classes）** ，然后选择 **文本3D（Text 3D）**。
2. 将文本3D Actor拖放到关卡中。
3. 在视口中，选择文本3D Actor, 以便在 **细节（Details）** 面板中查看其参数。

## 文本3D Actor设置

以下选项在 **细节（Details）** 面板的 **3D文本（3D Text）** 分段中可用，可控制3D文本的显示方式：

| 属性 | 说明 |
| --- | --- |
| **Text** | 输入用于创建3D文本几何体的文本。 按 **Shift+Enter** 实现换行。 |
| **挤压（Extrude）** | 设置几何体的深度：即文字从前到后的厚度。 |
| **斜面（Bevel）** | 设置沿着字幕边缘的斜面大小。 |
| **斜面类型（Bevel Type）** | 设置边缘斜面的类型：用于锐利、平直斜面的线性或是用于圆形边缘的半圆形。 |
| **半圆分段数（Half Circle Segments）** | 设置创建半圆斜面所使用的分段数。 |
| **正面材质（Front Material）** | 选择给字母正面表面着色的材质。 |
| **斜面材质（Bevel Material）** | 选择给斜面表面着色的材质。 |
| **挤压材质（Extrude Material）** | 选择给字母侧面着色的材质。 |
| **背面材质（Back Material）** | 选择给字母背面着色的材质。 |
| **字体（Font）** | 选择用在字幕上的True Type(TTF)或Open Type(OTF)字体资产。 关于将字体导入虚幻引擎项目的更多详情，请参阅[导入字体](../../../../user-interfaces/text-formatting-localization-and-fonts/fonts/importing-fonts/index.md)。 |
| **水平对齐（Horizontal Alignment）** | 根据Actor在3D空间中的位置，将文本水平向左、居中或向右对齐。 |
| **垂直对齐（Vertical Alignment）** | 根据Actor在3D空间中的位置，将文本在垂直方向上与控件的顶线、顶部、底部或中心对齐。 |
| **字距调整（Kerning）** | 设置各个字符之间的额外空间。 |
| **行距（Line Spacing）** | 设置各行之间的额外空间。 |
| **字距（Word Spacing）** | 设置各个词之间的额外空间。 |
| **最大宽度（Max Width）** | 设置文本的最大宽度。 |
| **最大高度（Max Height）** | 设置文本的最大高度。 |
| **按比例缩放（Scale Proportionally）** | 将字母的高度和宽度锁定为当前比例。一旦启用，对字幕的高度或宽度的任何改动都会同时影响到两者。 |

## 逐字母动画处理

你可以让文本3D Actor中的字母的3D平移、旋转和缩放属性在起始值和最终值（可配置）之间进行内插值。你可以设置动画在文本字母间的播放顺序（从左到右、从右到左、从中间字母往外或从外侧字母往内），以及每个字母的动画与相邻字母动画的重叠程度。当这与[Sequencer](../../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)工具结合使用时，你就能设计出拥有逐字母动画效果的动态示意图形。

例如，以下视频显示了如何将变换应用于文本3D Actor字母的位置、缩放和旋转，以及如何使用关卡序列让变换随着时间产生动画效果。

文本3D Actor中的逐字母动画由 **Text3DCharacterTransform** 组件控制。你需要将这类组件添加到Actor，并设置其值。

若要设置逐字母动画：

1. 在视口或 **世界大纲视图（World Outliner）** 中选择文本3D Actor。
2. 在 **细节（Details）** 面板中，单击 **添加组件（Add Component）**，并选择 **Text3DCharacterTransform**。

   ![添加Text3DCharacterTransform组件](../../../../../assets/images/88/887b850323feff287a1346d0b23b2cfb10b4225605980fa7783d6ab892834c9b.jpg)
3. 在 **细节（Details）** 面板顶部，选择新的 **Text3DCharacterTransform**，以访问其设置。

   ![选择Text3DCharacterTransform组件](../../../../../assets/images/99/998400dc99d15c092fa8d8cac763a8e2d39b6e9c8f0eab21798ed4b5357eaec2.jpg)
4. 启用位置、旋转和/或缩放变换，并调整其设置，以生成所需的动画效果。有关每种设置的说明，请参见下表。

   > [!TIP]
   > 调整位置、旋转或缩放变换的设置时，你可以在0到100之间来回拖动 **进度（Progress）** 值，以预览效果。
5. 通常，你需要用 **关卡序列（Level Sequence）** 播放你设计的动画效果。这通常涉及将文本3D Actor添加到关卡序列中，为 **进度（Progress）** 设置创建新轨迹，然后在这些轨迹上创建关键帧，让数值随着时间在0到100之间变化。例如：

   ![关卡序列中的动画进度设置](../../../../../assets/images/e8/e83e929adc189b82a29ad780ad388de63edc9e29a1fea6fc691a3dfdba29987b.jpg)

   > [!NOTE]
   > 有关创建关卡序列和在Sequencer编辑器中操作的细节，请参见[Sequencer](../../../../working-with-media/integrating-media/real-time-compositing-with-composure/real-time-compositing-with-sequencer/index.md)文档。

### 文本3D角色变换设置

**Text3DCharacterTransform** 组件公开文本3D位置、旋转和缩放的以下设置。你可以分别控制三种变换类型。

| 设置 | 说明 |
| --- | --- |
| **启用（Enabled）** | 确定 **Text3DCharacterTransform** 组件是否根据此分段中的值更新字母的位置、旋转或缩放。 启用此选项会需要CPU进行一些额外计算。通常，你应仅为真正需要动画处理的变换类型启用此设置。 |
| **进度（Progress）** | 确定文本动画在 **开始（Begin）** 和 **结束（End）** 状态之间的总进度。位于 `0` 时，文本的位置、旋转或缩放处于其 **开始（Begin）** 状态。位于 `100` 时，文本的位置、旋转或缩放处于其 **结束（Begin）** 状态。两者之间的值在 **开始（Begin）** 和 **结束（End）** 状态之间按比例内插位置、旋转或缩放。 如果你想创建关卡序列，让字母逐个随着时间播放动画，那么你通常可以在关卡序列中使用这种设置处理动画。 |
| **顺序（Order）** | 确定文本字母在播放动画时的顺序。 **正常（Normal） -** 动画从最左侧字母开始，并向右移动。 **从中心开始（From Center） -** 动画从文本中心的字母开始，并朝两个方向向外移动。 **向中心靠拢（To Center） -** 动画从文本的最外侧字母开始，并朝中间的字母向内移动。 **反向（Opposite） -** 动画从最右侧字母开始，并向左移动。 |
| **范围（Range）** | 确定相邻字母之间的动画同步程度。位于 `0` 时，每个字母会在下一个字母开始变换之前，完成从 **开始（Begin）** 状态到 **结束（End）** 状态的变换。位于 `100` 时，所有字母会同时开始和结束其转换。介于两者之间的值，则会让相互衔接的字母在动画播放的时间上产生部分重叠。 |
| **开始（Begin）** | 为字母的旋转或缩放所设置的初始状态。所有方向轴数值均以文本3D Actor的局部空间表示。 对于位置，每个字母的 **开始（Begin）** 位置始终由文本3D Actor在关卡中的位置确定。 |
| **结束（End）** 或 **距离（Distance）** | 为字母的位置、旋转或缩放设置所需的结束状态。 |

