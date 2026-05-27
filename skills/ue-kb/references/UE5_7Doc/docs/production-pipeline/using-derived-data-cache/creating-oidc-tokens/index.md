---
title: "OIDC令牌"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/creating-oidc-tokens-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "派生数据缓存(DDC)", "OIDC令牌"]
---

# OIDC令牌

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 派生数据缓存(DDC) / OIDC令牌

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/creating-oidc-tokens-for-unreal-engine

**OIDC令牌**是一款工具，可以公开、分配、访问并刷新与OIDC兼容的身份提供商提供的令牌。 这对于设置各种云服务非常有用，以便让虚幻编辑器使用这些服务，例如[云DDC](../how-to-set-up-a-cloud-type-derived-data-cache/index.md)。 本页面将介绍如何配置OIDC令牌工具和设置身份提供商。

## 配置

配置文件可以放在`Engine\Programs\OidcToken\oidc-configuration.json`或`<Game>\Programs\OidcToken\oidc-configuration.json`下

下面是配置文件的示例：

C++

oidc-configuration.json

```
{

	"OidcToken": {

		"Providers": {

			"MyOwnProvider": {

				"ServerUri": "https://<url-to-your-provider>",
```

## 设置身份提供商

本小节将介绍如何设置一些常见的**身份提供商（IdP）**。

### Okta

你需要设置以下项目才能将Okta用作IdP：

- 一款用于**交互式登录**（由用户登录）的**客户端**（应用程序）。
- 一款**自定义身份验证服务器**，用于控制Okta如何映射声明和作用域，以及你可以指定用户来管理访问控制的一些组。
- 如果你要在无法进行交互式登录的构建场中运行，则需要设置另一款**客户端**（应用程序）以允许登录。

> [!NOTE]
> 在没有自定义身份验证服务器的情况下，Okta不支持OIDC登录。 要设置身份验证服务器，请参阅[Okta关于身份验证服务器的文档](https://developer.okta.com/docs/concepts/auth-servers/)。

要将Okta设置为身份提供商，请按以下步骤操作：

1. 打开**Okta管理员操作面板（Okta admin dashboard）**。
2. 点击**应用程序（Applications）** > **应用程序（Applications）**。
3. 创建用于交互式登录的**客户端**并启用以下授权类型：

   - 刷新令牌
   - 授权代码
4. 我们建议在**本地主机（Localhost）**下指定**多个登录URL**。 例如：

   - http://localhost:8749/oidc-token
   - http://localhost:8750/oidc-token
   - http://localhost:8751/oidc-token
   - http://localhost:8752/oidc-token
   - http://localhost:8753/oidc-token
   - http://localhost:8754/oidc-token

   这样应用程序就可以在登录过程中在多个本地端口上运行，从而避免端口繁忙的问题。

   > [!NOTE]
   > 上面列出的端口是随机示例。 你可以选择适合自己需求的端口。
5. 设置**无人值守登录客户端**，该客户端与你在前面步骤中建立的客户端类似，但有以下几点不同：

   - 改用**客户端凭证（Client Credentials）**授予类型。
   - 无需指定任何登录URL。

   这要求你为客户端使用**配置文件对象**。 如需了解如何更新已创建配置文件的示例，请参阅[Okta关于更新配置文件属性的文档](https://developer.okta.com/docs/reference/api/apps/#update-application-level-profile-attributes)。
6. 创建你要用于无人值守登录的客户端凭证后，请为其提交有效负载，类似于以下示例：

   C++

   ```
   "profile": {		             "clientCredentialsGroups": [		                 "app-ue-storage-project-your-project-name"		             ]		         }
   ```
7. 按照以下指南更新自定义身份验证服务器中的**组声明**：

   - 你可以根据需要映射用户组，但你需要创建至少一个组，且该组需要准确包含你想要有访问权限的所有用户。 在Epic Games，我们通常是一个项目一个组。
   - 你还需要为具有某些更高访问权限的用户创建一个**管理员组**。
   - 采用的命名规范要便于识别你想使用的组。 这有助于确保你仅发送适用于虚幻引擎事务的组作为令牌的一部分，而不是用户所属的所有组。
   - 创建时请确保为每个组至少分配一个用户。
8. 在Okta管理员页面，在**安全（Security）** > **API**下配置自定义身份验证服务器。

   > [!NOTE]
   > 自定义身份验证服务器是Okta的附加组件，你可能无法使用，但Okta需要它来处理OIDC登录。

   要创建身份验证服务器，请点击**创建身份验证服务器（Create Authorization Server）** 按钮。 该身份验证服务器并非只有云DDC才能用， 而是可用于你想要使用的任何虚幻引擎服务。
9. 编辑身份验证服务器并设置**访问策略（Access Policies）**。 为每个客户端创建一个策略，并将其设置为允许该客户端登录。
10. 打开访问令牌类型的**声明（Claims）**，然后设置**组（Groups）**声明，并将其设置为筛选出你要使用的组，同时包含`clientCredentialsGroups`。 使用此自定义表达式：

    C++

    ```
    (appuser != null) ? Arrays.flatten( Groups.startsWith("OKTA", "app-ue-", 100) == null ? {} : Groups.startsWith("OKTA", "app-ue-", 100) ) : app.profile.clientCredentialsGroup1s
    ```

    这会筛选掉以`app-ue`开头的组。
11. 设置你可以为构建场登录而使用的**cache_access**作用域。

完成上述步骤后，Okta即可充当你的身份提供商。

#### 如何测试你的身份提供商Okta

要测试Okta，请执行以下步骤：

1. 在身份验证服务器中，前往**令牌预览（Token Preview）**。
2. 选择授权类型为**授权代码（Authorization Code）**的**交互式登录**客户端。
3. 选择分配到正确组的用户。

当你预览此令牌时，显示的JSON应包含一个 **组（Group）**数组，其中包含你已分配的组的名称。

### Microsoft Entra（AzureAD）

要将Microsoft Entra设置为身份提供商，请按以下步骤操作：

1. 前往Microsoft的[Azure门户网站](https://portal.azure.com/)。
2. 点击**Microsoft Entra**服务。
3. 前往**应用程序注册（App registration）**并为桌面登录创建新的应用程序注册。 它应包含以下设置：

   - 单一租户
   - 包含一组使用公共客户端/原生选项的本地主机重定向URL。 以下是一些重定向URL示例：

     - http://localhost:8749/oidc-token
     - http://localhost:8750/oidc-token
     - http://localhost:8751/oidc-token
     - http://localhost:8752/oidc-token
     - http://localhost:8753/oidc-token
     - http://localhost:8754/oidc-token

   记下此应用程序的`client id`。
4. 前往**令牌配置（Token Configuration）**并添加**组**声明设置，以使用**分配给应用程序的组**。
5. 为**项目用户**角色创建新的**安全组**。 将该安全组分配给该角色，然后将你所需的所有用户添加到该安全组。
6. 创建以下**应用角色**：

   - **项目用户（Project User）**（通常是一个项目一个用户）
   - **管理员（Admin）**

   项目用户角色需要可分配给用户、组和应用程序，而管理员角色仅适用于用户。
7. 返回**应用程序注册（App registration）**并为后端服务（例如"虚幻云DDC"）创建应用程序。
8. 将API作用域添加到你的新应用程序并将其命名为`user.access`。 为此API分配桌面应用程序访问的`client id`。
9. 为你的烘焙应用程序创建一个单独的新应用程序注册，并向其添加客户端密钥，以便在无人值守的情况下登录（或者如果你愿意，也可以使用托管身份或类似身份）。 你还应该为此应用程序分配项目用户角色。
10. 创建`oidc-configuration.json`文件时，你可以在**端点（Endpoints）**按钮下找到要用于应用程序注册的**服务器url**。 通常是`[https://login.microsoftonline.com/](https://login.microsoftonline.com/)<directory-tenant-id>/v2.0`。
11. 针对**客户端ID**，请使用你创建的桌面应用程序的`client id` 。 该作用域需要包含你在后端服务中创建的API作用域， 因此其结尾通常都是`offline_access profile openid api://<api scope guid>/user.access`。

完成上述步骤后，Microsoft Azure即可充当你的身份提供商。
