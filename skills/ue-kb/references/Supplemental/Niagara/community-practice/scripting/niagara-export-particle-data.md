# 尼亚加拉 - 导出粒子数据

- 来源: https://dev.epicgames.com/community/learning/knowledge-base/l7E0/unreal-engine-niagara-export-particle-data
- 原文标题: Niagara - Export Particle Data

## Sep 17, 2020.Knowledge

## 知识库

![Niagara - Export Particle Data](../assets/images/niagara-scalability-effect-types-01.jpg)

## Sep 17, 2020.Knowledge 2020年9月17日。知识

原作者： Ryan B.

在 4.25 版本中，我们引入了一项实验性功能，用于导出粒子数据并为 Niagara 中的 CPU 粒子生成蓝图事件。新的 UNiagaraDataInterfaceExport 数据接口可以将位置、大小和速度导出到实现了 INiagaraParticleCallbackHandler 接口的蓝图。此功能通过“存储粒子数据”节点实现，该节点可以添加到自定义的 Niagara 模块脚本中。

例如，以下是系统概览，重点展示了相关模块。该系统基于 Fountain 模板创建。

有两个用户参数：Callback 和 ExportData。Callback 是一个对象，将被赋值给实现了回调处理程序接口的对象。ExportData 是导出数据接口，用作自定义导出数据模块的链接输入。请注意，ExportData 将其回调处理程序设置为 User.Callback。 Here’s

## 以下是自定义导出数据模块的图表：

这是一个最基本的配置，仅导出位置信息。您可以导出任意浮点数和任意两个 Vector 3 参数，如图所示。“存储数据”输入将决定在本次执行中是否将数据导出到蓝图，这可用于触发事件。例如，如果您只想在粒子碰撞时导出数据，则可以使用`Particles.HasCollided`作为“存储数据”的输入。

存储输出的 Success 布尔值对于编译是必要的。在本例中，它没有被使用，但如果数据未导出，您可能需要采取不同的响应方式。在“导出数据”模块之后的“发射器粒子更新”中，它的输出会被分配给一个新的粒子参数，因此如果需要，可以在其他地方使用它。 Store

“存储粒子数据”操作会触发回调处理程序对象上的“接收粒子数据”事件，因此该对象需要实现粒子回调处理程序接口。以下是回调处理程序的相应事件图，该处理程序仅打印粒子的位置：

在这个例子中，演员还拥有 Niagara 组件，并将此系统作为其资产。在其构造脚本中，它设置了用户变量，以便将相应的对象分配给回调处理程序，在本例中，该对象是对自身的引用：
