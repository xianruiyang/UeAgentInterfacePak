---
title: "BuildGraph功能的使用"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-use-buildgraph-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "用虚幻构建管线", "自动工具", "BuildGraph功能的使用"]
---

# BuildGraph功能的使用

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 用虚幻构建管线 / 自动工具 / BuildGraph功能的使用

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-use-buildgraph-for-unreal-engine

***BuildGraph** 是一种在虚幻引擎中创建可扩展的构建进程中使用的 **虚幻自动工具（Unreal Automation Tool）** 脚本。这些进程可以在本地运行，也可以在构建场中同时运行。

## 使用命令行运行

作为一个虚幻自动工具脚本，你可以根据使用的平台，通过 `RunUAT` 批处理文件或shell脚本直接在 `Engine\Build\BatchFiles` 目录下使用命令行运行BuildGraph。

### Windows系统

```
./RunUAT.bat BuildGraph [ARGUMENTS]
```

### Linux系统和Mac系统

```
./RunUAT.sh BuildGraph [ARGUMENTS]
```

## 示例脚本

引擎源中包含了一些BuildGraph XML文件的示例供你使用。这些文件在 `Engine/Build/Graph/Examples` 目录中。这些示例文件包含以下内容：

- AllExamples.xml

  : 这个脚本是

  Properties.xml

  、

  TagsAndFiles.xml

  和

  Building.xml

  三个脚本的组合。
- BuildEditorAndTools.xml

  : 这个脚本展示了如何编译美术师使用引擎所需的工具和编辑器二进制文件，将它们复制到一个临时目录中进行分发，并选择将它们提交给Perforce。
- Building.xml

  : 这个脚本可以编译UnrealPak。
- BuildWorldPartitionHLODs.xml

  : 这个脚本构建了世界分区的HLOD。
- Macros.xml

  : 这个脚本是一个定义和使用宏的示例。
- Properties.xml

  : 这个脚本是一个使用各种不同BuildGraph功能的示例。
- TagsAndFiles.xml

  : 这个脚本是一个对文件进行操作和交互的示例。

BuildGraph使用的XML模式文件名为 `Schema.xsd`，位于 `Engine/Build/Graph` 目录中。

## 示例命令

### 所有可用的节点和选项

你可以通过执行以下内容查看BuildGraph脚本中的所有可用节点和选项：

```
./RunUAT.bat BuildGraph -Script=Engine/Build/Graph/Examples/AllExamples.xml -ListOnly
```

### 控制流程

你可以通过执行 `Properties.xml` BuildGraph脚本来了解控制流程是如何运作的：

```
./RunUAT.bat BuildGraph -Script=Engine/Build/Graph/Examples/Properties.xml -Target="Property Examples" -Clean
```

这个脚本执行被评估为 "真（true）"的条件，并输出其相应的信息。它还展示了几个控制流程语句的行为，这些语句包含在[BuildGraph脚本剖析](../buildgraph/buildgraph-script-anatomy/index.md)当中。

### 在虚幻引擎中创建安装构建版本

你可以使用提供的 `InstalledEngineBuild.xml` BuildGraph脚本，用以下命令创建用于Windows系统的UE安装构建版本：

```
./RunUAT.bat BuildGraph -Script=Engine/Build/InstalledEngineBuild.xml -Target="Make Installed Build Win64" -set:HostPlatformOnly=true -Clean
```

这将创建一个安装引擎构建版本，你可以在 `<UNREAL_ENGINE_ROOT>/LocalBuilds/InstalledDDC/Engine/Binaries/Win64`中找到它。

## 命令行参数

BuildGraph支持使用 `-help` 命令，在命令行中显示帮助文本。要使用命令行查看可用的 `BuildGraph` 参数，请运行：

```
./RunUAT.bat BuildGraph -help
```

### 自定义命令行选项

BuildGraph支持向你的BuildGraph脚本传递自定义命令行选项。要在你的XML脚本中定义一个自定义的选项，可以使用：

```
<Option Name="NAME" Restrict="REGEX" DefaultValue="DEF_VAL" Description="DESCRIPTION"/>
```

一个选项的组成部分如下：

- Name

  ：要从命令行引用的选项名称。
- Restrict

  ：用于限制可接受的值的一个正则表达式。
- DefaultValue

  ：表示如果没有提供任何选项时的默认值。
- 说明

  ：对这个选项的描述，包括它可能的方式。

然后你可以通过命令行将该选项传递给你的脚本：

```
-Set:<OPTION_NAME>=<OPTION_VALUE>
```

#### 示例

下面是一个在XML脚本中定义选项的示例：

```
<Option Name="MyBooleanOption" Restrict="true|false" DefaultValue="false" Description="A boolean option for my BuildGraph script."/>
```

而以下是如何使用命令行向你的脚本传递这个选项：

```
-Set:MyBooleanOption=true
```

### 参考

该表包含了从命令行运行BuildGraph时可使用的命令行参数列表：

```
./RunUAT.bat BuildGraph [ARGUMENTS]
```

| **参数** | **说明** |
| --- | --- |
| `-Script=<FILE_NAME>` | 描述图形的脚本的路径。 |
| `-Target=<NAME>` | 要建立的节点或输出标签的名称。 |
| `-Schema` | 在默认位置生成一个模式文件。 |
| `-Schema=<FILE_NAME>` | 生成一个描述有效脚本文件的模式，包括所有已知的任务。 |
| `-ImportSchema=<FILE_NAME>` | 使用现有的模式文件中导入。 |
| `-Set:<PROPERTY>=<VALUE>` | 为指定的 `VALUE` 设置一个已命名的 `PROPERTY`。 |
| `-Branch=<VALUE>` | 覆盖当前分支的自动检测。 |
| `-Clean` | 在运行前清理所有已完成的构建节点的缓存状态。 |
| `-CleanNode=<NAME>[+<NAME>...]` | 在运行前清理指定的节点。 |
| `-Resume` | 使用最后一个成功完成的节点恢复本地构建。 |
| `-ListOnly` | 显示预处理图的内容，但不执行它。 |
| `-ShowDiagnostics` | 当以`-ListOnly`运行时，使在解析图表时显示输入的诊断信息。 |
| `-ShowDeps` | 在输出图表中显示节点的依赖性。 |
| `-ShowNotifications` | 显示在输出中为每个节点发送的通知。 |
| `-Trigger=<NAME>` | 只执行特点触发器后面的节点。 |
| `-SkipTrigger=<NAME>[+<NAME>...]` | 跳过指定的触发器，包括在图表中它们后面的所有节点。 |
| `-SkipTriggers` | 跳过所有触发器。 |
| `-TokenSignature=<NAME>` | 指定识别当前作业的签名，以写入需要签名的模式的令牌中。如果不指定此参数，则忽略令牌。 |
| `-SkipTargetsWithoutTokens` | 排除无法获得令牌的目标，而非让其报错。 |
| `-Preprocess=<FILE_NAME>` | 将预处理后的图表写入给定文件。 |
| `-Export=<FILE_NAME>` | 输出一个包含预处理的构建图表的JSON文件，作为构建系统的一部分使用。 |
| `-Export=<FILE_NAME>` | 输出一个包含完整构建图表的JSON文件，供Horde使用。 |
| `-PublicTasksOnly` | 在模式中只包括内置任务，不包括任何其他UAT模块。 |
| `-SharedStorageDir=<DIR_NAME>` | 设置用于在构建场的代理之间传输构建产品的目录。 |
| `-SingleNode=<NAME>` | 只运行指定的节点。适用于使用 `-Export` 运行后的构建系统。 |
| `-WriteToSharedStorage` | 允许写入共享存储。如果没有设置，但指定了 `-SharedStorageDir`，构建产品将被读取，但不被写入。 |
