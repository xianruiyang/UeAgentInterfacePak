---
title: "Horde权限"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-permissions-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde权限"]
---

# Horde权限

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde权限

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-permissions-for-unreal-engine

## 身份验证

Horde为用户提供了三种身份验证和授权模式：

- 匿名
- OpenID Connect
- 内置用户账号

你可以通过 `AuthMethod` 设置来配置模式。

### 匿名

出于展示目的以及便于快速入门，Horde默认禁用授权。

> [!NOTE]
> 对于制片部署，必须使用OpenID Connect或内置用户账号正确配置身份验证。

### OpenID Connect

Horde可以使用外部OpenID Connect (OIDC)提供程序进行授权。 如需了解配置OIDC提供程序，请参阅[服务器部署](../../horde-deployment/horde-server/index.md)文档。 对于已经使用集中式身份验证提供程序（如Google Workspaces、Okta或Azure AD/Entra ID）的工作室，建议使用OIDC。

配置好OIDC提供程序后，可以在浏览器中访问 `http://{{ server_url }}/account` 页面，查看用户的声明。

### 内置用户账号

如果你是一家小型工作室，或者认为没有必要使用OpenID Connect方法，则Horde的内置用户账号是一种可行的选择。这些账号由Horde自己管理，存储在本地数据库中。当服务器处于匿名模式时，你可以使用Web UI（右上角的服务器下拉菜单）设置用户账号。至少配置一名管理员用户，并将 `AuthMethod` 设置为 `Horde` 。

## 访问权限控制列表

**访问权限控制列表（ACL）** 用于控制Horde中实体的访问权限。列表中的每一项都赋予具有特定OIDC声明的用户执行某些操作的权限。每个声明都是一个键值对，由OIDC提供程序返回或者在登录时由Horde合成。 如需可用操作的完整列表，请参阅[ACL操作](../horde-schema/index.md#acl%E6%93%8D%E4%BD%9C)。

用户可以查询或操作的许多对象在其他ACL控制的对象层次中都附有一个ACL。例如，某个流是某个项目的一部分。你可以授予用户相应权限，让用户能够查看特定的Perforce流（通过该流配置上的ACL）、项目内的所有流（通过项目配置上的ACL），或者服务器上的所有流（通过全局配置上的ACL）。

### 管理员

管理员用户可以执行任何操作，与配置了何种ACL无关。如果用户具有特定声明，且该声明是通过 `AdminClaimType` 和 `AdminClaimValue` 属性在服务器的[Server.json](../../horde-deployment/horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中配置的，则这些用户将被授予管理员身份。

### 合成声明

Horde会在通过OIDC提供程序返回的配置声明中添加几个声明：

| 名称 | 说明 |
| --- | --- |
| `http://epicgames.com/ue/horde/user` | 用户的真实姓名。这是根据 `OidcClaimNameMapping` [服务器设置](../../horde-deployment/horde-server/index.md)从OIDC提供程序返回的声明中提取出来的。 |
| `http://epicgames.com/ue/horde/user-id-v3` | 用户的标识符。这是一个由Horde分配的24字符唯一标识符。 |
| `http://epicgames.com/ue/horde/agent` | 标识一个特定代理（其值为代理ID）。 |
| `http://epicgames.com/ue/horde/perforce-user` | 提供与用户相对应的Perforce用户名 |

### 示例

以下配置片段声明了一个ACL，其中：

- 授予名为

  Tim Sweeney

  的用户

  ViewJob

  和

  CreateJob

  权限。
- 授予所有具有 `app-horde-users` 角色声明的用户 `ViewJob` 权限。

  ```
        "acl":      {          "entries": [              {                  "claim": {                      "type": "http://epicgames.com/ue/horde/user",                      "value": "Tim Sweeney"                  },                  "actions": [                      "ViewJob",                      "CreateJob"                  ]              },              {                  "claim": {                      "type": "http://schemas.microsoft.com/ws/2008/06/identity/claims/role",                      "value": "app-horde-viewers"                  },                  "actions": [                      "ViewJob"                  ]              }          ],          "inherit": true      }
  ```
