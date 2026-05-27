# 开关节点、锯齿波和一些风格化材质的手绘

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/v3pR/unreal-engine-switch-node-sawtooth-wave-and-a-bit-of-hand-painting-for-stylised-materials

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 4894 字符。

## 摘要

材质编辑器中的 Switch 节点经常被低估，但它可以实现非常有趣的应用程序。 This short tutorial shows how the sw...

## 中文整理

### 概览

传统绘画动画的一个特点是，当摄像机角度或角色姿势发生变化时，需要绘制每一帧。

即使角色或道具保持静态，由于周围场景的变化，通常也需要为每一帧重新绘制。

这是一个繁琐的过程，但却为我们带来了许多我们今天所珍藏的精美手绘影片。

借助现代动画工具，许多动画师的目标是复制这些经典动画的外观。

一个常见的问题是如何实现绘制动画的效果。

在这个简短的教程中，我将演示一种创建材质的简单方法，该材质循环使用多个手绘纹理，给人一种正在为每个帧重新绘制的错觉。

此外，我将讨论材质编辑器中一个未被充分重视的节点，称为 switch。

在本教程中，我将使用 Fab 上免费提供的模型“一个贫穷女人的裙子”。

我的目标是选择布料的一个元素并创建一个将在几个帧中循环的绘制纹理。

通过查看纹理数据，最容易操作的纹理似乎是裙子纹理。

在这里，模型被展开到 UV 空间中的一个区域，使其相对容易用绘制的数据替换。

最终，创建了四个与源相似的纹理。

请注意，这些纹理相似但不相同，这正是我们效果所需的。

现在，将这些纹理导入虚幻引擎并找到模型附带的裙子的材质。

该材质仅包含与纹理相关的“基色”和“法线贴图”。

As we have four different textures that we want to iterate between, we are going to use some mathematics.

Let’s look into periodic functions, specifically a sawtooth wave (you can learn more about it here ).

The sawtooth wave function consistently goes from 0 to 1 and then back to 0 in a repeating cycle.

它的定义为：x(t) = t – Floor(t)，其中，floor 函数采用实数并返回小于或等于该数字的最大整数。

The material editor has a node for the floor function in the “Math” category.

I’ll use the Time node as the input for the sawtooth wave.

The resulting value from the sawtooth wave will range between 0 and 1.

To obtain an integer value between 0 and 3, we multiply the output of the sawtooth wave by a number slightly less than 4, such as 3.99.

您可能想知道为什么我们不使用 4。

原因是，在某些时间值，锯齿波可能输出 1，将其乘以 4 并应用下取整函数将得到 4，这超出了我们期望的范围。

到目前为止，材料如下所示： 我应该注意，我不会使用另一个楼层函数，但我将使用另一个称为 switch 的节点。

In essence, the switch node functions similarly to a switch operator in programming languages like C++ or Python.

It takes the Switch Value and number of input values.

If the Switch Value is 0, the output will be the first input; if it is 1, the output will be to the second input, and so on.

如果“开关值”超过输入数量减一或小于零，则节点将返回作为默认输入的输入提供的任何内容。

该节点自动应用下取整函数将输入值转换为整数。

对于开关节点，创建四个输入并将我们的四个纹理连接到它们。

无需将任何内容连接到默认输入，因为锯齿波乘以 3.99 将不会返回任何内容，只会返回对应于四个整数 0、1、2、3 的 [0, 3.99] 范围内的值。

开关节点的输出直接进入基色。

如果纹理变化太慢或太快，可以通过修改锯齿波的周期来调整速度。

为此，只需将输入乘以保存速度值的标量参数即可。

生成的材质如下所示： 如果我们将此材质应用于网格，我们可以看到所需的实际效果： 为了使纹理迭代与来自 Sequencer 的时间同步，我们需要将 Time 节点转换为标量参数。

这种转换允许我们从定序器访问这两个参数。

将裙子的静态网格物体添加到序列器中后，找到材料槽。

在那里，您应该能够查看并设置标量参数的值。

最后，通过键入时间并确定与时间轴一致的适当速度值，您将获得所需的结果。

总之，Switch 节点在材质编辑器中经常被低估，但它使我们能够轻松执行强大的任务。

绘制的纹理效果只是其功能的一个示例。

我想向我的学生 Chloe O 表示感谢。

为本教程提出建议并绘制纹理。

- 动画 - 材质



## 相关链接

- [available for free on Fab](https://www.fab.com/listings/6560d539-9275-4bcc-ab3b-4a9c1a91c47e)
- [here](https://en.wikipedia.org/wiki/Sawtooth_wave)

