# 远程控制API WebSocket参考

---
title: "远程控制API WebSocket参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-api-websocket-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制API WebSocket参考"]
---

# 远程控制API WebSocket参考

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制API WebSocket参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-api-websocket-reference-for-unreal-engine

本页面将介绍 **远程控制API** 提供的WebSocket消息类型。本页面结束时，会提供一个内含JavaScript函数的HTML示例文件，用以演示如何使用和测试这些WebSocket消息。

引擎中的WebSocket端口默认为30020。使用 `ws://127.0.0.1:30020` 地址连接到WebSocket服务器，开始发送消息。你可以为自己的项目更改WebSocket端口。

- 在编辑器的主菜单中，选择 **编辑（Edit）> 编辑项目设置...（Edit Project Settings…）**，打开 **项目设置（Project Settings）** 窗口。
- 在 **项目设置（Project Settings）** 窗口中，在 **插件（Plugins）** 部分中选择 **远程控制（Web Remote Control）**。
- 将字段 **远程控制WebSocket服务器端口（Remote Control WebSocket Server Port）** 的值更改为想要使用的端口。

![远程控制插件设置](../../../../../assets/images/6e/6e87768009b0b9c4f6d121c039cc689e28a5132cae167b9e8c6dd8b7a36cda4b.jpg)

## WebSocket消息

远程控制API使用JSON格式发送WebSocket消息。所有发送到服务器的WebSocket消息必须是JSON对象，且具有以下属性：

| 属性 | 说明 |
| --- | --- |
| MessageName | 识别要发送的消息类型。选项包括： HTTP Preset.Register Preset.Unregister |
| 参数 | 各个消息类型的参数。详情请参见以下各节。 |
| Id | 可选：非常有用的标识符，供来自服务器的延迟响应所用。 |

### WebSocket消息类型 - HTTP

使用此消息类型通过WebSocket消息调用HTTP路由。有关可调用的HTTP路由的详细信息，请参阅[远程控制API HTTP参考](../remote-control-api-http-reference/index.md)。

JSON格式消息示例：

```
	{		"MessageName": "http",		"Parameters": {			"Url": "/remote/object/property",			"Verb": "PUT",			"Body": {				"ObjectPath": "/Game/ThirdPerson/Maps/ThirdPersonMap.ThirdPersonMap:PersistentLevel.StaticMeshActor_1.StaticMeshComponent0",				"propertyName": "StreamingDistanceMultiplier",				"access": "READ_ACCESS"			}		}	} 
```

WebSocket服务器将返回一条JSON消息，以响应调用：

```
	{		"RequestId": -1,		"ResponseCode": 200,		"ResponseBody": {			"StreamingDistanceMultiplier": 1		}	} 
```

### WebSocket消息类型 - Preset.Register

使用此消息类型订阅 **远程控制预设** 发出的事件。JSON格式消息示例：

```
	{		"MessageName": "preset.register",		"Parameters": {			"PresetName": "MyPreset"		}	} 
```

以下各节描述由预设发出的事件及其JSON消息。

#### 远程控制预设事件 - PresetFieldsChanged

每当预设中公开属性的值被修改时，都将发送此消息。

```
	{		"Type": "PresetFieldsChanged",		"PresetName": "MyPreset",		"ChangedFields":  [			{					"PropertyLabel": "Relative Rotation (LightSource_0)",					"ObjectPath": "/Game/ThirdPerson/Maps/ThirdPersonMap.ThirdPersonMap:PersistentLevel.DirectionalLight_0.LightComponent0",					"PropertyValue":  {						"Pitch": 346.4,						"Yaw": 0,						"Roll": 169.2					}			}			]		} 
```

#### 远程控制预设事件 - PresetFieldsAdded

每当预设中有新的公开属性加入时，都将发送此消息。响应仅包括属性添加到的组。

```
	{		"Type": "PresetFieldsAdded",		"PresetName": "MyPreset",		"Description": {			"Name": "MyPreset",			"Path": "/Game/Presets/MyPreset.MyPreset",			"Groups": [				{					"Name": "Lighting",					"ExposedProperties": [						{							"DisplayName": "Light Color (LightSource_0)",							"UnderlyingProperty": {								"Name": "LightColor",								...							}						}					],					"ExposedFunctions": []				}			]		}	} 
```

#### 远程控制预设事件 - PresetFieldsRemoved

每当预设中的属性或函数被删除后，都将发送此消息。

```
	{		"Type": "PresetFieldsRemoved",		"PresetName": "MyPreset",		"RemovedFields": [			"Light Color (LightSource_0)"		]	} 
```

#### 远程控制预设事件 - PresetFieldsRenamed

每当预设中的属性或函数被重命名后，都将发送此消息。

```
	{		"Type": "PresetFieldsRenamed",		"PresetName": "MyPreset",		"RenamedFields": [			{				"OldFieldLabel": "Relative Rotation (LightSource_0)",				"NewFieldLabel": "Directional Light Rotation"			}		]	} 
```

### WebSocket消息类型 - Preset.Unregister

使用此消息类型取消订阅 **远程控制预设** 发出的事件。JSON格式消息示例：

```
	{		"MessageName": "preset.unregister",		"Parameters": {			"PresetName": "MyPreset"		}	} 
```

## HTML/JavaScript示例文件

1. 在名为 **index.html** 的文件中保存以下代码：

   ```
   	<!DOCTYPE html>	<html>	<head></head>	<body>		<h3 id="status">Connection Closed</h3>		<input id="in"></input>		<button id="btn" onclick="sendMessage()">Register Preset</button>		<div id="holder"></div>			</body>	</html>
   ```
2. 在Web浏览器中打开index.html文件。如果能够成功连接WebSocket服务器，页面将显示 **连接打开（Connection Open）**。

   ![测试HTML/JavaScript页面的屏幕截图](../../../../../assets/images/45/4560878a559c07a72c590de95a2f3b777fe5cbcded15089e7d23da1cd0ba3561.png)
3. 在输入字段中输入 **远程控制预设** 的名称，并更改预设的字段。
4. 打开浏览器的控制台日志，确认记录了响应消息。

