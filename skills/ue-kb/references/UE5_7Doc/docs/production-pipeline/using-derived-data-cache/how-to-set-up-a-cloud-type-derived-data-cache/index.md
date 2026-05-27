---
title: "如何设置虚幻云DDC"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-set-up-a-cloud-type-derived-data-cache-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "派生数据缓存(DDC)", "如何设置虚幻云DDC"]
---

# 如何设置虚幻云DDC

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 派生数据缓存(DDC) / 如何设置虚幻云DDC

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-set-up-a-cloud-type-derived-data-cache-for-unreal-engine

**虚幻云派生数据缓存（Unreal Cloud DDC）** 是一种分布式存储服务，主要用作基于云的 **派生数据缓存 (DDC)** 。

虚幻云DDC将紧凑的二进制对象存储在一个内容可寻址的存储中，该存储可以在全球范围内进行复制。紧凑型二进制对象是自描述键值对象（类似于JSON），具有良好的二进制序列化性和广泛的类型系统。

其中一个关键类型是 **附件（Attachment）** 类型，该类型支持引用Blob而不包含Blob的对象。Blob是二进制数据文件，如图像、音频文件或其他多媒体内容。这些附加的负载是内容寻址的，这意味着负载的哈希值被用作其标识符。内容寻址是分布式存储系统中的常见做法，在Git中最为显著。内容寻址提供了为负载生成不可变标识符的能力，从而可以快速确定该负载是否已经在缓存中可用，还是需要在其他地方复制。

虚幻云DDC可以帮助团队大幅加快在虚幻引擎中的烘焙过程，以应对无法访问已就绪的本地（或文件共享）缓存的情况，例如远程用户的情况。

## 许可证

虚幻云DDC的源代码包含在普通虚幻引擎源代码许可证之中。

我们在[GitHub](https://github.com/orgs/EpicGames/packages/container/package/unreal-cloud-ddc)上提供了容器镜像。这些容器根据MIT许可证提供。

## 目录

- Jupiter

  - 大部分虚幻云DDC功能。
- Jupiter.Common

  - Lib - 可在虚幻云DDC之外使用功能的旧版库。
- Helm

  - 所有组件的Helm章程。
- Benchmark

  - 使用SuperBenchmark (sb)进行简单HTTP基准测试的实用模板，以及可用于使用Vegeta运行基准测试的Docker容器。
- Composes

  - 一组不同的Docker编排文件，用于简化本地部署和测试。

## 依赖项

- DotNet Core 6（以及Visual Studio 2022或VS Code）
- Docker
- Scylla
- Blob存储（S3、Azure Blob Store或本地文件系统）

## 其他有用项

- MongoDB
- Minio
- Docker Compose

## 功能测试要求

开始测试前，使用以下命令行启动先决服务：

命令行

```
docker-compose -f Composes\docker-compose-tests.yml -p jupiter-test up
```

## 本地运行

如果你想试用虚幻云DDC，请使用 `docker-compose` 将其启动。请注意，由于虚幻云DDC支持多种不同的后端，我们为每种用例提供了不同的组合。

要开始，请运行：

命令行

```
docker-compose -f Composes\docker-compose.yml -f Composes\docker-compose-aws.yml up --build
```

如果想使用更接近Azure上可用服务的服务，可以用 `docker-compose-azure.yml` 替换AWS的编排文件。

Docker compose的安装会禁用身份验证，以便快速上手。一般来说，我们建议你在部署之前将虚幻云DDC与OIDC供应商挂钩。

## 部署

虚幻云DDC目前仅在AWS的生产环境中运行，但其存储和数据库要求是通用和抽象的。

我们提供对Azure服务的基本支持（未经测试）。

我们提供了用于Epic内部部署到Kubernetes的helm值（在 `/Helm` 下），但Kubernetes并非必需。

Docker镜像发布在[Epic Games GitHub organization](https://github.com/orgs/EpicGames/packages/container/package/unreal-cloud-ddc)。

### Scylla

你需要为虚幻云DDC设置一个Scylla集群来进行对话。

虚幻云DDC支持使用Scylla Open Source（免费）或付费产品版本运行。付费版本可以帮助你减少管理集群的工作量，因为Scylla管理器可以帮你完成维护任务。

关于如何配置多区域集群，请参阅Scylla文档中的[Create a ScyllaDB Cluster - Multi Data Centers (DC)](https://docs.scylladb.com/stable/operating-scylla/procedures/cluster-management/create-cluster-multidc.html)：

点击[此处](https://www.scylladb.com/download/#open-source)下载Scylla的开源版本。

Scylla提供用于云环境的机器镜像。

### AWS

这是最经得起考验的部署形式，也是Epic的做法。我们安装到每个地区Kubernetes集群中的Helm Chart就在此库中提供。

### 现场部署

虚幻云DDC可在现场部署，无需使用云资源。如果只打算在单个地区运行，你可以为此建立MongoDB数据库。如果打算在多个地区运行，但仍在现场部署，你可以建立Scylla数据库。

如果你一开始只在一个地区运行，但以后可能会扩展，我们建议使用Scylla，因为Scylla可以直接扩展，而MongoDB则要求放弃全部现有状态。

### Azure

要在AWS上部署，需要将Azure设置为云供应商，并使用Azure Blob Storage的连接字符串指定 `Azure.ConnectionString` 设置。

### 测试部署

一旦部署完成并开始运行，就可以连接到机器并运行curl命令来验证它是否正常工作。

首先可使用健康检查。应该返回字符串 `Health` ：

命令行

```
curl http://localhost/health/live
```

接下来，你可以尝试在命名空间中添加和获取内容。这将在 `test-namespace` 中插入测试字符串（`test`）。根据设置，你可能需要使用不同的命名空间。还有一个前提是，你禁用了身份验证。这将返回一个状态码200和一个空的"需求（needs）"列表。

命令行

```
curl http://localhost/api/v1/refs/test-namespace/default/00000000000000000000000000000000000000aa -X PUT --data 'test' -H 'content-type: application/octet-stream' -H 'X-Jupiter-IoHash: 4878CA0425C739FA427F7EDA20FE845F6B2E46BA' -i
```

然后，就可以尝试检索该对象了。这将打印 'test' 字符串和状态码200。

命令行

```
curl http://localhost/api/v1/refs/test-namespace/default/00000000000000000000000000000000000000aa.raw -i
```

## 监控

我们使用Datadog来监控我们的服务。因此，虚幻云DDC在设计上就可以与该服务很好地协同工作。但是，所有日志均以结构化日志的形式传输到标准输出（stdout），因此所有能够理解结构化日志的监控服务都应该能够很好地进行监控。

### 健康检查

所有虚幻云DDC服务都使用健康检查来监控自身、可能运行的后台服务，以及可能拥有的依赖服务（如DB/Blob存储等）。

你可以通过 `/health/live` 和 `/health/ready` 来分别进行实时和就绪检查。就绪检查用于验证服务是否正常运行。如果就绪检查返回false，应用程序将不会获得流量（负载平衡器会忽略它）。实时检查用于查看Pod是否正常工作。如果实时检查返回false，整个Pod将被关闭。这仅适用于在Kubernetes集群中运行的情况。

## 身份验证

虚幻云DDC支持使用任何可以进行JWT验证的OIDC供应商进行身份验证。Epic使用Okta，因此已对其进行了测试，但其他OIDC也应该能兼容。

要设置身份验证。请设置IdentityProvider（IdP），然后为每个命名空间设置授权。

### 设置IdentityProvider

在 `auth` 设置中指定身份验证方案。

身份验证设置

```
auth:    defaultScheme: Bearer    schemes:      Bearer:         implementation: "JWTBearer"        jwtAudience: "api://unreal"        jwtAuthority: "<url-to-your-idp>
```

如果这是你的第一个也是唯一的方案，我们建议将其命名为 `Bearer`。你可以根据多个IdP使用多个方案进行连接。这在迁移过程中将非常有用。

实现字段通常是 `JWTBearer` ，但如果你使用的是拥有自定义身份验证服务器的Okta，我们也提供一个 `Okta` 字段。对于使用组织身份验证服务器的Okta，你也需要使用 `JWTBearer` 。

### 命名空间访问权限

虚幻云DDC的操作访问权限通过下列行动控制：

- ReadObject
- WriteObject
- DeleteObject
- DeleteBucket
- DeleteNamespace
- ReadTransactionLog
- WriteTransactionLog
- AdminAction

可以使用每个命名空间策略中的访问控制列表（access control list (acls)）为每个命名空间分配这些权限，也可以将其分配给身份验证设置中的访问控制列表（该设置适用于所有命名空间以及与命名空间无关的操作）。

下方是一个配置示例，它为有访问权限的用户设置了事务日志访问权限，为管理员设置了管理员访问权限，然后为每个命名空间设置了访问权限。

```
auth:    acls:    - claims:         - groups=app-ddc-storage-transactionlog        actions:        - ReadTransactionLog        - WriteTransactionLog     - claims:        - groups=app-ddc-storage-admin        actions:        - ReadObject        - WriteObject        - DeleteObject        - DeleteBucket        - DeleteNamespace        - AdminAction namespace:  policies:    example-namespace:      acls:      - actions:         - ReadObject        - WriteObject        claims:         - ExampleClaim     - actions:         - ReadObject        - WriteObject        claims:         - AnotherClaim    open-namespace:      acls:      - actions:         - ReadObject        - WriteObject        claims:         - "*"
```

如果在声明数组中指定多个声明，则这些声明将进行AND运算，这意味着所有声明都需要求值为true。像 `A=B` 这样的声明语句要求声明 `A` 具有值 `B` （或者在数组的情况下包含值 `B`）。

你还可以指定 `*` 声明，这样无论它有什么声明，它都会为有效令牌授予访问权限。这主要用于调试和测试场景，不应用于生产环境数据。

## 网络设置

虚幻云DDC的大部分性能都衍生于正常的互联网连接，而不是依赖VPN隧道。因此，我们强烈建议你在公共互联网端点上公开虚幻云DDC。使用HTTPS并按照本页的描述设置你的身份验证，以防止任何人访问这些数据。

虚幻云DDC还提供了多个端口，可以用来控制API的访问权限级别。

### 公共端口

这是你应该向公共互联网公开的端口，也是大多数用户访问服务时应该使用的端口。该端口不会公开某些较为敏感的API（例如枚举所有内容）。在Kubernetes中，这将以 `80` 端口和 `http` 的形式公开。如果你只在一个区域中运行，则只需公开此端口。

### 私有端口

这也称为企业（Corp）端口。如果你的路由在内网公开，请使用此端口。其目的是将某些敏感命名空间只公开给内网用户。使用命名空间策略中的 `IsPublicNamespace` （设置为 false）来启用。

> [!WARNING]
> 我们不建议在DDC中使用此功能，因为在没有VPN的情况下，居家办公的用户无法访问命名空间（对于DDC用例来说，VPN的速度通常太慢）。

在Kubernetes中，该端口一般以 `8008` 端口和 `corp-http` 的形式公开。

```
        "PublicApiPorts": [ 80, 8081 ],        "CorpApiPorts": [ 8008, 8082 ],        "InternalApiPorts": [ 8080, 8083 ]
```

### 内部端口

只有其他虚幻云DDC实例才需要访问内部端口。内部端口公开了私有端口的所有功能，但也公开了某些敏感的API（主要是通过复制日志枚举内容）。

在Kubernetes中，该端口将以 `8080` 端口和 `internal-http` 的形式公开。

我们建议仅通过私有VPC或使用IP范围白名单或类似方式将此入口保留给其他虚幻云DDC实例。

请注意，该端口主要用于推测性Blob复制（请参阅本页的 *设置Blob复制* ）。

## 一般操作

### 针对本地实例运行本地烘培

如果运行本地实例，可以通过传递选项 `-UE-CloudDataCacheHost=http://localhost` 来针对它运行本地烘培。前提是你的项目已设置为使用云DDC，并且使用 `UE-CloudDataCacheHost=None` 作为其主机重载项（可能因项目而异）。

如果此操作按预期工作，你应该会在烘焙器中看到如下输出：

控制台输出

```
DerivedDataCache http://localhost: HTTP DDC: Healthy
```

### 添加新区域

新区域需要包含：

- S3存储
- 计算机（Kubernetes集群或虚拟机）
- Scylla部署

要配置虚幻云DDC以添加新区域，请更新所有节点上的集群设置以包含新区域的DNS。

还需要确保为新区域设置 `LocalKeyspaceReplicationStrategy` 。

对于Scylla的配置，请参阅[Adding a New Data Center Into an Existing ScyllaDB Cluster](https://docs.scylladb.com/stable/operating-scylla/procedures/cluster-management/add-dc-to-existing-dc.html)。

具体而言，关键在于密钥空间的更新

```
ALTER KEYSPACE jupiter WITH replication = { 'class' : 'NetworkTopologyStrategy', '<exiting_dc>' : 3, <new_dc> : 3};ALTER KEYSPACE system_auth WITH replication = { 'class' : 'NetworkTopologyStrategy', '<exiting_dc>' : 3, <new_dc> : 3};ALTER KEYSPACE system_distributed WITH replication = { 'class' : 'NetworkTopologyStrategy', '<exiting_dc>' : 3, <new_dc> : 3};ALTER KEYSPACE system_traces WITH replication = { 'class' : 'NetworkTopologyStrategy', '<exiting_dc>' : 3, <new_dc> : 3};
```

我们在所有地方都使用了复制因子3，因此请添加新区域（DC）的名称。

你还需要更改每个 `local` 密钥空间的密钥空间，将新区域的复制因子设置为0（请参阅本节中有关 `LocalKeyspaceReplicationStrategy` 的说明）。

```
ALTER KEYSPACE jupiter_local_regionA WITH replication = { 'class' : 'NetworkTopologyStrategy', 'regionA' : 2, 'regionB' : 0}ALTER KEYSPACE jupiter_local_regionB WITH replication = { 'class' : 'NetworkTopologyStrategy', 'regionA' : 0, 'regionB' : 2}
```

这将确保本地密钥空间仅写入本地区域。虽然这并不关键，但该数据将只会在该区域内被请求，因此可在Scylla集群内节省大量带宽和存储空间。

你可能还得更新虚幻云DDC工作器配置中的复制器，从这个新区域进行复制。

### 设置Blob的复制

虚幻云DDC有两种复制方法：

- 按需复制
- 推测性复制

当B区域发出缺少必须blob的请求时， **按需复制** 会将blob从A区域复制到B区域。将命名空间政策中的 `OnDemandReplication` 设置为true，即可让每个命名空间都使用按需复制。

> [!WARNING]
> 我们不建议为DDC命名空间设置此项，因为这会导致响应时间极度不统一。对DDC而言，最好接受缓存缺失并为这种情况重建内容，但一般依靠推测性复制来传输blob，以便blob在所有地方都可用且不会增加延迟。

**推测性复制** 使用添加引用（Ref）时在每个区域保存的日志来了解需要复制哪些内容。这将随着命名空间中的变化而变化，并复制这些新Ref所引用的所有blob。这将最终导致所有内容被复制，包括本地区域可能永远不会使用或需要的内容，但好处是一旦解析Ref，通常会有一个本地blob可用。

对DDC而言，保持较短的响应时间非常重要，我们建议使用推测性复制。

要设置推测性复制，请在工作器配置中添加如下所示的分段（参阅 `example-values-ABC.yaml` ）：

example-values-ABC.yaml

```
worker:  config:    Replication:      Enabled: true      Replicators:       - ReplicatorName: DEF-to-ABC-test-namespace        Namespace: test-namespace        ConnectionString: http://url-to-region-DEF.com
```

复制器名称可以是任何唯一标识此复制器的字符串（用于存储该复制器的状态和日志记录）。

`Namespace` 是需要复制的命名空间。

`ConnectionString` 是用于连接其他区域虚幻云DDC部署的URL。

需使用内部端口进行公开（参阅 `网络设置` 小节）。还需要在 `ServiceCredentials` 部分中设置虚幻云DDC使用的凭据，这些凭据需具有 `ReadTransactionLog` 访问权限。
