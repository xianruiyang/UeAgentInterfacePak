# Niagara 碰撞

- 来源: https://dev.epicgames.com/community/learning/knowledge-base/oDPB/unreal-engine-niagara-collisons
- 原文标题: Niagara Collisons

## 尼亚加拉碰撞

## Niagara Collision

## 知识库

![Niagara Collisons](../assets/images/niagara-scalability-effect-types-01.jpg)

## 尼亚加拉碰撞

## 本文作者： Austin C. Overview 概述 Niagara provides a fairly robust collision suite,

提供了一套相当强大的碰撞检测功能，允许粒子与关卡中的几何体进行交互。根据模拟类型的不同，Niagara 可以使用不同的功能。为了简化操作，我们通过一个碰撞模块提供对所有这些功能的访问。

有些通用设置对于每种碰撞类型都是相同的，而其他类型特定的设置将在选择类型后显示，以减少用户界面混乱。 Collision Types 碰撞类型 Depending on the simulation type of your emitter (GPU or CPU) you’ll

根据发射器的模拟类型（GPU 或 CPU），您可以使用不同的碰撞类型。一般来说，CPU 碰撞检测的精度更高。

分析平面：CPU 和 GPU Simple collision based on one or two user-defined planes (based on a normal vector and a point). Particles will collide with these planes,

基于一个或两个用户自定义平面（基于法向量和一个点）的简单碰撞检测。粒子将与这些平面发生碰撞，这些平面与场景几何体无关。

最快但最粗略的方法。

## 光线追踪：CPU Ray traced collisions that use UE’s

使用 UE 更广泛的碰撞系统的光线追踪碰撞检测。允许追踪通道选择性地与场景中的特定对象发生碰撞。因此，性能受限于 CPU。

大量快速运动的粒子可能会冲击效果性能。

深度缓冲区：GPU Uses the depth buffer for collisions,

使用深度缓冲区进行碰撞检测，性能非常出色。

不会与被遮挡或屏幕外的物体发生碰撞。

精度较低且移动速度快的粒子有时会像穿过墙壁或边缘一样穿过障碍物。

不透明粒子可能会导致自碰撞，这可以通过查询自定义深度缓冲区选项来解决。

这会给不透明粒子带来延迟，因为它需要等待不透明对象渲染到深度缓冲区。延迟是系统级别的（与帧组绑定），因此同级发射器也会受到冲击效果。对于半透明粒子，您可以在渲染器上启用 GPU 低延迟半透明功能，以使用当前帧的数据。

内置遮挡剔除功能，可通过“杀死被遮挡粒子”开关控制（默认开启）。注意：如果粒子生成在屏幕外或位于几何体后方，则可能导致粒子在不希望的情况下被杀死。

距离场：GPU

查询全局距离场以检测碰撞。必须启用“生成网格距离场”项目设置（项目设置 > 引擎 - 渲染 > 照明 > 生成网格距离场）。

精度取决于关卡的距离视野距离（世界设置 > 渲染 > 全局距离视野距离）。数值越低，精度越高。

距离场分辨率在相机附近最高，随着系统距离相机越远而下降。因此，远处的系统可能无法正确碰撞检测。

碰撞可能发生在屏幕外。

我们希望在未来的版本中将其与距离场环境光遮蔽分离。

如果粒子位于网格内部，这种碰撞检测方法会杀死该粒子。

## 通用设置

适用于所有碰撞类型的设置。工具提示将提供每个设置的更多信息。 Collision Radius 碰撞半径

定义碰撞检测中粒子的大小。

可以根据精灵大小或网格缩放进行计算，也可以手动指定。

## 弹跳 Controls energy retained after collision,

控制碰撞后保留的能量，以及用于控制反弹方向的碰撞法线。

## 摩擦

控制与表面碰撞时的摩擦力。

## 年龄碰撞粒子

允许粒子在碰撞时更快地老化。有助于限制碰撞次数。

## 休息

控制各种相互作用，防止粒子无限碰撞。适用于粒子可能与一个或多个表面相交的情况。

## 碰撞事件 CPU emitters have event support built-in,

CPU 发射器内置了事件支持，您可以使用“生成碰撞”事件模块生成碰撞事件，供同一发射器中的事件处理程序或同一系统中的另一个 CPU 发射器使用。

您可以在我们的内容示例项目中的尼亚加拉地图示例 2.6 中看到碰撞事件的示例。

碰撞模块会在其参数写入（Output.Collision.CollisionValid）中输出该帧中是否发生了有效碰撞，因此您可以使用此信息来控制 CPU 和 GPU 发射器的行为。对于 GPU 发射器，您可以使用属性读取器访问来自另一个发射器的参数，该读取器可以通过读取该值来模拟事件处理程序。

我们也支持将粒子数据导出到蓝图，这可以用作从 Niagara 碰撞触发蓝图事件的一种方法。有关更多信息，请参阅 “导出粒子数据”知识库文章。

我们在 Niagara_Advanced 地图示例中也提供了一个内容示例。 See more on the Knowledge Base!

## 更多信息请访问 知识库！
