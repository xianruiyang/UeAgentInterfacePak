---
title: "Horde方向"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-orientation-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde配置", "Horde方向"]
---

# Horde方向

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde配置 / Horde方向

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-orientation-for-unreal-engine

Horde几乎完全通过JSON配置文件进行配置。尽管当中涉及到一些惯例和概念，在初期需要加以学习，但我们坚信，此功能优于UI驱动型配置。通过将配置信息存储在文本文件中，能够更轻松地执行以下操作：对更改进行差异比较和版本管理，追踪导致问题出现的更改，以及提供清晰的功能集规范。

有两个与配置Horde相关的方面：

- 服务器配置

  将配置该服务器与其他服务器的通信，定义静态参数等。它由与该服务器一同部署的

  Server.json

  文件驱动。
- 全局配置

  在部署后控制所有面向用户的元素，该配置存于名为

  Globals.json

  的文件中。设置好部署参数后，大多数配置都在此处完成。

`Server.json` 文件通过[`ConfigPath`](../../horde-deployment/horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E8%AE%BE%E7%BD%AE)属性指定了读取 `Globals.json` 文件的位置，该位置可以是磁盘上的路径，也可以是版本控制系统中文件的路径（详见[下文](#%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6)）。

Horde会检测到所引用文件的更改，并自动更新，无需停机。如果在运行时尝试更新配置时遇到错误，可以通过Slack通知进行报告，服务器将继续使用上一次配置的缓存版本运行，直至问题修复。

Horde配置文件可以通过路径包含其他配置文件。例如，对于CI用例，在每个流内部配置流会很方便。

## 项目和流

Horde操作面板的大部分内容被划分为项目和流。项目被设计为一种顶级的功能划分方式，用于在共享的Horde实例上为不同团队划分功能，而流则用于配置与特定Perforce流相关的功能。

每个项目和流通常都有各自的配置文件。按照惯例（以及为了让模式服务器正常运行），项目配置文件的扩展名为 `.project.json` ，流配置文件的扩展名为 `.stream.json` 。

项目和流需要进行相应的设置，才能使用Horde的CI、PerfMem Hub以及Test Hub功能。对于配置远程执行和DDC用例，一个全局配置文件就足够了。

## 修订控制

Horde支持从Perforce读取配置文件。

用于读取配置数据的Perforce服务器和账户信息列在 `Server.json` 文件的 `Perforce` 部分。配置完成后，可以使用以下任意一种形式从源代码控制中引入文件：

Perforce语法（使用配置了"default" ID的Perforce服务器）

```
//Foo/Bar/globals.json
```

显式URI语法（使用配置了"some-name" ID的Perforce服务器）

```
perforce://some-name//Foo/Bar/globals.json
```

相对路径可以用于指定配置文件相对于正在解析的当前文件的位置，而无需考虑提供该文件的当前存储后端。

## 模式服务器

Horde配置文件中有很多设置，你可能需要一些时间来熟悉。为了便于编辑，Horde实现了一个JSON模式服务器，允许IDE执行上下文高亮显示、自动完成以及验证功能。

要在Microsoft Visual Studio中将Horde设置为模式服务器，转至 `工具（Tools）` > `选项...（Options...）` ，并找到 `文本编辑器（Text Editor）` > `JSON` > `模式（Schema）` 。

将你的Horde服务器的路径添加为 `{{ SERVER-URL }}/api/v1/schema/catalog.json` ，并根据实际情况替换 `{{ SERVER-URL }}` 。

所包含文件所使用的扩展名表明了模式所预期的根元素。扩展名为 `.project.json` 的文件从项目元素开始，扩展名为 `.stream.json` 的文件从流元素开始，依此类推。
