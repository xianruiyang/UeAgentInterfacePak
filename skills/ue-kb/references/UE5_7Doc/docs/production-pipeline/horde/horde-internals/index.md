---
title: "Horde内部机制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-internals-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde内部机制"]
---

# Horde内部机制

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde内部机制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-internals-for-unreal-engine

## 入门指南

### 服务器

Horde服务器的源代码位于 `Engine/Source/Programs/Horde/Horde.Server` 中。它用C#编写而成，使用ASP.NET。

Horde采用了 Microsoft发布的标准[C#代码约定](https://learn.microsoft.com/zh-cn/dotnet/csharp/fundamentals/coding-style/coding-conventions)，不过由于遗留原因，我们使用制表符而非空格。我们启用了.NET SDK自带的大多数静态分析器警告，但你可以通过 `.editorconfig` 文件禁用其中一些警告。

Horde默认配置为支持本地开发。打开 `Engine/Source/Programs/Horde/Horde.sln` 并将Horde.Server设置为默认项目，即可启动它。默认情况下，转到 `http://localhost:5000/account` 即可访问服务器。

当针对实时部署调试本地Horde服务器时，在[`Server.json`](https://dev.epicgames.com/documentation/404)中设置 `DatabaseReadOnlyMode` 属性，可以防止服务器尝试执行服务器状态的修改操作。为了安全起见，建议额外使用一个只读数据库账户。

### 操作面板

Horde操作面板是一个前端客户端，它采用[TypeScript](https://www.typescriptlang.org/)并使用[React](https://react.dev/)开发而成。要设置机器以开发操作面板，请执行以下操作：

1. 安装

   Node.js

   。
2. 从命令行，使用以下命令安装Yarn：

   npm install --global yarn

   。
3. 找到位于

   Engine\Source\Programs\Horde\HordeDashboard

   的操作面板文件夹。
4. 运行

   yarn install

   以安装包依赖项。
5. 编辑package.json，将代理属性设置为指向你的服务器URL，例如：

   http://localhost:13340

   。
6. 找到你的服务器的管理员令牌端点，以获取一个有过期时间的访问令牌，例如：

   http://localhost:13340/api/v1/admin/token

   。
7. 在HordeDashboard文件夹的根目录下创建一个名为

   .env.development.local

   的文件，并按以下方式粘贴访问令牌：

   REACT_APP_HORDE_DEBUG_TOKEN=eyFhbGciziJIUz

   。
8. 运行

   yarn start

   命令以启动开发Web服务器，该服务器应该会打开一个标签页，访问

   http://localhost:3000

   ，显示本地操作面板。

## Docker

Horde包含一个用于创建Docker镜像的 `Dockerfile` 。但它在虚幻引擎源代码树中的位置要求预先对文件进行暂存处理，以减小复制到构建镜像中的数据大小。

在 `Engine\Source\Programs\Horde\HordeBuild.xml` 中包含了一个用于执行这些操作的BuildGraph脚本，该脚本可按以下方式运行：

```
RunUAT.bat Engine/Source/Programs/Horde/HordeBuild.xml -Target="Build HordeServer"
```

## 主题

- 构建健康状况
- 存储
- 租赁
- 日志
- 结构化的日志记录
