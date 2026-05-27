---
title: "远程控制API HTTP参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/remote-control-api-http-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "远程控制", "远程控制API HTTP参考"]
---

# 远程控制API HTTP参考

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 远程控制 / 远程控制API HTTP参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/remote-control-api-http-reference-for-unreal-engine

本文介绍远程控制API提供的HTTP端点，并详细说明调用每个端点时需要包含的消息正文的格式。

## GET remote/info

使用这个端点可以查看远程控制API中所有可用的HTTP路由。调用会返回一个JSON负载，其中包含所有可用的HTTP路由及其说明。

### 示例

发送请求时，请求体为空。请求成功后会返回状态200，响应体如下：

```
	{		"HttpRoutes": [			{				"Path": "/remote/info",				"Verb": "Get",				"Description": "Get information about different routes available on this API."			},			{				"Path": "/remote",				"Verb": "Options",				"Description": "Allows cross-origin http requests to the API."			},			{				"Path": "/remote/batch",				"Verb": "Put",				"Description": "Allows batching multiple calls into one request."			}			...		]	} 
```

## PUT remote/object/call

用此端点可调用编辑器当前内存中由指定 `UObject` 公开的函数：通常是当前关卡的Actor或项目中的资源。

> [!TIP]
> 可以调用蓝图中所有可调用的函数。包括在C++中用 `BlueprintCallable` 说明符定义的函数，或完全在蓝图中定义和实现的函数。

调用此端点时，必须传递拥有以下属性的JSON负载：

| 属性 | 说明 |
| --- | --- |
| `object路径（objectPath）` | 该路径对所要交互的 `UObject` 进行独特标记。欲了解查找此路径的更多信息，请参见下面的[关于UObject路径](#%E5%85%B3%E4%BA%8Euobject%E8%B7%AF%E5%BE%84) |
| `函数名称（functionName）` | 要从指定 `UObject` 调用的函数的命名。如函数在C++中定义，其原始命名可能与蓝图中显示的命名不符。在此情况下，请使用C++中定义的函数命名。 |
| `参数（parameters）` | 对需传递给函数的参数进行定义的object。 此object中每个属性的命名应与调用的函数所接受参数的命名相同。 `` 如函数在C++中定义，原始参数命名可能与在蓝图编辑器中看到的值不匹配。在此情况下，请使用C++中定义的参数命名。例如，下面代码中，第二个参数需指定为 `bSweep`，从而与其C++定义相匹配，但其在同等蓝图节点中公开为 **Sweep**。 `` 该属性的值可是任何简单值，例如数字或布尔值。或者，如函数要求传递object，可提供可以封装该object属性的JSON object。远程控制系统将使用提供的值，尝试创建必要类型的新object。例如，下面代码中，`新位置（NewLocation）` 被自动用于创建新矢量。 对于该函数接受的每个参数，不必在此object中包含属性。对于省略的参数，网络远程控制系统将构造适当类型的默认object。 |
|  | 如函数在C++中定义，原始参数命名可能与在蓝图编辑器中看到的值不匹配。在此情况下，请使用C++中定义的参数命名。例如，下面代码中，第二个参数需指定为 `bSweep`，从而与其C++定义相匹配，但其在同等蓝图节点中公开为 **Sweep**。 |
|  |  |
| `生成事务（generateTransaction）` | 定义编辑器是否应在项目的事务历史中记录此函数调用。将此属性设为 `true` 具备以下效果： 函数所做的任何更改均可撤销。对于该函数的调用，编辑器会对项目 **撤销历史** 面板中的条目进行记录。在虚幻编辑器中工作的用户可回滚更改的效果。无论调用何种函数，该条目的命名始终为 **远程调用事务封装（Remote Call Transaction Wrap）**。 撤销历史中列出的远程事务 如处于[多用户编辑](../../../multi-user-editing/index.md)会话中，该更改将复制至其他连接的用户。 |

该调用会返回JSON负载，其中包含已调用函数的返回值、以及函数定义中指定的所有其他输出参数。

### 范例

请求正文：

```
	{		"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5",		"functionName" : "SetActorLocation",		"parameters" : {			"NewLocation" : {"X" : 100, "Y" : 0, "Z" : 30},   // 这些值用于创建新矢量			"bSweep" : true		},		"generateTransaction" : true	} 
```

成功的请求在以下响应正文中给出 `200` 个状态：

```
	{		"SweepHitResult":{			"bBlockingHit":true,			"bStartPenetrating":false,			"FaceIndex":-1,			"Time":0.338644,			"Distance":170.822,			"Location":{ "X":100, "Y":0, "Z":429.178 },			"ImpactPoint":{ "X":169, "Y":30, "Z":354 },			"Normal":{ "X":-1.51964e-11, "Y":4.01851e-8, "Z":1 },			"ImpactNormal":{ "X":-1.51964e-11, "Y":4.01851e-8, "Z":1 },			"TraceStart":{ "X":100, "Y":0, "Z":600 },			"TraceEnd":{ "X":100, "Y":0, "Z":100 },			"PenetrationDepth":0,			"Item":-1,			"PhysMaterial":"",			"Actor":"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Bump_StaticMesh",			"Component":"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Bump_StaticMesh.StaticMeshComponent0",			"BoneName":"None",			"MyBoneName":"None"		},		"ReturnValue":true	} 
```

> [!TIP]
> 在此情况下，由于 `Engine/Source/Runtime/Engine/Classes/GameFramework/Actor.h` 文件中的 `SetActorLocation()` 函数的原始定义将其定义为输出参数：即对函数调用产生的数据值的非常量引用，所以 `SweepHitResult` 会包含在返回值中。

## PUT远程/object/属性

使用此端点可访问编辑器当前内存中由指定UObject公开的属性值：通常是Actor或资源。

> [!TIP]
> 如果访问的UObject是一个C++类的实例，它将包含在C++内被定义为属性，且可被蓝图访问的所有类成员，但受以下限制。
>
> 如果访问的UObject是一个蓝图类的实例，它将该类拥有的所有蓝图变量，但受以下限制。

此端点只能访问符合特定标准的属性：

- 必须将该属性定义为

  public

  ，但不能为

  private

  或

  protected

  。
- 不得定义任何

  BlueprintGetter

  或

  BlueprintSetter

  函数。如定义，必须在这些函数中使用上文中的

  remote/object/call

  端点，不得直接使用

  remote/object/property

  端点尝试读取或写入数值。
- 如要在编辑器中访问该object，该属性必须设为

  EditAnywhere

  。为修改该值，请勿将属性设为

  EditConst

  。
- 如在

  -游戏

  模式或编辑器中运行（PIE）模式下访问object，其属性必须设为

  BlueprintVisible

  。为修改该值，请勿将属性设为

  BlueprintReadOnly

  。

根据请求消息的构建方式，你可以：

- 请求object公开的所有可用属性及其当前值。
- 请求任何至少提供读取权限的属性的值。
- 设置任何提供写入权限的属性的值。

调用此端点时，必须传递拥有以下属性的JSON负载：

| 属性 | 说明 |
| --- | --- |
| `object路径（objectPath）` | 该路径对所要交互的 `UObject` 进行独特标记。欲了解查找此路径的更多信息，请参见下面的[关于UObject路径](#%E5%85%B3%E4%BA%8Euobject%E8%B7%AF%E5%BE%84) |
| `属性命名（propertyName）` | 要读取或修改的属性命名。如在 `READ_ACCESS` 的调用中忽略此属性，该响应将列出指定 `UObject` 上所有可用的可读属性。 |
| `访问（access）` | 定义对该属性发出的访问请求的类型。可为以下任意值： `READ_ACCESS` 为正在请求的属性，或指定的 `UObject` 上的所有属性指定当前的值。 `WRITE_ACCESS` 为在 `属性值（propertyValue）` object中定义的一个或多个属性指定新值。 `WRITE_TRANSACTION_ACCESS` 与 `WRITE_ACCESS` 相同，但会在项目的事务历史中记录属性值的更改。此操作与 `remote/object/call` 端点的 `生成事务（generateTransaction）` 相似。其拥有以下效果： 编辑器处理属性修改的方式与虚幻编辑器 **细节（Details）** 面板中的修改方式完全相同。这可能需要调用编辑器中的更多代码，以便处理链接至该属性的更改前和更改后事件。 如处于[多用户编辑](../../../multi-user-editing/index.md)会话中，该更改将被复制至其他连接的用户。 此选项可撤销更改。如将此属性设置为 `true`，编辑器会在项目的 **撤消历史（Undo History）** 面板的条目中记录此属性的更改。在虚幻编辑器中工作的用户可回滚更改的效果。该条目的命名始终为 **远程设置Object属性（Remote Set Object Property）**： 远程设置Object属性 |
| `属性值（propertyValue）` | 使用 `WRITE_ACCESS` 或 `WRITE_TRANSACTION_ACCESS` 发出请求时，可使用此object指定所要修改的属性、以及要为每个属性设置的新值。 必须是JSON object，其中每个字段的命名均与指定 `UObject` 上的可写属性的命名相匹配，且每个字段的值均是要为该属性所设的新值。 |

该调用会返回JSON负载，其中包含请求的信息或写入请求的结果。

### 范例

#### 读取所有属性

请求正文：

```
	{		"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5",		"access" : "READ_ACCESS"	} 
```

成功的请求在以下响应正文中给出 `200` 个状态：

```
	{		"bStaticMeshReplicateMovement": false,		"NavigationGeometryGatheringMode": "Default",		"PrimaryActorTick": {			"TickGroup": "TG_PrePhysics",			"EndTickGroup": "TG_PrePhysics",			"bTickEvenWhenPaused": false,			"bCanEverTick": false,			"bStartWithTickEnabled": true,			"bAllowTickOnDedicatedServer": true,			"TickInterval": 0		},		"bHidden": false,		"bOnlyRelevantToOwner": false,		"bAlwaysRelevant": false,		"bReplicateMovement": false,		"bNetLoadOnClient": true,		"bNetUseOwnerRelevancy": false,		"bRelevantForLevelBounds": true,		"bReplayRewindable": false,		"bAllowTickBeforeBeginPlay": false,		"bBlockInput": false,		"bCanBeDamaged": false,		"bFindCameraComponentWhenViewTarget": true,		"bGenerateOverlapEventsDuringLevelStreaming": false,		"bIgnoresOriginShifting": false,		"bEnableAutoLODGeneration": true,		"bIsEditorOnlyActor": false,		"ReplicatedMovement": {			"LinearVelocity": { "X": 0, "Y": 0, "Z": 0 },			"AngularVelocity": { "X": 0, "Y": 0, "Z": 0 },			"Location": { "X": 0, "Y": 0, "Z": 0 },			"Rotation": { "Pitch": 0, "Yaw": 0, "Roll": 0 },			"bSimulatedPhysicSleep": false,			"bRepPhysics": false,			"LocationQuantizationLevel": "RoundWholeNumber",			"VelocityQuantizationLevel": "RoundWholeNumber",			"RotationQuantizationLevel": "ByteComponents"		},		"InitialLifeSpan": 0,		"NetDormancy": "DORM_Awake",		"SpawnCollisionHandlingMethod": "AlwaysSpawn",		"AutoReceiveInput": "Disabled",		"InputPriority": 0,		"NetCullDistanceSquared": 2.25e+08,		"NetUpdateFrequency": 100,		"MinNetUpdateFrequency": 2,		"NetPriority": 1,		"SpriteScale": 1,		"Tags": []	} 
```

#### 读取单个属性

请求正文：

```
	{		"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",		"propertyName" : "StreamingDistanceMultiplier",		"access" : "READ_ACCESS",	} 
```

成功的请求在以下响应正文中给出 `200` 个状态：

```
	{		"StreamingDistanceMultiplier":1	} 
```

#### 写入属性

请求正文：

```
	{		"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",		"access" : "WRITE_ACCESS",		"propertyName" : "StreamingDistanceMultiplier",		"propertyValue" : {			"StreamingDistanceMultiplier" : 2		}	} 
```

请求成功后会返回状态`200`以及空的响应体：

## PUT remote/object/thumbnail

使用此端点来获取 **内容浏览器（Content Browser）** 中的资产的缩略图。该调用返回一个包含缩略图的JSON有效载荷。

### 示例

请求体:

```
	{		"objectPath" : "/Game/Mannequin/Animations/ThirdPersonJump_Start.ThirdPersonJump_Start"	} 
```

A successful request returns a 200 status with the thumbnail image in the response body:

![image alt text](../../../../../assets/images/d0/d0339c27897fbfad8975e1872ca7e21ad8bb8a17917026734b56271cdc6a18f2.jpg)

## PUT remote/search/assets

使用此端点在资产注册表中搜索资产。

当你调用这个端点时，你必须传递一个具有以下属性的JSON负载。

| 属性 | 描述 |
| --- | --- |
| 查询 | 你希望在资产名称中匹配的文本。如果该字段为空，则返回所有结果。 |
| 过滤 | 一个JSON对象，用于指定如何使用以下可选属性过滤请求的资产： **包名（PackageNames）** 将搜索限制为与指定包完全匹配。值的格式是一个字符串数组，例如["/Game/MyFolder/MyAsset"]。 **类名（ClassNames）:** 将搜索限制为与指定包完全匹配。值的格式是一个字符串数组，例如["/Game/MyFolder/MyAsset"]。 **包路径（PackagePaths）:** 将搜索限制为，包含指定路径的包。例如，["/Game/MyFolder"]只返回资产路径中包含鈥"/Game/MyFolder"的资产。值的格式是一个字符串数组。 **RecursiveClassesExclusionSet:** 当递归搜索匹配的类时，你可以指定从结果中排除哪个类。值的格式是一个字符串数组。 **RecursivePaths:** 当递归搜索匹配的类时，你可以指定任何想从结果中排除的类。值的格式是一个字符串数组。 **RecursiveClasses:** 一个布尔值，指定是否查看ClassNames中指定类的子类。 |

该调用会返回一个JSON负载，其中包含你所请求的信息。

### 示例

请求体:

```
	{		"Query": "Cube",		"Filter": {			"PackageNames": [],			"ClassNames": [],			"PackagePaths": [],			"RecursiveClassesExclusionSet": [],			"RecursivePaths": false,			"RecursiveClasses": false		}	} 
```

请求成功后会返回200状态以及以下响应体：

```
	{		"Assets": [			{				"Name": "CubeMaterial",				"Class": "Material",				"Path": "/Game/Geometry/Meshes/CubeMaterial.CubeMaterial"			},			{				"Name": "1M_Cube",				"Class": "StaticMesh",				"Path": "/Game/Geometry/Meshes/1M_Cube.1M_Cube"			},			{				"Name": "1M_Cube_Chamfer",				"Class": "StaticMesh",				"Path": "/Game/Geometry/Meshes/1M_Cube_Chamfer.1M_Cube_Chamfer"			}		]	} 
```

## PUT remote/object/describe

使用此端点可以查看编辑器中当前内存中某个UObject（例如Actor或Asset）的所有属性、函数和其他元数据。该调用会返回一个JSON负载，其中包含你所要求的信息。

### 示例

Request body:

```
	{		"objectPath": "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5"	} 
```

请求成功后会返回200状态以及以下响应体：

```
	{		"Name": "CubeMesh_5",		"Class": "/Script/Engine.StaticMeshActor",		"Properties": [			{				"Name": "StaticMeshComponent",				"Description": "",				"Type": "UStaticMeshComponent*",				"ContainerType": "",				"KeyType": "",				"Metadata": {}			},			{				"Name": "PrimaryActorTick",				"Description": "Primary Actor tick function, which calls TickActor().\nTick functions can be configured to control whether ticking is enabled, at what time during a frame the update occurs, and to set up tick dependencies.\n@see https://docs.unrealengine.com/latest/INT/API/Runtime/Engine/Engine/FTickFunction/\n@see AddTickPrerequisiteActor(), AddTickPrerequisiteComponent()",				"Type": "FActorTickFunction",				"ContainerType": "",				"KeyType": "",				"Metadata": {					"ToolTip": "Primary Actor tick function, which calls TickActor().\nTick functions can be configured to control whether ticking is enabled, at what time during a frame the update occurs, and to set up tick dependencies.\n@see https://docs.unrealengine.com/latest/INT/API/Runtime/Engine/Engine/FTickFunction/\n@see AddTickPrerequisiteActor(), AddTickPrerequisiteComponent()"				}			},			{				"Name": "bOnlyRelevantToOwner",				"Description": "If true, this actor is only relevant to its owner. If this flag is changed during play, all non-owner channels would need to be explicitly closed.",				"Type": "uint8",				"ContainerType": "",				"KeyType": "",				"Metadata": {					"ToolTip": "If true, this actor is only relevant to its owner. If this flag is changed during play, all non-owner channels would need to be explicitly closed."				}			},			...		]	} 
```

## PUT remote/batch

使用此端点将多个HTTP请求组合成单个远程调用。执行顺序由 **请求（Requests）** 数组中元素的顺序决定。

**请求（Requests）** 数组中的所有请求元素都必须是一个JSON对象，其属性如下：

| 请求属性 | 描述 |
| --- | --- |
| RequestId | 一个唯一的ID，用于将请求与相应的响应相匹配。 |
| URL | 请求目标，如`/remote/object/describe`。 |
| Verb | HTTP方法的选项包括：PUT、POST、GET和DELETE。 |
| Body | 发送给服务器的数据。并非所有的请求都有一个主体（Body）。 |

该调用会返回一个JSON负载，其中包含多个请求的响应数组。数组中的每个元素都有以下属性：

| 响应属性 | 描述 |
| --- | --- |
| RequestId | 一个唯一的ID，用于将请求与相应的响应相匹配。 |
| ResponseCode | 响应的状态码。响应成功则返回状态200。 |
| ResponseBody | 包含任何请求数据的负载。并非所有响应都有响应主体。 |

### 示例

Request body:

```
	{		"Requests" : [			{				"RequestId" : 1,				"URL": "/remote/object/property",				"Verb" : "PUT",				"Body": {					"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",					"propertyName": "StreamingDistanceMultiplier",					"access" : "READ_ACCESS"				}			},			{				"RequestId" : 2,				"URL": "/remote/object/property",				"Verb" : "PUT",				"Body": {					"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",					"propertyName": "StreamingDistanceMultiplier",					"propertyValue": {						"StreamingDistanceMultiplier" : 2					},					"access" : "WRITE_ACCESS"				}			},			{				"RequestId" : 3,				"URL": "/remote/object/property",				"Verb" : "PUT",				"Body": {					"objectPath" : "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",					"propertyName": "StreamingDistanceMultiplier",					"access" : "READ_ACCESS"				}			}		]	} 
```

成功的请求会返回以下响应体，其中包含每个请求的响应数组：

```
	{		"Responses": [			{				"RequestId": 1,				"ResponseCode": 200,				"ResponseBody": {					"StreamingDistanceMultiplier": 1				}			},			{				"RequestId": 2,				"ResponseCode": 200,				"ResponseBody": null			},			{				"RequestId": 3,				"ResponseCode": 200,				"ResponseBody": {					"StreamingDistanceMultiplier": 2				}			}		]	} 
```

## PUT remote/object/event

> [!WARNING]
> 该路由是试验性的。通过在项目的 **DefaultEngine.ini** 文件中添加以下控制台变量来启用它。
>
> ```
> 	[Console Variables]	WebControl.EnableExperimentalRoutes = 1
> ```

使用这个端点来接收对象的下一个事件，比如当一个对象的属性发生变化时接收更新。在事件发生之前，路由不会返回。

目前支持以下事件：

- ObjectPropertyChanged
- PreObjectPropertyChanged

### 示例

请求体：

```
	{		"EventType": "ObjectPropertyChanged",		"ObjectPath": "/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5.StaticMeshComponent0",		"PropertyName": "StaticMesh"	} 
```

事件发生之前，成功的请求不会返回。当StaticMesh属性发生变化时，将返回状态200，其主体如下：

```
	{	"StaticMesh": "/Engine/EditorMeshes/ArcadeEditorSphere.ArcadeEditorSphere"	} 
```

## 关于UObject路径

虚幻编辑器加载到内存中的每个资源和Actor均有一个路径对其进行唯一标识。此类路径主要用于编辑器内部，所以其不会以一种易于访问的方式直接向用户公开。而且它们是根据内部规则以编程方式确定，所以不易预测。

通常，这些object的路径遵循以下格式：

```
	/path/PackageName.ObjectName:SubObjectName.SubObject 
```

> [!TIP]
> 在C++中使用引擎的程序员可能认出这种格式与 `FindObject()` 和 `StaticFindObject()` 等函数所接受的格式相同。

例如，解构上面请求范例中显示的Actor路径：

|  |  |
| --- | --- |
| `/Game/ThirdPersonBP/Maps/` | 内容浏览器中资源的路径。 |
| `ThirdPersonExampleMap.ThirdPersonExampleMap:` | 包的名称及其包含的object（对于许多资源而言这都是相同的）。 |
| `PersistentLevel.CubeMesh_5.StaticMeshComponent0` | 通过子object的层级，到达所要影响的object的路径。 |

这些路径不易查看，但以下部分将讲述一些获取方法。

### 撤销历史中的路径

修改UObject时，可在 **撤销历史（Undo History）** 面板中查看其路径。

1. 点击面板右下角的过滤器图标，并启用 **显示事务细节（Show transactions details）**。

   ![显示事务细节](../../../../../assets/images/b1/b1859d32168f64f39f4233f639a428fa15f0dc59693f444311737a0d5a5e4349.png)
2. 对要访问的资源或Actor进行细微更改，例如将Actor移动至新位置。此操作在 **撤销历史（Undo History）**中会记录为新事务。
3. 在 **事务细节（Transaction Details）** 面板中，将鼠标悬停在 **已修改对象和属性（Modified objects and properties）** 列的条目上。提示文本会包含高亮object的路径。

   ![提示文本中显示的Object路径](../../../../../assets/images/f9/f920c73ee010365870963c3ea3367a51111556f836fc165c372f7e7d498b6198.png)

### 编辑脚本编辑工具中的路径

根据要远程执行的任务类型，网络应用程序应当了解当前关卡中可用的Actor或内容浏览器中存在的资源的路径，这可能很有帮助。为实现这一点，**编辑器脚本编辑工具（Editor Scripting Utilities）** 插件公开了一些实用函数，可用其与资源和关卡进行交互。

例如，`EditorScriptingUtilities` 模块中的 `EditorLevelLibrary` 类公开 `GetAllLevelActors` 函数，可对其进行全程调用，获取当前关卡中所有Actor的路径列表。向 `remote/object/call` 端点发送以下请求正文：

```
	{		"objectPath" :"/Script/EditorScriptingUtilities.Default__EditorLevelLibrary",		"functionName":"GetAllLevelActors"	} 
```

响应正文中的 `返回值（ReturnValue）` 域提供该关卡中所有Actor的一组路径。例如：

```
	{		"ReturnValue": [			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.LightmassImportanceVolume_0",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.AtmosphericFog_1",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.SkySphereBlueprint",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.SphereReflectionCapture",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.NetworkPlayerStart",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.DocumentationActor1",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Linear_Stair_StaticMesh",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Bump_StaticMesh",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.LeftArm_StaticMesh",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.RightArm_StaticMesh",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Ramp_StaticMesh",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.CubeMesh_5",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.LightSource_0",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.PostProcessVolume_0",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.SkyLight_0",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Floor_1",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Wall7_4",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Wall9",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Wall10",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.Wall11",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.TextRenderActor_1",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.MyBlueprint_5",			"/Game/ThirdPersonBP/Maps/ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.ThirdPersonCharacter_167"		]	} 
```

> [!NOTE]
> 欲了解安装 **编辑器脚本编写工具（Editor Scripting Utilities）** 插件的详细信息，请参见[脚本编写和编辑器自动化](../../index.md)。

> [!TIP]
> 在[PIE](../../../../understanding-the-basics/playing-and-simulating/index.md)模式下，**UEDPIE_X_** 是地图的名称前缀，而 **X** 是PIE实例ID。以上文中的第一个返回值为例，对象在PIE模式下的路径是：
>
> ```
> 	"objectPath" : "/Game/ThirdPersonBP/Maps/UEDPIE_0_ThirdPersonExampleMap.ThirdPersonExampleMap:PersistentLevel.LightmassImportanceVolume_0"
> ```

### 蓝图函数库路径

为了使用静态方法远程调用自定义[蓝图函数库](../../../../blueprints-visual-scripting/blueprints-technical-guide/blueprint-function-libraries/index.md)，对象路径必须指向[类默认对象(CDO)](../../../../cpp-programming/reflection-system/objects/index.md)，也就是UCLASS维持的对象。下文解释了如何未C++和Python对象构建对象路径。

#### C++

指向CDO（C++）的对象路径必须遵循以下格式：

```
	/Script/ModuleName.Default__ClassName 
```

下列表格描述了 如何确定蓝图函数库的模块名称和类名。

| 列 1 | 列 2 |
| --- | --- |
| 模块名称（ModuleName） | 模块名称（ModuleName）是DLL的名称，它包含了你所寻找的类。在Visual Studio项目中，有一个和模块同名的 **.build.cs** 文件，明确了该模块的构建方式以及该模块的依赖项。 |
| 类名（ClassName） | 类名（ClassName）是类的名称，拥有一个UCLASS宏。 |

#### Python

指向CDO（Python）的对象路径必须遵循以下格式：

```
	/Engine/PythonTypes.Default__ClassName
```

ClassName是类的名称，使用了 `@unreal.uclass()` 修饰符。
