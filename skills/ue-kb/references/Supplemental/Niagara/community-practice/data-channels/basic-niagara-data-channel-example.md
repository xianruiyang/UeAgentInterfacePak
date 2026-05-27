# Niagara 数据通道基础示例

- 来源: https://dev.epicgames.com/community/learning/tutorials/qXL5/unreal-engine-basic-niagara-data-channel-example
- 原文标题: Basic Niagara Data Channel Example

## 尼亚加拉数据通道基本示例

新的 Niagara 数据通道功能允许您按需在单个系统（或多个系统）中生成粒子。这可以减少创建和销毁多个系统的开销，并在许多场景中非常有用。

这里有一个很棒的教程，但它稍微复杂一些： https://dev.epicgames.com/community/learning/tutorials/RJbm/unreal-engine-niagara-data-channels-intro

本文旨在通过三个简单的步骤展示一个更简单、更基础的示例： 1)

2）创建一个能够从该通道读取数据的系统 3)

3）启动该系统，并在您按下按键时通过通道发送数据。 Step 1)

步骤 1）首先，创建一个新的 Niagara 数据通道：

我们还创建了一个名为 Location 的 Vector 4 变量用于发送数据。但在此实例中，我们并未在系统中使用它。（如果创建的通道不包含任何变量，可能会出现错误）。此步骤定义了将通过该通道发送哪些数据。 Step 2)

步骤 2）接下来创建一个简单的尼亚加拉喷泉：

禁用生成速率，并在 EmitterUpdate 下创建一个名为 SpawnFromNDC 的新 ScratchModule：

修改 SpawnFromNDC 节点以设置 NDC 读取器，并添加一个 SpawnConditional 节点，该节点将针对通道中的任何数据生成 10 个粒子：

请确保将 SpawnFromNDC 配置为将通道设置为我们上面创建的 BasicChannel：

步骤 3）将该系统添加到蓝图中。在本例中，我将一个 Niagara 系统组件添加到了第三人称角色中。请务必调整高度以便查看，并设置正确的资源。

最后，添加一个调试键，用于通过通道发送数据来生成粒子：

就是这样！现在当你跑动时，按下 j 键，系统就会生成大量粒子：
