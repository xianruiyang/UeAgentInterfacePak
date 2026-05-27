---
title: "Horde集成"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-integrations-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde部署", "Horde集成"]
---

# Horde集成

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde部署 / Horde集成

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-integrations-for-unreal-engine

## Perforce

### 通用

Horde主要使用Perforce实现CI功能，但也支持直接从Perforce服务器读取配置数据（请参阅[配置 > 方向](../../horde-configuration/horde-orientation/index.md)）。

用于读取配置文件的Perforce连接将连同服务器部署一起，通过服务器[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中的 `perforce` 属性进行配置。

> [!NOTE]
> 未来可能会增加对其他版本控制系统的支持。

### 群集

Epic的Perforce部署十分精细复杂，我们希望在多个地区和数据中心扩展我们的CI构建基础设施，这促使我们为Horde增添了大量与Perforce边缘服务器交互的自定义功能。例如，Horde实现了一个负载均衡器，用于将构建代理连接到Perforce服务器，例如，当服务器报告出现问题时，它会使用服务器实例提供的健康检查数据转到新的服务器实例。

Horde支持使用多个独立的Perforce安装，并在每个安装内的多个镜像间实现负载均衡。一组镜像相同数据的Perforce服务器被称为一个群集。如果需要，你可以将CI系统中的每个流配置为使用不同群集。

集群通过[globals.json](../../horde-configuration/horde-schema/index.md#globals)配置文件中的 `perforceClusters` 属性进行配置。

每个群集都有多个可配置项：

- Name

  ：用于从CI系统中的流引用群集。
- Servers

  ：每个服务器自身支持多项设置：

  - ServerAndPort

    ：服务器部分可以是一个包含多条记录的DNS条目，在这种情况下，它将主动进行负载平衡。
  - ResolveDns

    ：如果为true，系统会解析给定的DNS名称，找出可使用的具体服务器列表。这允许IT/基础设施团队在不重新配置Horde的情况下向群集添加和删除服务器。
  - Properties

    ：指定代理选择此服务器时必须具备的属性。
  - HealthCheck

    ：如果为true，Horde服务器将定期轮询服务器在常见端点上的健康状况。如需了解详情，请参阅

    健康检查

    。
- Credentials

  ：此服务器上不同账户的用户名/密码/申请单列表。CI作业可以请求这些凭证。
- ServiceAccount

  ：设置Horde用于执行内部操作（例如从某个流查询提交记录、代表其他用户提交等操作）的账户用户名。
- CanImpersonate

  ：表示在预检和提交操作成功后，Horde在提交更改时是否应尝试冒充其他用户。通常需要管理员账户权限。

### 带SSL的服务器

当Perforce服务器使用SSL并且指定了 `ssl:` 前缀时，务必确保服务器的指纹或证书受到信任。如需了解详情，请参阅[p4信任](https://www.perforce.com/manuals/cmdref/Content/CmdRef/p4_trust.html)文档。根据具体配置情况，可能需要显式设置 `P4TRUST` 环境变量，该变量应指向一个有效的 `p4trust.txt` 文件。同样，如需了解详情，请参阅P4文档。

例如，在Windows系统上，Horde服务器默认以服务形式运行。在这种情况下，信任文件的默认位置解析为 `%SystemRoot%\System32\config\systemprofile\p4trust.txt` 。

### 健康检查

启用后，系统将向 `http://{{ PERFORCE_SERVER_URL }}:5000/healthcheck` 执行HTTP `GET` 请求，为Perforce服务器执行健康检查。预计端点会返回一个具有以下结构的JSON文档：

```
{    "results": [        {            "checker": "edge_traffic_lights"            "output": "green"        }    ]}
```

其中， `output` 的有效值如下：

- 绿色（green）

  ：服务器处于健康状态。
- 黄色（yellow）

  ：服务器性能有所下降。
- 红色（red）

  ：服务器正在逐步关闭现有连接，不应再使用该服务器。

这一功能在 `PerforceLoadBalancer.GetServerHealthAsync()` 中实现。

### P4CONFIG

HHorde会在为CI使用而创建的工作空间的父目录中创建一个名为 `p4.ini` 的文件，其中包含合适的Perforce服务器、端口和用户名。

运行以下命令可让Perforce自动检测当前目录下工作空间的正确设置：

```
p4 set P4CONFIG=p4.ini
```

## Slack

Horde使用Slack执行以下操作：

- 当出现配置错误和CI故障时，广播相关通知。
- 为登录到Horde的用户提供头像。

### 清单

可以使用以下清单配置Horde Slack应用程序。请注意下面的 `{{ SERVER_URL }}` 占位符。

```
{    "display_information": {        "name": "Horde",        "description": "Allow for interaction with the Horde build system.",        "background_color": "#000000"    },    "features": {        "bot_user": {            "display_name": "Horde",            "always_online": false        }    },    "oauth_config": {        "scopes": {            "用户": [                "admin.conversations:write"            ],            "bot": [                "chat:write",                "chat:write.public",                "reactions:read",                "reactions:write",                "users.profile:read",                "users:read",                "users:read.email",                "channels:manage"            ]        }    },    "settings": {        "interactivity": {            "is_enabled": true,            "request_url": "{{ SERVER URL }}/api/v1/slack"        },        "org_deploy_enabled": true,        "socket_mode_enabled": true,        "token_rotation_enabled": false    }}
```

你可以在源代码树的 `Horde/Horde.Server/Slack` 下找到合适的应用程序图标，以及可用于构建健康通知提示的图标。

Horde需要在服务器的[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中配置两个令牌才能完全运行：

- SlackToken

  ：用于向通道发布消息的bot令牌（前缀为

  xoxb-

  ）。Horde bot用户还必须被明确邀请加入其需要发布消息的通道。
- SlackSocketToken

  ：用于与Slack建立WebSocket连接并提供交互功能的令牌（前缀为

  xapp-

  ），响应按钮点击等操作。

### 用户映射

Horde用户通过将其[OIDC配置文件](../horde-server/index.md)中的电子邮件地址与其Slack用户配置文件进行关联，从而实现与Slack用户的映射。对于成功映射的电子邮件地址，Horde将在操作面板中使用通过Slack配置的头像。
