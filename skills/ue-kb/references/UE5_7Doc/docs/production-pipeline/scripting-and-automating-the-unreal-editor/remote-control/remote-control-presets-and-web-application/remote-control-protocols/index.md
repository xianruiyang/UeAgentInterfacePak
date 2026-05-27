---
title: "远程控制协议"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-protocols-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制预设和Web应用程序", "远程控制协议"]
---

# 远程控制协议

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制预设和Web应用程序 / 远程控制协议

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-protocols-in-unreal-engine

借助远程控制协议，你可以将协议输入数据绑定给被暴露的属性，从而通过外部设备控制属性。本文将介绍如何使用DMX、MIDI和OSC插件的专用远程控制插件，以及如何创建你自己的协议插件。

## 先决条件

1. 启用 **远程控制API（Remote Control API）** 插件。
2. 根据你使用的协议，启用对应的远程控制插件：

   1. 对于DMX，启用 **远程控制协议DMX（Remote Control Protocol DMX）** 插件。
   2. 对于MIDI，启用 **远程控制协议MIDI（Remote Control Protocol MIDI）** 插件。
   3. 对于OSC，启用 **远程控制协议OSC（Remote Control Protocol OSC）** 插件。
3. 重启编辑器。

在启用这些插件之后，创建 **远程控制预设资产（Remote Control Preset Asset）** 并将属性公开到预设。如需更多信息，请参考[远程控制预设入门](../getting-started-with-remo-1077b97f/index.md)。

## 远程控制中的映射协议

按照这些步骤操作，即可从外部设备控制属性。

1. 在远程控制面板中，选择要映射到协议的属性。

   ![Select a property to map to a protocol](../../../../../../assets/images/0f/0fc0152ebe9992788622908999ffad59e69299cc994567765fb00007745db89f.png)
2. 在下拉列表中选择协议，然后按旁边的加号按钮添加新映射。

   ![Select a protocol mapping](../../../../../../assets/images/2e/2ef36ca949695e77a1dcfe10662eca09c1c87e0bf3e60ee6f47993bc329ff8c5.png)
3. 修改映射分段中的设置，以连接到外部设备。如需各个字段的更多信息，请参考[远程控制面板参考](../remote-control-panel-reference/index.md)。

   > [!TIP]
   > 你可以使用映射面板右上角的自动绑定按钮迅速自动绑定输入。如需更多信息，请参考[远程控制面板参考](../remote-control-panel-reference/index.md)。
4. 在 **范围（Ranges）** 分段中，选择右侧的加号按钮添加更多的范围步长。从外部设备进行控制时，在范围点中输入不同的数值，从而使属性在范围点之间内插。

   > [!TIP]
   > 按下范围数值旁边的向左箭头，以获取其在世界中的当前数值。
5. 使用你的外部设备并在对象的 **细节（Details）** 面板或视口中查看更改，从而验证你的映射和输入已正确设置。

## 添加新协议

要将你自己的协议支持添加到远程控制，需要实现 `IRemoteControlProtocol` 和 `FRemoteControlProtocolEntity`。

按照这些步骤，为远程控制协议添加你自己的实现。

1. 创建新的空白插件。如需说明，请参见[创建新插件](../../../../plugins/index.md#creatingnewplugins)。

   建议使用命名规范 **RemoteControlProtocol{Name}**，其中 **{Name}** 是协议名称。例如，MIDI实现将命名为 `RemoteControlProtocolMIDI`。
2. 在创建的*.uplugin文件中，将依赖项添加到远程控制插件。

   ```
            "Plugins": [             {                 "Name": "RemoteControl",                 "Enabled": true             }         ]		
   ```
3. 在项目的Visual Studio解决方案浏览器中，找到 `.Build.cs` 文件中定义的模块。将 `RemoteControl` 和 `RemoteControlProtocol` 附加到 `PrivateDependencyModuleNames` 范围。
4. 新建一个类来实现 `IRemoteControlProtocol`，或从 `FRemoteControlProtocol` 这个基类实现继承，并重载以下内容：

   1. **GetProtocolScriptStruct()**：提供 **协议实体（Protocol Entity）** 实现的类。对于使用MIDI的示例，则为 `FRemoteControlProtocolMIDIEntity::StaticStruct()`。
   2. **Bind(Entity)**：这通常用于在本地集合注册实体，以便在接收到输入时进行迭代。提供的实体将特定于下面描述的实现。
   3. **Unbind(Entity):** 它的作用与绑定相似，通常用于从集合中删除提供的实体。
   4. **UnbindAll():** 从集合中删除所有实体。
5. 从FRemoteControlProtocolEntity结构体继承，从而创建一个新的结构体，用于表示给定实体（公开的属性）的协议绑定，并重载：

   1. **GetRangePropertyName():** 例如，如果来自设备的输入是浮点数，则是 `FFloatProperty`。
   2. 瞬时、不可见且不可编辑的UPROPERTY()，名为RangeInputTemplate：你可以指定额外的约束，例如最小值和最大值。这用于创建合适的编辑器控件。你可以选择将属性存储在其他位置，并通过重载 `IRemoteControlProtocol::GetRangeTemplateType()` 来指定属性。
6. 使用以下内容来注册你的 `IRemoteControlProtocol` 实现：

   ```
            IRemoteControlProtocolModule::Get().AddProtocol({Name}, MakeShared<{Implementation}>());
   ```

如需更多示例，包括如何创建和注册项目设置，请参阅UE源代码中，关于DMX、MIDI和OSC远程控制协议插件的实现细节。
