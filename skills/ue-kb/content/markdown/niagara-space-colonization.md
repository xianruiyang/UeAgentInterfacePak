# Niagara 中的 Space Colonization 算法

# Niagara 中的 Space Colonization 算法

- 来源: https://dev.epicgames.com/community/learning/tutorials/vwRZ/unreal-engine-spacecolonization-algorithm-in-niagara
- 原文标题: SpaceColonization algorithm in Niagara

## 算法 in Niagara

## 该教程将讲述如何在Niagara里实现 Space Colonization 算法

## 介绍

继上次尝试使用Niagara实现重力模拟之后 得益于Niagara的灵活与可拓展性遂开始研究Niagara，这篇文章就是我研究一段时间的产物

## [UE] [Niagara] SpaceColonization

需要什么： 虚幻引擎 5.1 对 Niagara 的基本了解 大约1小时的空闲时间 1、概述

## 模拟的理论基础

绿色的为’吸引子’，黑色为’节点’ (a) 放置一组吸引子 (b) 寻找哪些吸引子正在冲击效果哪些节点 (c) 对于每个节点，计算冲击效果它的所有吸引子的平均方向。 (d) 通过将该平均方向归一化为单位向量来计算新节点的位置，然后按预定义的线段长度对其进行缩放。 (e) 将节点放置在计算的位置。 (f) 检查是否有任何节点位于任何吸引子的死亡半径内。 (g)移除符合您想要的增长类型标准的吸引子 (h)从步骤(b)重新开始该过程 这个算法可以用于模拟分支网络的生长，例如叶子、树木、循环系统等中的分支网络！ 尽管名字听起来很科幻，但太空殖民算法实际上描述了一种基于有机材料的放置迭代生长分支线网络的方法。 早先我在Houdini 上实现过该算法且尝试把这个算法应用于城市布局与规划上 如果感兴趣可以看看这篇论文: 参考 如果想更了解这个算法可以看看这篇 文章： Modeling organic branching structures with the space colonization algorithm and JavaScript 还有在学习Niagara时在知乎看到的一个分析Niagara advanced 案例解析，作者是：沙滩Beachc， 文章链接： UE5.1 Niagara Advance 案例理解分析 3.1 PS 我目前只看到了 3.4 Color Propagation 章节就迫不及待地上手尝试模拟了 对于Neighbor的一些基本概念不了解的话建议先看一下。 这两位的文章与视频在我实现模拟提供了很大的帮助，后面部分也会有部分的素材来自他们，在此表示感谢。 实现的基本方法 Niagara Neighbor 在看到了 UNREAL 官方大师案例3.4后知道了Niagara可以借助网格查询附近网格的粒子，并可以读取粒子的属性使得上述的一切成为可能。 我们在后面的设置中将LOD的级别改成了3级，分别是10001000，111111，5* 5.PS：在实操中发现Neighbor Grid3D发现他们的最大分辨率是1000. 在介绍前我们需要先分清楚两个概念Cell和Neighbor，Neighbor Grid 3D中每一个格子称为Cell，在每一个Cell中被“放置”的元素或者粒子称为Neighbor，注意这里不是粒子位于Cell的空间范围内就能被称为“放置”了，而是必须通过Grid的操作使粒子的Index和Neighbor的Index产生关联才可以实现。ps : 沙滩Beachc

## 沙滩Beachc

## 可视化

## 沙滩Beachc

## 可视

## 沙滩Beachc

基本方法 在上面我们得知通过 neighbor 粒子可以感知他周围其他的粒子，但这还不够，我们还需要一个东西来寄存由步骤(d) 得来的相对于当前粒子的位置。这里我们就需要用到 Render target, 它表象上是一张贴图我们可以用类似UV信息来写入和读取该位置的数据。

我们为了方便理解和设置需要创建两个发射器，一个是’节点’(NODE)，为主要的计算与显示部分。另一个是’吸引子’(pLANE)，两个通过’Attribute reader’相互读取各自的数据

## 2、用户参数设置

即上文提到的 Render target count： 单帧发射的最大数量同时也是 Render target 的U值 Cell radius : 粒子寻找的最大格数 Find rad : 寻找半径 Rad : 节点生成的距离 Kill rad： 吸引子相对于节点的死亡半径 SpriteScale : 节点粒子的显示半径 Line width : 线的宽度 Max Neighbor : Grid 中可读到属性的粒子的最大数量 Num Cell B-H : 网格分辨率 GridHeight-Width : Grid的高和宽 3、系统和发射器创建

这里可以使用 官方高级案例 3.4 Color Propagation 为模板，在此基础上修改 - 右键单击内容浏览器并创建一个空的 Niagara 系统。 - 在 Niagara 编辑器中打开新创建的系统。 - 添加一个空发射器。 - 根据你的喜好重命名发射器 - 在System Attributes下添加2个’Neighbor Grid3D’

![Niagara 中的 Space Colonization 算法 图示](../assets/images/spacecolonization-algorithm-in-niagara-01.jpg)

- 将System Attributes下添加的2个’Neighbor Grid3D’ 拖进System Update 下 - 在System Update 下添加2个‘Neighbor Grid 3D

- 在System Update 下继续添加’Grid 3D

- 将发射器的相关设置修改为图中所示

- 这里的Emitter Name 是吸引子发射器的名字，它将读取你设置的发射器的数据

我们需要在这里设置 Render target. X值对应当前的粒子，因为我们之前设置的最大发射数量与当前值相关联所以每个粒子都可以被记录。 Y值为2，是固定值。Y为0目的是记录经过计算的下一个Node的位置，Y为1目的是记录当前particle的位置。 Oerrider render target format 选择为RTF RGBA16f Render target 把用户参数设置的Rt 拖入即可 count 是起始发射数量，默认为1.

pLANE 发射器设置 在正式介绍Node 之前我们先看一下pLANE, 我们需要发射一定数量的粒子然后要保持发射位置和形状在设置的Neigbhor grid 内。 剩下的主要设置有三项。

首先我们要给 AttributeReader 的 emitter name 中填入’NODE’ 1是Niagara 默认的装载 Neighbor 的操作，不多赘述。 2是 执行***(f) (g)***的步骤，截图和代码如下

如图，实际上有用的信息只有Trigger, 被激活了之后将粒子的Lifetime 设置为0.

```cpp
Velocity = VelocityIn;
Color = Color001;
#if GPU_SIMULATION
bool Valid;
float ttg = TG;
float AccumDist = 0;//10000.0;
float AccumW = 0.0;
```

## 4、发射器更新

## 5、粒子生成

![Niagara 中的 Space Colonization 算法 图示](../assets/images/spacecolonization-algorithm-in-niagara-02.jpg)

在这里我们将进行前期的属性设置及对 Render target 采样 Ppos, ite, Trigger 这三个参数均为 0

这是set uv1 内部的结构，这里的1和2都是为了让采样位置设置到像素中心，不过1是U轴，2是Y轴。 Lid 为当前帧时粒子id 取值范围时0-255 Uid 记录了当前发射帧数 UU 是debug 参数 无实际用处

剩下的我们只需要通过上面求到的 tuv1和 tuv2 采集两次render target里的数据 6、粒子更新

1 Line set 这里主要是设置线条和粒子的位置，大小和宽度

A 这里主要是判断什么时候用从RT得到的位置信息，判断依据是系统的第一帧和确定是当前帧spawn的粒子 B 这里主要是判断拿到的是否是有效的信息，如果不是就设置粒子的 Lifetime 为0.

在上述第四步时有一个覆盖全部RT数据的操作设置的值为{100，100，100}，因为如果不设置，当粒子搜索不到吸引子时会返回为0的数值，但数值为0在这里是有效的数据，所以设置了一个在Neigbhor 范围外的数值。 C 这里是主要输出的属性 D 这里主要是粒子外观显示参数 2 node 是Niagara 默认的装载 Neighbor 的操作，不多赘述。 3 find other pos 寻找我们在 pLANE 发射器里的粒子及计算下一个粒子的位置

代码的前半部分都是Neigbhor 的固定的代码不必理会

AV, AW 是用来Debug 的 不必理会。 4 Rasterize Particles 输出得到的数据 recorve data 这里是给RT设置一个在 Neigbhor 外的位置的值，因为RT默认的值为0，而这对于粒子来讲是个有效且在 Neigbhor 内的值，所以要重新设置一下。 X 对应 Lid 属性

## Rasterize Particles 01

这里就是把得到的位置根据 Trigger 和对应的UV位置输入进RT

## 这里还需要把 ite+1 7、参数探讨

1，使用256的总count数可能会有些少，可以适当调整，当然也要同步调整绑定的其他数值 2，Cell radius，各种rad，还有neigbhor，吸引子的数量 的设置 要配合好，不然可能会出现找不到或者找到但太多的问题 8、优化方法

可以从发射数量与重置RT数据想想办法，比如 data interface 数据遍历，这样 发射数量较少时也可以正确的重置 RT数据 其他如果思路不变的话应该不会有什么大的优化方法 结束语

这个是在年初完成的，大概三四个月前，当时只是想把我在Houdni 上实现过的一些算法搬到Niagara 上，不知道有没有实际的价值，我现在虽在游戏特效的岗位却不是用UE也不是unity， 自研引擎的粒子系统上限又极低，不具备Niagara 的灵活和可拓展性。 至于文档当时是准备过两天就写的，但是后来我的懒癌晚期发作加上沉迷游戏遂猝，后来沉迷游戏三四个月罪恶感爆棚才写的这些，后面又可以心安理得的开摆了。 文章加上我的表达方式可能并不能很好描述细节，后面可能会录个视频。

