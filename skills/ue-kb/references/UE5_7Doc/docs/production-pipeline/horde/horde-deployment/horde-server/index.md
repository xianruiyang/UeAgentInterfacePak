---
title: "Horde服务器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-server-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde部署", "Horde服务器"]
---

# Horde服务器

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde部署 / Horde服务器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-server-for-unreal-engine

## 安装

### MSI安装程序（Windows）

MongoDB和Redis的Windows构建包含在安装程序中，在启动时由Horde启动（Horde也会在终止时关闭它们）。这种安装适合小规模安装和测试Horde，但在制片环境中优先考虑单独托管数据库。

### Docker（Linux）

可以通过Epic Games组织在[GitHub](https://www.unrealengine.com/zh-CN/ue-on-github)上获取通过Docker托管Horde的镜像。请注意，你必须使用与Epic Games账号关联的GitHub账号登录GitHub，才能访问这些链接。

- Horde服务器

要下载镜像，首先从你的账号设置页面的开发者部分创建一个GitHub个人访问令牌（PAT），然后将其作为密码传递给：

```
docker login ghcr.io
```

下载镜像：

```
docker pull ghcr.io/epicgames/horde-server:latest 
```

请注意，在这种形式下，外部MongoDB和Redis实例必须通过配置文件或环境变量来配置（详见下文）。

只要每台服务器都指向同一个MongoDB和Redis实例，则在负载均衡器后面运行多个Horde服务器就无需进行显式配置。

在Linux系统上使用Docker容器是[Epic的首选Horde运行方式](../index.md)。

### Docker Compose（Linux）

[Docker Compose](https://docs.docker.com/compose/)通过提供一组预配置的Docker容器，简化了基于Docker的安装设置，这些容器中包含MongoDB和Redis的实例。

这种方法与MSI安装程序类似，适用于测试Horde或在小规模环境中进行部署。要访问预构建镜像，请参阅上文Docker小节。必要的Docker Compose配置可以在 `Engine/Source/Programs/Horde.Server/docker-compose.yml` 文件中找到。

在同一目录下，可以使用以下命令启动容器：

```
docker compose up
```

如需更多指导，请参阅YAML文件中的注释。

### Homebrew（Mac）

我们没有提供用于在Mac系统上运行服务器的预构建二进制文件，不过使用[Homebrew](https://brew.sh/)安装所有必要的先决条件相对简单。

1. 安装.NET 8 SDK。

   ```
        brew install dotnet-sdk
   ```
2. 安装MongoDB。

   ```
        brew tap mongodb/brew     brew update     brew install mongodb-community     brew services start mongodb-community
   ```
3. 安装Redis。

   ```
        brew install redis     brew services start redis
   ```
4. 启动Horde。以下环境变量使用标准的ASP.NET语法；如果你愿意，也可以改为修改 `server.json` 中的值。

   ```
        export Horde__MongoConnectionString=mongodb://localhost:27017     export Horde__HttpPort=37107     export Horde__Http2Port=37109		     cd Engine/Source/Programs/Horde/Horde.Server     dotnet run
   ```

### 从源代码编译

Horde服务器的源代码位于 `Engine/Source/Programs/Horde/Horde.Server/...` 下。

你可以在Visual Studio中使用 `Engine/Source/Programs/Horde/Horde.sln` 中的解决方案来编译和运行服务器，也可以通过命令行使用 `dotnet build` 或 `dotnet publish` 命令来完成。

Docker镜像可以通过位于 `Engine/Source/Programs/Horde/BuildHorde.xml` 的BuildGraph脚本并使用 `Engine/Source/Programs/Horde.Server/Dockerfile` 中的Dockerfile来编译。

建议使用BuildGraph脚本，而不是直接运行Dockerfile，因为在运行 `docker build` 之前，该脚本会将相关文件暂存到一个临时目录中，这样可以避免Docker daemon在编译之前将整个UE的源代码树复制到容器化环境中。

使用BuildGraph编译Docker镜像的命令行如下：

```
RunUAT.bat BuildGraph -Script=Engine/Source/Programs/Horde/BuildHorde.xml -Target="Build HordeServer"
```

Windows安装程序通过同一个BuildGraph脚本，使用类似的命令行编译：

```
RunUAT.bat BuildGraph -Script=Engine/Source/Programs/Horde/BuildHorde.xml -Target="Build Horde Installer"
```

## 设置

### 通用

服务器设置通过[`Server.json`](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件配置。在Windows上，该文件存储在 `C:\ProgramData\Epic\Horde\Server\Server.json` 中。在其他平台上，它默认存储在应用程序目录下的 `Data` 文件夹中。该文件中的设置会覆盖随服务器可执行文件一同分发的 `appsettings.json` 文件。

所有与Horde相关的设置都存储在 `Horde` 顶层键之下，而中间件和标准.NET设置则存储在其他根键之下。

作为一个ASP.NET应用程序，Horde的应用程序配置支持以下功能：

- 可以使用标准的ASP.NET语法，通过

  环境变量

  重载各个属性（请参阅

  MSDN

  ）。例如，数据库连接字符串可以使用

  Horde__MongoConnectionString

  环境变量传入。
- 部署环境可以使用ASPNETCORE_ENVIRONMENT环境变量配置。Horde的标准值为

  Production

  、

  Development

  和

  Local

  。
- 可以创建一个名为

  appsettings.{Environment}.json

  （例如 appsettings.Local.json）的特定于部署的配置文件，该文件将与其他设置合并。

请注意，服务器配置文件（ `Server.json` 、 `appsettings.json` 等）与全局配置文件（ `globals.json` ）有所不同。服务器配置文件会与服务器一同部署。它包含部署/基础设施设置，而全局配置文件可以存储在修订控制中，并在服务器的运行周期内动态更新。如需了解详情，请参阅[配置 > 方向](../../horde-configuration/horde-orientation/index.md)。

### MongoDB

MongoDB连接字符串可以通过[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中的 `MongoConnectionString` 属性或 `Horde__MongoConnectionString` 环境变量指定。连接字符串应采用标准的[MongoDB语法](https://www.mongodb.com/docs/manual/reference/connection-string/)，例如：

```
mongodb://username:password@host:27017?replicaSet=rs0&readPreference=primary
```

Horde将许多操作实现为比较并交换操作，因此，当使用副本集时，务必使用 `readPreference=primary` 参数将所有读取配置为使用主数据库实例。使用辅助实例进行读取可能会导致死锁，因为服务器在读取-修改-写入循环过程中会获取过期文档。

MongoDB连接可以通过 `MongoPublicCertificate` 属性配置为使用一组受信任的证书。例如，当在AWS上使用DocumentDB运行时，可以将 `global-bundle.pem` 文件放入服务器的应用程序目录，从而设置此属性，以使用Amazon的[组合证书包](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html)。

### Redis

Redis服务器可以通过[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)文件中的RedisConnectionConfig属性或 `Horde__MongoConnectionString` 环境变量配置。此字符串格式为普通的服务器名称和端口号，例如：

```
127.0.0.1:6379
```

### 端口

默认情况下，Horde配置为使用端口5000通过未加密的HTTP提供数据。在默认情况下，代理通过端口5002使用未加密的HTTP/2上的gRPC与Horde服务器通信。这些设置在服务器启动时显示在控制台上。

gRPC使用了一个单独的端口，因为Kestrel（.NET Web服务器）不支持在同一个端口上同时处理未加密的HTTP/2流量和HTTP/1流量。将Horde置于反向代理之后时，为非TLS HTTP/2流量使用单独的端口，这将非常有用。如果配置了一个HTTPS端口，则所有流量都可以使用该端口。

端口使用的设置在[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)中定义：

- 要禁用通过HTTP协议提供数据，可将

  HttpPort

  属性设置为零。
- 要配置使用的辅助HTTP/2端口，请设置

  Http2Port

  属性（或将其设置为零以禁用）

### HTTPS

要通过HTTPS协议提供数据，请在[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)中设置 `HttpsPort` 属性。

通过在同一文件中设置默认证书，为[Kestrel](https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/servers/kestrel?view=aspnetcore-8.0)（NET Core web服务器）配置证书。

跨平台：

```
"Kestrel": {    "Certificates": {        "Default": {            "Path": "C:\\cert\\test.pfx",            "Password": "my-password"        }    }}
```

Windows（使用系统证书存储）：

```
"Kestrel": {    "Certificates": {        "Default":        {            "Subject": "my-domain.com",             // 使用本地计算机上的'个人’证书存储            "Store": "My",            "Location": "LocalMachine"        }    }}
```

> [!NOTE]
> 必须将 `Kestrel` 对象添加到文件的根作用域中，而不是在 `Horde` 对象中。

其他为Kestrel配置证书的方法列在[MSDN](https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/servers/kestrel/endpoints?view=aspnetcore-8.0#configure-https)上。

HTTP/1.1和HTTP/2.0流量都可以通过 `HttpsPort` 提供。可以通过将 `HttpPort` 和 `Http2Port` 设置为零，禁用未加密的流量。

在某些情况下，服务器会提供指向自身的链接（例如使用Horde的内部账户系统时使用的OIDC发现文档），务必确保这些URL与HTTPS证书匹配。默认情况下，此URL是从服务器报告的DNS名称派生的，但也可以通过 `ServerUrl` 属性重载此设置。

要为测试设置自签名证书，请参阅[教程 > 自签名证书](../../horde-tutorials/horde-self-signed-certs-tutorial/index.md)。

### 监控

Horde使用[Serilog](https://serilog.net/)记录日志，并配置为生成纯文本和JSON日志文件，在Linux上这些文件将生成到应用程序目录中，在Windows系统上则生成到 `C:\ProgramData\HordeServer` 文件夹中。默认情况下，纯文本输出会被写入stdout，但可以通过[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)中的 `LogJsonToStdOut` 属性来启用JSON输出。

服务器的分析和遥测数据通过[OpenTelemetry](https://opentelemetry.io/)传输。遥测捕获的设置[在此列出](../horde-settings/index.md#%E6%89%93%E5%BC%80%E9%81%A5%E6%B5%8B%E8%AE%BE%E7%BD%AE)。

### RunModes

为了将较轻量级的请求流量与较重量级的后台操作分开处理，可以将Horde服务器配置为以不同的RunMode运行。你可以通过[RunMode](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)设置配置这些项。

### 身份验证

Horde支持使用外部身份提供程序通过[OpenID Connect (OIDC)](https://openid.net/developers/how-connect-works/)进行身份验证。OIDC是一种广泛使用的身份验证标准，Okta、AWS、Azure、Google、Facebook等许多服务都实现了与其兼容的身份提供程序。

[入门 > 验证](../../horde-tutorials/horde-authentication-tutorial/index.md)页面介绍了如何配置Horde的内部账户系统和OIDC提供程序。

要配置外部OIDC提供程序，需要在[Server.json](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)中进行以下设置：

- AuthMethod

  ：将其设置为

  OpenIdConnect

  。
- OidcAuthority

  ：OIDC授权的URL。你可以在浏览器中访问

  {{Url}}/.well-known/openid-configuration

  ，检查此处指定的URL是否正确，该地址应返回OIDC发现文档。
- OidcClientId

  ：向OIDC提供程序标识应用程序（Horde）。它由OIDC提供程序生成。
- OidcClientSecret

  ：OIDC提供程序提供的一个机密值，用于识别请求授权的应用程序。

此外，还可以指定以下设置：

- OidcRequestedScopes

  ：指定向OIDC提供程序请求的权限范围。权限范围决定了Horde向OIDC提供程序请求的访问权限，以及将返回的且可用于在Horde ACL中进行检查的声明。这些值的含义取决于你的OIDC 提供程序配置。
- OidcClaimNameMapping

  ：指定在尝试显示用户真实姓名时按偏好顺序检查的声明的列表。
- OidcClaimEmailMapping

  ：指定在尝试显示用户邮件地址时按偏好顺序检查的声明的列表。
- OidcClaimHordePerforceUserMapping

  ：指定在尝试确定用户的Perforce用户名时按偏好顺序检查的声明的列表。

如需了解其他身份验证选项，请参阅[配置 > 权限](../../horde-configuration/horde-permissions/index.md)。

### 参考

如需服务器配置文件中的有效属性的完整列表，请参阅[Server.json（服务器）](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)。
