# Niagara 重力模拟

- 来源: https://dev.epicgames.com/community/learning/tutorials/ZeRw/unreal-engine-gravity-simulation-in-niagara
- 原文标题: Gravity Simulation in niagara

该文档在于记录对重力模拟的在niagara中初步尝试

## [UE] Gravity Simulation

## 介绍

大概在两三个月前看到了这篇文章 Ocean Simulation | Community tutorial 惊讶于Niagara的灵活与可拓展性遂开始研究Niagara，这篇文章就是我研究一段时间的产物 在本文中，我将展示在 Niagara 中以单个星系运动为目标创建的重力模拟系统的示例，这更像一个总结与记录，最后我也会抛出一些期间遇到的问题。 需要什么： 虚幻引擎 5.1 对 Niagara 的基本了解 大约1小时的空闲时间 1、概述

## 模拟的理论基础

## Brendan Galea

这次模拟我们需要用到万有引力定律，该定律认为“两个物体之间存在吸引力，该吸引力与物体的质量成正比，与两个物体之间的距离的平方成反比”。人们认为力本身会瞬时传播，即以无线的速度传播，用公式表示万有引力的大小’F’是物体的质量M,m，物体之间的距离r,G为万有引力常数，在应用中我们可以自定义一个系数表示G。

值得一提的是纯套用万有引力定律将不利于星系外围物质成型，会被加速度甩出去。在天文学中引用了暗物质来修正，也有一些文章指出在极小加速度的情况不是平方反比，但这里不做讨论，我们将引用一个极小的Drag来辅助完成咱们的模拟。 参考 本次模拟中划分体素来获取近似值的来源 **Brendan Galea ,**这是视频链接： Realtime 2D Gravity Simulation 还有在学习Niagara时在知乎看到的一个分析Niagara advanced 案例解析，作者是：沙滩Beachc， 文章链接： UE5.1 Niagara Advance 案例理解分析 3.1 PS 我目前只看到了 3.4 Color Propagation 章节就迫不及待地上手尝试模拟了 对于Neighbor的一些基本概念不了解的话建议先看一下。 这两位的文章与视频在我实现模拟提供了很大的帮助，后面部分也会有部分的素材来自他们，在此表示感谢。 实现的基本方法 基本方法 有了以上的公式我们就可以去创建我们的粒子系统了。首先我们需要规定一定的空间，然后在这个空间内撒下一些粒子，设置粒子的质量M,这里我们方面计算质量设置为1，所以这里的公式就简化为 1/r²。然后检索这个空间内除本体以外所有的粒子，一一遍历计算每个粒子对另一个粒子施加的力相等但方向相反

## Brendan Galea

但是这具有N平方的复杂度，这意味这要计算的粒子相互作用的数量与总数量成平方正比，因此这对于有数量不多的粒子实时模拟例如几个，几百甚至一千的是个比较好的选择。但如果我们想要更多例如十万级百万级的实时模拟，这个方法便失去了价值，我们需要一定的优化 优化 我们把粒子的质量累计到网格上，然后比较网格单元的相互作用，驱动粒子

## Brendan Galea

## Brendan Galea

但如果网格的分辨率为1000，这意味计算次数也需要1000000，这个计算次数对于实时模拟还是太多了，所以我们只采样当前网格的邻居，但这样我们当前的粒子获取不到邻居之外的力，所以我们用不同分级的网格来修正，获得最终的力

## Brendan Galea

这就是优化的思路，不过相比第一个方式我们付出了精度为代价，而还有一个精度衍生的问题就是粒子容易向着网格中心塌陷并且容易在移动过程中碰见一堵看不见的墙使得粒子一直过不去。

## Brendan Galea

在看到了 UNREAL 官方大师案例3.4后知道了Niagara可以借助网格查询附近网格的粒子，并可以读取粒子的属性使得上述的一切成为可能。 我们在后面的设置中将LOD的级别改成了3级，分别是1000*1000，111*111，5*5 PS：在实操中发现Neighbor Grid3D发现他们的最大分辨率是1000. 在介绍前我们需要先分清楚两个概念Cell和Neighbor，Neighbor Grid 3D中每一个格子称为Cell，在每一个Cell中被“放置”的元素或者粒子称为Neighbor，注意这里不是粒子位于Cell的空间范围内就能被称为“放置”了，而是必须通过Grid的操作使粒子的Index和Neighbor的Index产生关联才可以实现。ps : 沙滩Beachc

## 沙滩Beachc

## 可视化

## 沙滩Beachc

## 可视

## 沙滩Beachc

## 2、用户参数设置

上文提到的代替暗物质来帮助星系成型的系数 GridHeight-Width : Grid的高和宽 MassRatio : 计算中质量对于距离的系数 Max Neighbor : Grid 中可读到属性的粒子的最大数量 Num Cell B-H : 网格分辨率 Size : 粒子的大小（只冲击效果显示） SpawnCount : 粒子数量 Speed : 公式中代表 g 的系数 3、系统和发射器创建

这里可以使用 官方高级案例 3.4 Color Propagation 为模板，在此基础上修改 右键单击内容浏览器并创建一个空的 Niagara 系统。

在 Niagara 编辑器中打开新创建的系统。

添加一个空发射器。

根据你的喜好重命名发射器

在System Attributes下添加3个’Neighbor Grid3D’

将System Attributes下添加的3个’Neighbor Grid3D’ 拖进System Update 下

在System Update 下添加三个‘Neighbor Grid 3D

根据你想要的递减分辨率设置后面的Grid,需要注意 Max Neighbor PerCell 是一个递增的数，我的设置为 10 20 50，这个数字将会冲击效果计算精度，但会性能会受比较大的冲击效果。

在System Update 下继续添加’Grid 3D

将发射器的相关设置修改为图中所示

这里的Emitter Name 是你发射器的名字，它将读取你设置的发射器的属性

## 4、粒子生成

不必理会这里的Life,因为我们有三个Grid 所以需要三个Mass和cPos属性来储存，cPos为当前网格所有粒子的质量中心，是个矢量。cPos默认为0，Mass 默认为 1。

属性是为模拟行星穿越星系中心高密度区域所潜在的因为碰撞而产生加速度的损失，简单来讲就是粒子的高密度区域Drag值会更大。默认为0.

添加Vortex Vel ,给予初始速度，有助于星系旋转的生成。

## 5、粒子更新

## 取消勾选

Vis 主要是显示粒子密度，限制粒子z轴，设置DragRatio值和设置后面的Offset值

显示粒子密度是取Mass值除以总数量的0.01倍映射一个颜色

设置DragRatio值，是利用Mass,Mass_0来确定值

## 限制粒子z轴

## 是一个{-1/1，-1/1，0}的矢量,用来进一步消除边界感

## 6、Neighbor

这个阶段主要分3步 装载3个Grid的Neighbor 这里与官方案例类似只不过需要装载3个Grid,代码如下。

```cpp
OutPosition = Position;
#if GPU_SIMULATION
float3 cPos;
float3 UnitPos;
NeighborGrid.SimulationToUnit(Position, SimulationToUnit, UnitPos);
int3 Index;
```

利用Neighbor输出对应的Mass,平均位置 这里需要读取粒子属性和设置一个Offset强度的系数，Offset是对平均位置的模糊方便粒子跨越网格的边界 这里的属性都需要输出，要不然会不起作用或者计算出错误的数值，即使他看起来很正常。

1.这个函数返回这个网格内的粒子数量，即这个网格的质量。 2.循环网格内的Neighbor,读取LOD0的Mass,求这个网格内的平均质量 3.利用得到的平均Mass,用LOD0的Mass除以平均Mass,可以得到当前网格的质量权重，再利用质量权重得到相对正确的质量平均位置，最后与Offset相乘。 关于这里的Offset应用目的后面会做视频单独指出来

```cpp
AddedToGrid = false;
Outmass = float (0);
OutPosition = Position;
OutcPos = float3(0,0,0);
OutaPosMass = float (0);
#if GPU_SIMULATION
float3 cPos;
float aPosMass;
```

## 利用接收到的属性做最后的计算

这里需要计算三个Grid的Vel相加并乘以Drag输出

这里以LOD1举例，这里需要设置一个数组，用以循环网格的邻居，注意{0，0，0}需要在最前面。

## 循环九次并加上数组的偏移值

1，读取循环到的网格neighbor粒子Position,平均位置，LOD0的Mass和该Grid的Mass 2，LOD0的Mass和该Grid的Mass除以网格平均Mass,得到Mass权重 3，读取循环到的网格neighbor粒子Position,平均位置。判断哪个离的近，如果粒子Position离的近的话则根据长度与中间位置得到位置权重，得到最终位置，位置在粒子Position和平均位置之间（关于这里的目的后面会做视频单独指出来）

1，质量权重 2，给质量与距离做保险，防止出现极值，并套用公式

```cpp
#if GPU_SIMULATION
float3 ttDir = float3(0, 0, 0);
const int3 IndexOffsets[9] =
{
```

## int3(0, 0, 0),

## int3(1,-1, 0),

## int3(1, 0, 0),

## 7、参数探讨

1，如果将公式内 r² 改成 r 将更有助于聚拢，远处的粒子将更受质量冲击效果，不过不利于远处粒子的小团聚拢 2，将Drag值加大也有助于聚拢不过旋转动量将很快消失 3，Max neighbor 值加大会提升精度不过代价是性能 4，最后的那些权重是当前的一些经验公式和数值 8、优化方法

提升硬件，如果有4090的显存和算力大概能完成100w粒子与4级别的LOD 结束语和进一步改进

糟糕的运动模糊及自适应曝光，即使调整了渲染方式和曝光方式依然问题很大 经过测试Niagara neighbor 支持最多1000分辨率和200w粒子的模拟 目前的方式不支持多个星系的计算，尽管理论上可以，我也测试出来过，不过非常不稳定不容易见到。 Niagara 运行非常不稳定容易崩，数据运行不稳定，即使相同的代码，粒子有时候莫名往+X轴方向运动或者向Grid的-x-y-z轴运动，有时会连续出现且频率不低。 网格偏移的数组{0，0，0}要放在最前面，不然有时运动不一样 有时会出现同时丢失目标的问题，在有单个或多个聚拢点时会同时突然的不聚拢，过一两秒再聚拢
