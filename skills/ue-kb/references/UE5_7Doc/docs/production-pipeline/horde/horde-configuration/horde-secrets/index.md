---
title: "Horde保密信息"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-secrets-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde保密信息"]
---

# Horde保密信息

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde保密信息

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-secrets-for-unreal-engine

Horde实现了一个用于检索保密信息的API，这些保密信息可以存储在其自身的配置文件中，也可以从外部源获取。通过Horde编组数据，允许使用Horde的权限模型对访问进行控制，并允许自动化流程冒充发起请求的用户。

目前，Horde仅支持AWS Parameter Store作为外部保密信息提供程序开箱即用，但可以通过 `ISecretProvider` 接口添加其他实现。

## 配置保密信息

保密信息在[`globals.json`](../horde-schema/index.md#globals)文件的 `secrets` 列表中定义。每个[条目](../horde-schema/index.md#secretconfig)都包含一个标识保密信息的标识符（ `id` ）、一组键值对（ `data` ），以及一个用于控制可访问用户的[ACL](../horde-permissions/index.md)。

通过在 `sources` 数组中添加条目，可以从外部提供程序合并其他键值对。这里的每个条目都包含要从中获取保密信息的提供程序的 `name` ，以及一个用于在特定于提供程序的语法中定位保密信息的 `path` 。

来自外部提供程序的保密信息可能有两种形式，这由 `format` 属性决定。

- text

  保密信息是简单的字符串值，这些值会使用指定的

  key

  属性被添加到保密信息的键值对集中。
- json

  保密信息被解析为JSON对象，并使用属性名作为键被合并到保密信息的键值对中。

保密信息示例可以配置如下：

```
"secrets": [    {        "id": "horde-secrets",         // 一些硬编码属性值                "data": {            "aws-region": "us-east-1"        },         // 从AWS参数存储读取的一些值        "sources": [             // 从AWS参数存储读取单个保密信息参数，并将其分配给"aws-secret-access-key"            {                "provider": "AwsParameterStore",                "key": "aws-secret-access-key",                "path": "name-of-secret-in-parameter-store"            },             // 从AWS参数存储读取JSON对象，并将所有键值对合并到此保密信息中。            {                "provider": "AwsParameterStore",                "format": "json",                "path": "name-of-secret-in-parameter-store"            },        ],         // 仅允许Horde代理访问此内容        "acl": {            "entries": [                {                    "claim": {                        "type": "http://epicgames.com/ue/horde/role",                        "value": "agent"                    },                    "actions": [                        "ViewSecret"                    ]                }            ]        }    }]
```

当用户提出请求时，系统会从外部提供程序获取保密信息，并且Horde不会对其进行缓存。

## 使用保密信息

保密信息的最常见用例是在构建自动化管线期间。在这种场景下，Horde服务器URL和凭证将从Horde代理自动注入的环境变量中获取，并让管线能够代表启动作业的用户请求保密信息，而无需进行额外配置。

保密信息有三种常见的使用方式：

### 1. 使用Horde-GetSecrets BuildGraph任务

该任务会将文件作为参数，而且会读取该文件，并以{{ secret-name.property }}形式使用从Horde获取的值扩展所有保密信息，然后再将保密信息写回。你也可以不选择更新现有文件，而是将模板存放到BuildGraph属性中并进行展开，如下所示：

```
<Property Name="AwsEnvironmentText" Multiline="true">    AWS_REGION={{horde-secrets.aws-region}}    AWS_ACCESS_KEY_ID={{horde-secrets.aws-access-key-id}}    AWS_SECRET_ACCESS_KEY={{horde-secrets.aws-secret-access-key}}</Property><Horde-GetSecrets File="credentials.txt" Text="$(AwsEnvironmentText)"/>
```

### 2. 使用Horde-SetSecretEnvVar BuildGraph任务

该任务在运行时将一个环境变量设置为某个保密信息的值。环境变量由子进程继承，但不会在系统级别设置，因此该环境变量将一直包含该保密信息，直到当前步骤结束。

```
<Horde-SetSecretEnvVar Name="AWS_SECRET_ACCESS_KEY" Secret="horde-secrets.aws-secret-access-key"/>
```

### 3. 使用Horde API

Horde的API文档中列出了HTTP保密信息端点，并且 `AutomationTool` 包含以下实用方法，可在运行时查询这些保密信息：

```
IReadOnlyDictionary<string, string> secret = await CommandUtils.GetHordeSecretAsync(new SecretId("my-secret-name"));
```

```
string propertyValue = await CommandUtils.GetHordeSecretAsync(new SecretId("my-secret-name"), "propertyName")
```
