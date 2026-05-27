# 为 Ida Faber 的角色添加服装

# 为 Ida Faber 的角色添加服装

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/L7vb/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 3859 字符。

## 摘要

快速概述如何使用 ida faber 的角色或类似的模块化角色创建服装。

## 中文整理

### 概览

Ida Faber 制作了一些很酷的角色，您可以在 Unreal(fab)marketplace、Unity 和 Artstation 上找到这些角色。

他们中的许多人都能够选择模块化零件或完整角色。

全身角色有时会有不穿衣服或穿着内衣的角色，例如街头恶魔系列、科斯莫角色以及她的一些新角色。

这对于那些想为这些模特制作自己的服装的人来说是件好事。

如果您想使用下面没有任何东西的布料，模块化部件会很方便，这有利于将单独的网格组合成一个。

我要讨论的方法涉及使用基本模型和已缩小的衣服，没有配件或口袋。

您可以使用搅拌机来制作这样的角色。

Techwear Girls 套装中有一位模特穿着 T 恤和短裤。

我去掉了口袋，然后将 fbx 转移到了奇妙的设计师中。

我在里面做了一套衣服。

将服装导出为fbx（暂时删除头像）。

在 Unreal 中为 Techwear girls 示例项目中的服装制作了一个文件夹。

你不需要太导入简化的角色，只需要导入服装即可。

***** 将服装导出为 fbx 时需要了解的重要一点是，需要将其设置为 sdk 2014/2015 并使用绝对纹理，而不是相对或嵌入纹理。

否则，只会加载材质，文件中不会出现纹理。

当纹理文件出现时，您仍然需要重新导入它们并设置漫反射和法线等路径以使材质正确生成。

如果做得正确，纹理将在虚幻中显示为 png。***** 使用模块化部件，我发现类似的合身和部件，如头部、腿部、靴子和头发，位于未穿/覆盖的服装外部。

每件衣服都已经位于身体的正确位置，您只需以相同的方式调整所有部件，包括您的服装。

要将静态网格物体和骨架网格物体转换为一个骨架网格物体，最简单的方法是将所有内容都转换为一个静态网格物体，然后将其转换为骨架网格物体。

您需要激活两个插件才能执行此操作。

骨架网格物体完成后，应该有两个新文件，即骨架和虚幻中的骨架网格物体。

为了在关卡序列中使用角色并使用控制装备，您需要在骨架网格物体菜单中装备（制作骨骼并添加权重）角色。

最好的方法是制作3根脊椎，左右骨盆，颈部和头部，左右腿骨和臂骨，脚和手。

应该能够制作手指和脚趾骨头，并进一步制作面部骨头，但我没有这样做。

一旦骨头制成，你就可以增加重量。

如果角色伸展得很奇怪，请退出该菜单并返回。

第二次可能会起作用。

您应该编辑权重，确保不应受骨骼运动影响的部分完全为零或黑色。

受影响的部分应为蓝色/白色。

完成此操作后，您应该能够进入关卡音序器并添加在地图上选择的角色作为演员。

然后您可以向其中添加一个 fk 控制装置。

如果完成，正确地列出的所有可能的骨骼都应该使用变换键显示为可移动关节。

额外的步骤......

您可以添加摄像机并将摆好姿势的角色的镜头渲染到关卡音序器。

如果您想更进一步，您可以添加影片渲染队列插件，为您的镜头添加额外的滤镜。

还可以添加动画等。

到镜头。

要仅渲染一帧，请添加自定义框架并选择 0 和 1 帧。

这在电影队列中效果更好。

如果您使用常规渲染设置，我建议使用 3 帧并选择最后一帧作为可保留的图像。

要查找这些文件，请检查内容中的“已保存”文件夹。

可能位于电影渲染文件夹下。

我认为你必须为基本渲染设置创建自己的文件夹。

- 角色 - 控制 - 插件 - 虚拟制作 - 过场动画

![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-01.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-02.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-03.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-04.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-05.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-06.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-07.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-08.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-09.jpg)


![教程图片](assets/unreal-engine-fortnite-adding-outfits-to-ida-faber-s-characters/image-10.jpg)


## 相关链接

- 未识别到明确相关链接。


